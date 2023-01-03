/// <summary>
/// PageExtension HWM Item Card Ext. (ID 81900) extends Record Item Card.
/// </summary>
pageextension 81900 "HWM Item Card Ext." extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group(ECommerceFields)
            {
                Caption = 'Ecommerce translatable fields';
                field(MetaTitle; Rec."E-Comm Meta Title")
                {
                    Caption = 'Meta Title';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        OpenTranslationOrder(Rec.FieldNo(Rec."E-Comm Meta Title"));
                    end;
                }
                field(EcommDescription2; EcommDescription2)
                {
                    Caption = 'Description 2';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        OpenTranslationOrder(Rec.FieldNo(Rec."E-Comm Description 2"));
                    end;
                }
            }
            group(ECommerceEditors)
            {
                Caption = 'Ecommerce translateble field with editors';
                part(EntryBaseCardPart; "HWM Transl. Entry CardPart")
                {
                    Caption = 'Copywrite (From)';
                    ApplicationArea = All;
                    UpdatePropagation = SubPart;
                    SubPageLink =
                        "Source Table No." = const(Database::Item),
                        "Source Field No." = const(81900);
                    SubPageView = sorting("Source Table No.", "Source Field No.", "Source System Id", "Language Code");
                }
                part(EntryCardPart; "HWM Transl. Entry CardPart")
                {
                    Caption = 'Translation (To)';
                    ApplicationArea = All;
                    UpdatePropagation = SubPart;
                    SubPageLink =
                        "Source Table No." = const(Database::Item),
                        "Source Field No." = const(81900);
                    SubPageView = sorting("Source Table No.", "Source Field No.", "Source System Id", "Language Code");
                }
            }
        }
    }

    var
        iTranslationLanguage: Codeunit "HWM iTranslationLanguage";
        iTranslationHeader: Codeunit "HWM iTranslationHeader";
        iTranslationEntry: Codeunit "HWM iTranslationEntry";
        EcommDescription2: Text;

    trigger OnAfterGetCurrRecord()
    begin
        InitTranslationEditorCardParts(Rec.FieldNo("E-Comm Description"));
        EcommDescription2 :=
            iTranslationEntry.GetTranslationValueBySource(
                Database::Item,
                Rec.FieldNo("E-Comm Description 2"),
                Rec.SystemId,
                iTranslationLanguage.GetBaseLanguageCode());
    end;

    local procedure InitTranslationEditorCardParts(FieldNo: Integer)
    var
        TranslFieldHeaderNo: Integer;
    begin
        TranslFieldHeaderNo := iTranslationHeader.InitHeaderBySource(Database::Item, FieldNo, Rec.SystemId);

        CurrPage.EntryBaseCardPart.Page.SetHeader(TranslFieldHeaderNo);
        CurrPage.EntryBaseCardPart.Page.SetSource(Database::Item, FieldNo, Rec.SystemId);
        CurrPage.EntryBaseCardPart.Page.SetCardPartAsBaseLanguage();
        CurrPage.EntryBaseCardPart.Page.SetLanguageCodeEditable(false);
        CurrPage.EntryBaseCardPart.Page.SetActionsVisible();

        CurrPage.EntryCardPart.Page.SetHeader(TranslFieldHeaderNo);
        CurrPage.EntryCardPart.Page.SetSource(Database::Item, FieldNo, Rec.SystemId);
        CurrPage.EntryCardPart.Page.SetTranslationLanguageCode();
        CurrPage.EntryCardPart.Page.SetLanguageCodeEditable(true);
        CurrPage.EntryCardPart.Page.SetActionsVisible();
    end;

    local procedure OpenTranslationOrder(FieldNo: Integer)
    var
        TranslHeaderNo: Integer;
    begin
        TranslHeaderNo := iTranslationHeader.InitHeaderBySource(Database::Item, FieldNo, Rec.SystemId);
        iTranslationHeader.SetRangeHeaderNo(TranslHeaderNo);
        iTranslationHeader.OpenHeaderCard();
    end;
}