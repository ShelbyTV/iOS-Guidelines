//
//  SPModel.m
//  Shelby.tv
//
//  Created by Arthur Ariel Sabintsev on 2/4/13.
//  Copyright (c) 2013 Arthur Ariel Sabintsev. All rights reserved.
//


@interface SampleSingleton ()

@end

@implementation SampleSingleton

#pragma mark - Singleton Methods
+ (SampleSingleton*)sharedInstance
{
    static SampleSingleton *sharedInstance = nil;
    static dispatch_once_t sampleSingletonToken = 0;
    dispatch_once(&sampleSingletonToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    
    return sharedInstance;
}

@end
