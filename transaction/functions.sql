CREATE PROCEDURE insert_transaction(
    IN Id_Pagante INT,
    IN Id_destinatario INT,
    IN Valor VARCHAR(100),
    IN Tipo VARCHAR(100)
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
        Id_destinatario,
        Id_pagante,
        Valor,
        Tipo
    ) VALUES (
        Id_Pagante,
        Id_destinatario,
        Valor,
        Tipo
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
    IN s_Id_pagante INT
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
        t.Id_destinatario,
        t.Id_pagante,
        t.Valor,
        t.Tipo
    FROM Transacao t
    WHERE t.Id_pagante = s_Id_pagante;

    -- Verifica se não há registros encontrados
    IF ROW_COUNT() = 0 THEN
        SELECT JSON_OBJECT('status', 'error', 'message', 'No records found') AS error;
    END IF;
END;

CALL get_transaction('55555');
