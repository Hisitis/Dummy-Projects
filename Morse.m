%traducteur morse

Mor   =   {'.- '; '-... '; '-.-. '; '-.. '; '. '; '..-. '; '--. '; '.... ';
 '.. '; '.--- '; '-.- '; '.-.. '; '-- '; '-. '; '--- '; '.--. '; '--.- ';
 '.-. '; '... '; '- '; '..- '; '...- '; '.-- '; '-..- '; '-.-- '; '--.. ';
 '    '; '----- '; '.---- '; '..---'; '...-- '; '....- '; '..... ';
 '-.... '; '--... '; '---.. '; '----. '; '.-.-.- '; '--..-- '; '..--.. ';
 '.----. '; '-.-.-- '; '-..-. '; '-.--. '; '-.--.- '; '.-... '; '---... ';
 '-.-.-. '; '-...- '; '.-.-. '; '-....- '; '..--.- '; '.-..-. ' };

Mor =   Mor.';
Alpha = ('abcdefghijklmnopqrstuvwxyz 0123456789.,?''!/()&:;=+-_"');
ALPHA  =    ('ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789.,?''!/()&:;=+-_"');

sa=size(Alpha);
sa=sa(1,2);

text=input('traduire en morse : ','s');
T=size(text);
T=T(1,2);
trad={};

for a=1:T
    for b=1:sa
        if text(1,a)==ALPHA(1,b)
           text(1,a)=Alpha(1,b);
        end
    end
end
for i=1:T
    for j=1:sa
        if text(1,i)==Alpha(1,j)
           trad{1,i}=Mor{1,j};
        end
    end
end

trad=cell2mat(trad);
disp(trad)
