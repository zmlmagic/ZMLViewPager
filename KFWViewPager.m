//
//  KFWViewPager.m
//  ViewPagerTest
//
//  Created by 张明磊 on 15/7/29.
//  Copyright (c) 2015年 flame_thupdi. All rights reserved.
//

#import "KFWViewPager.h"

@interface KFWViewPager()<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *view_background;
@property (nonatomic, weak) UIImageView *imageView_moveBottom;
@property (nonatomic, weak) UIScrollView *scrollView_content;

@property (nonatomic,weak) UIScrollView *scrollView_title;

@property (nonatomic, weak) UIColor *themeColor;
@property (nonatomic, weak) UIColor *textColor;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSArray *titles;

//初始位置
@property (nonatomic, assign)CGFloat float_beginPosetion;

//多项每页项数
@property (nonatomic, assign) CGFloat float_moreNumber;

@property (nonatomic, assign) CGFloat float_currentX;
@property (nonatomic, assign) NSInteger int_currentIndex;

@property (nonatomic, strong) NSMutableArray *array_titleButton;
@property (nonatomic, assign) int int_to;

@end

@implementation KFWViewPager

- (id)initWithFrame:(CGRect)frame andViews:(NSArray *)views andTitles:(NSArray *)titles andThemeColor:(UIColor *)themeColor andTitleColor:(UIColor *)textColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _themeColor = themeColor;
        _textColor = textColor;
        _views = views;
        _titles = titles;
        _float_currentX = 0.0;
        _int_currentIndex = 0;
        _float_moreNumber = 4.5;
        _float_beginPosetion = 0.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if(_views.count <= 4){
        UIImageView* imageView_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        [imageView_bg setBackgroundColor:[UIColor whiteColor]];
        imageView_bg.userInteractionEnabled = YES;
        [self addSubview:imageView_bg];
        
        NSMutableArray *arrat_tmp = [NSMutableArray arrayWithCapacity:_views.count];
        for (int i = 0; i<_titles.count; i++) {
            UIButton *button_title = [UIButton buttonWithType:UIButtonTypeCustom];
            button_title.frame = CGRectMake(self.frame.size.width/_titles.count * i, 15, self.frame.size.width/_titles.count, 30);
            button_title.backgroundColor = [UIColor clearColor];
            button_title.titleLabel.textAlignment = NSTextAlignmentCenter;
            button_title.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            [button_title setTitle:_titles[i] forState:UIControlStateNormal];
            [button_title setTitleColor:_themeColor forState:UIControlStateNormal];
            button_title.tag = i;
            [button_title addTarget:self action:@selector(didClickTag:) forControlEvents:UIControlEventTouchUpInside];
            //button_title.titleLabel
            [imageView_bg addSubview:button_title];
            [arrat_tmp addObject:button_title];
        }
        _array_titleButton = arrat_tmp;
        
        UIImageView *image_bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width/_titles.count, 5)];
        image_bottom.backgroundColor = _themeColor;
        [imageView_bg addSubview:image_bottom];
        _imageView_moveBottom = image_bottom;
        
        UIScrollView *scrollView_content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, imageView_bg.frame.size.height, self.frame.size.width, self.frame.size.height - imageView_bg.frame.size.height)];
        scrollView_content.userInteractionEnabled = YES;
        scrollView_content.showsHorizontalScrollIndicator = NO;
        scrollView_content.showsVerticalScrollIndicator = NO;
        scrollView_content.pagingEnabled = YES;
        scrollView_content.directionalLockEnabled = YES;
        _scrollView_content = scrollView_content;
        
        CGRect frame;
        frame.origin.y = 0;
        frame.size.height = scrollView_content.frame.size.height;
        frame.size.width = scrollView_content.frame.size.width;
        
        for (int i = 0; i < _views.count; i++) {
            UIView* view = [_views objectAtIndex:i];
            frame.origin.x = scrollView_content.frame.size.width*i;
            [view setFrame:frame];
            [scrollView_content addSubview:view];
        }
        
        [scrollView_content setContentSize:CGSizeMake(scrollView_content.frame.size.width * _views.count + 1, scrollView_content.frame.size.height)];
        scrollView_content.delegate = self;
        [self addSubview:scrollView_content];
        
        [self changSelectButton];
    }else{
        UIScrollView* scrollView_bg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
        scrollView_bg.userInteractionEnabled = YES;
        scrollView_bg.showsHorizontalScrollIndicator = NO;
        scrollView_bg.showsVerticalScrollIndicator = NO;
        scrollView_bg.pagingEnabled = YES;
        scrollView_bg.directionalLockEnabled = YES;
        scrollView_bg.tag  = 100;
        scrollView_bg.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView_bg];
        _scrollView_title = scrollView_bg;
        
        NSMutableArray *arrat_tmp = [NSMutableArray arrayWithCapacity:_views.count];
        for (int i = 0; i<_titles.count; i++) {
            UIButton *button_title = [UIButton buttonWithType:UIButtonTypeCustom];
            button_title.frame = CGRectMake(self.frame.size.width/_float_moreNumber  * i, 15, self.frame.size.width/_float_moreNumber , 30);
            button_title.backgroundColor = [UIColor clearColor];
            button_title.titleLabel.textAlignment = NSTextAlignmentCenter;
            button_title.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
            [button_title setTitle:_titles[i] forState:UIControlStateNormal];
            [button_title setTitleColor:_themeColor forState:UIControlStateNormal];
            button_title.tag = i;
            [button_title addTarget:self action:@selector(didClickTag:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView_bg addSubview:button_title];
            [arrat_tmp addObject:button_title];
        }
        _array_titleButton = arrat_tmp;
       
        [scrollView_bg setContentSize:CGSizeMake(self.frame.size.width/_float_moreNumber  * _views.count + 1, scrollView_bg.frame.size.height)];
        
        UIImageView *image_bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width/_float_moreNumber , 5)];
        image_bottom.backgroundColor = _themeColor;
        [scrollView_bg addSubview:image_bottom];
        _imageView_moveBottom = image_bottom;
        
        UIScrollView *scrollView_content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollView_bg.frame.size.height, self.frame.size.width, self.frame.size.height - scrollView_bg.frame.size.height)];
        scrollView_content.userInteractionEnabled = YES;
        scrollView_content.showsHorizontalScrollIndicator = NO;
        scrollView_content.showsVerticalScrollIndicator = NO;
        scrollView_content.pagingEnabled = YES;
        scrollView_content.directionalLockEnabled = YES;
        _scrollView_content = scrollView_content;
        
        CGRect frame;
        frame.origin.y = 0;
        frame.size.height = scrollView_content.frame.size.height;
        frame.size.width = scrollView_content.frame.size.width;
        
        for (int i = 0; i < _views.count; i++) {
            UIView* view = [_views objectAtIndex:i];
            frame.origin.x = scrollView_content.frame.size.width*i;
            [view setFrame:frame];
            [scrollView_content addSubview:view];
        }
        
        [scrollView_content setContentSize:CGSizeMake(scrollView_content.frame.size.width * _views.count + 1, scrollView_content.frame.size.height)];
        scrollView_content.delegate = self;
        [self addSubview:scrollView_content];
        
        [self changSelectButton];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(_views.count <= 4){
        NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
        if(_int_currentIndex != index){
            if ([self.delegate respondsToSelector:@selector(viewPager:didScrollIndex:)]) {
                [_delegate viewPager:self didScrollIndex:index];
            }
        }
        _int_currentIndex = index;
        [self resetImageViewBottom];
    }
    else{
        NSInteger index = _scrollView_content.contentOffset.x/self.frame.size.width;
        if(_int_currentIndex != index){
            if ([self.delegate respondsToSelector:@selector(viewPager:didScrollIndex:)]) {
                [_delegate viewPager:self didScrollIndex:index];
                if(_int_to == 0){
                        if(_scrollView_title.contentOffset.x < _imageView_moveBottom.frame.size.width * (_views.count - 4)){
                            _float_beginPosetion = _float_beginPosetion + _imageView_moveBottom.frame.size.width;
                            [_scrollView_title setContentOffset:CGPointMake(_float_beginPosetion, 0) animated:YES];
                        }
                }else if(_int_to == 1){
                        if(_scrollView_title.contentOffset.x > 0){
                            _float_beginPosetion = _float_beginPosetion - _imageView_moveBottom.frame.size.width;
                            [_scrollView_title setContentOffset:CGPointMake(_float_beginPosetion, 0) animated:YES];
                        }
                }
            }
        }
        _int_currentIndex = index;
        [self resetImageViewBottom];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(_views.count <= 4){
        if(scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <self.frame.size.width*(_views.count - 1)){
            _imageView_moveBottom.center = CGPointMake(_imageView_moveBottom.center.x - (_float_currentX-scrollView.contentOffset.x)/_views.count,_imageView_moveBottom.center.y);
        }
        _float_currentX = scrollView.contentOffset.x;
    }
    else{
        if(scrollView.contentOffset.x > 0 && scrollView.contentOffset.x <self.frame.size.width*(_views.count - 1)){
            _imageView_moveBottom.center = CGPointMake(_imageView_moveBottom.center.x - (_float_currentX-scrollView.contentOffset.x)/_float_moreNumber,_imageView_moveBottom.center.y);
            if(_float_currentX > scrollView.contentOffset.x){
                _int_to = 1;
            }else{
                _int_to = 0;
            }
        }
        _float_currentX = scrollView.contentOffset.x;
    }
}

- (void)didClickTag:(UIButton *)button{
    if(_views.count <= 4){
        [_scrollView_content setContentOffset:CGPointMake(self.frame.size.width * button.tag, 0) animated:YES];
        if(_int_currentIndex != button.tag){
            if ([self.delegate respondsToSelector:@selector(viewPager:didScrollIndex:)]) {
                [_delegate viewPager:self didScrollIndex:button.tag];
            }
        }
        _int_currentIndex = button.tag;
    }
    else{
        [_scrollView_content setContentOffset:CGPointMake(self.frame.size.width * button.tag, 0) animated:YES];
        if(button.tag > _views.count - 4){
            _float_beginPosetion =  _imageView_moveBottom.frame.size.width * (button.tag - 3);
            [_scrollView_title setContentOffset:CGPointMake(_imageView_moveBottom.frame.size.width * (button.tag - 3), 0) animated:YES];
        }else{
            _float_beginPosetion =  _imageView_moveBottom.frame.size.width * button.tag;
            [_scrollView_title setContentOffset:CGPointMake(_imageView_moveBottom.frame.size.width * button.tag, 0) animated:YES];
        }
        if(_int_currentIndex != button.tag){
            if ([self.delegate respondsToSelector:@selector(viewPager:didScrollIndex:)]) {
                [_delegate viewPager:self didScrollIndex:button.tag];
            }
        }
        _int_currentIndex = button.tag;
    }
}

//转变title颜色
- (void)changSelectButton{
    for (int i = 0; i<_views.count; i++) {
        UIButton *button_title = _array_titleButton[i];
        [button_title setTitleColor:_textColor forState:UIControlStateNormal];
    }
    UIButton *button_select = _array_titleButton[_int_currentIndex];
    [button_select setTitleColor:_themeColor forState:UIControlStateNormal];
}

//矫正移动位置
- (void)resetImageViewBottom{
    [self changSelectButton];
    if(_views.count <= 4){
        _imageView_moveBottom.center = CGPointMake(_imageView_moveBottom.frame.size.width/2 + _int_currentIndex*_imageView_moveBottom.frame.size.width, _imageView_moveBottom.center.y);
    }else{
        _imageView_moveBottom.center = CGPointMake(_imageView_moveBottom.frame.size.width/2 + _int_currentIndex*_imageView_moveBottom.frame.size.width, _imageView_moveBottom.center.y);
        
        if(_int_currentIndex > _views.count - 4){
            _float_beginPosetion =  _imageView_moveBottom.frame.size.width * (_int_currentIndex - 3);
            [_scrollView_title setContentOffset:CGPointMake(_imageView_moveBottom.frame.size.width * (_int_currentIndex - 3), 0) animated:YES];
        }else{
            _float_beginPosetion =  _imageView_moveBottom.frame.size.width * _int_currentIndex;
            [_scrollView_title setContentOffset:CGPointMake(_imageView_moveBottom.frame.size.width * _int_currentIndex, 0) animated:YES];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self resetImageViewBottom];
}

@end
