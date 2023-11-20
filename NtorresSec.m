clear;
clc;


N = 8; % Numero de torres del problema
Theta = -ones(N, N); % Matriz de sesgos
W = zeros(N, N, N, N); % Matriz de pesos
epoc = 3000; % Numero de epocas
Shist = zeros(N, N, epoc); % Historico de potenciales sinapticos

for i = 1:N
    for j = 1:N
        W(i, j, 1:N, j) = -2;
        W(i, j, i, 1:N) = -2;
        W(i, j, i, j) = 0;
    end
end

for e = 2:epoc
    Shist(:, :, e) = Shist(:, :, e - 1);
    for i = 1:N
        for j = 1:N
            h = 0;
            for l = 1:N
                for k = 1:N
                    h = h + Shist(l, k, e) * W(i, j, l, k);
                end
            end
            Shist(i, j, e) = int16(h > Theta(i, j));
        end
    end
    if (Shist(:, :, e) == Shist(:, :, e - 1))
        break;
    end
end

disp(Shist(:, :, e));