//
//  UIViewController+templatematch.h
//  NomiChoco
//
//  Created by 岡田みなみ on 2015/02/28.
//  Copyright (c) 2015年 岡田みなみ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TemplateMatch: NSObject
- (id) init;
- (int)recognizeMatch:(UIImage *)image;
@end
