//
//  ViewController.m
//  Hal Flashlight
//
//  Created by Łukasz Balcerzak on 8/17/12.
//  Copyright (c) 2012 Łukasz Balcerzak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize onButton = _onButton;
@synthesize offButton = _offButton;
@synthesize onImageView = _onImageView;
@synthesize offImageView = _offImageView;

- (IBAction)torchOn:(id)sender
{
    _onButton.hidden = YES;
    _offButton.hidden = NO;
    
    _onImageView.hidden = NO;
    _offImageView.hidden = YES;
    
    [self setTorchEnabled:YES];
}

- (IBAction)torchOff:(id)sender
{
    _onButton.hidden = NO;
    _offButton.hidden = YES;
    
    _onImageView.hidden = YES;
    _offImageView.hidden = NO;
    
    [self setTorchEnabled:NO];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

@end
