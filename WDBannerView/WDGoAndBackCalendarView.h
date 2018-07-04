//
//  WDGoAndBackCalendarView.h
//  WDBannerView
//
//  Created by Mac on 2018/7/3.
//  Copyright © 2018年 windy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDGoAndBackCalendarViewDelegate <NSObject>

@optional

- (void)selectDates:(NSArray *)dates;

@end

@interface WDGoAndBackCalendarView : UIView

@property (strong, nonatomic) id<WDGoAndBackCalendarViewDelegate> delegate;
@property (strong, nonatomic) NSDate *minDate;//日历显示的最小日期
@property (strong, nonatomic) NSDate *maxDate;//日历显示的最大日期
@property (strong, nonatomic) NSTimeZone *zone;
@property (strong, nonatomic) NSDate *goDate;//选中的起始日期
@property (strong, nonatomic) NSDate *backDate;//选中的结束日期

@end
