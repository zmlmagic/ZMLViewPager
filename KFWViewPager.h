//
//  KFWViewPager.h
//  ViewPagerTest
//
//  Created by 张明磊 on 15/7/29.
//  Copyright (c) 2015年 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KFWViewPager;
@protocol KFWViewPagerDelegate<NSObject>
-(void)viewPager:(KFWViewPager *)viewPager didScrollIndex:(NSInteger)index;
@end

@interface KFWViewPager : UIView

@property(nonatomic,weak)id<KFWViewPagerDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andViews:(NSArray *)views andTitles:(NSArray *)titles andThemeColor:(UIColor *)themeColor andTitleColor:(UIColor *)textColor;

@end
