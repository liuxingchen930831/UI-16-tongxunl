//
//  XCEditViewController.m
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "XCEditViewController.h"
#import "XCContact.h"
@interface XCEditViewController ()
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@end

@implementation XCEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButton)];
     self.nameField.text = self.contact.name;
     self.phoneField.text = self.contact.phone;
    self.title = @"修改联系人";
}
-(void)rightBarButton
{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"取消";
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        self.changeButton.enabled = YES;
    }else if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"取消"]){
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        
    }
}
- (IBAction)changeAction:(id)sender
{
    self.contact.name = self.nameField.text ;
    self.contact.phone = self.phoneField.text;
    self.editBlock();
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
