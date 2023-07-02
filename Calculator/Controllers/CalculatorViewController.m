//
//  ViewController.m
//  Calculator
//
//  Created by Ангеліна Семенченко on 02.07.2023.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCalculator];
    [self createButtons];
    [self createLabel];
    [self setDefaultButtonColor];
}

- (void)setupCalculator {
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentOperand = nil;
    self.updatedOperand = [NSDecimalNumber zero];
    self.calculator = [[Operations alloc] init];
    self.operation = @"";
}

- (void)createButtons {
    NSArray *buttonTitles = @[@"C", @"+-", @"%", @"/",
                              @"7", @"8", @"9", @"×",
                              @"4", @"5", @"6", @"-",
                              @"1", @"2", @"3", @"+",
                              @"0", @"", @".", @"="];
    
    CGFloat buttonWidth = 80;
    CGFloat buttonHeight = 80;
    CGFloat spacing = 10;
    CGFloat xOffset = 30;
    CGFloat yOffset = CGRectGetMaxY(self.view.bounds) - (buttonHeight + spacing) * 6;
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [self createButtonWithFrame:CGRectMake(xOffset + (buttonWidth + spacing) * (i % 4), yOffset + (buttonHeight + spacing) * (i / 4), buttonWidth, buttonHeight) title:buttonTitles[i]];
        
        [self.view addSubview:button];
        
        if ([buttonTitles[i] isEqualToString:@"0"]) {
            button.frame = CGRectMake(xOffset, yOffset + (buttonHeight + spacing) * 4, buttonWidth * 2 + spacing, buttonHeight);
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        }
    }
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:36];
    button.layer.cornerRadius = button.frame.size.width / 2;
    button.layer.masksToBounds = YES;
    
    return button;
}

- (void)createLabel {
    CGFloat buttonWidth = 80;
    CGFloat buttonHeight = 80;
    CGFloat spacing = 10;
    CGFloat xOffset = 30;
    CGFloat yOffset = CGRectGetMaxY(self.view.bounds) - (buttonHeight + spacing) * 6;
    
    self.inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset - 100, buttonWidth * 4 + spacing * 3, 80)];
    self.inputLabel.textAlignment = NSTextAlignmentRight;
    self.inputLabel.font = [UIFont systemFontOfSize:72 weight:UIFontWeightThin];
    [self.view addSubview:self.inputLabel];
}

- (void)buttonTapped:(UIButton *)sender {
    NSString *buttonTitle = [sender titleForState:UIControlStateNormal];
    
    NSArray *operations = @[@"/", @"-", @"×", @"+"];
    
    if ([buttonTitle isEqualToString:@"="]) {
        [self handleEqualsButton];
    } else if ([buttonTitle isEqualToString:@"C"]) {
        [self handleClearButton];
    } else if ([operations containsObject:buttonTitle]) {
        [self handleOperationButton:buttonTitle withSender:sender];
    } else {
        [self handleNumberButton:buttonTitle];
    }
}

- (void)handleEqualsButton {
    if (self.inputLabel.text.length > 0) {
        NSDecimalNumber *currentInputValue = [NSDecimalNumber decimalNumberWithString:self.inputLabel.text];
        NSDecimalNumber *result = [NSDecimalNumber zero];
        
        if ([self.operation isEqualToString:@"+"]) {
            result = [self.calculator add:self.updatedOperand to:currentInputValue];
        } else if ([self.operation isEqualToString:@"-"]) {
            result = [self.calculator subtract:currentInputValue from:self.updatedOperand];
        } else if ([self.operation isEqualToString:@"×"]) {
            result = [self.calculator multiply:self.updatedOperand by:currentInputValue];
        } else if ([self.operation isEqualToString:@"/"]) {
            result = [self.calculator divide:self.updatedOperand by:currentInputValue];
        }
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.groupingSeparator = @" ";
        formatter.maximumFractionDigits = 6;
        formatter.minimumFractionDigits = 0;
        
        NSString *formattedResult = [formatter stringFromNumber:result];
        self.inputLabel.text = formattedResult;
        self.updatedOperand = result;
        [self setDefaultButtonColor];
    } else {
        self.inputLabel.text = @"";
        self.operation = @"";
        [self setDefaultButtonColor];
    }
}

- (void)handleClearButton {
    self.currentOperand = nil;
    self.updatedOperand = [NSDecimalNumber zero];
    self.operation = @"";
    self.inputLabel.text = @"";
    [self setDefaultButtonColor];
}

- (void)handleOperationButton:(NSString *)buttonTitle withSender:(UIButton *)sender {
    self.operation = buttonTitle;
    self.updatedOperand = [NSDecimalNumber decimalNumberWithString:self.inputLabel.text];
    self.inputLabel.text = @"";
    [self updateOperatorButtonColor:sender];
}

- (void)handleNumberButton:(NSString *)buttonTitle {
    if ([self.inputLabel.text isEqualToString:@"0"] || self.inputLabel.text == nil) {
        self.inputLabel.text = buttonTitle;
    } else {
        self.inputLabel.text = [NSString stringWithFormat:@"%@%@", self.inputLabel.text, buttonTitle];
    }
}

- (void)updateOperatorButtonColor:(UIButton *)selectedButton {
    [selectedButton setTitleColor:[UIColor systemOrangeColor] forState:UIControlStateNormal];
    [selectedButton setBackgroundColor:[UIColor whiteColor]];
    selectedButton.layer.borderWidth = 3.0;
    selectedButton.layer.borderColor = [UIColor systemOrangeColor].CGColor;
}

- (void)setDefaultButtonColor {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if ([button.titleLabel.text isEqualToString:@"/"] ||
                [button.titleLabel.text isEqualToString:@"-"] ||
                [button.titleLabel.text isEqualToString:@"×"] ||
                [button.titleLabel.text isEqualToString:@"+"] ||
                [button.titleLabel.text isEqualToString:@"="])
            {
                [button setBackgroundColor:[UIColor systemOrangeColor]];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            } else if ([button.titleLabel.text isEqualToString:@"C"] ||
                       [button.titleLabel.text isEqualToString:@"+-"] ||
                       [button.titleLabel.text isEqualToString:@"%"])
            {
                [button setBackgroundColor:[UIColor darkGrayColor]];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            } else {
                [button setBackgroundColor:[UIColor systemGray5Color]];
            }
        }
    }
}

@end
