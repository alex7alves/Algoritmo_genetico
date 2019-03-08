%Desenvolvimento de um algoritmo genético
% Para duas variáveis 
%Autor : Alex Alves

function m = nain()
close all
clear
clc
%Ts=1;
[x,y] =  AG(70,70,90,2,5)
end
function[Melhor_individuox, Melhor_individuoy]  = AG(Numero_De_Geracoes,Tamanho_Da_Populacao,taxaCros,taxa_mutacao,Numero_de_bits_do_Individuo )

Valor_Populacao_Binariox=randi([0 1],Tamanho_Da_Populacao,Numero_de_bits_do_Individuo); 
Valor_Populacao_Binarioy=randi([0 1],Tamanho_Da_Populacao,Numero_de_bits_do_Individuo);    

Melhor_individuox  = zeros(Tamanho_Da_Populacao,1); 
Melhor_individuoy  = zeros(Tamanho_Da_Populacao,1); 
for i=1:Numero_De_Geracoes
  
    Valor_Populacao_Decimalx=bi2de(Valor_Populacao_Binariox,'left-msb')'; 
    Valor_Populacao_Decimaly=bi2de(Valor_Populacao_Binarioy,'left-msb')'; 
  %   populacao_Realx =  Valor_Populacao_Decimalx/((2^Numero_de_bits_do_Individuo)-1);     
   %  populacao_Realy =  Valor_Populacao_Decimaly/((2^Numero_de_bits_do_Individuo)-1);  

     disp([num2str(i) 'ª Populaçãox =     ' num2str(Valor_Populacao_Decimalx)  'ª Populaçãoy =     ' num2str(Valor_Populacao_Decimaly)]);
  % disp([num2str(i) 'ª População =     ' num2str( populacao_Real)]);
    x=Valor_Populacao_Decimalx;
    y= Valor_Populacao_Decimaly;
     Aptidao= (x.*x)+(y.*y) +(((3.*x)+ (4.*y) -26).*((3.*x)+ (4.*y) -26));
    for j=1:2:(Tamanho_Da_Populacao)
        
        %Seleção Por Torneio     
           Escolhido1= Torneio( Aptidao,Tamanho_Da_Populacao);
           Escolhido2= Torneio( Aptidao,Tamanho_Da_Populacao);
     
     %Cruzamento por Um-Ponto
        Valor_Populacao_Binariox = Cros_Over(Numero_de_bits_do_Individuo,Escolhido1,Escolhido2,Valor_Populacao_Binariox,j,Tamanho_Da_Populacao,taxaCros);
        Valor_Populacao_Binarioy = Cros_Over(Numero_de_bits_do_Individuo,Escolhido1,Escolhido2,Valor_Populacao_Binarioy,j,Tamanho_Da_Populacao,taxaCros);
    end
    
    %mutacao
    Valor_Populacao_Binariox = Mutacao(Valor_Populacao_Binariox,Numero_de_bits_do_Individuo,Tamanho_Da_Populacao,taxa_mutacao);
    Valor_Populacao_Binarioy = Mutacao(Valor_Populacao_Binarioy,Numero_de_bits_do_Individuo,Tamanho_Da_Populacao,taxa_mutacao);
    [Mi,pos]= min(Aptidao);
    Melhor_individuox(i) = Valor_Populacao_Decimalx(pos);
    Melhor_individuoy(i) = Valor_Populacao_Decimaly(pos);
  % Melhor_individuox(i) =  populacao_Realx(pos);
 % Melhor_individuoy(i) =  populacao_Realy(pos);
 
    plot( Melhor_individuox, Melhor_individuox,'o');
end

fprintf(['\n\nPopulação Finalx = '  num2str(Valor_Populacao_Decimalx) '\n\nPopulação Finaly = '  num2str(Valor_Populacao_Decimaly) '\n\n']);
end

function  Valor_Populacao_Binario = Mutacao(Valor_Populacao_Binario,Numero_de_bits_do_Individuo,Tamanho_Da_Populacao,taxa_mutacao)
        for k=1:Tamanho_Da_Populacao 
            for g=1:Numero_de_bits_do_Individuo 
                mutacao =  randi(100);
                if(mutacao<=taxa_mutacao)

                   if( Valor_Populacao_Binario(k,g)==0 ) 
                        Valor_Populacao_Binario(k,g) =1;
                   else
                        Valor_Populacao_Binario(k,g)=0;
                   end
                end
            end
        end   
end

function pos = Torneio(z,Tamanho_Da_Populacao)
 x = randi([1 Tamanho_Da_Populacao],1,4);
concorrentes =  zeros(1,length(x));
posicoes =  zeros(1,length(x));
    for i=1: length(x)
        concorrentes(i) = z(x(i));  
        posicoes(i)=x(i);
    end
   selecionado =concorrentes(1);
    pos=  posicoes(1);
    for i=1:length(x)
        if selecionado > concorrentes(i)
            selecionado = concorrentes(i);
            pos= posicoes(i);
        end        
    end   
end
function Valor_Populacao_Binario = Cros_Over(Numero_de_bits_do_Individuo,Escolhido1,Escolhido2,Valor_Populacao_Binario,j,Tamanho_Da_Populacao,taxaCros)

        HaCrossover=randi(Tamanho_Da_Populacao);
         if  HaCrossover <= taxaCros
            Corte_Crossover=randi(Numero_de_bits_do_Individuo-1); 

            aux=Valor_Populacao_Binario(Escolhido1,(1:end)); 
            Valor_Populacao_Binario(j,(1:end))= [Valor_Populacao_Binario(Escolhido2,(1:Corte_Crossover)) Valor_Populacao_Binario(Escolhido1,(Corte_Crossover+1:end))]; 
            Valor_Populacao_Binario(j+1,(1:end))= [aux(1:Corte_Crossover)   Valor_Populacao_Binario(Escolhido2,(Corte_Crossover+1:end))]; 
         else 
             Valor_Populacao_Binario(j,(1:end)) = Valor_Populacao_Binario(Escolhido1,1:end);
              Valor_Populacao_Binario(j+1,(1:end))= Valor_Populacao_Binario(Escolhido2,1:end);
         end
end
