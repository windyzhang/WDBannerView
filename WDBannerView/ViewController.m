//
//  ViewController.m
//  WDBannerView
//
//  Created by WindyZhang on 2018/3/2.
//  Copyright © 2018年 windy. All rights reserved.
//

#import "ViewController.h"
#import "WDCalendarViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) CADisplayLink *displaylinkTimer;
@property (nonatomic,strong) dispatch_source_t sourceTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 0, 60, 44)];
    [rightButton setTitle:@"日历" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickCalendar) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:rightButton];
}

- (void)clickCalendar {
   
    WDCalendarViewController *calendarvc = [[WDCalendarViewController alloc] init];
    [self.navigationController pushViewController:calendarvc animated:YES];
}

- (void)createTimer{

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
}

- (void)timerStart:(NSTimer *)timer{
    NSLog(@"%lf",timer.timeInterval);
    //销毁定时器
    //[_timer invalidate];
    //_timer = nil;
}

- (void)createCADisplayLink{
    
    _displaylinkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [_displaylinkTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displaylinkTimer{
    NSLog(@"%ld",displaylinkTimer.preferredFramesPerSecond);
    //销毁定时器
    //[_displaylinkTimer invalidate];
    //_displaylinkTimer = nil;
}

- (void)createSourceTimer {
    
    //1.创建类型为 定时器类型的 Dispatch Source
    //1.1将定时器设置在主线程
    _sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //1.2设置定时器每一秒执行一次
    dispatch_source_set_timer(_sourceTimer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    //1.3设置定时器执行的动作
    dispatch_source_set_event_handler(_sourceTimer, ^{
        NSLog(@"在这里实现业务逻辑");
//        dispatch_source_cancel(self.sourceTimer);
    });
    //2.启动定时器
    dispatch_resume(_sourceTimer);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
