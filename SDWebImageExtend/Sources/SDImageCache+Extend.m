//
//  SDImageCache+Extend.m
//  TangramWebImageManagerDemo
//
//  Created by ZhiPeng Ben on 15/7/8.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "SDImageCache+Extend.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

NSString* NAMESPACE_DEFAULT = @"Default";
NSString* NAMESPACE_THEME = @"Theme";

@implementation SDImageCache (Extend)

+ (void)load{
    
    Class class = [self class];
    
    //替换第三方SDWebImage里面的方法 cachedFileNameForKey: 每次更新时需要注意
    SEL originalSelector = NSSelectorFromString(@"cachedFileNameForKey:");
    SEL swizzledSelector = NSSelectorFromString(@"customCachedFileNameForKey:");
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (NSString*)customCachedFileNameForKey:(NSString*)key{
    if([key hasPrefix:@"http"]){
        const char *str = [key UTF8String];
        if (str == NULL) {
            str = "";
        }
        unsigned char r[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), r);
        NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                              r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
        
        return filename;
    }else {
        return [key lastPathComponent];
    }
}

+ (SDImageCache*)sharedDocImageCache{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        NSString* path = [[self class] docPath:nil];
        [instance setValue:path forKey:@"diskCachePath"];
        [[NSNotificationCenter defaultCenter] removeObserver:instance];
        
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return instance;
}

+ (SDImageCache*)sharedDocThemeImageCache{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        NSString* path = [[self class] docPath:NAMESPACE_THEME];
        [instance setValue:path forKey:@"diskCachePath"];
        [[NSNotificationCenter defaultCenter] removeObserver:instance];
        
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return instance;
}

+ (NSString*)docPath:(NSString*)namespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = paths[0];
    if(namespace){
        path = [paths[0] stringByAppendingPathComponent:namespace];
    }
    return path;
}

+ (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces{

    if(namespaces){
        if([namespaces isEqualToString:NAMESPACE_DEFAULT]){
            return [SDImageCache sharedImageCache];
        }else if([namespaces isEqualToString:NAMESPACE_THEME]){
            return [SDImageCache sharedDocThemeImageCache];
        }else {
            return [SDImageCache sharedDocImageCache];
        }
    }else {
        return [SDImageCache sharedDocImageCache];
    }
}

@end
