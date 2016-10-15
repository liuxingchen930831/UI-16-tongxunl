//
//  XCContact.m
//  通讯录复习
//
//  Created by liuxingchen on 16/10/15.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "XCContact.h"
static NSString *name = @"name";
static NSString *phone = @"phone";
@implementation XCContact
+(instancetype)contactWithName:(NSString *)name phone:(NSString *)phone
{
    XCContact *c = [[self alloc]init];
    c.name = name;
    c.phone = phone;
    return c;
}
//归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:name];
    [aCoder encodeObject:self.phone forKey:phone];
}
//读档
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:name];
        self.phone = [aDecoder decodeObjectForKey:phone];
    }
    return self;
}
@end
