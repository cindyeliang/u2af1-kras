#!/usr/bin/env python3


########################################################################
# File: jbToDRIMM.py
#  executable: jbToDRIMM.py
# Purpose: 
#
#          
# Author: Cameron M. Soulette
# History:      cms 10/26/2018 Created
#
########################################################################


########################################################################
# Hot Imports & Global Variable
########################################################################


import os, sys
from tqdm import *

########################################################################
# CommandLine
########################################################################

class CommandLine(object) :
    '''
    Handle the command line, usage and help requests.
    CommandLine uses argparse, now standard in 2.7 and beyond. 
    it implements a standard command line argument parser with various argument options,
    and a standard usage and help,
    attributes:
    myCommandLine.args is a dictionary which includes each of the available command line arguments as
    myCommandLine.args['option'] 
    
    methods:
    
    '''
    
    def __init__(self, inOpts=None) :
        '''
        CommandLine constructor.
        Implements a parser to interpret the command line argv string using argparse.
        '''
        import argparse
        self.parser = argparse.ArgumentParser(description = ' jbToDRIMM - convert juncBASE step6 AS table to DRIMMSeq table.',
                                             epilog = 'Please feel free to forward any questions/concerns to /dev/null', 
                                             add_help = True, #default is True 
                                             prefix_chars = '-', 
                                             usage = '%(prog)s [options] -i step6_AS_lenNorm.txt --as_type (e.g. cassette)')
        # Add args
        self.parser.add_argument('-i', "--input_isoforms", action = 'store', required=True, help='juncbase table!!')
        self.parser.add_argument("--as_type", action = 'store', default = False, required=False, help='Optional: If you only want to get an event type.')
        self.parser.add_argument("--keep_jcn_only", action = 'store_false', required=False, default = True, help='Filter JCN_ONLY JB entries.')
        self.parser.add_argument("--quiet", action = 'store_false', required=False, default = True, help='Do not display progress')
        if inOpts is None :
            self.args = vars(self.parser.parse_args())
        else :
            self.args = vars(self.parser.parse_args(inOpts))

#######
# MAINE
#######

def main():
    '''
    not the state.
    '''
    myCommandLine = CommandLine()
    jbTable       = myCommandLine.args['input_isoforms']
    asType        = myCommandLine.args['as_type']
    jcnOnly       = myCommandLine.args['keep_jcn_only']

    if asType == False:
        filterFlag = False
    global verbose
    verbose = myCommandLine.args['quiet']

    #convert juncbase to drimm
    '''
    format follow:
    feature_id gene_id samples....
    '''

    count = 0
    if verbose:
        try:
            print("Reading JuncBASE table %s"  % jbTable, file=sys.stderr)
            with open(jbTable) as lines:
                for line in lines:
                    cols       =  line.rstrip().split("\t")
                    asType     = cols[1]

                    if (filterFlag and cols[1] != asType) or (jcnOnly and "jcn_only" in asType):
                        continue
               
                    count += 1
        except:
            print("Cannot read JuncBASE table %s" % jbTable, file=sys.stderr)
    else:
        pass

    with open(jbTable) as lines:

        header = next(lines)
        cols = header.rstrip().split("\t")
        print("feature_id","gene_id","\t".join(cols[11:]), sep="\t")
            
        for line in tqdm(lines, total=count, desc="Converting juncbase entries to DRIMMSeq format.") if verbose else lines:
    
            cols       =  line.rstrip().split("\t")
            gene       = cols[2]
            asType     = cols[1]
            novelty    = cols[0]
            uuidCoords = cols[5] + '_' + cols[6]

            if len(gene)<1:
                gene = uuidCoords
            gene = gene + '_' + uuidCoords + '_' + asType

            if (filterFlag and cols[1] != asType) or (jcnOnly and "jcn_only" in asType):
                continue
               
            vals = cols[11:]
            inclusions = [x.split(";")[0] for x in vals]
            exclusions = [x.split(";")[1] for x in vals]

            if len(uuidCoords) > 1:
                print("%s_inclusion" % gene, "%s;%s;%s;%s" % (cols[2],uuidCoords,asType,novelty), "\t".join(inclusions),sep="\t")
                print("%s_exclusion" % gene, "%s;%s;%s;%s" % (cols[2],uuidCoords,asType,novelty), "\t".join(exclusions),sep="\t")
                  

if __name__ == "__main__":
    main()
