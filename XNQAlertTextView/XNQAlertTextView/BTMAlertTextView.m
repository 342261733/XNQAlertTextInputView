//
//  BTMAlertTextView.m
//  BitMainWallet_Hot
//
//  Created by xunianqiang on 15/7/9.
//  Copyright (c) 2015年 xunianqiang. All rights reserved.
//

#import "BTMAlertTextView.h"

//#import "ConstantCenter.h"
//#import "XNQAFNHttp.h"
//#import "BTMUserInfo.h"
//#import "BTMConnetionCenter.h"

//比例
#define BTMHEIGHTRATESCALE (BTMHeight>568?BTMHeight/568:1)
#define BTMWIDthRATESCALE (BTMWidth/320)

//size
#define BTMWidth [[UIScreen mainScreen] bounds].size.width
#define BTMHeight [[UIScreen mainScreen] bounds].size.height

@interface BTMAlertTextView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *alertTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertWarningLabel;
@property (weak, nonatomic) IBOutlet UITextField *alertTextField;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *myActivityIndicator;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewYOffSet;



//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineTtBottomHeight;



@end

@implementation BTMAlertTextView
{
    double currentKeyBoardOffset;
}


-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil]) {
        self.alertViewStyle = UIAlertViewStyleSecureTextInput;
        
        
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




-(instancetype)init
{
    if (self = [super init]) {
       self = [[[NSBundle mainBundle] loadNibNamed:@"BTMAlertTextView" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, BTMWidth, BTMHeight);
        self.alertTextField.delegate = self;
        
        self.bgImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBack:)];
        [self.bgImageView addGestureRecognizer:tap];
        
        [self registerForKeyboardNotifications];
        
        [self initLayout];
        [self.myActivityIndicator setHidden:YES];

    }
    return self;
}


-(void)initLayout
{
    self.bgViewWidth.constant = self.bgViewWidth.constant * BTMWIDthRATESCALE;
    self.bottomLineTtBottomHeight.constant = self.bottomLineTtBottomHeight.constant * BTMHEIGHTRATESCALE;
}


#pragma mark - set
-(void)setAlertTitle:(NSString *)alertTitle
{
    self.alertTitleLabel.text = alertTitle;
}

-(void)setAlertWarning:(NSString *)alertWarning
{
    _alertWarning = alertWarning;
    self.alertWarningLabel.text = alertWarning;
}


-(void)awakeFromNib
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}


-(void)alertShow
{
    UIWindow *keyWidow = [[UIApplication sharedApplication]keyWindow];
    [keyWidow addSubview:self];
}



-(void)alertHidden
{

    [UIView  animateWithDuration:0.5f animations:^{
        CAKeyframeAnimation * animation;
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.2)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];

        animation.values = values;
        [self.layer addAnimation:animation forKey:nil];
    } completion:^(BOOL finished) {
        self.alertTextField.delegate = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [self removeFromSuperview];
    }];


}



- (IBAction)btnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 200) {//确定
        
        if (self.alertTextField.text.length == 0) {
            [self alertWanringWithTitle:@"请输入密码"];
            return;
        }
        
        
        if (self.alertType == CHECKNETPASSWORD) {//验证密码页面
            [self.myActivityIndicator setHidden:NO];
            [self.myActivityIndicator startAnimating];
//            [self.myActivityIndicator stopAnimating];
           

                [self.myActivityIndicator stopAnimating];
                [self.myActivityIndicator setHidden:YES];
                
                self.passwordBack(self.alertTextField.text);
                [self alertHidden];

            //失败：
//                [self.myActivityIndicator stopAnimating];
//                [self.myActivityIndicator setHidden:YES];
//                [self alertWanringWithTitle:@"密码不正确"];
          
        }
        else if (self.alertType == SETNEWPASSWORD)//设置新密码
        {
            if (![self.alertTextField.text isEqualToString:self.firstPassword] && self.firstPassword != nil) {
                [self alertWanringWithTitle:@"两次密码输入不一致"];
                return;
            }
            else if ([self.alertTextField.text isEqualToString:self.firstPassword] && self.firstPassword != nil){
                [self.myActivityIndicator stopAnimating];
                [self.myActivityIndicator setHidden:YES];
                
                    [self.myActivityIndicator stopAnimating];
                    [self.myActivityIndicator setHidden:YES];
                    [self alertWanringWithTitle:@"密码修改成功"];
                    [self performSelector:@selector(finallayHidden) withObject:nil afterDelay:1.5];
                    

                //失败
//                    [self.myActivityIndicator stopAnimating];
//                    [self.myActivityIndicator setHidden:YES];
                
            }
            else{
                self.passwordBack(self.alertTextField.text);
                [self alertHidden];
            }
            
            
        }
        
        

    }
    else if (btn.tag == 201)
    {
        [self alertHidden];
    }
}

//返回最后的密码，可能会有用
-(void)finallayHidden{
    self.passwordBack(self.alertTextField.text);
    [self alertHidden];
}

-(void)alertWanringWithTitle:(NSString *)title
{
    UIButton *btn = (UIButton *)[self viewWithTag:200];
    [btn setEnabled:NO];
    [self.alertWarningLabel setHidden:NO];
    self.alertWarningLabel.text = title;
    
    [self performSelector:@selector(alertWanringHidden) withObject:nil afterDelay:1.5];
}

-(void)alertWanringHidden
{
    UIButton *btn = (UIButton *)[self viewWithTag:200];
    [btn setEnabled:YES];
    [self.alertWarningLabel setHidden:YES];
}

#pragma mark - textField delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)tapBack:(UITapGestureRecognizer *)myTap
{
    [self.alertTextField resignFirstResponder];
}


- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
}


- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;

    CGRect textfieldbounds;
    textfieldbounds=self.bgView.frame;
    if (BTMHeight-(self.bgView.frame.origin.y+self.bgView.bounds.size.height)<height) {
        
        float moveheight=height-(BTMHeight-(self.bgView.frame.origin.y+self.bgView.bounds.size.height));
        currentKeyBoardOffset = moveheight + 10;

        [UIView animateWithDuration:2.0f animations:^{
            self.bgViewYOffSet.constant = self.bgViewYOffSet.constant +currentKeyBoardOffset;
        }];
        
    }
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView  animateWithDuration:0.3f animations:^{
        self.bgViewYOffSet.constant = self.bgViewYOffSet.constant -currentKeyBoardOffset;
    }];
}


@end
