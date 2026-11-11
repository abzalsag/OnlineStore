-- name: CreateAddress :one
INSERT INTO addresses (user_id, city, street, zip, phone)
VALUES ($1, $2, $3, $4, $5)
    RETURNING *;

-- name: GetAddress :one
SELECT * FROM addresses
WHERE id = $1 AND user_id = $2;

-- name: ListAddressesByUser :many
SELECT * FROM addresses
WHERE user_id = $1;

-- name: DeleteAddress :exec
DELETE FROM addresses
WHERE id = $1 AND user_id = $2;