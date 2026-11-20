-- =====================================================
-- V3: AUDIT LOGS AND TRIGGERS
-- Project: Multi-Tenant E-Commerce Management System
-- =====================================================

-- Function to automatically record product changes.

CREATE OR REPLACE FUNCTION log_product_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    affected_business_id UUID;
    affected_record_id UUID;
    current_action TEXT;
BEGIN

    -- Identify the affected record.
    IF TG_OP = 'DELETE' THEN
        affected_business_id := OLD.business_id;
        affected_record_id := OLD.id;
        current_action := 'DELETE';
    ELSE
        affected_business_id := NEW.business_id;
        affected_record_id := NEW.id;
        current_action := TG_OP;
    END IF;

    -- Save the action in the audit_logs table.
    INSERT INTO audit_logs (
        business_id,
        user_id,
        action,
        table_name,
        record_id,
        details
    )
    VALUES (
        affected_business_id,
        NULLIF(current_setting('app.user_id', true), '')::UUID,
        current_action,
        'products',
        affected_record_id,
        CASE
            WHEN TG_OP = 'INSERT' THEN
                'Product created: ' || NEW.product_name
            WHEN TG_OP = 'UPDATE' THEN
                'Product updated: ' || NEW.product_name
            WHEN TG_OP = 'DELETE' THEN
                'Product deleted: ' || OLD.product_name
        END
    );

    -- Return the correct record.
    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;

END;
$$;


-- Create the trigger on the products table.

CREATE TRIGGER trg_product_audit
AFTER INSERT OR UPDATE OR DELETE
ON products
FOR EACH ROW
EXECUTE FUNCTION log_product_changes();