//
//  QuizViewController.m
//  Quiz
//
//  Created by Alex Danilychev, Jr. on 6/25/14.
//  Copyright (c) 2014 Alex Danilychev, Jr. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

- (id) initWithNibName:( NSString *) nibNameOrNil bundle:( NSBundle *) nibBundleOrNil {
    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Create two arrays and make the pointers point to them
        questions = [[ NSMutableArray alloc] init];
        answers = [[ NSMutableArray alloc] init];
        // Add questions and answers to the arrays
        [questions addObject:@" What is 7 + 7?"];
        [answers addObject:@" 14"];
        [questions addObject:@" What is the capital of Vermont?"];
        [answers addObject:@" Montpelier"];
        [questions addObject:@" From what is cognac made?"];
        [answers addObject:@" Grapes"];
    } // Return the address of the new object
    currentQuestionIndex = 0;
    return self;
}

-(IBAction)showQuestion:(id)sender {
    currentQuestionIndex++;
    
    if (currentQuestionIndex == [questions count]){
        currentQuestionIndex = 0;
    }
    NSString *question = [questions objectAtIndex:currentQuestionIndex];
    
    NSLog(@"Displaying question: %@", question);
    
    [questionField setText:question];
    [answerField setText:@"???"];
}

-(IBAction)showAnswer:(id)sender {
    NSString *answer = [answers objectAtIndex:currentQuestionIndex];
    [answerField setText:answer];
}
   

@end
