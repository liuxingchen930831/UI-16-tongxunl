//
//  XCLoginViewController.m
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "XCLoginViewController.h"
#import "MBProgressHUD+XMG.h"

#define XCuserInfo [NSUserDefaults standardUserDefaults]
static NSString *accountKey = @"account";
static NSString * pwdKey = @"pwd";
static NSString * remKey = @"rem";
static NSString * loginKey = @"login";

@interface XCLoginViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *remPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *tokenField;
@end

@implementation XCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.accountField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //UIControlEventEditingChanged键盘开始编辑枚举
    [self.tokenField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self readUserInfo];
    [self textChange];
}
/**
 *  读取用户保存信息
 */
-(void)readUserInfo
{
    NSString *account = [XCuserInfo objectForKey:accountKey];
    NSString *pwd = [XCuserInfo objectForKey:pwdKey];
    BOOL rmb = [XCuserInfo objectForKey:remKey];
    BOOL login = [XCuserInfo objectForKey:loginKey];
    
    self.accountField.text = account;
    if (rmb ==YES) {
        self.tokenField.text = pwd;
    }
    self.remPwdSwitch.on = rmb;
    self.autoLoginSwitch.on = login;
    //勾选自动登录
    if (login == YES) {
        [self LoginAction:nil];
    }
}

-(void)textChange
{
    if (self.accountField.text.length >0 && self.tokenField.text.length >0) {
        self.LoginButton.enabled = YES;
    }
}
- (IBAction)LoginAction:(id)sender
{
    if ([self.accountField.text isEqualToString:@"lxc"] &&[self.tokenField.text isEqualToString:@"lxc"]) {
        //保存用户信息
        [XCuserInfo setObject:self.accountField.text forKey:accountKey];
        [XCuserInfo setObject:self.tokenField.text forKey:pwdKey];
        [XCuserInfo setBool:self.remPwdSwitch.on forKey:remKey];
        [XCuserInfo setBool:self.autoLoginSwitch.on forKey:loginKey];
        
        [MBProgressHUD showMessage:@"success"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self performSegueWithIdentifier:@"login" sender:nil];
        });
    }else
    {
        [MBProgressHUD showError:@"error"];
    }
    
}
- (IBAction)autoLoginAction:(id)sender
{   //如果勾选自动登录，记住密码也要勾选
    if (self.autoLoginSwitch.on ==YES) {
        self.remPwdSwitch.on = YES;
    };
}
- (IBAction)remPwdAction:(id)sender
{   //如果取消记住密码，自动登录也要取消勾选
    if (self.remPwdSwitch.on ==NO) {
        self.autoLoginSwitch.on = NO;
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    vc.title = [NSString stringWithFormat:@"%@的联系人",self.accountField.text];
}
@end
