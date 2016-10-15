//
//  XCAddViewController.h
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCContact;
typedef void(^XCAddViewControllerBlock)(XCContact *);
@interface XCAddViewController : UIViewController
/** 模型 */
@property(nonatomic,strong)XCContact * contact ;
/** block传递模型 */
@property(nonatomic,copy)XCAddViewControllerBlock addBlock;

@end
