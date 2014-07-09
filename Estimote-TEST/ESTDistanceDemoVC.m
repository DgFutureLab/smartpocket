//
//  ESTDistanceDemoVC.m
//  Examples
//
//  Created by Grzegorz Krukiewicz-Gacek on 17.03.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import "ESTDistanceDemoVC.h"
#import "ESTBeaconManager.h"

/*
 * Maximum distance (in meters) from beacon for which, the dot will be visible on screen.
 */
#define MAX_DISTANCE 20
#define TOP_MARGIN   150

@interface ESTDistanceDemoVC () <ESTBeaconManagerDelegate>


@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;

@property (nonatomic, strong) UIImageView       *backgroundImage;
@property (nonatomic, strong) UIImageView       *positionDot;
@end

@implementation ESTDistanceDemoVC
@synthesize beacon;
@synthesize beaconImage;
- (id)initWithBeacon:(ESTBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Radar";
    
    /*
     * UI setup.
     */
    
    self.backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"distance_bkg.png"]];
    self.backgroundImage.frame = [UIScreen mainScreen].bounds;
    self.backgroundImage.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.backgroundImage];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *beaconImageView = [[UIImageView alloc] initWithImage:self.beaconImage];
    beaconImageView.frame = CGRectMake(0, 0, 60, 60);
    [beaconImageView setCenter:CGPointMake(self.view.center.x, 100)];
    [self.view addSubview:beaconImageView];
    
    self.positionDot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dotImage.png"]];
    [self.positionDot setCenter:self.view.center];
    [self.view addSubview:self.positionDot];
    
    
    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.beaconManager stopRangingBeaconsInRegion:self.beaconRegion];
    
    [super viewDidDisappear:animated];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    ESTBeacon *firstBeacon = [beacons firstObject];
    
    [self updateDotPositionForDistance:[firstBeacon.distance floatValue]];
}

#pragma mark -

- (void)updateDotPositionForDistance:(float)distance
{
    NSLog(@"distance: %f", distance);
    
    float step = (self.view.frame.size.height - TOP_MARGIN) / MAX_DISTANCE;
    
    int newY = TOP_MARGIN + (distance * step);
    
    [self.positionDot setCenter:CGPointMake(self.positionDot.center.x, newY)];
}

@end
