//
//  ContentObject.m
//  LocationSimulateDec
//
//  Created by RainZhang on 2018/7/13.
//  Copyright © 2018年 raintest. All rights reserved.
//

#import "ContentObject.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface ContentObject () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* name;
@end

@implementation ContentObject

- (id)init {
  if (self = [super init]) {
    _name = [[CLLocationManager alloc] init];
    _name.delegate = self;
    _name.desiredAccuracy = kCLLocationAccuracyBest;
  }
  return self;
}

- (void)statrCheckPositionspoofing
{
  /** 由于IOS8中定位的授权机制改变 需要进行手动授权
   * 获取授权认证，两个方法：
   * [self.locationManager requestWhenInUseAuthorization];
   * [self.locationManager requestAlwaysAuthorization];
   */
  if ([_name respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //NSLog(@"requestAlwaysAuthorization");
    [_name requestAlwaysAuthorization];
  }
  
  
  //开始定位，不断调用其代理方法
  [_name startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  // 1.获取用户位置的对象
  CLLocation *location = [locations lastObject];
 //高度 和高度的精确度
//  if (location.altitude == 0.00  && location.verticalAccuracy == -1.0)
  {
    //停止定位
    [manager stopUpdatingLocation];
    unsigned char cOriStr[27] = {0xC0, 0x68, 0x4B, 0x6D, 0x30, 0x52, 0x4B, 0x62, 0x3A, 0x67, 0x9, 0x67, 0x21, 0x6A, 0xDF, 0x62, 0x9A, 0x5B, 0x4D, 0x4F, 0x84, 0x76, 0xCD, 0x64, 0x5C, 0x4F, 0x00};
    unsigned char okStr[4] = {0x6e, 0x78, 0x9a, 0x5b};

    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithCharacters:cOriStr length:13] delegate:self cancelButtonTitle:NULL otherButtonTitles:[NSString stringWithCharacters:okStr length:2], nil];
    [alt show];
  }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
  if (error.code == kCLErrorDenied) {
    // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
  }
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
  [self statrCheckPositionspoofing];
}

@end
