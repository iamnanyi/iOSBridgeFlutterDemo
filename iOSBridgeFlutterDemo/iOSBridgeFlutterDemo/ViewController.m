//
//  ViewController.m
//  iOSBridgeFlutterDemo
//
//  Created by zhaobin on 2019/7/3.
//  Copyright © 2019 zhaobin. All rights reserved.
//

#import <Flutter/Flutter.h>
#import "ViewController.h"

@interface ViewController () <FlutterStreamHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clicked:(id)sender {
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    flutterViewController.navigationItem.title = @"EventChannel Demo";
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_post";
    
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterViewController];
    // 代理
    [evenChannal setStreamHandler:self];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
}

#pragma mark - FlutterStreamHandler

// 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(FlutterEventSink)events {
    // arguments flutter给native的参数
    // 回调给flutter， 建议使用实例指向，因为该block可以使用多次
    if (events) {
        events(@"我是标题");
    }
    return nil;
}

// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    return nil;
}

@end
