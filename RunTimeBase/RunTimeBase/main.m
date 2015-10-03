//
//  main.m

#import <Foundation/Foundation.h>
//两个和运行时有关的头文件
#import <objc/runtime.h>
#import <objc/message.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //运行时的实现两个自定义方法的交换，就是说在我们执行的过程中，虽然执行的是run而结果确实study
        
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
//通过clang -rewrite-objc  main.m 可以知道 NSObject *object = [[NSObject alloc]init];转换为下列的c++语言
/**
 int main(int argc, const char * argv[]) {
{ __AtAutoreleasePool __autoreleasepool;
     
     NSObject *object = ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"));
     
 }
return 0;
}
替换：
 
 NSObject *obj = objc_msgSend(objc_getClass(@"NSObject"),sel_registerName("alloc"));
 
 objc_msgSend(obj ,sel_registerName("init"));

 */
