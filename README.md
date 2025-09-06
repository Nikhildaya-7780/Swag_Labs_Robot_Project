# 🧪 Swag Labs Robot Framework Automation

Automated end-to-end UI tests for [Swag Labs](https://www.saucedemo.com/) using **Robot Framework**, **SeleniumLibrary**, and modular keyword-driven design. Built for clarity, scalability, and real-world interview readiness.

## 📁 Project Structure

Swag_Labs_Robot_Project/
├── tests/                  # 💡 Test suites organized by functionality
│   └── login_test.robot    # Login flow validations (valid, invalid, locked-out)
│   └── cart_test.robot     # Add/remove items, cart count verification
│   └── checkout_test.robot # Checkout form, summary, and confirmation
│
├── resources/              # 🔧 Reusable keywords and helper logic
│   └── keywords.robot      # Custom keywords (login, cart ops, etc.)
│   └── locators.robot      # Centralized element locators
│   └── test_data.robot     # Variables like usernames, product names, zip codes
│
├── screenshots/            # 📸 Captured UI states on failure
│   └── login_failure.png   # Example screenshot for failed login
│
├── output.xml              # 🧪 Raw test execution output
├── report.html             # 📊 Summary of test results
├── log.html                # 📋 Detailed execution logs
├── README.md               # 📘 Project overview and instructions
├── .gitignore              # 🚫 Excludes junk files from version control
└── requirements.txt        # 📦 Python dependencies (Robot Framework, SeleniumLibrary)


---

## 🚀 Features

- ✅ Login validation with positive and negative scenarios
- 🛒 Add-to-cart and checkout flow automation
- 🔐 Error message verification and edge case handling
- 📸 Screenshot capture on failure
- 📊 HTML and XML reporting for test runs

---

## 🛠️ Tech Stack

- **Robot Framework**
- **SeleniumLibrary**
- **Python 3.x**
- **ChromeDriver / WebDriver**
- **Git + GitHub**

---

## 📸 Sample Screenshots

Screenshots are auto-captured during test execution and stored in the repo for reference.

---
🧪 Test Case Breakdown
Your test suite validates core user flows on the Swag Labs demo site, simulating real-world e-commerce behavior. Here's what you've automated:
🔐 Login Tests
- ✅ Valid login with standard user credentials
- ❌ Invalid login with wrong username/password
- 🔒 Locked-out user scenario
- 🧪 Verifies error messages and alert handling
Purpose: Ensures authentication logic is secure and user feedback is clear. Great for catching broken login flows early.


🛒 Add to Cart
- ➕ Adds single and multiple products to cart
- 🔄 Verifies cart count updates dynamically
- 🧹 Removes items and checks cart state
Purpose: Validates product selection and cart integrity. Helps ensure users can manage their shopping experience smoothly.


📦 Checkout Flow
- 🚫 Prevents checkout with empty cart
- 📝 Fills out user info (name, zip, etc.)
- ✅ Completes purchase and verifies confirmation
Purpose: Tests critical purchase flow from cart to confirmation. Ensures data entry and order processing work as expected.


📸 Failure Handling
- 🖼 Captures screenshots on test failure
- 📊 Generates HTML and XML reports
Purpose: Improves debugging and traceability. Makes your framework recruiter-ready and CI/CD-friendly.


🧠 Why This Matters
These test cases reflect real-world QA priorities:
- Negative testing for robustness
- Edge case coverage for reliability
- Modular keywords for scalability
- Clear reporting for team visibility


## 🧠 How to Run

```bash
# Install dependencies
pip install -r requirements.txt

# Run tests
robot tests/

