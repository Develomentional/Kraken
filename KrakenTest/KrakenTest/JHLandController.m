//
//  JHLandController.m
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import "JHLandController.h"
#include <QuartzCore/QuartzCore.h>

#define DEFAULT_CANNON_NUMBER 3

@interface JHLandController ()

@end

@implementation JHLandController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _cannonHolder = [[NSMutableArray alloc]init];
        self.numberOfCannons = DEFAULT_CANNON_NUMBER; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizingMask = 0;
    [self createCannons]; //create first set of default cannons
	// Do any additional setup after loading the view.
}

-(void)createCannons{
    
    CGRect debugCannonFrame = CGRectMake(0, 300, 50, 30); //hard-coded frame :(
    
    for (int i=0; i<self.numberOfCannons; i++){
        
        JHCannonViewController *newCannon = [[JHCannonViewController alloc]init];
        [self.view addSubview:newCannon.view];
        [newCannon.view setFrame:debugCannonFrame];
        newCannon.view.backgroundColor = [UIColor brownColor];
        newCannon.view.autoresizingMask = 0;
        [_cannonHolder addObject:newCannon];
        [newCannon release];
        
        debugCannonFrame.origin.y +=100;
    }
}

#pragma mark - public methods 

-(void)reloadCannons{
    
    [_cannonHolder removeAllObjects];
    [self createCannons];
}

-(void)fireCannonsAtLocation:(CGPoint)location{
    
    for (JHCannonViewController *cannon in _cannonHolder){
        
        CGPoint adjustedLocation; //adjust location for relative positioning of cannon and land
        adjustedLocation.y = (location.y - cannon.view.frame.origin.y)-(cannon.cannonBall.frame.size.height/2);
        adjustedLocation.x = (location.x - cannon.view.frame.origin.x)-(cannon.cannonBall.frame.size.width/2)-self.view.frame.origin.x;
    
        int randomDelay = arc4random() % 30;
        float timeDelay = (float)randomDelay/100;
        
        [cannon performSelector:@selector(fireCannonAtPoint:) withObject:[NSValue valueWithCGPoint:adjustedLocation] afterDelay:timeDelay];
    }
}

-(NSArray*)getCannonBallLocations{
    
    NSMutableArray *cannonLocations = [[NSMutableArray alloc]init];
    
    for (JHCannonViewController *cannon in _cannonHolder){
        
        CALayer *cannonBallPresentationLayer = (CALayer *)[cannon.cannonBall.layer presentationLayer]; //access presentation layer to get value during anim
        
        CGRect adjustedRect = cannonBallPresentationLayer.frame;
        adjustedRect.origin.y += cannon.view.frame.origin.y;
        adjustedRect.origin.x += cannon.view.frame.origin.x;
        adjustedRect.origin.x +=self.view.frame.origin.x;
        
        NSValue *cannonBallPointObj = [NSValue valueWithCGRect:adjustedRect]; //convert to object to store in array
        [cannonLocations addObject:cannonBallPointObj];
    }
    
    return [cannonLocations autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [_cannonHolder release];
    _cannonHolder = nil;
    
    [super dealloc];
}

@end
