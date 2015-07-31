//
//  UIImageView+WCWebCache.h
//  SDWebImageExtend
//
//  Created by B.E.N on 15/4/13.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SDWebImageHelper.h"


@interface WCImageViewData : NSObject

+ (WCImageViewData*)imageDataWithURL:(NSString*)url;

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder;

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces;

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces defaultMode:(UIViewContentMode)defaultMode finisheMode:(UIViewContentMode)finisheMode;

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces defaultMode:(UIViewContentMode)defaultMode finisheMode:(UIViewContentMode)finisheMode completedBlock:(SDWebImageCompletionWithFinishedBlock)completedBlock;


/**
 *  图片下载结束之后所在的文件夹 默认为Document的根目录,传"default" 为SDWebImage自带的文件夹,其余为Document下的子文件夹
 */
@property (nonatomic,strong) NSString*         namespaces;
/**
 *  图片下载的地址
 */
@property (nonatomic,strong) NSString*         url;
/**
 *  图片下载的占为图片 可以为空
 */
@property (nonatomic,strong) UIImage*          placeHolder;
/**
 *  初始的mode
 */
@property (nonatomic,assign) UIViewContentMode defaultMode;
/**
 *  下载图片结束之后需要设置的mode
 */
@property (nonatomic,assign) UIViewContentMode finisheMode;

/**
 *  是否在切换图时加上过度动画 默认为NO
 */
@property (nonatomic,assign) BOOL               animated;

/**
 *  下载进度回调的block
 */
@property (nonatomic,copy) SDWebImageDownloaderProgressBlock  progressBlock;

/**
 *  下载结束回调的block
 */
@property (nonatomic,copy) SDWebImageCompletionWithFinishedBlock  completedBlock;

@end



@interface UIImageView (WCWebCache)

- (void)setImageWithData:(WCImageViewData*)imageViewData;

@end
