//
//  ETViewController.m
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/18.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import "ETViewController.h"
#import <AudioToolbox/AudioServices.h>

@interface ETViewController () <ESTBeaconManagerDelegate>

@end

@implementation ETViewController

- (IBAction)switchValueChanged:(id)sender {
    NSLog(@"switch value changed");
    UISwitch *changedSwitch = sender;
    NSLog(@"tag:%ld", changedSwitch.tag);

    if (changedSwitch.isOn) {
        
    }else{
    
    }
}

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion
{
    self = [super init];
    if (self) {
        self.scanType = scanType;
        self.completion = [completion copy];
    }
    return self;
}

- (id)initWithBeacon:(ESTBeacon*)beacon
{
    self = [self init];
    if (self)
    {
        self.beaconForKey = beacon;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManagerForKey = [[ESTBeaconManager alloc] init];
    self.beaconManagerForKey.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    self.beaconRegionForKey = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:20826 minor:14135 identifier:@"foo"];//紫色のestimote
    
    self.beaconRegion.notifyOnEntry = true;
    self.beaconRegion.notifyOnExit = true;
    self.beaconRegionForKey.notifyOnEntry = true;
    self.beaconRegionForKey.notifyOnExit = true;
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
    [self.beaconManagerForKey startRangingBeaconsInRegion:self.beaconRegionForKey];
    [self.beaconManagerForKey startEstimoteBeaconsDiscoveryForRegion:self.beaconRegionForKey];
    [self.beaconManagerForKey startMonitoringForRegion:self.beaconRegionForKey];
    
    self.majorArray = @[self.major1, self.major2, self.major3, self.major4];
    self.minorArray = @[self.minor1, self.minor2, self.minor3, self.minor4];
    self.distArray  = @[self.dist1, self.dist2, self.dist3, self.dist4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beaconManager:(ESTBeaconManager *)manager
   didDetermineState:(CLRegionState)state
           forRegion:(ESTBeaconRegion *)region{
    NSLog(@"didDetermineState");
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if (manager == self.beaconManager) {
        NSLog(@"更新 NUM:%lu", (unsigned long)self.beaconsArray.count);
        self.beaconsArray = beacons;
    }
    [self pushBeaconInfo];
    //notification
    if ((unsigned long)self.beaconsArray.count >= 3) {
        self.messageLabel.text = [NSString stringWithFormat:@"忘れ物なし！ %lu", (unsigned long)self.beaconsArray.count];
        self.messageLabel.textColor = [UIColor blackColor];
        self.messageLabel.backgroundColor = [UIColor greenColor];
    }else{
        self.messageLabel.text = [NSString stringWithFormat:@"忘れ物があります！ %lu", (unsigned long)self.beaconsArray.count];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.backgroundColor = [UIColor blueColor];
    }
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
//    NSDate* date = [NSDate date];
//    NSString* dateStr = [formatter stringFromDate:date];
//    notification.alertBody = [NSString stringWithFormat:@"忘れ物発見!:%@", dateStr];
//    notification.applicationIconBadgeNumber = 1;
//    notification.soundName = UILocalNotificationDefaultSoundName;
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didDiscoverBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if (manager == self.beaconManager) {
        self.beaconsArray = beacons;
    }
    [self pushBeaconInfo];
}

- (void)pushBeaconInfo
{
    for (int i = 0; i < self.beaconsArray.count; i++) {
        NSString *beaconMajorString = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
        NSString *beaconMinorString = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
        
        NSNumber *beacondist = ((ESTBeacon *) self.beaconsArray[i]).distance;
        
        // Beacon Major
        ((UILabel *) self.majorArray[i]).text = beaconMajorString;
        
        // Beacon Minor
        ((UILabel *) self.minorArray[i]).text = beaconMinorString;
        
        // Beacon Distance
        if ( (beacondist) && (![[beacondist stringValue] isEqualToString: @"-1"]) ) {
            ((UILabel *) self.distArray[i]).text = [NSString stringWithFormat:@"%.02f", [beacondist floatValue]];
            if ([beacondist floatValue] < 2.0) {
                ((UILabel *) self.distArray[i]).backgroundColor = [UIColor colorWithRed:(2.0 - [beacondist floatValue])/2.0 green:0.0 blue:[beacondist floatValue]/2.0 alpha:1.0];
            }
        }
    }
}
#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = [NSString stringWithFormat:@"Enter region notification %lu", (unsigned long)self.beaconsArray.count];
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    //checking the estimote here
    NSLog(@"before notification NUM:%lu", (unsigned long)self.beaconsArray.count);
    [self.beaconRegion ]
    NSLog(@"ここ NUM:%lu", self);
    if (manager == self.beaconManagerForKey) {
        if ((unsigned long)self.beaconsArray.count >= 3) {
            UILocalNotification *notification = [UILocalNotification new];
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.alertBody = [NSString stringWithFormat:@"Exit region: 忘れ物なし！ %lu", (unsigned long)self.beaconsArray.count];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        } else{
            UILocalNotification *notification = [UILocalNotification new];
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.alertBody = [NSString stringWithFormat:@"Exit region: 忘れ物検知！ %lu", (unsigned long)self.beaconsArray.count];
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        }
    }
}



@end
