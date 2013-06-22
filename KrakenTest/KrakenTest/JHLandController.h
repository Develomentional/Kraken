//
//  JHLandController.h
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCannonViewController.h"

typedef enum{
    JHLandPositionLeft,
    JHLandPositionRight
}JHLandPosition;

@interface JHLandController : UIViewController{
    NSMutableArray *_cannonHolder;
}

-(void)reloadCannons; //removes existing cannons and creates new cannons based on the numberOfCannons property
-(void)fireCannonsAtLocation:(CGPoint)location;
-(NSArray*)getCannonBallLocations;

@property(nonatomic,assign) JHLandPosition landPosition;
@property(nonatomic,assign) int numberOfCannons;

@end
