//
//  ViewController.m
//  ViewPagerTest
//
//  Created by flame_thupdi on 13-4-17.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import "ViewController.h"
#import "KFWViewPager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView* viewFirst = [[UIView alloc] init];
    viewFirst.backgroundColor = [UIColor greenColor];
    
    UIView* viewSecond = [[UIView alloc] init];
    viewSecond.backgroundColor = [UIColor blueColor];
    
    UIView* viewThird = [[UIView alloc] init];
    viewThird.backgroundColor = [UIColor redColor];
    
    UIView* viewFour = [[UIView alloc] init];
    viewFour.backgroundColor = [UIColor yellowColor];
    
    UIView* viewFive = [[UIView alloc] init];
    viewFour.backgroundColor = [UIColor blackColor];
    
    NSArray *titles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    NSArray* views = [[NSArray alloc]initWithObjects:viewFirst,viewSecond,viewThird,viewFour,viewFive,viewFive,viewFive,viewFive,nil];
    KFWViewPager *view_pager = [[KFWViewPager alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andViews:views andTitles:titles andThemeColor:[UIColor blueColor] andTitleColor:[UIColor blackColor]];
    view_pager.delegate = self;
    [self.view addSubview:view_pager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewPager:(KFWViewPager *)viewPager didScrollIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

@end
