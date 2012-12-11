//
//  PlumberPickerViewController.h
//  PlumberPicker
//
//  Created by Simon Olesen on 10/12/12.
//  Copyright (c) 2012 Simon Olesen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlumberPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property(nonatomic, assign) id<UIPickerViewDelegate> delegate;
@end
