//
//  ViewController.m
//  TangramSDKDemo
//
//  Created by B.E.N on 15/4/13.
//  Copyright (c) 2015年 B.E.N. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+TAWebCache.h"

@implementation MyCell
- (void)awakeFromNib{
//    self.iconImageView.layer.cornerRadius = 20;
//    self.iconImageView.layer.masksToBounds  = YES;
}
@end


@interface ViewController ()<UITableViewDataSource>

@end

static  NSString *errorMessages[] = {
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab1d5e0d2ef5e0feee188f006c6034e5/71cf3bc79f3df8dc8a02de85ce11728b471028e2.jpg",
    @"http://e.hiphotos.baidu.com/image/w%3D310/sign=5631f23879f40ad115e4c1e2672c1151/eaf81a4c510fd9f98b609069272dd42a2834a4bf.jpg",
    @"http://d.hiphotos.baidu.com/image/w%3D310/sign=ab45b2e2be3eb13544c7b1ba961ea8cb/1ad5ad6eddc451daaa8492e1b4fd5266d016324d.jpg",
    @"http://g.hiphotos.baidu.com/image/w%3D310/sign=db454eb03b01213fcf3348dd64e636f8/9358d109b3de9c82870d83e66e81800a19d8436a.jpg",
    @"http://h.hiphotos.baidu.com/image/w%3D310/sign=f481a45a014f78f0800b9cf249300a83/a8014c086e061d9505170d3679f40ad162d9ca6e.jpg",
    @"http://b.hiphotos.baidu.com/image/w%3D310/sign=4bacd839718da9774e2f802a8051f872/908fa0ec08fa513d27ab77d43f6d55fbb2fbd9b2.jpg",
    @"http://c.hiphotos.baidu.com/image/w%3D310/sign=8db59e60cbfcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab64c9ea5f82f436afc378311ed3.jpg",
    @"http://f.hiphotos.baidu.com/image/w%3D310/sign=3a96cc23cafcc3ceb4c0cf32a244d6b7/a50f4bfbfbedab647ec90dc1f536afc379311e73.jpg",
    @"/Users/ben/Library/Developer/CoreSimulator/Devices/546CA3B2-A170-461F-B586-5BF46A7CD433/data/Containers/Data/Application/3CED5BFE-6EEA-48FC-81B6-927A1DD875A3/Documents/1.jpg"
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    UIImageView* imageView = cell.iconImageView;

    NSString* url = errorMessages[indexPath.row];
    TAImageViewData* imagedata = [TAImageViewData imageDataWithURL:url placeHolder:[UIImage imageNamed:@"noimg_pane"]];
    imagedata.namespaces = NAMESPACE_THEME;
    imagedata.finisheMode = UIViewContentModeScaleToFill;
    [imageView setImageWithData:imagedata];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16 * 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
