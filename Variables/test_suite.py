import os

LOGIN_URL = "https://www.saucedemo.com/"
HOME_URL = "https://www.saucedemo.com/inventory.html"
CART_URL = "https://www.saucedemo.com/cart.html"
CHECKOUT_PT1_URL = "https://www.saucedemo.com/checkout-step-one.html"
CHECKOUT_PT2_URL = "https://www.saucedemo.com/checkout-step-two.html"
# Firefox or Chrome
# service_log_path is for Firefox Only
# BROWSER=   Chrome
BROWSER = "Firefox"
FF_OPTIONS = os.path.devnull
USERNAME = "standard_user"
PASSWORD = "secret_sauce"

ITEMS_TO_ADD = ["Sauce Labs Backpack", "Sauce Labs Bike Light"]
ADD_TO_CART_TEXT= "Add to cart"

CHECKOUT_FNAME = "James"
CHECKOUT_LNAME = "Bond"
CHECKOUT_POSTALCODE = 90210

COOKIE_SHOULD_NOT_EXIST_AFTER_LOGOUT_MSG = "Cookie should not exist after Logout"
