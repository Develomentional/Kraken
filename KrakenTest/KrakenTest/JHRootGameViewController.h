//
//  JHRootGameViewController.h
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHLandController.h"
#import "JHKrakenViewController.h"

@interface JHRootGameViewController : UIViewController{
    JHLandController *_leftLandController;
    JHLandController *_rightLandController;
   
    JHKrakenViewController *_krakenController;
    
    CADisplayLink *_gameTimer;
    
    BOOL _isAnimatingKrakenHit;
}

@end
