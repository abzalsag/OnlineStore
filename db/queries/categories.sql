-- name: CreateCategory :one
INSERT INTO categories (parent_id, name, slug)
VALUES ($1, $2, $3)
    RETURNING *;

-- name: GetCategory :one
SELECT * FROM categories
WHERE id = $1;

-- name: GetCategoryBySlug :one
SELECT * FROM categories
WHERE slug = $1;

-- name: ListCategories :many
SELECT * FROM categories
ORDER BY name;

-- name: UpdateCategory :one
UPDATE categories
SET parent_id = $2, name = $3, slug = $4
WHERE id = $1
    RETURNING *;

-- name: DeleteCategory :exec
DELETE FROM categories
WHERE id = $1;