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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID identifier:@"EstimoteSampleRegion"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion];
    
    
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
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
    
    
    
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
    self.beaconsArray = beacons;
    [self pushBeaconInfo];
}

- (void)pushBeaconInfo
{
    for (int i = 0; i < self.beaconsArray.count; i++) {
//        NSLog(@"%d", [[self.beaconsArray objectAtIndex:i] major].intValue);
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

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region{
    NSLog(@"Major 1%d", region.major.intValue);
    if (region.major.intValue == 1639) {
        NSLog(@"beaconManager1 entered!");
        self.beacon1Image.hidden = false;
    }else if (region.major.intValue == 26751){
        NSLog(@"beaconManager2 entered!");
        self.beacon2Image.hidden = false;
    }else if (region.major.intValue == 20826){
        NSLog(@"beaconManager3 entered!");
        self.beacon3Image.hidden = false;
    }else if (region.major.intValue == -24162){
        NSLog(@"beaconManager4 entered!");
        self.beacon4Image.hidden = false;
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region{
    NSLog(@"Major 1%d", region.major.intValue);
    if (region.major.intValue == 1639) {
        NSLog(@"beaconManager1 exited!");
        self.beacon1Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Wallet!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == 26751){
        NSLog(@"beaconManager2 exited!");
        self.beacon2Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Mac!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == 20826){
        NSLog(@"beaconManager3 exited!");
        self.beacon3Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Notebook!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == -24162){
        NSLog(@"beaconManager4 exited!");
        self.beacon4Image.hidden = true;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your umbrella!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}



@end
