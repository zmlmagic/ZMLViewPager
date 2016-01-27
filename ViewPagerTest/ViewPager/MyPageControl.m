//
//  MyPageControl.m
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl
@synthesize PageNum;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
//    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, , <#CGFloat height#>)];
//    [imageView setBackgroundColor:[UIColor blackColor]];
    
    
//    [self addSubview:imageView];
    if (PageNum == 1) {
        self.hidden = YES;
    }
    else{
        CGRect frame = rect;
        frame.size.width = rect.size.width/PageNum;
        _selectView = [[UIImageView alloc]initWithFrame:frame];
        [_selectView setBackgroundColor:[UIColor redColor]];
        [self addSubview:_selectView];
    }
}

-(void)setSelectIndex:(NSInteger)index
{
    float width = _selectView.frame.size.width;
    CGRect rect = _selectView.frame;
    rect.origin.x = index*width;
    _selectView.frame = rect;
}


@end
