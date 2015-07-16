# SDWebImageExtend
基于SDWebImage的一些扩展

使用方法 :
 1.`pod 'SDWebImageExtend',:git=>"https://github.com/benzhipeng1024/SDWebImageExtend.git"`
 2.`pod install `
 
 主要的类 SDWebImageHelper,UIImageView+WCWebCache
 
###下载图片
`WCImageViewData* imagedata = [WCImageViewData imageDataWithURL:url placeHolder:[UIImage imageNamed:@"noimg_pane"]];`
`imagedata.namespaces = @"BEN";`
`[imageView setImageWithData:imagedata];`

###获取cache和manager
1.获取cache
`- (SDImageCache*)imageCacheWithNamespaces:(NSString*)namespaces;`
2、获取manager
`- (SDWebImageManager*)imageManagerWithNamespaces:(NSString*)namespaces;`
 
