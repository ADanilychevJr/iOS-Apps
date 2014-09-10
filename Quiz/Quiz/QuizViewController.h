//
//  QuizViewController.h
//  Quiz
//
//  Created by Alex Danilychev, Jr. on 6/25/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController
{
    NSMutableArray *answers;
    NSMutableArray *questions;
    
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
    
    int currentQuestionIndex;
}
    - (IBAction)showQuestion: (id) sender;
    - (IBAction)showAnswer: (id) sender;

@end
