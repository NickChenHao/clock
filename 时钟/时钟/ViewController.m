//
//  ViewController.m
//  时钟
//
//  Created by nick on 16/2/29.
//  Copyright © 2016年 nick. All rights reserved.
//

#import "ViewController.h"
#define perSecA 6
#define perMinA 6
#define perHourA 30
#define perMInHour 0.5
#define angle2radio(angle) ((angle) * M_PI / 180)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

//秒针
@property (nonatomic, weak) CALayer *secLayer;
//分针
@property (nonatomic, weak) CALayer *minLayer;
//时针
@property (nonatomic, weak) CALayer *hourLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSec]; //秒针
    [self setUpMin];
    [self setUpHour];
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
    
}
- (void)timeChange{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *com = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger curSec = com.second;
    NSInteger curMin = com.minute;
    NSInteger curHour = com.hour;
    
    CGFloat angle = curSec * perSecA;
    CGFloat minAngle = curMin * perMinA;
    CGFloat hourAngle = curHour * perHourA + curMin * perMInHour;
    
    self.secLayer.transform = CATransform3DMakeRotation(angle2radio(angle), 0, 0, 1);
    self.minLayer.transform = CATransform3DMakeRotation(angle2radio(minAngle), 0, 0, 1);
    self.hourLayer.transform = CATransform3DMakeRotation(angle2radio(hourAngle), 0, 0, 1);
    
}
//秒针
- (void)setUpSec{
    //创建CALayer
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 3, 70);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(self.imageV.bounds.size.width * 0.5,self.imageV.bounds.size.height * 0.5);
    self.secLayer = layer;
    [self.imageV.layer addSublayer:layer];
}
//分针
- (void)setUpMin{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 5, 60);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(self.imageV.bounds.size.width * 0.5,self.imageV.bounds.size.height * 0.5);
    self.minLayer = layer;
    [self.imageV.layer addSublayer:layer];
}
//时针
- (void)setUpHour{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 5, 50);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(self.imageV.bounds.size.width * 0.5,self.imageV.bounds.size.height * 0.5);
    self.hourLayer = layer;
    [self.imageV.layer addSublayer:layer];
}
@end
