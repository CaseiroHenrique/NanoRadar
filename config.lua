config = {}

--Recomendo deixar como TRUE para configuração dos radar, após finalizar a configuração deixe como FALSE
config.debug = "true"

--Defina abaixo as coordenadas, limite de velocidade e valor da multa para cada radar
config.lines = {
    {id = 1, start = vector3(160.84,-1007.26,29.49), endline = vector3(152.18,-1031.59,29.34), limite_velocidade = 60, valor_multa = 200},
    {id = 2, start = vector3(320.18,-1331.78,32.13), endline = vector3(337.86,-1306.21,32.07), limite_velocidade = 50, valor_multa = 150},
}
