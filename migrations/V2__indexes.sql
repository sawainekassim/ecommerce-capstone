-- =====================================================
-- V2: DATABASE INDEXES
-- Project: Multi-Tenant E-Commerce Management System
-- =====================================================

-- USERS
CREATE INDEX idx_users_business_id
ON users(business_id);


-- CUSTOMERS
CREATE INDEX idx_customers_business_id
ON customers(business_id);

CREATE INDEX idx_customers_email
ON customers(business_id, email);


-- CATEGORIES
CREATE INDEX idx_categories_business_id
ON categories(business_id);


-- PRODUCTS
CREATE INDEX idx_products_business_id
ON products(business_id);

CREATE INDEX idx_products_category_id
ON products(business_id, category_id);

CREATE INDEX idx_products_name
ON products(business_id, product_name);


-- ORDERS
CREATE INDEX idx_orders_business_id
ON orders(business_id);

CREATE INDEX idx_orders_customer_id
ON orders(business_id, customer_id);

CREATE INDEX idx_orders_date
ON orders(business_id, order_date);

CREATE INDEX idx_orders_status
ON orders(business_id, status);


-- ORDER ITEMS
CREATE INDEX idx_order_items_order_id
ON order_items(business_id, order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(business_id, product_id);


-- PAYMENTS
CREATE INDEX idx_payments_order_id
ON payments(business_id, order_id);

CREATE INDEX idx_payments_status
ON payments(business_id, payment_status);


-- AUDIT LOGS
CREATE INDEX idx_audit_logs_business_id
ON audit_logs(business_id);

CREATE INDEX idx_audit_logs_action_time
ON audit_logs(business_id, action_time);