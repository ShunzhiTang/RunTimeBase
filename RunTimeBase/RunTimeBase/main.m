//
//  main.m
//  RunTimeBase
//
//  Created by mac on 15-10-3.
//  Copyright (c) 2015年 tsz. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import <objc/message.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Student *student = [[Student alloc]init];
        //打印
        [student study];
        [student run];
        
        //使用运行时进行交换
        
        //对象方法
        Method m1 = class_getInstanceMethod([student class], @selector(study));
        Method m2 = class_getInstanceMethod([student class], @selector(run));
        //类方法
        Method m3 = class_getClassMethod([Student class], @selector(test));
        
        method_exchangeImplementations(m3, m1);
        
        [student study];//打印跑步
    }
    return 0;
}
