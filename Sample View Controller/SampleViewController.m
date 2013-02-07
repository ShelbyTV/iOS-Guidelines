//
//  SampleViewController.m
//  Shelby.tv
//
//  Created by Arthur Ariel Sabintsev on 2/4/13.
//  Copyright (c) 2013 Arthur Ariel Sabintsev. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

#pragma mark - Memory Management Methods
- (void)dealloc
{
    // Release NSNotifications
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
    if ( [self isViewLoaded] && ![self.view window] ) {
        
        // Release your view
        
    }
    
}

#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) {
        
        // Your custom initialization goes here
        
    }
    
    return self;
}

#pragma mark - View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

#pragma mark - Action Methods
// Define your IBActions Here

#pragma mark - Public Methods
// Define your Public Methods here

#pragma mark - Private Methods
// Define your Private Methods here

@end
