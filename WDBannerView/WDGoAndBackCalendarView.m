//
//  WDGoAndBackCalendarView.m
//  WDBannerView
//
//  Created by Mac on 2018/7/3.
//  Copyright © 2018年 windy. All rights reserved.
//

#import "WDGoAndBackCalendarView.h"
#import <FSCalendar.h>
#import "WDGoAndBackCalendarCell.h"
#import <YYKit.h>
#import "NSDate+Utilities.h"

@interface WDGoAndBackCalendarView()
<FSCalendarDelegate,
FSCalendarDataSource,
FSCalendarDelegateAppearance>

@property (nonatomic, strong) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;

@end

@implementation WDGoAndBackCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupWeekTitle];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.gregorian.timeZone = self.zone;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 98, self.frame.size.width, self.frame.size.height - 98) timeZone:self.zone];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO;
    calendar.scrollEnabled = YES;
    calendar.allowsMultipleSelection = YES;
    calendar.rowHeight = self.frame.size.width / 7 + 30;
    calendar.headerHeight = 81;
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    [self addSubview:calendar];
   
    self.calendar = calendar;
    
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    calendar.appearance.headerTitleColor = [UIColor grayColor];
    calendar.appearance.titleFont = [UIFont systemFontOfSize:16];
    calendar.weekdayHeight = 0;
    calendar.today = nil;
    [calendar registerClass:[WDGoAndBackCalendarCell class] forCellReuseIdentifier:@"cell"];
}

- (NSString *)weekTitle:(NSInteger)number {
    switch (number) {
        case 0:
            return @"日";
            break;
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        default:
            return @"";
            break;
    }
}

- (void)setupWeekTitle {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width, 34)];
    [self addSubview:titleView];
    CGFloat weekWidth = self.frame.size.width / 7.0f;
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * weekWidth, 12, weekWidth, 10)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = [self weekTitle:i];
        [titleView addSubview:label];
    }
}

- (void)selectDate:(FSCalendar *)calendar Date:(NSDate *)date {
    
    if ((_goDate && _backDate) || [date isEarlierThanDate:_goDate]) {
        _goDate = date;
        _backDate = nil;
    } else {
        if (!_goDate && !_backDate) {
            _goDate = date;
        } else {
            _backDate = date;
        }
    }
    [self configVisiableCell:calendar];
}

- (void)configVisiableCell:(FSCalendar *)calendar {
    
    [calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *everydate = [calendar dateForCell:obj];
        WDGoAndBackCalendarCell *everycell = obj;
        [self setCell:everycell Date:everydate];
    }];
}

- (void)setCell:(WDGoAndBackCalendarCell *)cell Date:(NSDate *)date {
    if ((_goDate && [_goDate isEqualToDateIgnoringTime:date]) || (_backDate && [date isEqualToDateIgnoringTime:_backDate])) {
        cell.cellSelected = YES;
    } else if ([_goDate isEarlierThanDate:date] && [_backDate isLaterThanDate:date]) {
        cell.middleOfSelected = YES;
    } else {
        cell.cellSelected = NO;
//        if (self.zone) {
//            NSDate *changeDate = [self changeDate:[NSDate date] timeZome:self.zone];
//            if ([date isEqualToDateIgnoringTime:changeDate]) {
//                cell.titleLabel.textColor = [UIColor redColor];
//            }
//        } else {
            if ([date isToday]) {
                cell.titleLabel.textColor = [UIColor redColor];
            }
//        }
        
    }
//    [self configHoliday:cell Date:date];
}
- (NSDate*)changeDate:(NSDate*)date timeZome:(NSTimeZone*)timeZone {
    
    NSInteger timestamp = [date timeIntervalSince1970] - [NSTimeZone systemTimeZone].secondsFromGMT;
    timestamp = timestamp - (timestamp % (3600 * 24)) - timeZone.secondsFromGMT;
    NSDate *changeDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return changeDate;
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return _minDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return _maxDate;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

- (NSString *)calendar:(FSCalendar *)calendar holidayForDate:(NSDate *)date {
//    NSString *str = [VZT_HOLIDAY chineseTraditionalHoliday:date];
//    if (!str) {
//        str = [VZT_HOLIDAY internationalHolidy:date];
//    }
    return @"";
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    WDGoAndBackCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    if ([date isEarlierThanDate:_minDate] || [date isLaterThanDate:_maxDate]) {
        cell.selectedable = NO;
    } else {
        cell.selectedable = YES;
    }
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition {
    WDGoAndBackCalendarCell *newcell = (WDGoAndBackCalendarCell *)cell;
    [self setCell:newcell Date:date];
}

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self selectDate:calendar Date:date];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    [self selectDate:calendar Date:date];
}

#pragma mark - DelegateAppearance

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
    return [UIColor blackColor];
}

//- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date {
//    NSString *str = [date localstringWithFormat:@"yyyy-MM-dd"];
//    NSString *color = [_dicTicketPrice valueForKey:str][@"textColor"];
//    UIColor *co = [UIColor colorWithHexString:color];
//    return co;
//}
@end
