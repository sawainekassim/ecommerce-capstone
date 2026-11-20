-- =====================================================
-- V5: DEMO DATA
-- Project: Multi-Tenant E-Commerce Management System
-- =====================================================

BEGIN;

-- A fictional business ID used only for this assignment.
-- It is a sample UUID, not a personal or registered business ID.

SELECT set_config(
    'app.business_id',
    '11111111-1111-1111-1111-111111111111',
    true
);

-- 1. BUSINESS

INSERT INTO businesses (
    id,
    business_name,
    email
)
VALUES (
    '11111111-1111-1111-1111-111111111111',
    'Demo Electronics Store',
    'demo@electronics.test'
);


-- 2. USERS

INSERT INTO users (
    id,
    business_id,
    full_name,
    email,
    password_hash,
    role
)
VALUES
(
    '22222222-2222-2222-2222-222222222221',
    '11111111-1111-1111-1111-111111111111',
    'Demo Administrator',
    'admin@electronics.test',
    'DEMO_ONLY_NOT_A_REAL_PASSWORD_HASH',
    'admin'
),
(
    '22222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    'Demo Staff Member',
    'staff@electronics.test',
    'DEMO_ONLY_NOT_A_REAL_PASSWORD_HASH',
    'staff'
);


-- 3. CUSTOMERS

INSERT INTO customers (
    id,
    business_id,
    full_name,
    email,
    phone
)
VALUES
(
    '33333333-3333-3333-3333-333333333331',
    '11111111-1111-1111-1111-111111111111',
    'Jane Customer',
    'jane@example.test',
    '0700000001'
),
(
    '33333333-3333-3333-3333-333333333332',
    '11111111-1111-1111-1111-111111111111',
    'John Customer',
    'john@example.test',
    '0700000002'
);


-- 4. CATEGORIES

INSERT INTO categories (
    id,
    business_id,
    category_name
)
VALUES
(
    '44444444-4444-4444-4444-444444444441',
    '11111111-1111-1111-1111-111111111111',
    'Laptops'
),
(
    '44444444-4444-4444-4444-444444444442',
    '11111111-1111-1111-1111-111111111111',
    'Mobile Phones'
);


-- 5. PRODUCTS

INSERT INTO products (
    id,
    business_id,
    category_id,
    product_name,
    description,
    price,
    stock_quantity
)
VALUES
(
    '55555555-5555-5555-5555-555555555551',
    '11111111-1111-1111-1111-111111111111',
    '44444444-4444-4444-4444-444444444441',
    'HP Laptop',
    'Demo laptop for testing',
    75000.00,
    10
),
(
    '55555555-5555-5555-5555-555555555552',
    '11111111-1111-1111-1111-111111111111',
    '44444444-4444-4444-4444-444444444442',
    'Samsung Phone',
    'Demo smartphone for testing',
    45000.00,
    15
),
(
    '55555555-5555-5555-5555-555555555553',
    '11111111-1111-1111-1111-111111111111',
    '44444444-4444-4444-4444-444444444442',
    'Nokia Phone',
    'Affordable demo smartphone',
    12000.00,
    20
);


-- 6. ORDERS

INSERT INTO orders (
    id,
    business_id,
    customer_id,
    status
)
VALUES
(
    '66666666-6666-6666-6666-666666666661',
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333331',
    'completed'
),
(
    '66666666-6666-6666-6666-666666666662',
    '11111111-1111-1111-1111-111111111111',
    '33333333-3333-3333-3333-333333333332',
    'pending'
);


-- 7. ORDER ITEMS

INSERT INTO order_items (
    id,
    business_id,
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
(
    '77777777-7777-7777-7777-777777777771',
    '11111111-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666661',
    '55555555-5555-5555-5555-555555555551',
    1,
    75000.00
),
(
    '77777777-7777-7777-7777-777777777772',
    '11111111-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666661',
    '55555555-5555-5555-5555-555555555552',
    1,
    45000.00
),
(
    '77777777-7777-7777-7777-777777777773',
    '11111111-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666662',
    '55555555-5555-5555-5555-555555555553',
    2,
    12000.00
);


-- 8. PAYMENTS

INSERT INTO payments (
    id,
    business_id,
    order_id,
    amount,
    payment_method,
    payment_status
)
VALUES
(
    '88888888-8888-8888-8888-888888888881',
    '11111111-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666661',
    120000.00,
    'mobile_money',
    'successful'
),
(
    '88888888-8888-8888-8888-888888888882',
    '11111111-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666662',
    24000.00,
    'card',
    'pending'
);

COMMIT;