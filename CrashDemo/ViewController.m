//
//  ViewController.m
//  CrashDemo
//
//  Created by ptx on 2019/10/17.
//  Copyright © 2019 ptx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickToCrash:(id)sender {
    [self performSelectorOnMainThread:@selector(addO) withObject:nil waitUntilDone:NO];
}

@end
