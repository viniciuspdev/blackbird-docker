DROP TABLE IF EXISTS permissao CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS amizade CASCADE;
DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS solicitacao_amizade CASCADE;
DROP TABLE IF EXISTS comentario CASCADE;
DROP TABLE IF EXISTS play CASCADE;



CREATE TABLE usuario (
                         id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                         nome_completo VARCHAR(255) NOT NULL,
                         email VARCHAR(255) NOT NULL,
                         apelido VARCHAR(50),
                         data_nascimento DATE NOT NULL,
                         senha VARCHAR(128) NOT NULL,
                         ativo BOOLEAN NOT NULL,
                         artista_favorito VARCHAR(255),
                         imagem VARCHAR (512)
);
ALTER TABLE usuario ADD CONSTRAINT pk_usuario PRIMARY KEY (id);
ALTER TABLE usuario ADD CONSTRAINT uk_usuario_email UNIQUE (email);

-----

CREATE TABLE permissao (
                           id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                           funcao VARCHAR(100) NOT NULL,
                           usuario_id BIGINT NOT NULL
);

ALTER TABLE permissao ADD CONSTRAINT pk_permissao PRIMARY KEY (id);
ALTER TABLE permissao ADD CONSTRAINT uk_permissao UNIQUE (funcao, usuario_id);
ALTER TABLE permissao ADD CONSTRAINT fk_permissao_usuario FOREIGN KEY (usuario_id) REFERENCES usuario;

-----

CREATE TABLE solicitacao_amizade (
                                     id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                                     remetente_id BIGINT NOT NULL,
                                     destinatario_id BIGINT NOT NULL,
                                     status VARCHAR(8) NOT NULL
);

ALTER TABLE solicitacao_amizade ADD CONSTRAINT pk_solicitacao_amizade PRIMARY KEY (id);
ALTER TABLE solicitacao_amizade ADD CONSTRAINT ck_solicitacao_amizade CHECK (status IN ('PENDENTE', 'ACEITA'));
ALTER TABLE solicitacao_amizade ADD CONSTRAINT fk_remetente_usuario FOREIGN KEY (remetente_id) REFERENCES usuario;
ALTER TABLE solicitacao_amizade ADD CONSTRAINT fk_destinatario_usuario FOREIGN KEY (destinatario_id) REFERENCES usuario;

-----

CREATE TABLE post (
                      id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                      conteudo VARCHAR(512) NOT NULL,
                      visualizacao VARCHAR(7) NOT NULL,
                      quantidade_plays BIGINT NOT NULL,
                      data_postagem TIMESTAMP NOT NULL,
                      midia VARCHAR(512),
                      usuario_id BIGINT NOT NULL
);

ALTER TABLE post ADD CONSTRAINT pk_post PRIMARY KEY (id);
ALTER TABLE post ADD CONSTRAINT ck_post CHECK (visualizacao IN ('PUBLICO', 'PRIVADO'));
ALTER TABLE post ADD CONSTRAINT fk_post_usuario FOREIGN KEY (usuario_id) REFERENCES usuario;

-----

CREATE TABLE play(
            id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
            usuario_id BIGINT NOT NULL,
            post_id BIGINT NOT NULL
);

ALTER TABLE play ADD CONSTRAINT pk_play PRIMARY KEY (id);
ALTER TABLE play ADD CONSTRAINT fk_play_usuario FOREIGN KEY (usuario_id) REFERENCES usuario;
ALTER TABLE play ADD CONSTRAINT fk_play_post FOREIGN KEY (post_id) REFERENCES post;


-----

CREATE TABLE comentario(
                    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                    conteudo VARCHAR(512) NOT NULL,
                    usuario_id BIGINT NOT NULL,
                    post_id BIGINT NOT NULL
);

ALTER TABLE comentario ADD CONSTRAINT pk_comentario PRIMARY KEY (id);
ALTER TABLE comentario ADD CONSTRAINT fk_comentario_usuario FOREIGN KEY (usuario_id) REFERENCES usuario;
ALTER TABLE comentario ADD CONSTRAINT fk_comentario_post FOREIGN KEY (post_id) REFERENCES post;

-----

CREATE TABLE amizade(
                        id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
                        primeiro_usuario_id BIGINT NOT NULL,
                        segundo_usuario_id BIGINT NOT NULL
);

ALTER TABLE amizade ADD CONSTRAINT pk_amizade PRIMARY KEY (id);
ALTER TABLE amizade ADD CONSTRAINT fk_primeiro_usuario_usuario FOREIGN KEY (primeiro_usuario_id) REFERENCES usuario;
ALTER TABLE amizade ADD CONSTRAINT fk_segundo_usuario_usuario FOREIGN KEY (segundo_usuario_id) REFERENCES usuario;


