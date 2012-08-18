//
//  ViewController.h
//  Hal Flashlight
//
//  Created by Łukasz Balcerzak on 8/17/12.
//  Copyright (c) 2012 Łukasz Balcerzak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    UIButton *_onButton;
    UIButton *_offButton;
    UIImageView *_onImageView;
    UIImageView *_offImageView;
}

@property (nonatomic, strong) IBOutlet UIButton *onButton;
@property (nonatomic, strong) IBOutlet UIButton *offButton;
@property (nonatomic, strong) IBOutlet UIImageView *onImageView;
@property (nonatomic, strong) IBOutlet UIImageView *offImageView;
@property (nonatomic, strong) IBOutlet UIImageView *lockedImageView;
@property (nonatomic, strong) IBOutlet UIImageView *unlockedImageView;
@property (nonatomic) BOOL locked;

-(void)torchOnIfNeeded;

@end
