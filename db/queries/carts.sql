-- name: CreateCart :one
INSERT INTO carts (user_id)
VALUES ($1)
    RETURNING *;

-- name: GetCartByUserID :one
SELECT * FROM carts
WHERE user_id = $1;

-- name: TouchCart :exec
UPDATE carts
SET updated_at = now()
WHERE id = $1;

-- name: AddCartItem :one
-- If the product is already in the cart, quantity is increased.
INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES ($1, $2, $3)
    ON CONFLICT (cart_id, product_id)
DO UPDATE SET quantity = cart_items.quantity + EXCLUDED.quantity
           RETURNING *;

-- name: SetCartItemQuantity :one
UPDATE cart_items
SET quantity = $3
WHERE cart_id = $1 AND product_id = $2
    RETURNING *;

-- name: RemoveCartItem :exec
DELETE FROM cart_items
WHERE cart_id = $1 AND product_id = $2;

-- name: ListCartItems :many
SELECT
    ci.id,
    ci.product_id,
    ci.quantity,
    p.name  AS product_name,
    p.price AS unit_price,
    p.stock AS product_stock
FROM cart_items ci
         JOIN products p ON p.id = ci.product_id
WHERE ci.cart_id = $1;

-- name: ClearCart :exec
DELETE FROM cart_items
WHERE cart_id = $1;