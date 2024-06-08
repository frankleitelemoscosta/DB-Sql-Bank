CREATE TABLE Transacao(
	CPFdestinatario INT,
	CPFpagante INT,
	Valor DECIMAL,
	Modo VARCHAR(1),
	FOREIGN KEY (CPFdestinatario) REFERENCES Usuario(CPF),
	FOREIGN KEY (CPFpagante) REFERENCES Usuario(CPF) 
);
