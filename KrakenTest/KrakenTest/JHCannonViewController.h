//
//  JHCannonViewController.h
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHCannonBall.h"

@interface JHCannonViewController : UIViewController{
    BOOL _isAnimatingCannonBall;
}

-(void)fireCannonAtPoint:(NSValue*)targetLocationObject;

@property(nonatomic,retain) JHCannonBall *cannonBall;

@end
