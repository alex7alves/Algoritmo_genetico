%Desenvolvimento de um algoritmo genético
%Autor : Alex Alves

function m = nain()
close all
clear
clc
%Ts=1;
m =  AG(40,30,90,3,5);
end
function Melhor_individuo = AG(Numero_De_Geracoes,Tamanho_Da_Populacao,taxaCros,taxa_mutacao,Numero_de_bits_do_Individuo )
%Numero_De_Geracoes = 40;
%Tamanho_Da_Populacao=30;
%taxaCros= 90;
%taxa_mutacao = 3;
%Numero_de_bits_do_Individuo=5;

Valor_Populacao_Binario=randi([0 1],Tamanho_Da_Populacao,Numero_de_bits_do_Individuo); 
                                                                                        
Melhor_individuo  = zeros(Tamanho_Da_Populacao,1); 

for i=1:Numero_De_Geracoes
  
    Valor_Populacao_Decimal=bi2de(Valor_Populacao_Binario,'left-msb')'; 
     populacao_Real =  Valor_Populacao_Decimal/((2^Numero_de_bits_do_Individuo)-1);     
   if i==1
       disp(Valor_Populacao_Decimal);
       disp(populacao_Real);
   end
     disp([num2str(i) 'ª População =     ' num2str(Valor_Populacao_Decimal)]);
  % disp([num2str(i) 'ª População =     ' num2str( populacao_Real)]);
    
   Aptidao=(Valor_Populacao_Decimal.*Valor_Populacao_Decimal)- (4*Valor_Populacao_Decimal)+4; 
 %   Aptidao=(populacao_Real.*populacao_Real)- (4*populacao_Real)+4;
 
    for j=1:2:(Tamanho_Da_Populacao)
        
        %Seleção Por Torneio     
           Escolhido1= Torneio( Aptidao,Tamanho_Da_Populacao);
           Escolhido2= Torneio( Aptidao,Tamanho_Da_Populacao);
     
     %Cruzamento 
        Valor_Populacao_Binario = Cros_Over(Numero_de_bits_do_Individuo,Escolhido1,Escolhido2,Valor_Populacao_Binario,j,Tamanho_Da_Populacao,taxaCros);
    end
    
    %mutacao
    Valor_Populacao_Binario = Mutacao(Valor_Populacao_Binario,Numero_de_bits_do_Individuo,Tamanho_Da_Populacao,taxa_mutacao);
  [Mi,pos]= min(Aptidao);
   Melhor_individuo(i) = Valor_Populacao_Decimal(pos);
  % Melhor_individuo(i) =  populacao_Real(pos);
  
    plot( Melhor_individuo,'o');
end

fprintf(['\n\nPopulação Final = '  num2str(Valor_Populacao_Decimal) '\n\n']);
Melhor_individuo
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
  %  saida = v(1,:);
    for i=1:length(x)
        if selecionado > concorrentes(i)
            selecionado = concorrentes(i);
           % saida = v(i,:);
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