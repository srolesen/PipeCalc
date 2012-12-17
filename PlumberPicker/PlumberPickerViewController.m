//
//  PlumberPickerViewController.m
//  PlumberPicker
//
//  Created by Simon Olesen on 10/12/12.
//  Copyright (c) 2012 Simon Olesen. All rights reserved.
//

#import "PlumberPickerViewController.h"

@interface PlumberPickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pYear;
@property (weak, nonatomic) IBOutlet UILabel *wYear;
@property (weak, nonatomic) IBOutlet UILabel *wWater;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation PlumberPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        //init of the root.plist settings
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *settingsBundle =
        [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
        NSDictionary *settings =
        [NSDictionary dictionaryWithContentsOfFile:
         [settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
        
        NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
        NSMutableDictionary *defaultsToRegister =
        [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
        
        [defaults registerDefaults:defaultsToRegister];
        //end "init of the root.plist settings"
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 50;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        switch (row) {
            case 0:
                return @"inch";
                break;
            case 1:
                return @"3/8";
                break;
            case 2:
                return @"1/2";
                break;
            case 3:
                return @"5/8";
                break;
            case 4:
                return @"3/4";
                break;
            case 5:
                return @"7/8";
                break;
            case 6:
                return @"1''";
                break;
            default:
                return @"0";
        }
        
    }
    if (component == 1)
    {
        if (row == 0)
            return @"Meter";
        else
        {
            NSString* myNewString = [NSString stringWithFormat:@"%i", row];
        return myNewString;
        }
        
    }
    if (component == 2)
    {
        switch (row) {
            case 0:
                return @"Flow";
                break;
            case 1:
                return @"1";
                break;
            case 2:
                return @"2";
                break;
            case 3:
                return @"3";
                break;
            case 4:
                return @"4";
                break;
        }
        
    }
    else 
    {
        if (row == 0)
        return @"Use";
            else
            {
                float myFloat = (float)row;
                NSString* myNewString = [NSString stringWithFormat:@"%0.1f", myFloat/5];
                return myNewString;
            }
        
    }
    return @"damn, switch failure in picker";
}
//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{    
    // set variables here from selected row's
    float pipeWidth = (((float)[_pickerView selectedRowInComponent:0]+2)/8)*2.54*0.9;
    float pipeLength = (float)[_pickerView selectedRowInComponent:1];
    float tapConsumption = ((float)[_pickerView selectedRowInComponent:3]/5);
        //    int mainsPressure = [_pickerView selectedRowInComponent:2];
    
    // set variables here from Root.strings
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float wateruse =(float)([prefs floatForKey:@"wateruse_day"]);
    float waterprice = ([prefs floatForKey:@"m3_waterprice"]);
    NSLog(@"how many times a day the tap is turned on %f", wateruse);
    NSLog(@"how much does water cost %f", waterprice);

    
    //Let's print in the console what the user had chosen;
    NSLog(@"rørdiameter i cm %f",pipeWidth);
    
    
    
    // do calculation here
    float pipeVolume = 3.14*pipeLength*10*(pipeWidth/20)*(pipeWidth/20);
    float pipeLag = (pipeVolume/tapConsumption)*60;
    
    
    //write result to the label
    NSString* myNewString = [NSString stringWithFormat:@"%0.1f s", pipeLag];
    self.label.text = myNewString;
    NSString* myWaterString = [NSString stringWithFormat:@"%0.1f l", pipeVolume];
    self.wWater.text = myWaterString;
    NSString* myWaterYearString = [NSString stringWithFormat:@"%0.1f l", pipeVolume*wateruse*365];
    self.wYear.text = myWaterYearString;
    NSString* myPriceYear = [NSString stringWithFormat:@"%0.1f kr", pipeVolume*wateruse*365*waterprice*0.001];
    self.pYear.text = myPriceYear;
}
@end
