CREATE TABLE carts (
                       id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       user_id    UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
                       updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE cart_items (
                            id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                            cart_id    UUID NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
                            product_id UUID NOT NULL REFERENCES products(id),
                            quantity   INT NOT NULL CHECK (quantity > 0),
                            UNIQUE (cart_id, product_id)
);