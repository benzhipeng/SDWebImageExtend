//
//  SDWebImageManager+Extend.h
//  TangramWebImageManagerDemo
//
//  Created by ZhiPeng Ben on 15/7/8.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "SDWebImageManager.h"
#import "SDImageCache+Extend.h"

@interface SDWebImageManager (Extend)

/**
 *  根目录的manager
 *
 *  @return 返回根目录的manager
 */
+ (SDWebImageManager*)sharedDocManager;


/**
 *  根目录下的Theme的manager
 *
 *  @return 返回根目录下的Theme的manager
 */
+ (SDWebImageManager*)sharedDocThemeManager;

/**
 *  根据文件夹名字获取manager
 *
 *  @param namespaces 文件夹名字
 *
 *  @return 对应文件夹的manager
 */
+ (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces;
@end
