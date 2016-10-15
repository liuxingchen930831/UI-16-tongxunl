//
//  XCContact.h
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCContact : NSObject<NSCoding>
/** 联系人姓名 */
@property(nonatomic,copy)NSString * name ;
/** 联系人手机号 */
@property(nonatomic,copy)NSString * phone ;
+(instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;
@end
