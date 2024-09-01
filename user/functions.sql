CREATE PROCEDURE insert_user(
    IN i_Nome VARCHAR(40),
    IN i_CPF VARCHAR(14),
    IN i_saldo VARCHAR(100),
    IN i_email VARCHAR(100),
    IN i_senha VARCHAR(40),
    IN i_telefone VARCHAR(14),
    IN i_aniversario DATE
)
BEGIN
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT JSON_OBJECT('status', 'error', 'message', error_message) AS error;
    END;

    -- Insere os dados na tabela Usuario
    INSERT INTO Usuario(
        Nome,
        CPF,
        saldo,
        email,
        Senha,
        telefone,
        aniversario
    ) VALUES (
        i_name,
        i_CPF,
        i_saldo,
        i_email,
        i_senha,
        i_telefone,
        i_aniversario
    );

    -- Verifica se a inserção foi bem-sucedida
    IF ROW_COUNT() > 0 THEN
        SELECT JSON_OBJECT('status', 'success', 'message', 'Dados inseridos com sucesso') AS result;
    ELSE
        SELECT JSON_OBJECT('status', 'error', 'message', 'Falha ao inserir dados') AS error;
    END IF;
END;

CALL insert_user('Exemplo',43253,54235,'fdsaf',43523,'2001-10-20');

-------------------------------------------------------------------------------------------------

CREATE PROCEDURE get_usuario(
    IN s_CPF INT
)
BEGIN
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT JSON_OBJECT('status', 'error', 'message', error_message) AS error;
    END;

    -- Consulta para obter os dados e retornar o resultado diretamente
    SELECT 
        t.name,
        t.CPF,
        t.saldo,
        t.email,
        t.telefone,
        t.aniversario
    FROM Usuario t
    WHERE t.CPF = s_CPF;

    -- Verifica se não há registros encontrados
    IF ROW_COUNT() = 0 THEN
        SELECT JSON_OBJECT('status', 'error', 'message', 'No records found') AS error;
    END IF;
END;

CREATE PROCEDURE update_user(
    IN i_name VARCHAR(40),
    IN i_CPF VARCHAR(14),
    IN i_saldo DECIMAL(10, 2),
    IN i_email VARCHAR(40),
    IN i_telefone VARCHAR(14),
    IN i_aniversario DATE
)
BEGIN
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT JSON_OBJECT('status', 'error', 'message', error_message) AS error;
    END;

    -- Atualiza os dados na tabela Usuario onde o CPF corresponde
    UPDATE Usuario
    SET
        name = i_name,
        saldo = i_saldo,
        email = i_email,
        telefone = i_telefone,
        aniversario = i_aniversario
    WHERE CPF = i_CPF;

    -- Verifica se a atualização foi bem-sucedida
    IF ROW_COUNT() > 0 THEN
        SELECT JSON_OBJECT('status', 'success', 'message', 'Dados atualizados com sucesso') AS result;
    ELSE
        SELECT JSON_OBJECT('status', 'error', 'message', 'Falha ao atualizar dados ou CPF não encontrado') AS error;
    END IF;
END;

CREATE PROCEDURE get_usuario_login(
    IN s_email VARCHAR(100),
    IN s_senha VARCHAR(40)
)
BEGIN
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT JSON_OBJECT('status', 'error', 'message', error_message) AS error;
    END;

    -- Consulta para obter os dados e retornar o resultado diretamente
    SELECT 
        T.Id,
        t.Nome,
        t.CPF,
        t.saldo,
        t.email,
        t.telefone,
        t.aniversario
    FROM Usuario t
    WHERE t.email = s_email AND t.Senha = s_senha;

    -- Verifica se não há registros encontrados
    IF ROW_COUNT() = 0 THEN
        SELECT JSON_OBJECT('status', 'error', 'message', 'No records found') AS error;
    END IF;
END;