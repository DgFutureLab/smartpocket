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

//- (id)initWithBeacon:(ESTBeacon*)beacon
//{
//    self = [self init];
//    if (self)
//    {
//        self.beaconForKey = beacon;
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.beaconManager1 = [[ESTBeaconManager alloc] init];
    self.beaconManager1.delegate = self;
    self.beaconManager2 = [[ESTBeaconManager alloc] init];
    self.beaconManager2.delegate = self;
    self.beaconManager3 = [[ESTBeaconManager alloc] init];
    self.beaconManager3.delegate = self;
    self.beaconManager4 = [[ESTBeaconManager alloc] init];
    self.beaconManager4.delegate = self;
    
    self.beaconRegion1 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:41374 minor:63236 identifier:@"region1"];//
    self.beaconRegion2 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:1639 minor:35798 identifier:@"region2"];// 緑
    self.beaconRegion3 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:26751 minor:29190 identifier:@"region3"];//青
    self.beaconRegion4 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:20826 minor:14135 identifier:@"region4"];//紫
    
    self.beaconRegion1.notifyOnEntry = true;
    self.beaconRegion1.notifyOnExit = true;
    self.beaconRegion2.notifyOnEntry = true;
    self.beaconRegion2.notifyOnExit = true;
    self.beaconRegion3.notifyOnEntry = true;
    self.beaconRegion3.notifyOnExit = true;
    self.beaconRegion4.notifyOnEntry = true;
    self.beaconRegion4.notifyOnExit = true;
    
    [self.beaconManager1 startRangingBeaconsInRegion:self.beaconRegion1];
    [self.beaconManager1 startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion1];
    [self.beaconManager1 startMonitoringForRegion:self.beaconRegion1];
    [self.beaconManager2 startRangingBeaconsInRegion:self.beaconRegion2];
    [self.beaconManager2 startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion2];
    [self.beaconManager2 startMonitoringForRegion:self.beaconRegion2];
    [self.beaconManager3 startRangingBeaconsInRegion:self.beaconRegion3];
    [self.beaconManager3 startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion3];
    [self.beaconManager3 startMonitoringForRegion:self.beaconRegion3];
    [self.beaconManager4 startRangingBeaconsInRegion:self.beaconRegion4];
    [self.beaconManager4 startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion4];
    [self.beaconManager4 startMonitoringForRegion:self.beaconRegion4];
    
    self.majorArray = @[self.major1, self.major2, self.major3, self.major4];
    self.minorArray = @[self.minor1, self.minor2, self.minor3, self.minor4];
    self.distArray  = @[self.dist1, self.dist2, self.dist3, self.dist4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)beaconManager:(ESTBeaconManager *)manager
//   didDetermineState:(CLRegionState)state
//           forRegion:(ESTBeaconRegion *)region{
//    NSLog(@"didDetermineState");
//}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
//    [self pushBeaconInfo];
    
    
    
    // message label
//    self   
//    
//    if ((unsigned long)self.beaconsArray.count >= 3) {
//        self.messageLabel.text = [NSString stringWithFormat:@"忘れ物なし！ %lu", (unsigned long)self.beaconsArray.count];
//        self.messageLabel.textColor = [UIColor blackColor];
//        self.messageLabel.backgroundColor = [UIColor greenColor];
//    }else{
//        self.messageLabel.text = [NSString stringWithFormat:@"忘れ物があります！ %lu", (unsigned long)self.beaconsArray.count];
//        self.messageLabel.textColor = [UIColor whiteColor];
//        self.messageLabel.backgroundColor = [UIColor blueColor];
//    }
    
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
    if (manager == self.beaconManager1) {
        self.beacon1 = [beacons objectAtIndex:0];
    }else if (manager == self.beaconManager2){
        self.beacon2 = [beacons objectAtIndex:0];
    }else if (manager == self.beaconManager3){
        self.beacon3 = [beacons objectAtIndex:0];
    }
//    [self pushBeaconInfo];
}

//- (void)pushBeaconInfo
//{
//    for (int i = 0; i < self.beaconsArray.count; i++) {
//        NSString *beaconMajorString = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
//        NSString *beaconMinorString = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
//        
//        NSNumber *beacondist = ((ESTBeacon *) self.beaconsArray[i]).distance;
//        
//        // Beacon Major
//        ((UILabel *) self.majorArray[i]).text = beaconMajorString;
//        
//        // Beacon Minor
//        ((UILabel *) self.minorArray[i]).text = beaconMinorString;
//        
//        // Beacon Distance
//        if ( (beacondist) && (![[beacondist stringValue] isEqualToString: @"-1"]) ) {
//            ((UILabel *) self.distArray[i]).text = [NSString stringWithFormat:@"%.02f", [beacondist floatValue]];
//            if ([beacondist floatValue] < 2.0) {
//                ((UILabel *) self.distArray[i]).backgroundColor = [UIColor colorWithRed:(2.0 - [beacondist floatValue])/2.0 green:0.0 blue:[beacondist floatValue]/2.0 alpha:1.0];
//            }
//        }
//    }
//}
#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region{
    if ([region.identifier isEqualToString:@"region1"]) {
        NSLog(@"beaconManager1 entered!");
        self.beacon1Image.hidden = false;
    }else if ([region.identifier isEqualToString:@"region2"]){
        NSLog(@"beaconManager2 entered!");
        self.beacon2Image.hidden = false;
    }else if ([region.identifier isEqualToString:@"region3"]){
        NSLog(@"beaconManager3 entered!");
        self.beacon3Image.hidden = false;
    }else if ([region.identifier isEqualToString:@"regionForKey"]){
        NSLog(@"beaconManagerForKey entered!");
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region{
    if ([region.identifier isEqualToString:@"region1"]) {
        NSLog(@"beaconManager1 exited!");
        self.beacon1Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Wallet!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if ([region.identifier isEqualToString:@"region2"]){
        NSLog(@"beaconManager2 exited!");
        self.beacon2Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Mac!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if ([region.identifier isEqualToString:@"region3"]){
        NSLog(@"beaconManager3 exited!");
        self.beacon3Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Notebook!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if ([region.identifier isEqualToString:@"region4"]){
        NSLog(@"beaconManager4 exited!");
        self.beacon4Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your umbrella!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}



@end
