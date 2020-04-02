# Exam conversion
This is a simple script for doing automatic conversion of documents in
different formats to pdf. It main purpose is to handle automate the
handling of exams or assignments that might be submitted in many
different formats and over many files.

I wrote this script for automatically handling a course with 250
exams. The scrip worked for that purpose but it not tested more than
that. Never the less it might be useful for others, if nothing else as
a start.

Apart from bash and standard Unix tools it requires
- `pandoc`
- `img2pdf`
- `lowriter`
- `pdfjoin`
- `pdfjam`

On a Debian system these can be installed with

``` shell
apt install pandoc
apt install img2pdf
apt install libreoffice-writer # lowriter
apt install texlive-extra-utils # pdfjoin and pdfjam
```

The submitted files are assumed to all be in subdirectories with the
name of the subdirectory corresponding to the students name (this is
the default if you download all files in a zip-file from
Studentportalen). You the run the script from the root of this
directory. The script will the create a new pdf-file in every
subdirectory with the name of the student first and the ending with
`-combined.pdf`, which contains all the files the student submitted.

At the moment the tool can handle files with the types
- `jpg`, `jpeg` and `JPG`
- `doc` and `docx`
- `pdf`
