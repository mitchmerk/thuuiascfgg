 - PreCondition: The user tapped an operation(+ * - ÷ % =) and the current number and mode and must be used to modify the saved number
     - PostCondition:  The current number and mode are evaluated correct
     
     - parameters:
     
     - pressedEq:  a boolean to represent whether evaluate is being run off of a = tap or if it is being run as part of a chained operation
     - prevMode:     The previous operating mode of the calculator, determined in the tappedEvaluate method.  This is
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
     
