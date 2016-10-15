//
//  XCAddViewController.m
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "XCAddViewController.h"
#import "XCContact.h"


@interface XCAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *accButton;

@end

@implementation XCAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    [self.phoneField addTarget:self action:@selector(textChage) forControlEvents:UIControlEventEditingChanged];
    self.title = @"添加联系人";
}

-(void)textChage
{
    if (self.nameField.text.length >0 && self.phoneField.text.length>0) {
        self.accButton.enabled = YES;
    }
}
- (IBAction)addAction:(id)sender
{
    XCContact *c = [XCContact contactWithName:self.nameField.text phone:self.phoneField.text];
    self.addBlock(c);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
