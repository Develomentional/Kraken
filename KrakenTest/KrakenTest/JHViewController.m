//
//  JHViewController.m
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import "JHViewController.h"

@interface JHViewController ()

@end

@implementation JHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    JHRootGameViewController *actualGame = [[JHRootGameViewController alloc]init];
    [actualGame.view setFrame:self.view.bounds];
    [self.view addSubview:actualGame.view];
    [actualGame release];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
