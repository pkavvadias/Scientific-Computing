function matrix2latex2(matrix, filename, varargin)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 30/12/2019
%Based on M. Koehler's matrix2latex found below
%https://github.com/pdollar/toolbox/blob/master/external/other/matrix2latex.m


% Usage:
% matrix2latex2(matrix, filename, varargs)
% where
%   - matrix is a 2 dimensional numerical or cell array
%   - filename is a valid filename, in which the resulting latex code will
%   be stored
%   - varargs is one ore more of the following (denominator, value) combinations
%      +'Mstyle', 'value' -> Latex matrix style, supported are
%      tabular, pmatrix, vmatrix, bmatrix. If no parameter given default is
%      tabular
%      + 'rowLabels', array -> Can be used to label the rows of the
%      resulting latex table
%      + 'columnLabels', array -> Can be used to label the columns of the
%      resulting latex table
%      + 'alignment', 'value' -> Can be used to specify the alginment of
%      the table within the latex document. Valid arguments are: 'l', 'c',
%      and 'r' for left, center, and right, respectively
%      + 'format', 'value' -> Can be used to format the input data. 'value'
%      has to be a valid format string, similar to the ones used in
%      fprintf('format', value);
%      + 'size', 'value' -> One of latex' recognized font-sizes, e.g. tiny,
%      HUGE, Large, large, LARGE, etc.

rowLabels = [];
    colLabels = [];
    alignment = 'l';
    format = [];
    textsize = [];
    latex_envir = 'tabular';
    if (rem(nargin,2) == 1 || nargin < 2)
        error('matrix2latex: ', 'Incorrect number of arguments to %s.', mfilename);
    end

    okargs = {'rowlabels','columnlabels', 'alignment', 'format', 'size','mstyle'};
    for j=1:2:(nargin-2)
        pname = varargin{j};
        pval = varargin{j+1};
        k = strmatch(lower(pname), okargs);
        if isempty(k)
            error('matrix2latex2: ', 'Unknown parameter name: %s.', pname);
        elseif length(k)>1
            error('matrix2latex2: ', 'Ambiguous parameter name: %s.', pname);
        else
            switch(k)
                case 1  % rowlabels
                    rowLabels = pval;
                    if isnumeric(rowLabels)
                        rowLabels = cellstr(num2str(rowLabels(:)));
                    end
                case 2  % column labels
                    colLabels = pval;
                    if isnumeric(colLabels)
                        colLabels = cellstr(num2str(colLabels(:)));
                    end
                case 3  % alignment
                    alignment = lower(pval);
                    if alignment == 'right'
                        alignment = 'r';
                    end
                    if alignment == 'left'
                        alignment = 'l';
                    end
                    if alignment == 'center'
                        alignment = 'c';
                    end
                    if alignment ~= 'l' && alignment ~= 'c' && alignment ~= 'r'
                        alignment = 'l';
                        warning('matrix2latex2: ', 'Unkown alignment. (Set it to \''left\''.)');
                    end
                case 4  % format
                    format = lower(pval);
                case 5  % format
                    textsize = pval;
                case 6 % environment
                    latex_envir = pval;
            end
        end
    end

    fid = fopen(filename, 'w');
    
    width = size(matrix, 2);
    height = size(matrix, 1);

    if isnumeric(matrix)
        matrix = num2cell(matrix);
        for h=1:height
            for w=1:width
                if(~isempty(format))
                    matrix{h, w} = num2str(matrix{h, w}, format);
                else
                    matrix{h, w} = num2str(matrix{h, w});
                end
            end
        end
    end
    
    if(~isempty(textsize))
        fprintf(fid, '\\begin{%s}', textsize);
    end
    if strcmp(latex_envir,'tabular')
        fprintf(fid, '\\begin{%s}{|',latex_envir);
    
        if(~isempty(rowLabels))
            fprintf(fid, 'l|');
        end
    else
      fprintf(fid, '\\begin{%s',latex_envir);
    end
    if strcmp(latex_envir,'tabular')
        for i=1:width
            fprintf(fid, '%c|', alignment);
        end
    end
    fprintf(fid, '}\r\n');
    if strcmp(latex_envir,'tabular')
        fprintf(fid, '\\hline\r\n');
    
        if(~isempty(colLabels))
            if(~isempty(rowLabels))
                fprintf(fid, '&');
            end
            for w=1:width-1
                fprintf(fid, '\\textbf{%s}&', colLabels{w});
            end
            fprintf(fid, '\\textbf{%s}\\\\\\hline\r\n', colLabels{width});
        end
    end
    for h=1:height
        if(~isempty(rowLabels))
            fprintf(fid, '\\textbf{%s}&', rowLabels{h});
        end
        for w=1:width-1
            fprintf(fid, '%s&', matrix{h, w});
        end
        if strcmp(latex_envir,'tabular')
         fprintf(fid, '%s\\\\\\hline\r\n', matrix{h, width});
        else
          fprintf(fid, '%s\\\\\n', matrix{h, width});
        end
    end
    fprintf(fid, '\\end{%s}\r\n',latex_envir);
   
    
    if(~isempty(textsize))
        fprintf(fid, '\\end{%s}', textsize);
    end

    fclose(fid);