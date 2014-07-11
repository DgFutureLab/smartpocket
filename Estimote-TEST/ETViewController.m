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

- (IBAction)beaconButton4Touched:(id)sender {
}

- (IBAction)switchValueChanged:(id)sender {
//    NSLog(@"switch value changed");
//    UISwitch *changedSwitch = sender;
//    NSLog(@"tag:%ld", changedSwitch.tag);
//
//    if (changedSwitch.isOn) {
//        
//    }else{
//    
//    }
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
    
    self.beaconRegion1 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:41374 minor:63236 identifier:@"region1"];//
    self.beaconRegion1.notifyOnExit = true;
    self.beaconRegion1.notifyOnEntry = true;
    self.beacon1StatusImageFound.hidden = true;
    self.beacon1StatusImageNotFound.hidden = true;
    
    self.beaconRegion2 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:1639 minor:35798 identifier:@"region2"];// 緑
    self.beaconRegion2.notifyOnExit = true;
    self.beaconRegion2.notifyOnEntry = true;
    self.beacon2StatusImageFound.hidden = true;
    self.beacon2StatusImageNotFound.hidden = true;
    
    self.beaconRegion3 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:26751 minor:29190 identifier:@"region3"];//青
    self.beaconRegion3.notifyOnExit = true;
    self.beaconRegion3.notifyOnEntry = true;
    self.beacon3StatusImageFound.hidden = true;
    self.beacon3StatusImageNotFound.hidden = true;

    self.beaconRegion4 = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID major:20826 minor:14135 identifier:@"region4"];//紫
    self.beaconRegion4.notifyOnExit = true;
    self.beaconRegion4.notifyOnEntry = true;
    self.beacon4StatusImageFound.hidden = true;
    self.beacon4StatusImageNotFound.hidden = true;

    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];

    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion1];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion1];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion2];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion2];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion3];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion3];
    
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion4];
    [self.beaconManager startMonitoringForRegion:self.beaconRegion4];

    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:self.beaconRegion];
    
    
    self.majorArray = @[self.major1, self.major2, self.major3, self.major4];
    self.minorArray = @[self.minor1, self.minor2, self.minor3, self.minor4];
    self.distArray  = @[self.dist1, self.dist2, self.dist3, self.dist4];
    
//    self.beacon1Image.layer.borderWidth = 3;
//    [self.beacon1Image.layer setBorderColor:[[UIColor redColor] CGColor]];
    
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
    NSLog(@"foo");
    for (int i = 0; i<beacons.count; i++) {
        NSLog(@"didDiscoverBeacon:%d", [beacons[i] major].intValue);
        if ([beacons[i] major].intValue  == 1639) {
            self.beacon1StatusImageFound.hidden = false;
            self.beacon1StatusImageNotFound.hidden = true;
        }else if ([beacons[i] major].intValue  == 26751){
            self.beacon2StatusImageFound.hidden = false;
            self.beacon2StatusImageNotFound.hidden = true;
        }else if ([beacons[i] major].intValue  == 20826){
            self.beacon3StatusImageFound.hidden = false;
            self.beacon3StatusImageNotFound.hidden = true;
        }else if ([beacons[i] major].intValue  == 41374 | [beacons[i] major].intValue == -24162){
            self.beacon4StatusImageFound.hidden = false;
            self.beacon4StatusImageNotFound.hidden = true;
        }
    }
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
    self.beaconsArray = beacons;


//    [self pushBeaconInfo];
}

//- (void)pushBeaconInfo
//{
//    
//    for (int i = 0; i < self.beaconsArray.count; i++) {
////        NSLog(@"%d", [[self.beaconsArray objectAtIndex:i] major].intValue);
//        NSString *beaconMajorString = [((ESTBeacon *) self.beaconsArray[i]).major stringValue];
//        NSString *beaconMinorString = [((ESTBeacon *) self.beaconsArray[i]).minor stringValue];
//        
//        NSNumber *beacondist = ((ESTBeacon *) self.beaconsArray[i]).distance;
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
    NSLog(@"entered!%d", region.major.intValue);
    if (region.major.intValue == 1639) {
        NSLog(@"beaconManager1 entered!");
        self.beacon1StatusImageFound.hidden = false;
        self.beacon1StatusImageNotFound.hidden = true;
    }else if (region.major.intValue == 26751){
        NSLog(@"beaconManager2 entered!");
        self.beacon2StatusImageFound.hidden = false;
        self.beacon2StatusImageNotFound.hidden = true;
    }else if (region.major.intValue == 20826){
        NSLog(@"beaconManager3 entered!");
        self.beacon3StatusImageFound.hidden = false;
        self.beacon3StatusImageNotFound.hidden = true;
    }else if (region.major.intValue == 41374){
        NSLog(@"beaconManager4 entered!");
        self.beacon4StatusImageFound.hidden = false;
        self.beacon4StatusImageNotFound.hidden = true;
    }
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region{
    NSLog(@"1:%d 2:%d 3:%d 4:%d", self.switch1.isOn, self.switch2.isOn, self.switch3.isOn, self.switch4.isOn);
    NSLog(@"Major%d :::check:%d", region.major.intValue, region.major.intValue == 41374);
    if (region.major.intValue == 1639 && self.switch1.isOn) {
        NSLog(@"beaconManager1 exited!");
        self.beacon1StatusImageFound.hidden = true;
        self.beacon1StatusImageNotFound.hidden = false;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Wallet!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == 26751 && self.switch2.isOn){
        NSLog(@"beaconManager2 exited!");
        self.beacon2StatusImageFound.hidden = true;
        self.beacon2StatusImageNotFound.hidden = false;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Mac!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == 20826 && self.switch3.isOn){
        NSLog(@"beaconManager3 exited!");
        self.beacon3StatusImageFound.hidden = true;
        self.beacon3StatusImageNotFound.hidden = false;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Notebook!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }else if (region.major.intValue == 41374){
        NSLog(@"beaconManager4 exited!");
        self.beacon4StatusImageFound.hidden = true;
        self.beacon4StatusImageNotFound.hidden = false;
        UILocalNotification *notification = [UILocalNotification new];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"You forgot your Umbrella!";
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
}

- (IBAction)beaconButtonTouched:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ESTDistanceDemoVC *distanceViewController = [segue destinationViewController];
    if([[segue identifier] isEqualToString:@"1"]) {
        distanceViewController.beacon = [self.beaconsArray objectAtIndex:0];
        distanceViewController.beaconImage = [UIImage imageNamed:@"wallet.jpg"];
      }
    else if ([[segue identifier] isEqualToString:@"2"]){
        distanceViewController.beacon = [self.beaconsArray objectAtIndex:0];
        distanceViewController.beaconImage = [UIImage imageNamed:@"mac.jpg"];
    }else if ([[segue identifier] isEqualToString:@"3"]){
        distanceViewController.beacon = [self.beaconsArray objectAtIndex:0];
        distanceViewController.beaconImage = [UIImage imageNamed:@"note.jpeg"];
    }else if ([[segue identifier] isEqualToString:@"4"]){
        distanceViewController.beacon = [self.beaconsArray objectAtIndex:0];
        distanceViewController.beaconImage = [UIImage imageNamed:@"umbrella.jpg"];
    }
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    bool doSegue = false;
    if([identifier isEqualToString:@"1"]) {
        if(!self.beacon1StatusImageFound.hidden){
            doSegue = true;
        }
    }else if ([identifier isEqualToString:@"2"]){
        if(!self.beacon2StatusImageFound.hidden){
            doSegue = true;
        }
    }else if ([identifier isEqualToString:@"3"]){
        if(!self.beacon3StatusImageFound.hidden){
            doSegue = true;
        }
    }else if ([identifier isEqualToString:@"4"]){
        if(!self.beacon4StatusImageFound.hidden){
            doSegue = true;
        }
    }
    return doSegue;
}

@end
