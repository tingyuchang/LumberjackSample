//
//  TTViewController.m
//  LumberjackSample
//
//  Created by Matt Chang on 2014/9/3.
//  Copyright (c) 2014年 Accuvally Inc. All rights reserved.
//

#import "TTViewController.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface TTViewController ()

- (NSArray*)getLogPath; // used to show all logs filepath

@end

@implementation TTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        DDLogVerbose(@"TTViewController init");
    }
    return self;
}

- (void)viewDidLoad {
    
    DDLogVerbose(@"TTViewController viewdidload");
    [super viewDidLoad];
    for (NSString *filePath in [self getLogPath]) {
        NSString * fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@", fileContents);
    }
    
}

#pragma mark - private

- (NSArray*)getLogPath {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString * logPath = [docPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSError * error = nil;
    NSArray * fileList = [[NSArray alloc]init];
    fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray * listArray = [[NSMutableArray alloc]init];
    
    for (NSString * oneLogPath in fileList) {
        NSString * truePath = [logPath stringByAppendingPathComponent:oneLogPath];
        [listArray addObject:truePath];
    }
    
    return listArray;

}

@end
