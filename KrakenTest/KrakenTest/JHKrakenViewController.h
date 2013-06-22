//
//  JHKrakenViewController.h
//  KrakenTest
//
//  Created by justin howlett on 2012-12-01.
//  Copyright (c) 2012 JustinHowlett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHKrakenBody.h"

@interface JHKrakenViewController : UIViewController{
    JHKrakenBody *_krakenBody;
}

-(CGRect)getPositionForKrakenBody;


@end
