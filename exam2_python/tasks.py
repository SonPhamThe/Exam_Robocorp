from RPA.Browser.Selenium import Selenium
import time

URL_ORDER_ROBOT = "https://robotsparebinindustries.com/#/robot-order"
CSV_FILE = "/Users/m143/Documents/certification_robocorp/exam2_robot/orders.csv"
WAIT_FOR_LOAD = "2s"

browser = Selenium()

def order_robots_from_robotsparebin():
    open_robot_order_website()
    fill_data_to_more_order_robot()

def open_robot_order_website():
    browser.open_available_browser(URL_ORDER_ROBOT)
    browser.click_button("OK")

def fill_data_to_order_robot(data_order):
    browser.select_from_list_by_value("head", data_order["Head"])
    browser.click_element(f'css:input[value="{data_order["Body"]}"]')
    browser.input_text("css:input.form-control[type='number']", data_order["Legs"])
    browser.input_text("css:input.form-control[type='text']", data_order["Address"])
    browser.execute_javascript("document.getElementById('order').click()")
    time.sleep(2)

def fill_data_to_more_order_robot():
    data_order = read_table_from_csv()
    for data in data_order:
        fill_data_to_order_robot(data)
        browser.wait_until_element_is_visible(f'css:button.btn.btn-primary[type="submit"]', WAIT_FOR_LOAD)
        browser.execute_javascript("document.getElementById('order-another').click()")
        time.sleep(2)
        browser.click_button("OK")

def read_table_from_csv():
    data_order = []
    with open(CSV_FILE, "r") as file:
        lines = file.readlines()
        for line in lines:
            parts = line.strip().split(",")
            data_order.append({"Head": parts[0], "Body": parts[1], "Legs": parts[2], "Address": parts[3]})
    return data_order

if __name__ == "__main__":
    order_robots_from_robotsparebin()
