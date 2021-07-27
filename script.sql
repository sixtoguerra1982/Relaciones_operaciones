DROP DATABASE blog;

CREATE DATABASE blog;

\c blog;

CREATE TABLE usuario(
    id INT,
    email VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE post(
    id INT,
    usuario_id INT,
    titulo VARCHAR(100),
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(usuario_id) REFERENCES usuario(id)
);

CREATE TABLE comentario(
    id INT,
    usuario_id INT,
    post_id INT,
    texto VARCHAR(100),
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(post_id) REFERENCES post(id),
    FOREIGN KEY(usuario_id) REFERENCES usuario(id)
);

\COPY usuario FROM 'usuarios.csv' CSV;

\COPY post FROM 'posts.csv' CSV;

\COPY comentario FROM 'comentarios.csv' CSV;

-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT y.id, y.email, x.titulo FROM(SELECT * FROM post WHERE usuario_id = 5) AS x INNER JOIN usuario AS y ON x.usuario_id = y.id; 

SELECT u.email,p.id,p.titulo FROM usuario AS u LEFT JOIN post AS p ON u.id = p.usuario_id WHERE u.id = 5; 

SELECT usuario.id, usuario.email, post.titulo FROM USUARIO INNER JOIN Post ON usuario.id=post.usuario_id WHERE usuario.id=5;

--  Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
-- usuario.correo
-- comentario.id
-- comentario.texto

SELECT usuario.email, comentario.id, comentario.texto FROM comentario FULL OUTER JOIN usuario ON comentario.usuario_id = usuario.id WHERE usuario.email <> 'usuario06@hotmail.com' AND comentario.id IS NOT NULL;

--  Listar los usuarios que no han publicado ningún post.

SELECT usuario.email FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE post.id IS NULL;

SELECT email AS usuarios FROM usuario AS u WHERE u.id NOT IN (SELECT usuario_id FROM post);

SELECT usuario.id FROM POST FULL OUTER JOIN USUARIO ON usuario.id=post.usuario_id WHERE titulo IS NULL;

-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
SELECT * FROM post FULL OUTER JOIN comentario ON post.id = comentario.post_id;

-- Listar todos los usuarios que hayan publicado un post en Junio
SELECT DISTINCT(usuario.email) FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE EXTRACT(MONTH FROM post.fecha) = 6; 

SELECT DISTINCT(usuario.email) FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE fecha BETWEEN '2020-05-31' AND '2020-07-01';