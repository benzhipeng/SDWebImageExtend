//
//  SDWebImageHelper.m
//  SDWebImageExtend
//
//  Created by ZhiPeng Ben on 15/7/14.
//  Copyright (c) 2015年 ZhiPeng Ben. All rights reserved.
//

#import "SDWebImageHelper.h"
#import "objc/runtime.h"


@interface SDWebImageHelper ()
@property (nonatomic,strong) NSMutableDictionary*   webImageManagerMap;
@end

@implementation SDWebImageHelper
+ (SDWebImageHelper*)shareInstance{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init{
    if(self = [super init]){
        self.webImageManagerMap = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces{
    
    SDWebImageManager* manager = [self imageManagerWithNamespaces:namespaces];
    return manager.imageCache;
}

+ (NSString*)docPath:(NSString*)namespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = paths[0];
    if(namespace){
        path = [paths[0] stringByAppendingPathComponent:namespace];
    }
    return path;
}

+ (BOOL)checkWheatherHasPropertyWithClass:(id)obj propertyName:(NSString*)propertyName
{
    unsigned int i, count = 0;
    objc_property_t * properties = class_copyPropertyList( [obj class], &count );
    if ( count == 0 ){
        free( properties );
        return NO;
    }
    for ( i = 0; i < count; i++ ){
        NSString* tmp = [NSString stringWithUTF8String: property_getName(properties[i])];
        if([tmp isEqualToString:propertyName]){
            free(properties);
            return YES;
        }
    }
    free(properties);
    return NO;
}

- (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces{
    
    if(!namespaces){
        namespaces = @"";
    }
    NSString* key = namespaces;
    if(namespaces.length <= 0){
        key = @"Root";
    }
    SDWebImageManager* manager = [self.webImageManagerMap objectForKey:key];
    if(!manager){
        manager = [[SDWebImageManager alloc] init];
        SDImageCache* cache = [[SDImageCache alloc] init];

        NSAssert([[self class] checkWheatherHasPropertyWithClass:cache propertyName:@"diskCachePath"] , @"源码中的diskCachePath字段不存在需要修改该字段");
        NSAssert([[self class] checkWheatherHasPropertyWithClass:manager propertyName:@"imageCache"] , @"源码中的imageCache字段不存在需要修改该字段");
        [cache setValue:[[self class] docPath:namespaces] forKeyPath:@"diskCachePath"];
        [manager setValue:cache forKeyPath:@"imageCache"];
        
        //先移除原有的通知
        [[NSNotificationCenter defaultCenter] removeObserver:cache];
        
        //添加新的通知
        [[NSNotificationCenter defaultCenter] addObserver:cache
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:cache
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidEnterBackgroundNotification object:nil];
        if([key isEqualToString:@"Root"]){
            cache.maxCacheAge = NSIntegerMax;
        }
        [self.webImageManagerMap setObject:manager forKey:key];
    }
    return manager;
}
@end
