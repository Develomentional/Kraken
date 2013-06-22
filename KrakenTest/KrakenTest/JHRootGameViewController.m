//
//  JHRootGameViewController.m
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import "JHRootGameViewController.h"
#include <QuartzCore/QuartzCore.h>

#define DEFAULT_KRAKEN_FRAME CGRectMake (400,200,200,200)
#define FIRE_CANNON_LEFT_VAR 20
#define FIRE_CANNON_RIGHT_VAR 19

@interface JHRootGameViewController ()

@end

@implementation JHRootGameViewController

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
    
    
    [self initKraken];//load kraken
    [self initLandObjects]; //load land objects with cannons
    
    
    //[self debugFireCannons];
    
    //load waves of civi ships
    //load waves of millitary ships
    
    
    [self initGameTimer];//setup update timer
}

#pragma mark - game object creation

-(void)initKraken{
    
    _krakenController = [[JHKrakenViewController alloc]init];
    _krakenController.view.autoresizesSubviews = NO;
    _krakenController.view.autoresizingMask = 0;
    [_krakenController.view setFrame:CGRectMake(100 , 0, 824, 768)];
    [self.view addSubview:_krakenController.view];
}

-(void)initLandObjects{
    
    _leftLandController = [[JHLandController alloc]init];
    _leftLandController.landPosition = JHLandPositionLeft;
    [self.view addSubview:_leftLandController.view];
    _leftLandController.view.autoresizingMask = 0;
    [_leftLandController.view setFrame:CGRectMake(0, 0, 100, self.view.bounds.size.width)];
    _leftLandController.view.backgroundColor = [UIColor greenColor];
    
    _rightLandController = [[JHLandController alloc]init];
    _rightLandController.landPosition = JHLandPositionRight;
    [self.view addSubview:_rightLandController.view];
    _rightLandController.view.autoresizingMask = 0;
    [_rightLandController.view setFrame:CGRectMake(self.view.bounds.size.height-100,0, 100, self.view.bounds.size.width)];
    _rightLandController.view.backgroundColor = [UIColor greenColor];
    
}

#pragma mark - game timer creation

-(void)initGameTimer{
    
    _gameTimer = [[CADisplayLink displayLinkWithTarget:self selector:@selector(update)] retain];
    [_gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


#pragma mark game timer callback

-(void)update{
    
    [self determineHitTests];
    [self determineLandCannonChance];
}

#pragma mark - game logic 

#pragma mark - Kraken hit detection


-(void)determineHitTests{
    
    NSArray *leftCannonLocations = [_leftLandController getCannonBallLocations];
    NSArray *rightCannonLocations = [_rightLandController getCannonBallLocations];
    
    BOOL krakenHitWithLeftCannon = [self wasKrakenHitWithPoints:leftCannonLocations];
    BOOL krakenHitWithRightCannon = [self wasKrakenHitWithPoints:rightCannonLocations];
    
    if (krakenHitWithLeftCannon || krakenHitWithRightCannon){
        
        if (_isAnimatingKrakenHit)
            return;
        
        _isAnimatingKrakenHit = TRUE;
        [UIView animateWithDuration:0.1 delay:0 options:0 animations:^{
            _krakenController.view.alpha = 0.2;
        } completion:^(BOOL finished) {
            _krakenController.view.alpha = 1;
            _isAnimatingKrakenHit = FALSE;
        }];
    }
}


-(BOOL)wasKrakenHitWithPoints:(NSArray*)valuesArray{
    //expects NSArray of NSValues formatted from CGPoints
    
    BOOL hitDetected = FALSE;
    for (NSValue *locationObject in valuesArray){
        
        CGPoint location = [locationObject CGRectValue].origin;
        CGRect krakenFrame = [self getAdjustedKrakenFrame];
        
        if (CGRectContainsPoint(krakenFrame,location)){
            hitDetected = TRUE;
        }
    }
    
    return hitDetected;
}

#pragma mark - random events

-(void)determineLandCannonChance{
   
    int cannonFireChance = arc4random() % 100;
    
    if (cannonFireChance == FIRE_CANNON_RIGHT_VAR){
        
        [_rightLandController fireCannonsAtLocation:[self getAdjustedKrakenLocationCenter]];
        
    }else if(cannonFireChance == FIRE_CANNON_LEFT_VAR){
        
        [_leftLandController fireCannonsAtLocation:[self getAdjustedKrakenLocationCenter]];
    }
}

#pragma mark - frame adjustment utilities 

-(CGPoint)getAdjustedKrakenLocationCenter{
    
    CGPoint krakenCenter = [self getAdjustedKrakenFrame].origin;
    krakenCenter.x = krakenCenter.x + ([_krakenController getPositionForKrakenBody].size.width /2);
    krakenCenter.y = krakenCenter.y + ([_krakenController getPositionForKrakenBody].size.height /2);
    
    return krakenCenter;
}

-(CGRect)getAdjustedKrakenFrame{
    
    CGRect krakenFrameAdjusted = [_krakenController getPositionForKrakenBody];
    krakenFrameAdjusted.origin.x += _krakenController.view.frame.origin.x;
    
    return krakenFrameAdjusted;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [_leftLandController release];
    _leftLandController = nil;
    
    [_rightLandController release];
    _rightLandController = nil;
    
    [_krakenController release];
    _krakenController = nil;
    
    [super dealloc];
}

@end
