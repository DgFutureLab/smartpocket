//
//  ETViewController.h
//  Estimote-TEST
//
//  Created by アンディット ヘリスティヨ on 2014/06/18.
//  Copyright (c) 2014年 Digital Garage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>
#import <ESTBeacon.h>

typedef enum : int
{
    ESTScanTypeBlueTooth,
    ESTScanTypeBeacon
} ESTScanType;

@interface ETViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UISwitch *switch4;

@property (nonatomic, copy) void (^completion)(ESTBeacon *);
@property (nonatomic, assign) ESTScanType scanType;

// 管理するもののセンサー郡
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;
@property (strong, nonatomic) NSArray *beaconsArray;

// keyとなるセンサー
@property (nonatomic, strong) ESTBeaconManager *beaconManagerForKey;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegionForKey;
@property (nonatomic, strong) ESTBeacon         *beaconForKey;

@property (strong, nonatomic) IBOutlet UILabel *major1;
@property (strong, nonatomic) IBOutlet UILabel *minor1;
@property (strong, nonatomic) IBOutlet UILabel *dist1;
@property (strong, nonatomic) IBOutlet UILabel *major2;
@property (strong, nonatomic) IBOutlet UILabel *minor2;
@property (strong, nonatomic) IBOutlet UILabel *dist2;
@property (strong, nonatomic) IBOutlet UILabel *major3;
@property (strong, nonatomic) IBOutlet UILabel *minor3;
@property (strong, nonatomic) IBOutlet UILabel *dist3;
@property (strong, nonatomic) IBOutlet UILabel *major4;
@property (strong, nonatomic) IBOutlet UILabel *minor4;
@property (strong, nonatomic) IBOutlet UILabel *dist4;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) NSArray *majorArray;
@property (strong, nonatomic) NSArray *minorArray;
@property (strong, nonatomic) NSArray *distArray;

- (IBAction)switchValueChanged:(id)sender;

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion;

@end
