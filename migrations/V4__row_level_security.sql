-- =====================================================
-- V4: ROW-LEVEL SECURITY
-- Project: Multi-Tenant E-Commerce Management System
-- =====================================================

-- 1. Create a helper function to identify the current business.

CREATE OR REPLACE FUNCTION app_current_business_id()
RETURNS UUID
LANGUAGE SQL
STABLE
AS $$
    SELECT NULLIF(
        current_setting('app.business_id', true),
        ''
    )::UUID;
$$;


-- 2. Enable and force Row-Level Security.

ALTER TABLE businesses ENABLE ROW LEVEL SECURITY;
ALTER TABLE businesses FORCE ROW LEVEL SECURITY;

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE users FORCE ROW LEVEL SECURITY;

ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers FORCE ROW LEVEL SECURITY;

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories FORCE ROW LEVEL SECURITY;

ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE products FORCE ROW LEVEL SECURITY;

ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders FORCE ROW LEVEL SECURITY;

ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items FORCE ROW LEVEL SECURITY;

ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments FORCE ROW LEVEL SECURITY;

ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs FORCE ROW LEVEL SECURITY;


-- 3. Create a security policy for businesses.

CREATE POLICY business_tenant_policy
ON businesses
FOR ALL
USING (id = app_current_business_id())
WITH CHECK (id = app_current_business_id());


-- 4. Create security policies for tenant-owned tables.

CREATE POLICY users_tenant_policy
ON users
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY customers_tenant_policy
ON customers
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY categories_tenant_policy
ON categories
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY products_tenant_policy
ON products
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY orders_tenant_policy
ON orders
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY order_items_tenant_policy
ON order_items
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY payments_tenant_policy
ON payments
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());


CREATE POLICY audit_logs_tenant_policy
ON audit_logs
FOR ALL
USING (business_id = app_current_business_id())
WITH CHECK (business_id = app_current_business_id());