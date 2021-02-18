# Arvore_KNN_BreastCancer


O câncer de mama é o tipo de câncer mais prevalente encontrado em mulheres em todo o mundo, bem como uma das principais causas de morte entre elas. Pesquisas recentes mostram que este tipo de câncer é um dos que mais avançam mundialmente em termos de  novos casos, trazendo grande preocupação às autoridades de saúde quanto à formulação de políticas públicas, conscientização sobre os fatores de risco e detecção precoce e regular. Esforços da comunidade científica na detecção preditiva, classificação de malignidade e tratamento eficaz desta doença também tem sido exaustivamente realizados, tanto no campo da medicina ou farmacologia clássica quanto na área da bioinformática e biologia computacional, empenhados no objetivo de  reduzir a mortalidade por câncer de mama.
No que diz respeito à biologia computacional, a utilização de algoritmos de aprendizado de máquina que sejam capazes de classificar e, ainda, predizer a malignidade de um tumor frente a características celulares específicas, podem ser de grande utilidade na determinação clínica e grau de seriedade de um dado paciente, auxiliando a equipe médica quanto à tomada de decisões e escolha de tratamento.

Neste sentido, o presente projeto traz para análise e discussão três conjuntos de dados (ou datasets) experimentais de câncer de mama - Wisconsin Breast Cancer (WBC), Wisconsin Diagnostic Breast Cancer (WDBC) e Wisconsin Prognostic Breast Cancer (WPBC) - com dados coletados nos hospitais da Universidade de Wisconsin durante o período de janeiro 1989 a julho de 1992, e acessados por meio do repositório de aprendizado de máquina da Universidade da California (Irvine). 
O dataset WBC (breast_cancer_wincosin) traz 699 instâncias e onze atributos ou variáveis, dos quais tais atributos representam o seguintes parâmetros (ou colunas), na seguinte ordem: 


1) Sample code number           
2) Clump Thickness               
3) Uniformity of Cell Size       
4) Uniformity of Cell Shape      
5) Marginal Adhesion          
6) Single Epithelial Cell Size   
7) Bare Nuclei                  
8) Bland Chromatin               
9) Normal Nucleoli               
10) Mitoses                       
11) Class                    


Neste dataset, o último atributo (ou seja, “Classe”) indica a característica de malignidade ou não do tumor, sendo “2” tumor benigno e  “4” para maligno, correspondendo à seguinte representatividade no dataset em relação ao número de instâncias:    458 benignos (65,5%) e 241 malignos (34,5%). 
Por sua vez, o dataset WDBC possui 569 instâncias e 32 atributos, sendo ID e diagnóstico (B para benigno e M para maligno) os dois primeiros e mais 30 características divididas entre média, erro padrão e "pior" ou maior (média dos três maiores valores) computadas para cada imagem de núcleo celular, sendo os trinta atributos: raio (média das distâncias do centro aos pontos do perímetro), textura, perímetro, área, suavidade (variação local nos comprimentos dos raios), compactação (perímetro² / área - 1,0), concavidade (severidade das porções côncavas do contorno), pontos côncavos (número de porções côncavas do contorno), simetria e dimensão fractal. Em relação ao número de instâncias, o dataset WDBC apresenta 357 exemplares benignos e 212 malignos. [1][2][3][4] [5][6]
Por fim, o dataset WPBC reúne dados de acompanhamento de casos já confirmados de câncer de mama, onde os registros representam casos de pacientes consecutivos atendidos pelo Dr. Wolberg desde 1984, e inclui destes apenas os casos que exibiram câncer de mama invasivo, porém, com nenhuma evidência de metástase no momento que o diagnóstico fora realizado. No total, 198 instâncias e 35 atributos  fazem parte deste dataset, sendo 30 deles computados para cada imagem de núcleo celular - da mesma forma como foram descritos previamente no dataset WDBC - e coletados igualmente a partir de um aspirado por agulha fina de massa mamária. Outros dois dois atributos representam o tamanho do tumor  (diâmetro do mesmo excisado em centímetros) e o status do linfonodo (número de linfonodos axilares positivos) no momento da cirurgia, com os restantes representando o número de identificação da instância (ID number), resultado de recorrência (R = recorrente, N = não recorrente) e o tempo associado (sendo tempo de recorrência se resultado = R, ou, tempo livre de doença se resultado = N). Já em relação ao número de instâncias, o dataset apresenta 151 não recorrentes e 47 recorrentes. [1][2][3][4][5][6]

Nesse contexto, com o objetivo de realizar a classificação destes dados a partir da malignidade ou não do tumor (WBC e WDBC) ou, no caso do último dataset (WPBC), da recorrência do câncer, implementamos os algoritmos KNN e árvore de decisão para cada dataset, validando a precisão dos resultados de classificação e comparando a taxa de acerto dos dois algoritmos.
