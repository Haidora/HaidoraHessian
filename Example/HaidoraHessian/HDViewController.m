//
//  HDViewController.m
//  HaidoraHessian
//
//  Created by mrdaios on 04/06/2015.
//  Copyright (c) 2014 mrdaios. All rights reserved.
//

#import "HDViewController.h"
#import "HDServiceProvider+HDTest.h"

@interface HDViewController ()

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (NSInteger i = 0; i < 10; i++)
    {
        NSLog(@"%@", [[HDServiceProvider shareTestService] login:@"test13" password:@"1" imei:nil]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
