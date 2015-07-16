# SDWebImageExtend
基于SDWebImage的一些扩展

###使用方法 :
```objc
pod 'SDWebImageExtend',:git=>"https://github.com/benzhipeng1024/SDWebImageExtend.git"
pod install 
```
 
 主要的类 SDWebImageHelper,UIImageView+WCWebCache
 
###下载图片
```objc
WCImageViewData* imagedata = [WCImageViewData imageDataWithURL:url placeHolder:[UIImage imageNamed:@"noimg_pane"]];
imagedata.namespaces = @"BEN";
[imageView setImageWithData:imagedata];
```

###获取cache和manager
```objc
//获取cache
- (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces;
//获取manager
- (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces;
```
