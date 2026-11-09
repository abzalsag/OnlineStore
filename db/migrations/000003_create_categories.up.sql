CREATE TABLE categories (
                            id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                            parent_id UUID REFERENCES categories(id) ON DELETE SET NULL,
                            name      TEXT NOT NULL,
                            slug      TEXT NOT NULL UNIQUE
);