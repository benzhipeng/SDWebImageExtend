//
//  UIImageView+WCWebCache.m
//  TangramSDKDemo
//
//  Created by B.E.N on 15/4/13.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "UIImageView+WCWebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"

@implementation WCImageViewData

+ (WCImageViewData*)imageDataWithURL:(NSString*)url{
    
    WCImageViewData* imageViewData = [[WCImageViewData alloc] init];
    imageViewData.url = url;
    return imageViewData;
}


+ (WCImageViewData*)imageDataWithURL:(NSString *)url placeHolder:(UIImage *)placeHolder{
    
    WCImageViewData* imageViewData = [[WCImageViewData alloc] init];
    imageViewData.url = url;
    imageViewData.placeHolder = placeHolder;
    return imageViewData;
}

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces
{
    WCImageViewData* imageViewData = [[WCImageViewData alloc] init];
    imageViewData.url = url;
    imageViewData.placeHolder = placeHolder;
    imageViewData.namespaces = namespaces;
    return imageViewData;
}

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces defaultMode:(UIViewContentMode)defaultMode finisheMode:(UIViewContentMode)finisheMode
{
    WCImageViewData* imageViewData = [[WCImageViewData alloc] init];
    imageViewData.url = url;
    imageViewData.placeHolder = placeHolder;
    imageViewData.namespaces = namespaces;
    imageViewData.defaultMode = defaultMode;
    imageViewData.finisheMode = finisheMode;
    return imageViewData;
}

+ (WCImageViewData*)imageDataWithURL:(NSString*)url placeHolder:(UIImage*)placeHolder namespace:(NSString *)namespaces defaultMode:(UIViewContentMode)defaultMode finisheMode:(UIViewContentMode)finisheMode completedBlock:(SDWebImageCompletionWithFinishedBlock)completedBlock
{
    WCImageViewData* imageViewData = [[WCImageViewData alloc] init];
    imageViewData.url = url;
    imageViewData.placeHolder = placeHolder;
    imageViewData.namespaces = namespaces;
    imageViewData.defaultMode = defaultMode;
    imageViewData.finisheMode = finisheMode;
    imageViewData.completedBlock = completedBlock;
    return imageViewData;
}


- (id)init{
    if(self = [super init]){
        self.namespaces = nil;
        self.defaultMode = UIViewContentModeScaleAspectFill;
        self.finisheMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setUrl:(NSString *)newUrl{
    
    if(_url != newUrl){
        _url = newUrl;
    }
}
@end


@implementation UIImageView (WCWebCache)

- (void)setImageWithData:(WCImageViewData*)imageViewData{
    
    self.clipsToBounds = YES;
    self.contentMode = imageViewData.defaultMode;
    SDWebImageManager* webImageManager = [[SDWebImageHelper shareInstance] imageManagerWithNamespaces:imageViewData.namespaces];
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    [self sd_cancelImageLoadOperationWithKey:@"TAUIImageViewImageLoad"];
    
    UIImage* placeHolder = imageViewData.placeHolder;
    SDImageCache* cache = [[SDWebImageHelper shareInstance] imageCacheWithNamespaces:imageViewData.namespaces];
    placeHolder = [cache imageFromMemoryCacheForKey:imageViewData.url];
    if(!placeHolder){
        placeHolder = imageViewData.placeHolder;
    }
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        self.image = placeHolder;
        [self setNeedsLayout];
    }
    
    if (imageViewData.url) {
        __weak UIImageView *wself = self;
        id <SDWebImageOperation> operation = [webImageManager downloadImageWithURL:[NSURL URLWithString:imageViewData.url] options:options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if(imageViewData.progressBlock){
                imageViewData.progressBlock(receivedSize,expectedSize);
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image) {
                    wself.contentMode = imageViewData.finisheMode;
                    wself.image = image;
                    if(imageViewData.animated){
                        
                        if(cacheType == SDImageCacheTypeNone){
                            CATransition *transition = [CATransition animation];
                            transition.duration = 0.25f;
                            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                            transition.type = kCATransitionFade;
                            [wself.layer addAnimation:transition forKey:nil];
                        }
                    }
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeHolder;
                        [wself setNeedsLayout];
                    }
                }
                if(imageViewData.completedBlock){
                    imageViewData.completedBlock(image,error,cacheType,finished,imageURL);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"TAUIImageViewImageLoad"];
    } else {
        
    }
}
@end
