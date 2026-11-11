-- name: CreateProduct :one
INSERT INTO products (category_id, name, description, price, stock)
VALUES ($1, $2, $3, $4, $5)
    RETURNING *;

-- name: GetProduct :one
SELECT * FROM products
WHERE id = $1;

-- name: GetProductForUpdate :one
SELECT * FROM products
WHERE id = $1
    FOR UPDATE;

-- name: ListProducts :many
-- Optional filters: category_id and search (by name).
SELECT * FROM products
WHERE is_active = true
  AND (sqlc.narg('category_id')::uuid IS NULL OR category_id = sqlc.narg('category_id'))
  AND (sqlc.narg('search')::text IS NULL OR name ILIKE '%' || sqlc.narg('search') || '%')
ORDER BY created_at DESC
    LIMIT sqlc.arg('limit') OFFSET sqlc.arg('offset');

-- name: UpdateProduct :one
UPDATE products
SET category_id = $2,
    name        = $3,
    description = $4,
    price       = $5,
    is_active   = $6
WHERE id = $1
    RETURNING *;

-- name: DecreaseProductStock :one
-- Atomic: returns no row (pgx.ErrNoRows) if stock is not enough.
UPDATE products
SET stock = stock - sqlc.arg('quantity')
WHERE id = sqlc.arg('id') AND stock >= sqlc.arg('quantity')
    RETURNING *;

-- name: IncreaseProductStock :one
UPDATE products
SET stock = stock + sqlc.arg('quantity')
WHERE id = sqlc.arg('id')
    RETURNING *;

-- name: DeactivateProduct :exec
UPDATE products
SET is_active = false
WHERE id = $1;