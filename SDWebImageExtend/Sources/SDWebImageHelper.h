//
//  SDWebImageHelper.h
//  SDWebImageExtend
//
//  Created by ZhiPeng Ben on 15/7/14.
//  Copyright (c) 2015年 ZhiPeng Ben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@interface SDWebImageHelper : NSObject

+ (SDWebImageHelper*)shareInstance;


- (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces;


- (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces;
@end
