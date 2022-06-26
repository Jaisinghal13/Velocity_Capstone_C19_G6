
CREATE TABLE cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);

CREATE TABLE discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

CREATE TABLE product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

CREATE TABLE product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);



CREATE table users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

CREATE TABLE wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO users VALUES (2147483645, true, 'Shop For Home, Mumbai, India', 'admin@shopforhome.com', 'Admin', '$2a$10$E5dcPiH7LJmx5tC9GC6hsufTY.kQ5zOxocYNNNyA.a0zPTm9aAjTu', '9876543210', 'ROLE_MANAGER');


INSERT INTO product_category VALUES (1000001, 'Mobiles', 0, '2022-06-21 23:03:26', '2022-06-22 00:15:27');
INSERT INTO product_category VALUES (1000002, 'Home Furnishings', 2, '2022-06-20 00:15:02', '2022-06-22 00:15:21');
INSERT INTO product_category VALUES (1000003, 'Fashion', 3, '2022-05-19 01:01:09', '2022-06-22 01:01:09');
INSERT INTO product_category VALUES (1000004, 'Skin care', 1, '2022-05-10 00:26:05', '2022-06-22 00:26:05');

INSERT INTO product_info VALUES ('M0001', 0, '2022-06-21 23:03:26', '4 GB | 22 GB | 12 MP | 10 MP', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-m13.jpg', 'Samsung M11', 10000.00, 1, 200, '2022-06-21 23:03:55');
INSERT INTO product_info VALUES ('M0002', 0, '2022-06-21 23:03:29', '8GB | 64 GB | 8+5 MP | 64 MP', 'https://i.pinimg.com/736x/ec/95/40/ec95401004afda63eaaf9e1420ef8822.jpg', 'Samsung F21 Pro', 15000.00, 1, 100, '2022-06-21 23:04:56');
INSERT INTO product_info VALUES ('M0003', 0, '2022-06-21 23:03:55', 'Fingerprint (under display, optical) | 64 MP ', 'https://clickmobile.pk/wp-content/uploads/2022/04/Samsung-Galaxy-M13.webp', 'Samsung Nord 2 CE', 20000.00, 1, 300, '2022-06-21 23:05:57');

INSERT INTO product_info VALUES ('H0001', 2, '2022-06-21 23:03:26', 'Pink Curtain', 'https://assets.ajio.com/medias/sys_master/root/20220121/tU0K/61ea80dcf997dd662333bbb4/-473Wx593H-462342072-pink-MODEL.jpg', 'Curtain', 1000.00, 1, 200, '2022-06-21 23:03:55');
INSERT INTO product_info VALUES ('H0002', 2, '2022-06-21 23:03:29', 'Grey Curtain', 'https://www.ikea.com/in/en/images/products/lenda-curtains-with-tie-backs-1-pair-grey__0599200_pe677975_s5.jpg?f=s', 'Curtain', 1500.00, 1, 100, '2022-06-21 23:04:56');
INSERT INTO product_info VALUES ('H0003', 2, '2022-06-21 23:03:55', 'Plastic Water Bottles', 'https://rukminim1.flixcart.com/image/416/416/kc29n680/bottle/x/s/n/1000-exclusive-water-bottles-for-fridge-school-college-office-original-imafta2gpxt7zjhr.jpeg?q=70', 'Bottles', 200.00, 1, 300, '2022-06-21 23:05:57');

INSERT INTO product_info VALUES ('S0001', 1, '2022-06-21 23:03:26', 'Facial Cleaner', 'https://media.gq.com/photos/62ab54aa3ade2278af3f4f52/master/pass/GQ-skincare-art.jpg', 'Cleaner', 600.00, 0, 200, '2022-06-21 23:03:55');
INSERT INTO product_info VALUES ('S0002', 1, '2022-06-21 23:03:29', 'Colors and paints', 'https://m.media-amazon.com/images/I/71OpIYmSbfL._SX522_.jpg', 'Colors', 1500.00, 0, 100, '2022-06-21 23:04:56');
INSERT INTO product_info VALUES ('S0003', 1, '2022-06-21 23:03:55', 'Small size make up bag', 'https://lcpshop.net/wp-content/uploads/2019/08/322995-jfvlqe.jpg', 'Make up Bag', 200.00, 0, 300, '2022-06-21 23:05:57');

INSERT INTO product_info VALUES ('F0001', 3, '2022-06-21 23:03:26', 'Party Wear', 'https://cdn.shopify.com/s/files/1/0266/6276/4597/products/300897721BLACK_2_1024x1024.jpg?v=1654610530', 'Girls Fashion', 1000.00, 1, 200, '2022-06-21 23:03:55');
INSERT INTO product_info VALUES ('F0002', 3, '2022-06-21 23:03:29', 'Casual', 'https://images.unsplash.com/photo-1596783074918-c84cb06531ca?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHJlc3Nlc3xlbnwwfHwwfHw%3D&w=1000&q=80', 'Girls Fashion', 1500.00, 1, 100, '2022-06-21 23:04:56');
INSERT INTO product_info VALUES ('F0003', 3, '2022-06-21 23:03:55', 'Party Wear', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNySDyz5Iy1vbsqZnjsHTYiZKwW4KjrdFa2g&usqp=CAU', 'Girls Fashion', 2000.00, 0, 300, '2022-06-21 23:05:57');
INSERT INTO product_info VALUES ('F0004', 3, '2022-06-21 23:03:26', 'Party Wear', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFakSibcXNJvUKJ50c9UaDy8WquNy0PfRi6w&usqp=CAU', 'Suit', 1000.00, 0, 200, '2022-06-21 23:03:55');
INSERT INTO product_info VALUES ('F0005', 3, '2022-06-21 23:03:29', 'Party Wear', 'https://i.pinimg.com/236x/a2/d7/3b/a2d73b717d4d23a16ad6c295e14f9131.jpg', 'Suit', 1500.00, 1, 100, '2022-06-21 23:04:56');
INSERT INTO product_info VALUES ('F0006', 3, '2022-06-21 23:03:55', 'Casual', 'https://i.pinimg.com/736x/83/39/38/833938651216c77f3a965767c1f3ecf9--mens-cardigan-fashion-mens-boots-fashion.jpg', 'Jacket', 2000.00, 1, 300, '2022-06-21 23:05:57');

