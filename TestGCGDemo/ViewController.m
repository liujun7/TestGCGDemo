//
//  ViewController.m
//  TestGCGDemo
//
//  Created by liujun on 16/9/26.
//  Copyright © 2016年 Stanford University. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_queue_t seriaQueue = dispatch_queue_create("seriaQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t seriaQueue = dispatch_get_main_queue();
//    dispatch_queue_t currentQueue = dispatch_queue_create("currentQueue", DISPATCH_CURRENT_QUEUE_LABEL);
    dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(currentQueue, ^{
            NSLog(@"线程 = %@-->>%@",[NSThread currentThread],[NSString stringWithFormat:@"%d",i]);
        });
    }
    NSLog(@"线程结束了！！！！"); // 队列外的任务（主线程的任务）
    
}

- (IBAction)clickBtn:(UIButton *)sender {
    NSLog(@"按钮点击了哦");
}

// 笔记：此五点只针对第一层，不适用嵌套层
// 一、全局并发队列和自己创建的并发队列/自己创建的串行队列，同步提交，如果任务过多会造成UI界面暂时刷不出来，但没有开辟线程，在主线程中顺序执行（队列外的任务最后打印），当所有任务执行完毕后UI界面才显示且能交互

// 二、自己创建的并发队列/自己创建的串行队列，异步提交，会开辟一个子线程顺序执行，UI界面能出来且不会阻塞，但与队列外的任务会交错（即队列外的任务顺序不固定）

// 三、主队列同步提交会造成死锁，根本不会打印且UI界面也不会显示

// 四、主队列异步提交，没有开辟线程在主线程中顺序执行，队列外的任务先执行

// 五、全局并发队列异步执行，开辟N条线程，不按顺序执行，UI界面能显示出来且不会造成阻塞，与队列外的任务会交错（即队列外的任务顺序不固定）


@end
