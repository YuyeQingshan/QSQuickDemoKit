//
//  ViewController.m
//  QSQuickDemoKit_example
//
//  Created by qingshan on 2017/4/14.
//  Copyright © 2017年 qingshan. All rights reserved.
//

#import "ViewController.h"

#import <QSQuickDemoKit/QSButtonGroup.h>

@interface ViewController ()

@property (nonatomic, strong) QSButtonGroup *buttonGroup;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonGroup = [[QSButtonGroup alloc] init];
    [_buttonGroup setupButtonGroupInContentView:self.view];
    
    [_buttonGroup addButtonWithTitle:@"TEST"
                         actionBlock:^{
                             NSLog(@"Hello world ^_^");
                         }];
}
@end
