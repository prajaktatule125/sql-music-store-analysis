-- Connect Artist to Album
ALTER TABLE Album ADD CONSTRAINT FK_Album_Artist_Id
FOREIGN KEY (Artist_Id) REFERENCES Artist (Artist_Id);

-- Connect Album to Track
ALTER TABLE Track ADD CONSTRAINT FK_Track_AlbumId
FOREIGN KEY (Album_Id) REFERENCES Album (Album_Id);

-- Connect Media Type to Track
ALTER TABLE Track ADD CONSTRAINT FK_Track_MediaTypeId
FOREIGN KEY (Media_Type_Id) REFERENCES Media_Type (Media_Type_Id);

-- Connect Genre to Track
ALTER TABLE Track ADD CONSTRAINT FK_Track_GenreId
FOREIGN KEY (Genre_Id) REFERENCES Genre (Genre_Id);






-- Connect Playlist to PlaylistTrack (Many-to-Many)
ALTER TABLE Playlist_Track ADD CONSTRAINT FK_PlaylistTrack_PlaylistId
FOREIGN KEY (Playlist_Id) REFERENCES Playlist (Playlist_Id);

-- Connect Track to PlaylistTrack
ALTER TABLE Playlist_Track ADD CONSTRAINT FK_PlaylistTrack_TrackId
FOREIGN KEY (Track_Id) REFERENCES Track (Track_Id);

-- Connect Track to InvoiceLine
ALTER TABLE Invoice_Line ADD CONSTRAINT FK_InvoiceLine_TrackId
FOREIGN KEY (Track_Id) REFERENCES Track (Track_Id);

-- Connect Invoice to InvoiceLine
ALTER TABLE Invoice_Line ADD CONSTRAINT FK_InvoiceLine_InvoiceId
FOREIGN KEY (Invoice_Id) REFERENCES Invoice (Invoice_Id);







ALTER TABLE employee ALTER COLUMN Reports_TO INT ;



-- Connect Customer to Invoice
ALTER TABLE Invoice ADD CONSTRAINT FK_Invoice_CustomerId
FOREIGN KEY (Customer_Id) REFERENCES Customer (Customer_Id);

-- Connect Employee to Customer (SupportRepId)
ALTER TABLE Customer ADD CONSTRAINT FK_Customer_SupportRepId
FOREIGN KEY (Support_Rep_Id) REFERENCES Employee (Employee_Id);

-- Connect Employee to itself (ReportsTo - Manager relationship)
ALTER TABLE Employee ADD CONSTRAINT FK_Employee_ReportsTo
FOREIGN KEY (Reports_To) REFERENCES Employee (Employee_Id);




