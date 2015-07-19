//
//  ViewController.m
//  XNQAlertTextView
//
//  Created by xunianqiang on 15/7/19.
//  Copyright (c) 2015年 xunianqiang. All rights reserved.
//

#import "ViewController.h"


#import "BTMAlertTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
    textView.alertTitle = @"请输入密码";
    textView.alertType = CHECKNETPASSWORD;
    textView.passwordBack = ^(NSString *password)
    {
        BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
        textView.alertTitle = @"设置新登录密码";
        textView.alertType = SETNEWPASSWORD;
        textView.passwordBack = ^(NSString *password)
        {
            BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
            textView.firstPassword = password;
            textView.alertTitle = @"重新输入新登录密码";
            textView.alertType = SETNEWPASSWORD;
            textView.passwordBack = ^(NSString *password){
                //                            NSLog(@"finally password -- %@",password);
                
            };
            
            [textView alertShow];
        };
        [textView alertShow];
    };
    [textView alertShow];

}

- (IBAction)btnClick:(id)sender {
    BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
    textView.alertTitle = @"请输入密码";
    textView.alertType = CHECKNETPASSWORD;
    textView.passwordBack = ^(NSString *password)
    {
        BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
        textView.alertTitle = @"设置新登录密码";
        textView.alertType = SETNEWPASSWORD;
        textView.passwordBack = ^(NSString *password)
        {
            BTMAlertTextView *textView = [[BTMAlertTextView alloc] init];
            textView.firstPassword = password;
            textView.alertTitle = @"重新输入新登录密码";
            textView.alertType = SETNEWPASSWORD;
            textView.passwordBack = ^(NSString *password){
                //                            NSLog(@"finally password -- %@",password);
                
            };
            
            [textView alertShow];
        };
        [textView alertShow];
    };
    [textView alertShow];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
