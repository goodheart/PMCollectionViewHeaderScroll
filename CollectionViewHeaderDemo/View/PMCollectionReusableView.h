//
//  PMCollectionReusableView.h
//  CollectionViewHeaderDemo
//
//  Created by majian on 15/10/8.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoViewController.h"

@protocol PMCollectionReusableViewDelegate <NSObject>
@optional
- (void)didSelectWithVideoPath:(NSString *)videoPath;
- (UIColor *)colorOfPageControlCurrentPageIndicator;

@end

@interface PMCollectionReusableView : UICollectionReusableView
/*
    下一步添加的功能：
        1、在自动翻页过程中，用户手动翻页时，自动翻页关闭，同时倒计时4秒，如果用户没有手动翻页了，则进行自动翻页，否则继续倒计时，直到用户不进行自动翻页为止。
        2、貂整定时器方法.
        3、pageControl颜色可定制,暂时在layoutSubviews中实现
 */

@property (nonatomic,strong) NSArray<NSDictionary *> * dataSourceArrayI;
@property (nonatomic,weak) id<PMCollectionReusableViewDelegate> delegate;

@end
