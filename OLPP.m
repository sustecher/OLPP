function [SEG1_Final,Mask_GM] = OLPP(SEG1)
%   此处显示详细说明
    [sA,junk,sB,junk,sC,eC] = Find_range(SEG1,0,0,0);
    %%
    CSF=SEG1==1;
    GM=SEG1==3;
    WM=SEG1==2;
    LV=SEG1==4;
    Skull=SEG1>4;
    % Correct some misclass tissues between 
    %% skull
    WM_LC=Label_connected(WM);
    GM_LC=Label_connected(GM);
    %CSF_LC=Label_connected(CSF);
    %% CSF
    M_inside_CSF =imfill(SEG1>0,'holes')-Label_connected(Skull)-CSF; 
    M_inside_CSF=Label_connected(M_inside_CSF);
    
    GM_to_Skull=(1-M_inside_CSF).*(GM-GM_LC==1);
    WM_to_Skull=(1-M_inside_CSF).*(WM-WM_LC==1);
    CSF_2_Skull=CSF+M_inside_CSF-Label_connected(CSF+M_inside_CSF);
    
    GM(GM_to_Skull==1)=0;
    WM(WM_to_Skull==1)=0;
    CSF(CSF_2_Skull==1)=0;
    Skull(GM_to_Skull==1)=1;
    Skull(WM_to_Skull==1)=1;
    Skull(CSF_2_Skull==1)=1;
    %%
    SEG1_PP=zeros(size(SEG1));
    %% 
    LV=LV+M_inside_CSF.*(SEG1==0);
    %%
    SEG1_PP(Skull==1)=5;
    SEG1_PP(CSF==1)=1;
    SEG1_PP(GM==1)=3;
    SEG1_PP(WM==1)=2;
    SEG1_PP(LV==1)=4;

    %%
    SEG1_Final=SEG1_PP;
    %SEG1_Final(SEG1_Final==4)=0;SEG1_Final(SEG1_Final==5)=0;SEG1_Final(SEG1_Final>0.5)=1;
    %% choose output
    %SEG1_Final=GMWM_M;
end

