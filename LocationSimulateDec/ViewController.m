//
//  ViewController.m
//  LocationSimulateDec
//
//  Created by RainZhang on 2018/7/13.
//  Copyright © 2018年 raintest. All rights reserved.
//

#import "ViewController.h"
#import "ContentObject.h"

@interface ViewController ()
@property (nonatomic, strong) ContentObject *objt;/**< <#explain#>*/

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
    _objt = [[ContentObject alloc] init];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [_objt statrCheckPositionspoofing];
}

@end
