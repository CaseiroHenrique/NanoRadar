config = {}


config.serverName = "CapitalModerna_1700001005970"

-- Define a URL do webhook para o envio da log    
config.webhook = "https://discord.com/api/webhooks/1176973898575781928/RZrWU9ip2mQ9vRpvcFOvRcYjo2QDDiuWNKmL4l1DzErfHTOx2lMmd0VN8EX6c-Zp2mpR"

-- Define os grupos que vão estar isentos a tomar multa
config.isentos = {"police", "admin"}

--Defina a notificação que será enviada quando o jogador receber uma multa por velocidade
config.notifymulta = "Você passou pelo radar a $velocidade KM/h e recebeu uma multa de R$ $multa"
-- UTILIZE "$velocidade" para mostrar na notify a velocidade que o jogador estava quando tomou multa
-- UTILIZE "$multa" para mostrar na notify o valor da multa que o jogador recebeu

config.mensagemisento = "Obrigado pelos seus serviços!"

--DIGITE ABAIXO COMO A PLCA FICA APÓS CLONAR A PLACA
--SEMPRE UTILIZA LETRAS MAIUSCULAS PARA FUNCIONAR.
config.clonada = "CLONADA1"