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

/**
 *  用于访问的单例
 *
 *  @return 访问的对象
 */
+ (SDWebImageHelper*)shareInstance;

/**
 *  获取指定文件夹下的cache
 *
 *  @param namespaces 文件夹名字 传nill则为
 *
 *  @return 对应文件夹下的cache
 */
- (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces;


/**
 *  获取指定文件夹的manager
 *
 *  @param namespaces 文件夹的名字
 *
 *  @return 对应文件夹的manager
 */
- (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces;
@end
