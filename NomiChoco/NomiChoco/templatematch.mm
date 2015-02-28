//
//  UIViewController+templatematch.m
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

#import "templatematch.h"
#import <opencv2/opencv.hpp>
#import <opencv2/nonfree/features2d.hpp>
#import <opencv2/highgui/ios.h>

@implementation TemplateMatch : NSObject

- (id)init {
    self = [super init];
    //TODO ここでマッチングするサンプルの準備
    
    
    return self;
}



- (int)recognizeMatch:(UIImage *)image; {
    // UIImage -> cv::Mat変換
    UIImage* originalImage = [UIImage imageNamed:@"tozurusample.jpg"];
    if (originalImage==nil) {
        return 0;
    }
    
    CGColorSpaceRef oriColorSpace = CGImageGetColorSpace(originalImage.CGImage);
    CGFloat oriCols = originalImage.size.width;
    CGFloat oriRows = originalImage.size.height;
    cv::Mat oriMat(oriRows, oriCols, CV_8UC4);
    
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat mat(rows, cols, CV_8UC4);
    
    cv::Mat gray_img1, gray_img2;
    cv::cvtColor(oriMat, gray_img1, CV_BGR2GRAY);
    cv::cvtColor(mat, gray_img2, CV_BGR2GRAY);
    cv::normalize(gray_img1, gray_img1, 0, 255, cv::NORM_MINMAX);
    cv::normalize(gray_img2, gray_img2, 0, 255, cv::NORM_MINMAX);
    
    std::vector<cv::KeyPoint> keypoints1, keypoints2;
    std::vector<cv::KeyPoint>::iterator itk;
    cv::Mat descriptors1, descriptors2;
    
    // SURF
    // threshold=2000
    cv::SurfFeatureDetector detector(2000);
    detector.detect(gray_img1, keypoints1);
    detector.detect(gray_img2, keypoints2);
    // SURF に基づくディスクリプタ抽出器
    cv::SurfDescriptorExtractor extractor;
    cv::Scalar color(100,255,50);
    extractor.compute(gray_img1, keypoints1, descriptors1);
    extractor.compute(gray_img2, keypoints2, descriptors2);
    
    // FlannBasedMatcher によるマッチ
    cv::FlannBasedMatcher matcher;
    std::vector<cv::DMatch> matches;
    matcher.match(descriptors1, descriptors2, matches);
    
    return (int)matches.size();

}
@end
