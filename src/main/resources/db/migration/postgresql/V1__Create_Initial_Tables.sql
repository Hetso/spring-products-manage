CREATE TABLE products_categories (
	id int8 NOT NULL,
	"name" varchar(128) NOT NULL,
	CONSTRAINT products_categories_pk PRIMARY KEY (id)
);

CREATE TABLE products (
	id int8 NOT NULL,
	"name" varchar(128) NOT NULL,
	price float8 NOT NULL,
	category_id int8 NOT NULL,
	CONSTRAINT products_pk PRIMARY KEY (id),
	CONSTRAINT products_categories_fk FOREIGN KEY (category_id)
		REFERENCES products_categories(id)
);

CREATE TABLE products_stocks (
	product_id int8 NOT NULL,
	"amount" int8 NOT NULL DEFAULT 0,
	CONSTRAINT products_stocks_pk PRIMARY KEY (product_id),
	CONSTRAINT products_stocks_fk FOREIGN KEY (product_id)
		REFERENCES products(id)
);

CREATE TABLE users (
	id int8 not null,
	firstname varchar(128) NOT NULL,
	lastname varchar(255) NOT NULL,
	username varchar(128) NOT NULL UNIQUE,
	email varchar(255) NOT NULL UNIQUE,
	password text NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (id)
);

CREATE TABLE sales (
	id int8 NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
	CONSTRAINT sales_pk PRIMARY KEY (id)
);

CREATE TABLE products_sales (
	sale_id int8 NOT NULL,
	product_id int8 NOT NULL,
	amount int8 NOT NULL,
	CONSTRAINT products_sales_pk PRIMARY KEY (sale_id, product_id),
	CONSTRAINT products_sales_sale_fk FOREIGN KEY (sale_id)
		REFERENCES sales(id),
	CONSTRAINT products_sales_product_fk FOREIGN KEY (product_id)
		REFERENCES products(id)
);

CREATE TABLE users_sales (
	sale_id int8 NOT NULL,
	user_id int8 NOT NULL,
	CONSTRAINT users_sales_pk PRIMARY KEY (sale_id, user_id),
	CONSTRAINT users_sales_sale_fk FOREIGN KEY (sale_id)
		REFERENCES sales(id),
	CONSTRAINT users_sales_user_fk FOREIGN KEY (user_id)
		REFERENCES users(id)
);

CREATE TABLE "groups" (
	id int8 NOT NULL,
	"name" varchar(128) NOT NULL UNIQUE,
	CONSTRAINT groups_pk PRIMARY KEY (id)
);

CREATE TABLE users_groups (
	group_id int8 NOT NULL,
	user_id int8 NOT NULL,
	CONSTRAINT users_groups_pk PRIMARY KEY (group_id, user_id),
	CONSTRAINT users_groups_group_fk FOREIGN KEY (group_id)
		REFERENCES groups(id),
	CONSTRAINT users_groups_user_fk FOREIGN KEY (user_id)
		REFERENCES users(id)
);

CREATE TABLE permissions (
	id int8 NOT NULL,
	"name" varchar(128) NOT NULL UNIQUE,
	CONSTRAINT permissions_pk PRIMARY KEY (id)
);

CREATE TABLE users_permissions (
	permission_id int8 NOT NULL,
	user_id int8 NOT NULL,
	CONSTRAINT users_permissions_pk PRIMARY KEY (permission_id, user_id),
	CONSTRAINT users_permissions_permission_fk FOREIGN KEY (permission_id)
		REFERENCES permissions(id),
	CONSTRAINT users_permissions_user_fk FOREIGN KEY (user_id)
		REFERENCES users(id)
);

CREATE TABLE groups_permissions (
	permission_id int8 NOT NULL,
	group_id int8 NOT NULL,
	CONSTRAINT groups_permissions_pk PRIMARY KEY (permission_id, group_id),
	CONSTRAINT groups_permissions_permission_fk FOREIGN KEY (permission_id)
		REFERENCES permissions(id),
	CONSTRAINT groups_permissions_group_fk FOREIGN KEY (group_id)
		REFERENCES groups(id)
);


