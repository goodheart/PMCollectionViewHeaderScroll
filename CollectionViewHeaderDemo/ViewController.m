//
//  ViewController.m
//  CollectionViewHeaderDemo
//
//  Created by majian on 15/9/30.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "ViewController.h"
#import "HttpTool.h"
//#import "CollectionHeaderView.h"
#import "PMCollectionReusableView.h"
//#import "CollectionReusableView.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PMCollectionReusableViewDelegate>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,copy) NSArray * headerDataSourceArrayI;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    http://192.168.0.212:8080/pocket_v2/api/video/recommendVideo
    /*
    limit = 6;
    userId = 33026;
     */
    /*
    NSString * url = @"http://192.168.0.212:8080/pocket_v2/api/video/recommendVideo";
    NSDictionary * params = @{@"limit":@"6",
                              @"userId":@"33026"};
    [HttpTool postWithNormalUrl:url params:params success:^(NSDictionary *contentDic) {
        NSLog(@"contentDict : %@",contentDic);
    } failure:^(NSString *errorStr) {
        NSLog(@"errorStr : %@",errorStr);
    }];
    */
    NSDictionary * dict = @{PMDurationKey : @"12:00",
                            PMPlayCountKey : @"123",
                            PMTitleKey : @"这是一个很好的东西",
                            PMTypeNameKey : @"喜剧片",
                            PMImagePathKey : @"http://d.hiphotos.baidu.com/image/w%3D230/sign=6027a8329045d688a302b5a794c37dab/79f0f736afc37931a98fe728e9c4b74542a911cf.jpg",
                            PMVideoPath : @"videoPath 1111"};
    
    NSDictionary * dict1 = @{PMDurationKey : @"1:00",
                             PMPlayCountKey : @"5000",
                             PMTitleKey : @"哎呦，还不错",
                             PMTypeNameKey : @"恐怖片",
                             PMImagePathKey : @"http://pic.pptstore.net/pptpic/81/49/d4318af57c077f60_small.JPG",
                             PMVideoPath : @"videoPath 222"};
    NSDictionary * dict2 = @{PMDurationKey : @"1:00",
                             PMPlayCountKey : @"5000",
                             PMTitleKey : @"哎呦，还不错",
                             PMTypeNameKey : @"恐怖片",
                             PMImagePathKey : @"http://c.hiphotos.baidu.com/image/pic/item/9f510fb30f2442a7fb220ca8d343ad4bd113028a.jpg",
                             PMVideoPath : @"videoPath 222"};
    
    NSDictionary * dict3 = @{PMDurationKey : @"1:00",
                             PMPlayCountKey : @"5000",
                             PMTitleKey : @"哎呦，还不错",
                             PMTypeNameKey : @"恐怖片",
                             PMImagePathKey : @"http://h.hiphotos.baidu.com/image/pic/item/267f9e2f0708283890f56e02bb99a9014c08f128.jpg",
                             PMVideoPath : @"videoPath 222"};
    
    self.headerDataSourceArrayI = @[dict,dict1,dict2,dict3];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class])
                                                                            forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0
                                           green:arc4random() % 255 / 255.0
                                            blue:arc4random() % 255 / 255.0
                                           alpha:0.8];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    PMCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                           withReuseIdentifier:kind
                                                                                  forIndexPath:indexPath];
    
    
    [headerView setDataSourceArrayI:self.headerDataSourceArrayI];
    headerView.delegate = self;
    
    return headerView;
}

#pragma mark - PMCollectionReusableViewDelegate
- (void)didSelectWithVideoPath:(NSString *)videoPath {
    NSLog(@"%@",videoPath);
}


#pragma mark - Property Getter
- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 200);
    flowLayout.itemSize = CGSizeMake(75, 75);
    
    CGRect frame = CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 20);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:frame
                                         collectionViewLayout:flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    /*
    [_collectionView registerClass:[PMCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
    */
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PMCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];

    [_collectionView registerClass:[UICollectionViewCell class]
        forCellWithReuseIdentifier:NSStringFromClass([self class])];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    return _collectionView;
}

@end









