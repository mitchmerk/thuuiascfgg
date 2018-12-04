//
//  ViewController.swift
//  phoneCalc
//
//  Created by Jacob Levy on 11/10/18.
//  Copyright © 2018 Jacob Levy. All rights reserved.
/**
The algorithm contained in this file, as well as the concept of the project is proprietary and using either for profit
without express written permission constitutes a form of plagiarism and theft. This project and algorithm may be re
-distributed freely and wholly, or in part, for purely educational and not-for-profit purposes as long as this statement
is included.
Removing this statement does not negate the rights of the Author (Jacob Levy).
*/


/*:
The Phone Calculator Project.
### This project is inspired by the video for a similar ( but simpler ) watchOS calculator  located [here]
(@https://www.lynda.com/Apple-Watch-tutorials/Displaying-tapped-numbers-calculator/418269/434721-4.html?org=rowan.edu).
_The relevant videos to help you get started are located in Chapter 2 (Displaying tapped numbers in the
Calculator, Making the Clear Button Clear All Values, Setting the Calculator to Add or Subtract, and Showing
the total when the equals button is tapped)_.

*****/
import UIKit

/**
operationMode is an enum that describes the current mode of the calculator.  There are 7 modes.  5 for the integer
math operations (ADD, SUB, MUL, DIV, MOD)
1 state that signals that there has been some sort of error (ERR), and 1
to indicate that the app is  either just starting up or the = button has been tapped.
The two errors that might occur are either overflow error (the result is greater than 11 characters and cannot be
shown in its entirety) or division by zero error (if you allow your calculator to divide by 0, you'll experience a
runtime error and crash).
If either of these errors occur, your app should display a distinct and meaningful message to the user via the the
inputLine label.
**/
enum operationMode{
	case ADD
	case SUB
	case MUL
	case DIV
	case MOD
	case EQL
	case ERR
	case NON
}
/**
*  the ViewController class is the C in the MVC design pattern.  Its sending the data to our views on screen.*/
class ViewController: UIViewController {
	
	/**
	the Feed that starts off by saying *"This is History"*.   There's room for anywhere up to 8 lines
	of text on this label.  You must keep track of NO LESS than the previous 5 operations in a feed that moves up the
	screen.
	*/
	@IBOutlet weak var HistoryLabel: UILabel!
	
	///The input "screen" for our calculator.  The inputLine displays tapped numbers and results of calculations.
	@IBOutlet weak var inputLine: UILabel!
	
	
	//	Flags for managing the calculator.
	
	
	///  signals that an operation was tapped before this code is run
	var justTappedOP = false
	/// signals that = was tapped before this code is run
	var tappedEQL = false
	/// signals that either we are currently entering a number or just entered a number
	var enteringNumber = false
	/// signals whether or not the inputLine was just cleared
	var justClearedLine = false
	/// tracks how many numbers have been entered.  used to manage the HistoryLabel
	var numEntries = 0
	/// tracks the saved num, this stores the result of the most recent calculation
	var savedNum: Int = 0
	///Stores the number that is currently on the inputLine
	var currentNum: Int = 0
	
	///tracks the current operation mode
	var currentMode: operationMode = operationMode.NON
	//keeps track of the previous operation mode
	var prevMode: operationMode = operationMode.NON
	///String that represents the number on the input line
	var inputString = "0"



	/**
	This is a more complicated version of the pre-checks performed in the Lynda video series.
	
	- PreCondition: None
	
	- PostCondition: A decision about whether we can or cannot enter a number has been made.
	
	 __Algorithm__:
	
	make sure that the input line was not just cleared.
	Otherwise display "Choose op" on the input and return false
	
	 If the currentMode is .ERR, clear the history.

	If the = button was just tapped (you need to determine what to check), reset the savedNum and whatever flags should be set
	
	If we weren't entering a number before this
			Otherwise set the approptiate booleans for just tappedOp and enteringNumbera, and set the line text to an
	empty string
	return true
	
	*/
	func passChecks() -> Bool{
		
		return false
	}
	/**
	The button tap functions.  Each Numeric button must make sure they run passChecks successfully or else they should
	have no effect.  If passChecks is successful then the updateValue method is called with the appropriate numeric
	value*/
	@IBAction func didTap1(){
		
		guard passChecks() else {
			return
		}
			updateValue(num: 1)
	}
	@IBAction func didTap2(){
		
		guard passChecks() else {
			return
		}
			updateValue(num: 2)
		
	}
	@IBAction func didTap3(){
	
		guard passChecks() else {
			return
		}
			updateValue(num: 3)
		
	}
	@IBAction func didTap4(){
	
		guard passChecks() else {
			return
		}
			updateValue(num: 4)
		
	}
	@IBAction func didTap5(){
	
		guard passChecks() else {
			return
		}
			updateValue(num: 5)
		
	}
	@IBAction func didTap6(){
		
		guard passChecks() else {
			return
		}
			updateValue(num: 6)
		
	}
	@IBAction func didTap7(){

		guard passChecks() else {
			return
		}
		updateValue(num: 7)
		
	}
	@IBAction func didTap8(){

		guard passChecks() else {
			return
		}
		updateValue(num: 8)
		
	}
	@IBAction func didTap9(){

		guard passChecks() else {
			return
		}
		updateValue(num: 9)
		
	}
	@IBAction func didTap0(){

		guard passChecks() else {
			return
		}
		updateValue(num: 0)
		
	}
	
	
	//Actions corresponding to tapping the aritmetic operations
	//All of these methods call tappedOperation and pass in their corresponding operationMode value
	///Runs when the + button was tapped
	@IBAction func didTapPlus(){
		
		tappedOperation(op: .ADD)
	}
	///Runs when the - button was tapped
	@IBAction func didTapSubt(){
		tappedOperation(op: .SUB)
		
	}
	///Runs when the x button was tapped
	@IBAction func didTapMult() {
		tappedOperation(op: .MUL)
		
	}
	///Runs when the ÷ button was tapped
	@IBAction func didTapDiv(){
		tappedOperation(op: .DIV)
		
	}
	///Runs when the % button was tapped
	@IBAction func didTapMod(){
		tappedOperation(op: .MOD)
		
	}
	
	
	/**
	clears out current (most recently typed) number and (most recently chosen) Mode

	- PreCondition: None, but assumes some number  has been entered and some mode has been chosen (has no effect
	otherwise)
	
	- PostCondition: justTappedOp, enteringNumber, currentNum, currentMode  are set to their app start-up conditions;
	the input line is set to the savedNum and justClearedLine is set to true
	
	__Algorithm__:
	
	Make sure calculator is not in Error mode, otherwise return
	Make sure the number of entries is greater than 0, otherwise set the inputLine to 0 and return
	set the justTappedOp and enteringNumber flags to false
	set the currentMode to .NON
	
			If = has been tapped, reset to false and set the inputLine to 0, then return //Functionally equivalent to starting new calculation
			otherwise, set the inputLine to the savedNum value, set justCleared line to true
	*/
	@IBAction func didTapClear(){
		
	}
	
	
	/**
	Clears out the current number and mode, as well as saved Number and History and resets to app starting conditions
	
	- PreCondition: None
	- PostCondition:  All booleans, mode, labels, and tracking numbers are reset to their app start-up conditions
	
	You fill in this method.  It should reset all of the flags and other values to their start-up state
	*/
	 func clearHistory(){
		
		
		
	}
	
	///Pre Condition: None
	///Post Condition: All numbers and booleans have been cleared and reset to app start up values
	@IBAction func didTapClearHistory(){
		clearHistory()
	}
	
	/**
	- PreCondition:  Either some number has been entered into the input line or we are continuing some sort of chained
	arithmetic operation (1 + 2 + 3...).   If the line has been cleared, we need to reset that boolean to false.
	- PostCondition: The currentMode has been set for the calculator, the previously entered number stored in current
	number, and if necessary, the previous calculation has been evaluated.
	
	- parameter  op: the arithmetic operation that has been tapped
	
	__Algorithm__ :
		Make sure that the inputLine does not say "overflow", "err div 0", or "Choose Num", otherwise display Choose
		Num on the inputLine and return
		If the line was just cleared, set justClearedLine to false
	
	Now 5 situations must be accounted for:
	
	- Situations where the current Operation is not the same as the one that was just tapped
		* Situation A) start-up, current Operation is .NON and no numbers have been entered before tapping this op -> we want to display "Choose Num" to the user via inputLine
		* Situation B)  after start-up (curent mode is set to some other valid Op), no number was immediately entered before tapping this operation, so we want to re-store the number on the line into currentNum, set the the currentMode to the passed-in operation
			return
		* Situation C) At Anytime, a number has been entered, store the number, evaluate and set inputLine to result

	- Situations where the current operation is the same as the one that was just tapped
		* Situation D) Make sure that the user was entering a number before the op was tapped otherwise return
		* Situation E) After making sure a number was entered, store the number, evaluate and set the inputLine to result

	Before exiting, set the booleans for justTappedOp to True and enteringNumber to False for any situations that have not already returned
	
		*/
	func tappedOperation(op: operationMode){
	}

	/**
	- PreCondition:  There is some entered Number on the inputLine.
	- PostCondition:  The most recently entered digit has been removed.
	
	
	_BackSpace_
	You will have to figure out the algorithm for how to handle backspaces.  The behavior should match that described
	in the specification document.
	
	- Hints:
	To make things easier on you, Backspace should be disabled if an operation was just tapped before this (number was
	entered), the line was just cleared, or if = was just tapped (there's a result on the inputLine), and when any
	message is displayed on the inputLine.  If the line only contains a single number (0 or otherwise) then
	backspacing over it, should result in a 0 being sent back to the inputLine (0 is the same as no entered Value).
	
	*/
	@IBAction func didTapBSpace(){
		
		
	}


	/**
		Stores the current number on the inputLine, if it is indeed a number and increments the total number of entries
		- PreCondition: The user has entered some Number, or there is at least a number on the inputLine.
		- PostCondition:  The current Number is stored correctly.
	
	__Algorithm__:
	
	 First make sure that there is some _String_ value to grab from the input Label. If there is nothing there,
	then we shouldn't grab it.  Also make sure that the String value is not empty. Otherwise return  Hint: Print
	something to the console during development to help see whats happening.
	
	
	Attempt to make the String Value grabbed from the line into an Integer with optional binding (when we are finished
	the app, there will occasionally be error messages on the and we don't to accidentally use those values).
	
	If this works, set the currentNum to the unwrapped int value.
	Make sure we have not already just tapped some operation. Otherwise return. (Explanation: IF user already tapped an op we neither want to increment the number of entries nor update the label but we do want)
	
	The current num should already have been saved when we tapped the first operation (subsequent taps do nothing)
	 AKA tapping 1, +, * will only set first entry to 1 and the mode to MUL.
	
	Then increment the number of entries.

`	If we just entered our first entry, add the first entry to the HistoryLabel set savedNum to currentNum.

	If we are unable to create an int from the input line, there must be some error message there.  If the message says "Choose Op", display the
	saved number to the user via the input line. Otherwise clear the history.
	*/
	func storeCurrNum() {
	
		
	}

	/**
		- PreCondition: The user tapped =
		- PostCondition: The series of taps and entries from the user is evaluated.
	
	__Algorithm__:
	
		make sure that we didn't just tap an operation (aka 3, +, =  is invalid)
	
		if tappedEQL is false (this is not a repeated tap)& a number was not previously entered & currentMod is NON & an Op was not tapped then set the inputLine to the saved Number, aka don't change the inputLine (nothing has happened)
	
		if the currentMode is not NON, set the prevMode to the value of currentMode (we are about to set currentMode to .NON)
	
		set the inputLine text to the result of button press evaluation with the previousMode
	
		set the appropriate flags
		if the current mode is not in ERR, set the mode to NON
	
	*/
	@IBAction func tappedEvaluate(){
		
	}
	
	/**
	- PreCondition: The user tapped an operation(+ * - ÷ % =) and the current number and mode and must be used to modify the saved number
	- PostCondition:  The current number and mode are evaluated correct
	
	- parameters:
	
		- pressedEq:  a boolean to represent whether evaluate is being run off of a = tap or if it is being run as part of a chained operation
		- prevMode:	 The previous operating mode of the calculator, determined in the tappedEvaluate method.  This is
		used when = is tapped multiple times in a row, so the previous operation is repeated
	
	__Algorithm__:
	
	Make sure that a number is on the inputLine and the currentMode is not set to ERR, otherwise return what is on the input line (maintains error messages)
	
		If this method is passed a true value then the = button was tapped.
			if a number was not entered & = was tapped
				check if both currentMode AND prevMode == .NON ( no mode has ever been set)
					if yes, then store/update the currentNumber, update the saved Number with the currentMode
						if (numEntries > 0) update the History with the currentMode
	
						return a String of the current Number
				If the check for the both Modes == NON is false ( some mode has been previously set, and we are startinga new calculation from the most recently entered number), increment the number of entries update Saved with the previous Mode
				Make sure that the String of the result (savedNum) is less than 11 chars in length, else set the Mode to .ERR and return an OVERFLOW message
				update the history with the previous mode and the current Number
				return a String of savedNum
	
				if currentMode is NON & we did just enter a Number & we did not tap an operation before this
					set savedNum to the currentNumber on the inputLine (start the repeated calculation from the most recent entered number)
					increment the number of entries (to reflect new starting number)
					update the History wih currentMode and saved Number
					return String (savedNum) to the line
	
				if a number was entered
					increment the number of Entries
					store the current number on the line
	
				Check the current number and Mode to see if we're dividing by 0
					if so, set the currentMode to .ERR and return div 0 error message
	
				if the number of entries is > 1, update the History with currentMode and currentNum
	
			Lastly, update the savedNum with the updateSaved using the currentMode
	
	
	Else if we are evaluating as part of a chained operation ( 5, +, 4 , *, 3, -...), = was not tapped
	
			Check to make sure we aren't dividing by 0.
				IF we are, set mode to .ERR and  you must return some div 0 error message.
			If we are on the second Entry return the savedNum to the inputLine as a String
			if we are still on the first entry, return the number on the Line as a String
			if we have entered a number before this, number of entries is greater than 0, and currentMode is NON, we are effectively starting a new calculation in the middle of a chain of operations
				Update the history with the current Mode and currentNumber
				update the savedNum with currentMode
				return the savedN Number as a String
	
		  	Update the savedNum with currentMode
			if number of entries is greater than 1 update the history with the currentMode and current Number

	
	*/
	func evaluate(pressedEq: Bool, prevMode: operationMode)-> String{
		
		
		return String(savedNum)
	}
	
	/**
	Updates the value on the inputLine based on what the user is entering via the numberpad.
	
	You write this part

	- PreCondition: None
	- PostCondition: The saved Number has been updated correctly
	
	- parameter theMode: represents the mode which you wish to use for updating the savedNumber
	
	*/
	
	func updateSaved(_ theMode: operationMode){
	
	}
	
	/**
	you write this algorithm.  Based on the passed-in operation and value update the feed.
	If the number of Entries is greater than 5, remove the first line.
	
	__HINT__: this is the same thing we did on Lab 8.

	
	 - PreCondition:  Some number has been entered and we want to update the feed.
	 - PostCondition: The history Feed is correctly updated
	
	- parameters:
	  - op: the operation you want to use to update the feed.  *Example:* tapping + and someNumer adds "+ someNumber" to the feed
	  - valueGrabbed: the number you wish to use to update the feed with
	
*/
	func updateHistory(op: operationMode, valueGrabbed: Int){
		
	}
	
	/**
	Returns the optional String that is currently stored on the inputLine.  use this whenever you need the most recent number on the line
	
	- PreCondition: None
	- PostCondition: An optional String has been returned.
	*/
	func getText() -> String?{
		
			return inputLine.text
		
	}
	
	
	/**
	- PreCondition: None
	- PostCondition: The number tapped has been added to the number being displayed on the inputLine.
	
	Updates the value on the inputLine based on what the user is entering via the numberpad.
	
	- parameter num:  some number that has been tapped.
	
	Get this major portion of this algorithm from the Lynda Video series.  However, make sure your algorithm checks to make sure that there is no numerical overflow (the resulting number cannot be larger than the space allowed for on the screen. If it is, you should return "OVERFLOW" or whatever your specific overflow message is.
	*/
	func updateValue(num: Int){
		
		
	}
	
	//////////THESE METHODS ARE NOT PART OF THE PROJECT
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		HistoryLabel.lineBreakMode = .byWordWrapping
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

