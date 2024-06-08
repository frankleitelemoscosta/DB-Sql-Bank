CREATE PROCEDURE insert_transaction(
    IN CPFPagante INT,
    IN CPFdestinatario INT,
    IN Valor DECIMAL,
    IN Modo VARCHAR(1)
)
BEGIN
    DECLARE error_message VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_message = MESSAGE_TEXT;
        SELECT JSON_OBJECT('status', 'error', 'message', error_message) AS error;
    END;

    -- Insere os dados na tabela Usuario
    INSERT INTO Transacao(
        CPFdestinatario,
        CPFpagante,
        Valor,
        Modo
    ) VALUES (
        CPFPagante,
        CPFdestinatario,
        Valor,
        Modo
    );

    IF ROW_COUNT() > 0 THEN
        SELECT JSON_OBJECT('status', 'success', 'message', 'Dados inseridos com sucesso') AS result;
    ELSE
        SELECT JSON_OBJECT('status', 'error', 'message', 'Falha ao inserir dados') AS error;
    END IF;
END;

CALL insert_transaction('444','55555',222);

-------------------------------------------------------------------------------------------------

CREATE PROCEDURE get_transaction(
    IN s_CPFpagante INT
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
        t.CPFdestinatario,
        t.CPFpagante,
        t.Valor,
        t.Modo
    FROM Transacao t
    WHERE t.CPFpagante = s_CPFpagante;

    -- Verifica se não há registros encontrados
    IF ROW_COUNT() = 0 THEN
        SELECT JSON_OBJECT('status', 'error', 'message', 'No records found') AS error;
    END IF;
END;

CALL get_transaction('55555');
