*** Settings ***
Library     SeleniumLibrary
Suite Teardown    Close Browser
Resource    ../resources/login_keywords.robot


*** Test Cases ***
#TC1
Open saucedemo Login Page
    [Teardown]    Close Browser
	Open saucedemo Login Page
	Sleep	2s

#TC2
Checking the email and password fields are present
    [Teardown]    Close Browser
	Open saucedemo Login Page
	Element Should Be Visible    ${USER_NAME}
	Element Should Be Visible    ${PASSWORD}
	Sleep	2s

#TC3
Login with valid credentials
    [Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Sleep	2s

#TC4
Login with lockedout credentials
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter locked out user and login   locked_out_user secret_sauce
	Element Should Be Visible   ${LOCKED_OUT_ERROR}
	Element Should Contain    ${LOCKED_OUT_ERROR_TEXT}    Epic sadface: Sorry, this user has been locked out.
	Sleep	2s

#TC5
Login with invalid credentials
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter wrong user and login   wrong_user wrong_password
	Element Should Be Visible   ${LOCKED_OUT_ERROR}
	Element Should Contain    ${LOCKED_OUT_ERROR_TEXT}    Username and password do not match any user in this service
	Sleep	2s

#TC6
Login with empty credentials
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Empty credentials and login
	Element Should Contain    ${LOCKED_OUT_ERROR_TEXT}    Epic sadface: Username is required
	Sleep	2s

#TC7
Login without password
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Username but no password   standard_user
	Element Should Contain    ${LOCKED_OUT_ERROR_TEXT}    Epic sadface: Password is required
	Sleep	2s

#TC8
Clicking cancel mark at error message
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Username but no password   standard_user
	Element Should Contain    ${LOCKED_OUT_ERROR_TEXT}    Epic sadface: Password is required
	Element Should Be Visible   ${CANCEL_MARK_AT_ERROR}
	Click Element   ${CANCEL_MARK_AT_ERROR}
	Element Should Not Be Visible   ${LOCKED_OUT_ERROR_TEXT}
	Sleep	2s

#TC9
Login with performance glitch user
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   performance_glitch_user secret_sauce
	Sleep	2s

#TC10
Checking the page title and product text after login
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Element Should Be Visible   ${PAGE_TITLE}
	Element Should Contain    ${PAGE_TITLE}	Swag Labs
	Element Should Be Visible    ${PRODUCTS_TEXT} 
	Element Should Contain    ${PRODUCTS_TEXT}    Products
	Sleep	2s

#TC11
Selecting an item from the products list | adding to cart | checking the cart | Removing from cart | checking the cart
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Title Should Be    Swag Labs
    Select Product By Name    Sauce Labs Backpack
	Page Should Contain    Sauce Labs Backpack
	Page Should Contain Element    xpath=//img[@alt='Sauce Labs Backpack']
	Page Should Contain    $29.99    
	Click Button    ${ADD_TO_CART_BUTTON_ON_IND_PRODUCT }
	Page Should Contain Element    ${REMOVE_BUTTON}
	Page Should Contain Element    ${CART_BADGE}
	Page Should Contain Element    ${CART_BADGE_NUMBER}
	Element Text Should Be    ${CART_BADGE_NUMBER}    1
	Click Element	${REMOVE_BUTTON}
	Page Should Not Contain Element    ${CART_BADGE_NUMBER}
	Sleep	2s

#TC12
Login and logout from the app
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Title Should Be    Swag Labs
	Logout from app        
	Sleep	2s

#TC13
Filter low to high price and select the lowest price item
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Title Should Be    Swag Labs
	Filter Low to High Price and select the lowest price item
	Sleep	2s

#TC14
Filter from high to low price and select the highest price item
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Title Should Be    Swag Labs
	Filter high to low price and select the highest price item
	Sleep	10s

#TC15
Filter from A to Z and select the first and second item
	[Teardown]    Close Browser
	Open saucedemo Login Page
	Enter Username password and login   standard_user secret_sauce
	Title Should Be    Swag Labs
	Filter And Select First Two Products
	Clicking cart button
	Clicking checkout button and verifying Your Information page
	Filling user information and continuing to next page
	Verify Cart Total Matches Product Sum
	Finish and verify order completion
	Sleep	10s
