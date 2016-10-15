//
//  XCContactViewController.m
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "XCContactViewController.h"
#import "XCAddViewController.h"
#import "XCContact.h"
#import "XCEditViewController.h"
#define XCfilePath [ [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"contact.data"]
@interface XCContactViewController ()<UITableViewDelegate>
/** 数据源 */
@property(nonatomic,strong)NSMutableArray * contacts ;
/** 模型 */
@property(nonatomic,strong) XCContact * c ;
@end

@implementation XCContactViewController
-(NSMutableArray *)contacts
{
    if (_contacts ==nil) {
        //读档
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:XCfilePath];
    }
    // 判断有没有读取数据
    if (_contacts == nil) {
        _contacts = [NSMutableArray arrayWithCapacity:0];
    }
    return _contacts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)zhuxiao:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定注销吗" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    XCAddViewController *vc = segue.destinationViewController;

    vc.addBlock = ^(XCContact *c){
        [self.contacts addObject:c];
        [self.tableView reloadData];
        //在添加页面更新读档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:XCfilePath];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    XCContact *c = self.contacts[indexPath.row];
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.phone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     XCEditViewController * editVC = [sb instantiateViewControllerWithIdentifier:@"edit"];
    editVC.contact = self.contacts[indexPath.row];
    editVC.editBlock = ^{
        [self.tableView reloadData];
        //在编辑页面更新读档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:XCfilePath];
    };
    [self.navigationController pushViewController:editVC animated:YES];
}
//实现cell侧滑方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.删除模型
    [self.contacts removeObjectAtIndex:indexPath.row];
    //2.删除tableViewcell
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
//也可以实现cell侧滑方法
-(nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除模型
        [self.contacts removeObjectAtIndex:indexPath.row];
        //更新读档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:XCfilePath];
        //删除tableViewcell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"啥都不干" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"啥都不干");
    }];
    return @[action,action1];
}
@end
