//
//  ViewController.m
//  Hal Flashlight
//
//  Created by Łukasz Balcerzak on 8/17/12.
//  Copyright (c) 2012 Łukasz Balcerzak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    AVAudioPlayer *clickPlayer;
    AVAudioPlayer *lockingPlayer;
    AVAudioPlayer *unlockingPlayer;
}

@end

@implementation ViewController

@synthesize onButton = _onButton;
@synthesize offButton = _offButton;
@synthesize onImageView = _onImageView;
@synthesize offImageView = _offImageView;
@synthesize lockedImageView = _lockedImageView;
@synthesize unlockedImageView = _unlockedImageView;
@synthesize locked = _locked;

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url;
    
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Click" ofType:@"wav"]];
    clickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    clickPlayer.delegate = self;
    [clickPlayer prepareToPlay];
    
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Locking" ofType:@"wav"]];
    lockingPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    lockingPlayer.delegate = self;
    [lockingPlayer prepareToPlay];
    
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Carlock" ofType:@"wav"]];
    unlockingPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    unlockingPlayer.delegate = self;
    [unlockingPlayer prepareToPlay];
    
    _locked = NO;
}

- (IBAction)torchOn:(id)sender
{
    _onButton.hidden = YES;
    _offButton.hidden = NO;
    
    _onImageView.hidden = NO;
    _offImageView.hidden = YES;
    
    [self setTorchEnabled:YES];
    [self playSoundClick];
}

- (IBAction)torchOff:(id)sender
{
    if (_locked)
    {
        return;
    }
    _onButton.hidden = NO;
    _offButton.hidden = YES;
    
    _onImageView.hidden = YES;
    _offImageView.hidden = NO;
    
    [self setTorchEnabled:NO];
    [self playSoundClick];
}

- (void)setTorchEnabled:(BOOL)enabled
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isTorchAvailable] && [device isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [device lockForConfiguration:nil];
        if (success)
        {
            if (enabled) {
                [device setTorchMode:AVCaptureTorchModeOn];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            [device unlockForConfiguration];
        }        
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(BOOL)isTorchEnabled
{
    return _onImageView.hidden;
}

-(void)torchOnIfNeeded
{
    if (![self isTorchEnabled])
    {
        // it is enabled (or should be)
        [self setTorchEnabled:YES];
    }
}

-(void)playSoundClick
{
    [clickPlayer play];
}

-(void)playSoundLocking
{
    [lockingPlayer play];
}
  
- (IBAction)onLockClick:(UIButton *)sender
{
    if (!_locked)
    {
        _locked = YES;
        _lockedImageView.hidden = NO;
        _unlockedImageView.hidden = YES;
        [lockingPlayer play];
    }
    else
    {
        _locked = NO;
        _lockedImageView.hidden = YES;
        _unlockedImageView.hidden = NO;
        [unlockingPlayer play];
    }
}

@end
