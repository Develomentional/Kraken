//
//  JHKrakenViewController.m
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import "JHKrakenViewController.h"
#define DEFAULT_KRAKEN_BODY_FRAME CGRectMake(0,0,200,200)

@interface JHKrakenViewController ()

@end

@implementation JHKrakenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor orangeColor];
    [self initKrakenBody];
	// Do any additional setup after loading the view.
}

-(void)initKrakenBody{
    
    _krakenBody = [[JHKrakenBody alloc]init];
    _krakenBody.userInteractionEnabled = TRUE;
    [self.view addSubview:_krakenBody];
    [_krakenBody setFrame:DEFAULT_KRAKEN_BODY_FRAME];
    _krakenBody.backgroundColor = [UIColor redColor];
}

#pragma mark - public methods

-(CGRect)getPositionForKrakenBody{
    
    return _krakenBody.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [_krakenBody release];
    _krakenBody = nil;
    
    [super dealloc];
}

@end
