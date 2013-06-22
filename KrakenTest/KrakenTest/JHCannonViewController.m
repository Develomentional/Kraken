//
//  JHCannonViewController.m
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import "JHCannonViewController.h"
#include <QuartzCore/QuartzCore.h>

#define CANNON_BALL_WIDTH 20.0f

@interface JHCannonViewController ()

@end

@implementation JHCannonViewController

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
	// Do any additional setup after loading the view.
}


#pragma mark - public methods

-(void)fireCannonAtPoint:(NSValue*)targetLocationObject{
   
    if (_isAnimatingCannonBall)
        return; //can only fire one at a time
    
    CGPoint targetLocation = [targetLocationObject CGPointValue];
    
    int randomWindInfluenceX = arc4random() % 20;
    randomWindInfluenceX -= 10; //between -10 and 10
    
    int randomWindInfluenceY = arc4random() % 20;
    randomWindInfluenceY -= 10; //between -10 and 10
    
    targetLocation.x += randomWindInfluenceX;
    targetLocation.y +=randomWindInfluenceY;
    
    _isAnimatingCannonBall = TRUE;
    
    if (!self.cannonBall){
        self.cannonBall = [[JHCannonBall alloc]init];
        self.cannonBall.autoresizingMask = 0;
    }
    
    [self.cannonBall setFrame:CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y,CANNON_BALL_WIDTH,CANNON_BALL_WIDTH)];
    [self.view addSubview:self.cannonBall];
    
    
    CABasicAnimation *cannonBallAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    cannonBallAnimation.delegate = self;
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    cannonBallAnimation.duration = 1.0;
    cannonBallAnimation.fromValue = [self.cannonBall.layer valueForKey:@"position"];
    cannonBallAnimation.toValue = [NSValue valueWithCGPoint:targetLocation];
    // Update the layer's position so that the layer doesn't snap back when the animation completes.
    self.cannonBall.layer.position = targetLocation;
    // Add the animation, overriding the implicit animation.
    [self.cannonBall.layer addAnimation:cannonBallAnimation forKey:@"position"];
    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    _isAnimatingCannonBall = FALSE;
    
    CGRect resetFrame = CGRectMake(self.view.bounds.origin.x,self.view.bounds.origin.y,CANNON_BALL_WIDTH,CANNON_BALL_WIDTH);
    [self.cannonBall setFrame:resetFrame];
    self.cannonBall.layer.position = resetFrame.origin;
    
    [self.cannonBall removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
