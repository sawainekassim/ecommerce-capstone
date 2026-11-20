-- =====================================================
-- V1: CORE TABLES
-- Project: Multi-Tenant E-Commerce Management System
-- Database: PostgreSQL
-- =====================================================

-- 1. BUSINESSES
-- Each business is a separate tenant in the system.

CREATE TABLE businesses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- 2. USERS
-- Users belong to a specific business.

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'staff',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id),

    CONSTRAINT uq_users_business_id
        UNIQUE (business_id, id),

    CONSTRAINT uq_users_business_email
        UNIQUE (business_id, email),

    CONSTRAINT chk_users_role
        CHECK (role IN ('owner', 'admin', 'staff'))
);


-- 3. CUSTOMERS
-- Customers belong to a specific business.

CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(30),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customers_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id),

    CONSTRAINT uq_customers_business_id
        UNIQUE (business_id, id)
);


-- 4. CATEGORIES
-- Products are organized into categories.

CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    category_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_categories_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id),

    CONSTRAINT uq_categories_business_id
        UNIQUE (business_id, id),

    CONSTRAINT uq_categories_business_name
        UNIQUE (business_id, category_name)
);


-- 5. PRODUCTS
-- Every product belongs to a business.
-- A category is optional.

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    category_id UUID,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(12, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_products_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id),

    CONSTRAINT fk_products_category
        FOREIGN KEY (business_id, category_id)
        REFERENCES categories(business_id, id),

    CONSTRAINT uq_products_business_id
        UNIQUE (business_id, id),

    CONSTRAINT chk_products_price
        CHECK (price >= 0),

    CONSTRAINT chk_products_stock
        CHECK (stock_quantity >= 0)
);


-- 6. ORDERS
-- Each order belongs to a business and a customer.

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    customer_id UUID NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'pending',

    CONSTRAINT fk_orders_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id),

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (business_id, customer_id)
        REFERENCES customers(business_id, id),

    CONSTRAINT uq_orders_business_id
        UNIQUE (business_id, id),

    CONSTRAINT chk_orders_status
        CHECK (status IN (
            'pending',
            'processing',
            'shipped',
            'completed',
            'cancelled'
        ))
);


-- 7. ORDER ITEMS
-- Each order can contain multiple products.

CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    order_id UUID NOT NULL,
    product_id UUID NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,

    line_total NUMERIC(14, 2)
        GENERATED ALWAYS AS (quantity * unit_price) STORED,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (business_id, order_id)
        REFERENCES orders(business_id, id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (business_id, product_id)
        REFERENCES products(business_id, id),

    CONSTRAINT chk_order_items_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_items_unit_price
        CHECK (unit_price >= 0)
);


-- 8. PAYMENTS
-- An order can have multiple payment attempts.

CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    order_id UUID NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL DEFAULT 'pending',
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_order
        FOREIGN KEY (business_id, order_id)
        REFERENCES orders(business_id, id),

    CONSTRAINT chk_payments_amount
        CHECK (amount >= 0),

    CONSTRAINT chk_payments_status
        CHECK (payment_status IN (
            'pending',
            'successful',
            'failed',
            'refunded'
        ))
);


-- 9. AUDIT LOGS
-- Records important actions performed in the system.

CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id UUID NOT NULL,
    user_id UUID,
    action VARCHAR(30) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id UUID,
    action_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    details TEXT,

    CONSTRAINT fk_audit_logs_business
        FOREIGN KEY (business_id)
        REFERENCES businesses(id)
);