//
//  PMCollectionReusableView.m
//  CollectionViewHeaderDemo
//
//  Created by majian on 15/10/8.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMCollectionReusableView.h"
#import "VideoViewController.h"
@interface PMCollectionReusableView ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,VideoViewControllerDelegate>
/* IBOutlet */
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/* Private Property  */
@property (nonatomic, strong) UIPageViewController * pageViewController;

/* Private Method */
- (VideoViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(VideoViewController *)viewController;
- (void)initCustomUIWithFrame:(CGRect)frame;
- (void)timerTurnPage;//定时翻页

@end

@implementation PMCollectionReusableView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomUIWithFrame:frame];
    }
    return self;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor orangeColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [self initCustomUIWithFrame:self.frame];
}

#pragma mark - Public Method
- (void)setDataSourceArrayI:(NSArray<NSDictionary *> *)dataSourceArrayI {
    
    if ([dataSourceArrayI isEqualToArray:_dataSourceArrayI]) {
        return;
    }

    _dataSourceArrayI = dataSourceArrayI;
    dispatch_async(dispatch_get_main_queue(), ^{        
        VideoViewController * vc = [self viewControllerAtIndex:0];
        NSArray * vcs = [NSArray arrayWithObject:vc];
        [self.pageViewController setViewControllers:vcs
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
        [self.pageControl setNumberOfPages:dataSourceArrayI.count];
        [self timerTurnPage];//定时翻页
    });
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(VideoViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    return [self viewControllerAtIndex:(self.dataSourceArrayI.count + index - 1) % self.dataSourceArrayI.count];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(VideoViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    return [self viewControllerAtIndex:(index + 1) % self.dataSourceArrayI.count];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (finished && completed) {
        VideoViewController * currentViewController = [self.pageViewController.viewControllers firstObject];
        NSUInteger index = [self indexOfViewController:currentViewController];
        [self.pageControl setCurrentPage:index];
    }
}

#pragma mark - VideoViewControllerDelegate
- (void)didSelectViewController:(VideoViewController *)videoViewController {
    if (nil == self.delegate) {
        return;
    }
    
    if (![self.delegate respondsToSelector:@selector(didSelectWithVideoPath:)]) {
        return;
    }
    
    NSUInteger index = [self indexOfViewController:videoViewController];
    NSString * videoPath = [self.dataSourceArrayI objectAtIndex:index][PMVideoPath];
    [self.delegate didSelectWithVideoPath:videoPath];
}

#pragma mark - Private Method
- (VideoViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (self.dataSourceArrayI.count == 0 || index >= self.dataSourceArrayI.count) {
        return nil;
    }
    
    VideoViewController * viewController = [[VideoViewController alloc] initWithNibName:NSStringFromClass([VideoViewController class]) bundle:nil];
    
    viewController.dataSourceDictI = self.dataSourceArrayI[index];
    viewController.delegate = self;
    
    return viewController;
}

- (NSUInteger)indexOfViewController:(VideoViewController *)viewController {
    return [self.dataSourceArrayI indexOfObject:viewController.dataSourceDictI];
}

//初始化UI
- (void)initCustomUIWithFrame:(CGRect)frame{
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.pageViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - CGRectGetHeight(self.pageControl.frame));
    
    [self.contentView addSubview:self.pageViewController.view];
}

- (void)timerTurnPage {
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(autoTurnPage)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)autoTurnPage {
    VideoViewController * currentViewController = [self.pageViewController.viewControllers firstObject];
    NSUInteger index = [self indexOfViewController:currentViewController];
    NSUInteger nextIndex = (index + 1) % self.dataSourceArrayI.count;
    VideoViewController * nextViewController = [self viewControllerAtIndex:nextIndex];
    [self.pageViewController setViewControllers:@[nextViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    [self.pageControl setCurrentPage:nextIndex];
}




@end
