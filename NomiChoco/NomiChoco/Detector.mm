//
//  UIViewController+Detector.m
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

#import "OpenCVSample-Bridging-Header.h"
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@interface Detector()
{
    cv::CascadeClassifier cascade;
}
@end

@implementation Detector: NSObject

- (id)init {
    self = [super init];
    
    // 分類器の読み込み
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    std::string cascadeName = (char *)[path UTF8String];
    
    if(!cascade.load(cascadeName)) {
        return nil;
    }
    
    return self;
}

- (UIImage *)recognizeFace:(UIImage *)image {
    // UIImage -> cv::Mat変換
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    
    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
        
    
    // cv::Mat -> UIImage変換
    UIImage *resultImage = MatToUIImage(mat);
    
    return resultImage;
}

@end