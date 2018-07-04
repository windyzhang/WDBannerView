//
//  NSDate+Utilities.h
//  WDBannerView
//
//  Created by Mac on 2018/7/4.
//  Copyright © 2018年 windy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

@end
