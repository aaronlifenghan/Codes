#!/usr/bin/perl -w  
########################################################################################################################################################################################
##    For a detailed description of this evaluation metric and source code, please read:                                                                                           #####
##    This code is to implement the Machine Translation Evaluation metric hLEPOR                                                                                                   #####
##    hLEPOR evaluation metric is proposed by Aaron Li-Feng Han, Derek F. Wong, Lidia S. Chao, Liangye He, Yi Lu, Junwen Xing and Xiaodong Zeng in University of Macau             #####
##    This perl code is  written by Aaron Li-Feng Han in university of macau, 2013.04                                                                                              #####
##    All Copyright (c) preserved by the authors. Corresponding author: Aaron Li-Feng Han < hanlifengaaron@gmail.com >                                                             #####
##    Please cite paper below if you use the metric or source code in your research work                                                                                           #####
##    "Language-independent Model for Machine Translation Evaluation with Reinforced Factors". 2013. Aaron Li-Feng Han, Derek F. Wong, Lidia S. Chao, Liangye He, Yi Lu,           #####
##    Junwen Xing and Xiaodong Zeng. Proceedings of the Machine Translation Summit XIV, Nice, France. International Association for Machine Translation.                           #####
##    Source code website: https://github.com/aaronlifenghan/aaron-project-hlepor                                                                                                  #####
##    Online paper: http://www.mtsummit2013.info/programme.asp                                                                                                                     #####
########################################################################################################################################################################################
##    How to use this Perl code and how to assign the weights of sub-factors, e.g. Precision, Recall, Length penalty, Position difference penalty, et.                             #####
##    1. Your system output translation documents and the reference translation document should contain the plain text only, each line containing one sentence.                    #####
##    2. Put you system output translation documents under the address in Line 23, 53, 55 of this Perl code.                                                                       #####
##    3. Put you reference translation document under the address in Line 27 of this Perl code.                                                                                    #####
##    4. Tune the alpha:beta(Recall:Precision) weights in Line 176; Tune the HPR:ELP:NPP weights in Line 369-371 of this Perl code.                                                #####
##    5. The document containing evaluation score of hLEPOR will be shown under the address in Line 57 of this Perl code.                                                          #####
##                                                                                                                                                                                 #####
########################################################################################################################################################################################


# #open E1,"<:encoding(utf8)","Test-content-lm.txt"; ## put the address of language model file p(e1) here
# open E1,"<:encoding(utf8)","news-commentary-v8.fr-en.arpa copy.en"; ## put the address of language model file p(e1) here

# 		$E1_length=0;
# 		$str_tem="";
# 		@arry_tem=();
# 		@arry_str_leng=();
# 		@arrytwo_E1_file=();
# 		$num_of_E1_line=0;

# 		while($str_tem=<E1>)
# 			{
# 				chomp($str_tem);
# 				@arry_tem=split(/\t+/, $str_tem);
# 				push @arrytwo_E1_file, [@arry_tem];
# 				@arry_tem=();
# 				$num_of_E1_line++;	


# 			}
# close E1;


# open (RESULT, ">:encoding(utf8)", "Test-storage-lm-2.txt") || die "$!"; ## put the address of evaluation results documents here 

# 							for($j=0;$j<$num_of_E1_line;$j++)
# 							{
# 								for($k=0;$k<=1;$k++)
# 									{
# 										print RESULT $arrytwo_E1_file[$j][$k], ' -- ';
# #										print RESULT $arrytwo_E1_file[$j][$k], ' -- ';



# 									}
# 									print RESULT "\n";
# 							}


# close RESULT;

######################################################### 
open PhraseT,"<:encoding(utf8)","Test-content-phraseT.txt"; ## put the address of phrase table file p(e|f) and reverse here

open ResultF,">:encoding(utf8)","phraseT-into-_f-e-a.txt"; ## put the address of phrase table file p(e|f) and reverse here


	$str_tem_input="";
	@arry_tem_store=();


	while($str_tem_input=<PhraseT>)
		{
			chomp($str_tem_input);
			@arry_tem_store=split(/\s+\|\|\|\s+/, $str_tem_input);
			print ResultF $arry_tem_store[0], ' ||| ', $arry_tem_store[1], ' ||| ', $arry_tem_store[3], "\n";


		}



close PhraseT;
close ResultF;








# 		$PhraseT_length=0;
# 		$str_tem2="";
# 		@arry_tem2=();
# 		@arry_str_leng=();
# 		@arrytwo_PhraseT_file=();
# 		$num_of_PhraseT_line=0;

# 		while($str_tem2=<PhraseT>)
# 			{
# 				chomp($str_tem2);
# 				@arry_tem2=split(/\s+\|\|\|\s+/, $str_tem2);  # split by ' ||| ', also remove the spaces
# #				@arry_tem2=split(/\|\|\|/, $str_tem2);
# #				@arry_tem2=split(/\s+|||\s+/, $str_tem2);
# 				push @arrytwo_PhraseT_file, [@arry_tem2];
# 				@arry_tem2=();
# 				$num_of_PhraseT_line++;	


# 			}
# close PhraseT;


# @arry_tem_split_phraseT_4P=();
# for($i=0;$i<$num_of_PhraseT_line;$i++)
# 	{
# 		@arry_tem_split_phraseT_4P=split(/\s+/, $arrytwo_PhraseT_file[$i][2]); #split the 4 different probability into a tem arry, then, add the 4 probability num into the original arry;
# #		push @arrytwo_PhraseT_file[$i], [@arry_tem_split_phraseT_4P]; # push function is the operation to the end of the arry
# #		splice @arrytwo_PhraseT_file[$i], 2, 0, [@arry_tem_split_phraseT_4P]; # splice, add element into the midlle of arry; from 2th position, delete nothing; insert new arry
# 		splice @arrytwo_PhraseT_file[$i], 2, 0, @arry_tem_split_phraseT_4P; # splice, add element into the midlle of arry; from 2th position, delete nothing; insert new arry

# 		@arry_tem_split_phraseT_4P=();
# 	}



# # open (TestPhraseT, ">:encoding(utf8)", "TestPhraseT-P-storage-test-2.txt") || die "$!"; ## put the address of test results documents here 

# # 							for($j=0;$j<$num_of_PhraseT_line;$j++)
# # 							{
# # 								for($k=0;$k<=4;$k++)
# # 									{
# # 										print TestPhraseT $arrytwo_PhraseT_file[$j][$k], ' ++++++ ';
# # #										print TestPhraseT $arrytwo_PhraseT_file[$j][$k], '-==-';
# # #										print TestPhraseT $arrytwo_E1_file[$j][$k], ' -- ';



# # 									}
# # 									print TestPhraseT "\n";
# # 							}


# # close TestPhraseT;

# @arrytwo_Pe_file=(); 
# # to store the marginal probability P(e)=\sum p(e,f*)= sum P(f*|e), where f* is variable
# $Pe_file_length=0;
# #store the length of file
# @tem_arry_Pe=();
# # temperary arry to stroe special e1

# for($i=0; $i<$num_of_PhraseT_line; $i++)
# 	{
# 		@tem_arry_Pe=()
# 	}





# @arrytwo_JointPef_file=();  
# # store the joint probability P(e1,f1)=P(e1)xP(f1|e1)
# $JointPef_file_length=0;
# # store the lenght of the generated file
# @tem_arry_Pef=();
# #temperaty arry to store e1, f1, and P(e1,f1); to be pushed
# $tem_JointPef_value=0;
# # store temperary joint probability vlue , P(e1,f1)

# for($i=0; $i<$num_of_E1_line; $i++)
# 	{
# 		for($j=0;$j<$num_of_PhraseT_line;$j++)
# 			{
# 				if($arrytwo_E1_file[$i][1]==$arrytwo_PhraseT_file[$j][1])
# 				## in P(e1) file, it is like '-3,52 ||| horse ||| another_number'
# 				## in P(f|e) file, it is like '$ en intérêts sur cet ajout ||| year in real interest on that extra ||| 0.2 2.37893e-12 0.5 8.94927e-11 ||| 1-1 2-3 3-4 4-5 5-6 ||| 5 2 1 ||| |||', the for probabilities: p(f|e),lex(f|e),p(e|f),lex(e|f)
# 					{
# 						$tem_JointPef_value=10**$arrytwo_E1_file[$i][0] * $arrytwo_PhraseT_file[$j][2];
# 						@tem_arry_Pef= ('$arrytwo_E1_file[$i][1]', '$arrytwo_PhraseT_file[$j][0]', '$tem_JointPef_value');
# 						push @arrytwo_JointPef_file, [@tem_arry_Pef];
# 						$JointPef_file_length++;
# 						@tem_arry_Pef=();
# 						$tem_JointPef_value=0;
# 					}
# 			}
# 	}
# # 							for($j=0;$j<$num_of_E1_line;$j++)


# open (StoreJointPef, ">:encoding(utf8)", "JointPef-storage.txt") || die "$!"; ## put the address of test results documents here 

# 							for($j=0;$j<$JointPef_file_length;$j++)
# 							{
# 								for($k=0;$k<=2;$k++)
# 									{
# 										print StoreJointPef $arrytwo_PhraseT_file[$j][$k], ' ++++ ';
# #										print TestPhraseT $arrytwo_PhraseT_file[$j][$k], '-==-';
# #										print TestPhraseT $arrytwo_E1_file[$j][$k], ' -- ';



# 									}
# 									print StoreJointPef "\n";
# 							}


# close TestPhraseT;





