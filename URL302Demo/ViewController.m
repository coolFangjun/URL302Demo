//
//  ViewController.m
//  URL302Demo
//
//  Created by 小宸宸Dad on 16/5/30.
//  Copyright © 2016年 fj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSMutableURLRequest *quest = [NSMutableURLRequest requestWithURL:url];
    quest.HTTPMethod = @"GET";
    NSURLConnection *connect = [NSURLConnection connectionWithRequest:quest delegate:self];
    [connect start];

    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:quest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        
        NSLog(@"%ld",urlResponse.statusCode);
        NSLog(@"%@",urlResponse.allHeaderFields);
        
        NSDictionary *dic = urlResponse.allHeaderFields;
        NSLog(@"%@",dic[@"Location"]);
        
    }];
    
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler{

    completionHandler(nil);


}


- (nullable NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(nullable NSURLResponse *)response{

    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"%ld",urlResponse.statusCode);
    NSLog(@"%@",urlResponse.allHeaderFields);
    
    NSDictionary *dic = urlResponse.allHeaderFields;
    NSLog(@"%@",dic[@"Location"]);
    
    return request;


}








@end
