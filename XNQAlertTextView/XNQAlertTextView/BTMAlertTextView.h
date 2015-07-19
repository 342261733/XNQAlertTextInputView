//
//  BTMAlertTextView.h
//  BitMainWallet_Hot
//
//  Created by xunianqiang on 15/7/9.
//  Copyright (c) 2015年 xunianqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CHECKNETPASSWORD,
    SETNEWPASSWORD,
} ALERTTYPE;
typedef void (^PasswordBack) (NSString *);


@interface BTMAlertTextView : UIAlertView


@property (copy,nonatomic) PasswordBack passwordBack;

@property (copy,nonatomic) NSString *alertTitle;
@property (copy,nonatomic) NSString *alertWarning;//可选
@property (copy,nonatomic) NSString *firstPassword;
@property (assign,nonatomic) ALERTTYPE alertType;//alert，类型

-(instancetype)init;

-(void)alertShow;
-(void)alertHidden;



@end
