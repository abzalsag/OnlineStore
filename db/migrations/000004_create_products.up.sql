CREATE TABLE products (
                          id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                          category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
                          name        TEXT NOT NULL,
                          description TEXT,
                          price       BIGINT NOT NULL CHECK (price >= 0),
                          stock       INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
                          is_active   BOOLEAN NOT NULL DEFAULT true,
                          created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_products_category_id ON products(category_id);