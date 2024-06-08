CREATE TABLE Usuario(
	name VARCHAR(40),
	CPF INT PRIMARY KEY,
	saldo DECIMAL,
	email VARCHAR(40),
	telefone VARCHAR(14),
	aniversario DATE
);

CREATE TABLE Transacao(
	CPFdestinatario INT,
	CPFpagante INT,
	Valor DECIMAL,
	FOREIGN KEY (CPFdestinatario) REFERENCES Usuario(CPF),
	FOREIGN KEY (CPFpagante) REFERENCES Usuario(CPF) 
);
