CREATE TABLE IF NOT EXISTS purchase_orders (
    id BIGSERIAL PRIMARY KEY,
    po_number TEXT NOT NULL,
    order_date DATE,
    supplier TEXT,
    currency CHAR(3),
    subtotal NUMERIC(18,2),
    tax NUMERIC(18,2),
    shipping NUMERIC(18,2),
    total_amount NUMERIC(18,2),
    confidence NUMERIC(4,3),
    requires_approval BOOLEAN NOT NULL DEFAULT FALSE,
    status TEXT NOT NULL DEFAULT 'RECEIVED',
    source_reference TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (po_number, supplier)
);

CREATE TABLE IF NOT EXISTS purchase_order_items (
    id BIGSERIAL PRIMARY KEY,
    purchase_order_id BIGINT NOT NULL REFERENCES purchase_orders(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    specification TEXT,
    quantity NUMERIC(18,4),
    uom TEXT,
    unit_price NUMERIC(18,2),
    line_total NUMERIC(18,2)
);

CREATE TABLE IF NOT EXISTS automation_audit_log (
    id BIGSERIAL PRIMARY KEY,
    po_number TEXT,
    event_type TEXT NOT NULL,
    event_status TEXT NOT NULL,
    details JSONB NOT NULL DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_po_status ON purchase_orders(status);
CREATE INDEX IF NOT EXISTS idx_audit_po_number ON automation_audit_log(po_number);
