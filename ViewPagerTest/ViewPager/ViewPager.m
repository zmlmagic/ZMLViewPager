//
//  ViewPager.m
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import "ViewPager.h"

@implementation ViewPager
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andViews:(NSArray *)views
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _views = views;
        self.userInteractionEnabled = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 2, 320, rect.size.height-2)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    CGRect frame;
    frame.origin.y = 0;
    frame.size.height = _scrollView.frame.size.height;
    frame.size.width = 320;
    for (int i = 0; i < _views.count; i++) {
        UIView* view = [_views objectAtIndex:i];
        frame.origin.x = 320*i;
        [view setFrame:frame];
        [_scrollView addSubview:view];
    }
    _pageControl = [[MyPageControl alloc]initWithFrame:CGRectMake(0, 0, 320, 2)];
    _pageControl.PageNum = _views.count;
    
    [_scrollView setContentSize:CGSizeMake(320*_views.count + 1, rect.size.height-2)];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"offset:%f",scrollView.contentOffset.x);
    NSInteger index = scrollView.contentOffset.x/320;
    [_pageControl setSelectIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(ViewPager:didSelectIndex:)]) {
        //[self.delegate ViewPager:self didSelectIndex:index];
    }
}

@end
