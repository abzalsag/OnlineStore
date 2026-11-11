CREATE TABLE orders (
                        id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                        user_id      UUID NOT NULL REFERENCES users(id),
                        address_id   UUID REFERENCES addresses(id),
                        status       TEXT NOT NULL DEFAULT 'pending',
                        total_amount BIGINT NOT NULL CHECK (total_amount >= 0),
                        created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE order_items (
                             id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             order_id   UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
                             product_id UUID NOT NULL REFERENCES products(id),
                             quantity   INT NOT NULL CHECK (quantity > 0),
                             unit_price BIGINT NOT NULL CHECK (unit_price >= 0)
);

CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);