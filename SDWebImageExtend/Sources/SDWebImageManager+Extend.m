//
//  SDWebImageManager+Extend.m
//  TangramWebImageManagerDemo
//
//  Created by ZhiPeng Ben on 15/7/8.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "SDWebImageManager+Extend.h"

@implementation SDWebImageManager (Extend)

+ (SDWebImageManager*)sharedDocManager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        [instance setValue:[SDImageCache sharedDocImageCache] forKeyPath:@"imageCache"];
    });
    return instance;
}

+ (SDWebImageManager*)sharedDocThemeManager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
        [instance setValue:[SDImageCache sharedDocThemeImageCache] forKeyPath:@"imageCache"];
    });
    return instance;
}

+ (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces{
    if(namespaces){
        if([namespaces isEqualToString:NAMESPACE_DEFAULT]){
            return [SDWebImageManager sharedManager];
        }else if([namespaces isEqualToString:NAMESPACE_THEME]){
            return [SDWebImageManager sharedDocThemeManager];
        }else {
            return [SDWebImageManager sharedManager];
        }
    }else {
        return [SDWebImageManager sharedDocManager];
    }
}
@end
