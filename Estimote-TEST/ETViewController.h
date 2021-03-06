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
#import "ESTDistanceDemoVC.h"
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

@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion1;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion2;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion3;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion4;

@property (nonatomic, strong) NSArray *beaconsArray;

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

@property (weak, nonatomic) IBOutlet UIButton *beaconButton1;
@property (weak, nonatomic) IBOutlet UIButton *beaconButton2;
@property (weak, nonatomic) IBOutlet UIButton *beaconButton3;
@property (weak, nonatomic) IBOutlet UIButton *beaconButton4;

@property (weak, nonatomic) IBOutlet UIImageView *beacon1StatusImageFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon2StatusImageFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon3StatusImageFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon4StatusImageFound;

@property (weak, nonatomic) IBOutlet UIImageView *beacon1StatusImageNotFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon2StatusImageNotFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon3StatusImageNotFound;
@property (weak, nonatomic) IBOutlet UIImageView *beacon4StatusImageNotFound;


- (IBAction)beaconButtonTouched:(id)sender;

- (IBAction)switchValueChanged:(id)sender;

- (id)initWithScanType:(ESTScanType)scanType completion:(void (^)(ESTBeacon *))completion;

@end
