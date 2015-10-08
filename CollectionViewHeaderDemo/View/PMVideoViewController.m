//
//  VideoViewController.m
//  CollectionViewHeaderDemo
//
//  Created by majian on 15/10/8.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMVideoViewController.h"
#import <UIImageView+WebCache.h>
NSString * const PMTitleKey = @"titleKey";
NSString * const PMPlayCountKey = @"playCountKey";
NSString * const PMTypeNameKey = @"typeNameKey";
NSString * const PMDurationKey = @"durationKey";
NSString * const PMImagePathKey = @"imagePathKey";
NSString * const PMVideoPath = @"videoPath";

@interface PMVideoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@end

@implementation PMVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (nil == self.delegate) {
        return;
    }
    
    if (![self.delegate respondsToSelector:@selector(didSelectViewController:)]) {
        return;
    }
    
    [self.delegate didSelectViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataSourceDictI:(NSDictionary *)dataSourceDictI {
    _dataSourceDictI = dataSourceDictI;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.durationLabel.text = dataSourceDictI[PMDurationKey];
        self.typeNameLabel.text = dataSourceDictI[PMTypeNameKey];
        self.titleLabel.text = dataSourceDictI[PMTitleKey];
        self.playCountLabel.text = dataSourceDictI[PMPlayCountKey];
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:dataSourceDictI[PMImagePathKey]]];
    });
}

@end
