//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Alex Danilychev, Jr. on 7/27/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController
//SUPER IMPORTANT, REMOVES TEXT KEYBOARD WHEN BACKGROUND TAPPED
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get picked info from dataDictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //Store the image in BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    //Put that image on our original screen
    self.imageView.image = image;
    //Take imagepicker off the screen (must do this)
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    //You need an NSDateFormatter that will turn a date into a simple string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    }
    //Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    //Get the image with its imageKey from the imagestore
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    //Use the image to put on the screen in imageView
    self.imageView.image = imageToDisplay;
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //Clear first responder
    [self.view endEditing:YES];
    //Save the changes to the item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

@end
