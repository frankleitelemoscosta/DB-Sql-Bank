CREATE TABLE Transacao(
	Id_destinatario INT,
	Id_pagante INT,
	Valor VARCHAR(100),
	Tipo VARCHAR(100),
	FOREIGN KEY (Id_destinatario) REFERENCES Usuario(Id),
	FOREIGN KEY (Id_pagante) REFERENCES Usuario(Id) 
);
