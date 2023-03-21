/// <summary>
/// TableExtension HWM Transl. Demo Item Ext. (ID 81900) extends Record Item.
/// </summary>
tableextension 81900 "HWM Transl. Demo Item Ext." extends "Item"
{
    fields
    {
        field(81900; "E-Comm Description"; Blob)
        {
            Caption = 'E-Comm Description';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(81901; "E-Comm Description 2"; Blob)
        {
            Caption = 'E-Comm Description 2';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(81902; "E-Comm Description 3"; Blob)
        {
            Caption = 'E-Comm Description 3';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(81903; "E-Comm Meta Title"; Text[50])
        {
            Caption = 'E-Comm Meta Title';
            DataClassification = CustomerContent;
        }
    }
}
