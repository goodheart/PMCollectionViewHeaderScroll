//
//  VideoViewController.h
//  CollectionViewHeaderDemo
//
//  Created by majian on 15/10/8.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const PMTitleKey;
extern NSString * const PMPlayCountKey;
extern NSString * const PMTypeNameKey;
extern NSString * const PMDurationKey;
extern NSString * const PMImagePathKey;
extern NSString * const PMVideoPath;

@class PMVideoViewController;
@protocol VideoViewControllerDelegate <NSObject>
@optional
- (void)didSelectViewController:(PMVideoViewController *)videoViewController;

@end

@interface PMVideoViewController : UIViewController

@property (nonatomic, strong) NSDictionary * dataSourceDictI;
@property (nonatomic,weak) id<VideoViewControllerDelegate> delegate;

@end
