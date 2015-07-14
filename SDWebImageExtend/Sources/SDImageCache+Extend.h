//
//  SDImageCache+Extend.h
//  TangramWebImageManagerDemo
//
//  Created by ZhiPeng Ben on 15/7/8.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "SDImageCache.h"

extern NSString* NAMESPACE_DEFAULT; //默认的文件夹
extern NSString* NAMESPACE_THEME; //theme文件夹

@interface SDImageCache (Extend)

/**
 *  Document根目录的cache
 *
 *  @return 根目录所对应的cache
 */
+ (SDImageCache*)sharedDocImageCache;

/**
 *  Document根目录下的Theme的cache
 *
 *  @return 根目录下的Theme的cache
 */
+ (SDImageCache*)sharedDocThemeImageCache;

/**
 *  根据指定文件夹名字获取cache
 *
 *  @param namespaces 文件夹名字
 *
 *  @return 对应文件夹的cache
 */
+ (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces;
@end


