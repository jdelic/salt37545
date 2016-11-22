
test-file:
    file.managed:
        - name: /test.txt
        - contents_pillar: apillar:apillar
        - allow_empty: False
