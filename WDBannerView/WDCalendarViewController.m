//
//  WDCalendarViewController.m
//  WDBannerView
//
//  Created by Mac on 2018/7/3.
//  Copyright © 2018年 windy. All rights reserved.
//

#import "WDCalendarViewController.h"
#import "WDGoAndBackCalendarView.h"
#import <NSDate+YYAdd.h>

@interface WDCalendarViewController ()<WDGoAndBackCalendarViewDelegate>

@end

@implementation WDCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDate *minDate,*maxDate;
    minDate = [NSDate date];
    maxDate = [[[NSDate date] dateByAddingDays:90] dateByAddingDays:-1];

    WDGoAndBackCalendarView *calendar = [[WDGoAndBackCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    calendar.delegate = self;
    calendar.minDate = minDate;
    calendar.maxDate = maxDate;
    calendar.zone = [NSTimeZone systemTimeZone];
    [self.view addSubview:calendar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
