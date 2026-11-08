CREATE TABLE addresses(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE  CASCADE,
    city TEXT NOT NULL,
    street TEXT NOT NULL,
    zip TEXT,
    phone TEXT
);

CREATE INDEX idx_addresses_user_id ON addresses(user_id);