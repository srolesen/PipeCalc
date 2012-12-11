//
//  PlumberPickerViewController.m
//  PlumberPicker
//
//  Created by Simon Olesen on 10/12/12.
//  Copyright (c) 2012 Simon Olesen. All rights reserved.
//

#import "PlumberPickerViewController.h"

@interface PlumberPickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation PlumberPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
- (IBAction)laLa:(id)sender {
    NSLog(@"lalalalala %d",[_pickerView selectedRowInComponent:2]);
    
    // set variables here from selected row's
    float pipeWidth = (((float)[_pickerView selectedRowInComponent:0]+2)/8)*0.9;
    int pipeLength = [_pickerView selectedRowInComponent:1];
//    int mainsPressure = [_pickerView selectedRowInComponent:2];
    float tapConsumption = ((float)[_pickerView selectedRowInComponent:3]/5);

    
    // do calculation here
    float pipeVolume = 3.14*pipeLength*(pipeWidth/2)*(pipeWidth/2);
    float pipeLag = (pipeVolume/tapConsumption)*60;
    
    
    
    
    //write testresults to console:
    NSLog(@"pipeWidth %f", tapConsumption);
    NSLog(@"pipeLag %f", pipeLag);
    
    
    //write result to the label
    //int myInteger = [_pickerView selectedRowInComponent:2];
    NSString* myNewString = [NSString stringWithFormat:@"%0.1f s", pipeLag];
    self.label.text = myNewString;
}

@end
