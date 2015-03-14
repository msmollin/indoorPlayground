//
//  ViewController.m
//  indoorPlayground
//
//  Created by Matt Smollinger on 3/12/15.
//  Copyright (c) 2015 Matt Smollinger. All rights reserved.
//

#import "ViewController.h"
#import <EstimoteIndoorSDK/ESTIndoorLocationManager.h>
#import <EstimoteIndoorSDK/ESTLocationBuilder.h>

@interface ViewController () <ESTIndoorLocationManagerDelegate>
@property (nonatomic, strong) ESTIndoorLocationManager *indoorLocationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    ESTLocationBuilder *locationBuilder = [ESTLocationBuilder new];
    [locationBuilder setLocationBoundaryPoints:@[
                                                 [ESTPoint pointWithX:0 y:0],
                                                 [ESTPoint pointWithX:0 y:5],
                                                 [ESTPoint pointWithX:5 y:5],
                                                 [ESTPoint pointWithX:5 y:0]]];

    [locationBuilder setLocationOrientation:0];
    //iPad
    [locationBuilder addBeaconIdentifiedByMac:@"b8e85689dbb0"
                       atBoundarySegmentIndex:0
                                   inDistance:2
                                     fromSide:ESTLocationBuilderLeftSide];

    //Mint
    [locationBuilder addBeaconIdentifiedByMac:@"dd1fb6b452fd"
                       atBoundarySegmentIndex:1
                                   inDistance:2
                                     fromSide:ESTLocationBuilderLeftSide];
    //Ice Light Blue

    [locationBuilder addBeaconIdentifiedByMac:@"d30be2d48180"
                       atBoundarySegmentIndex:2
                                   inDistance:2
                                     fromSide:ESTLocationBuilderLeftSide];
    //Ice Dark Blue
    [locationBuilder addBeaconIdentifiedByMac:@"e71a721081ee"
                       atBoundarySegmentIndex:3
                                   inDistance:2
                                     fromSide:ESTLocationBuilderLeftSide];

    ESTLocation *myLocation = [locationBuilder build];
    self.indoorLocationManager = [ESTIndoorLocationManager new];
    self.indoorLocationManager.delegate = self;
    [self.indoorLocationManager startIndoorLocation:myLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LocationManager

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager
            didUpdatePosition:(ESTOrientedPoint *)position
                   inLocation:(ESTLocation *)location
{
    NSLog(@"Position - %@, Location - %@", position, location);
}

- (void)indoorLocationManager:(ESTIndoorLocationManager *)manager
didFailToUpdatePositionWithError:(NSError *)error
{
    NSLog(@"Errored - %@", error);
}

@end
