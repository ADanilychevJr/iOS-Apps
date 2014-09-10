//
//  QuizViewController.h
//  Quiz2
//
//  Created by Alex Danilychev, Jr. on 7/1/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController
{
    int currentQuestionIndex; // The model objects
    NSMutableArray *questions; NSMutableArray *answers;
    // The view objects - don't worry about IBOutlet - // we'll talk about it shortly
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}
    - (IBAction) showQuestion:( id) sender;
    - (IBAction) showAnswer:( id) sender;
    
    

@end
