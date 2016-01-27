//
//  MyPageControl.h
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageControl : UIView
{
    UIImageView* _selectView;
}
-(void)setSelectIndex:(int)index;
@property(nonatomic,assign) int PageNum;
@end
