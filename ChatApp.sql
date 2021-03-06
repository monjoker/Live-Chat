USE [master]
GO
/****** Object:  Database [ChatApp]    Script Date: 1/3/2021 7:55:59 PM ******/
CREATE DATABASE [ChatApp]
GO
ALTER DATABASE [ChatApp] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ChatApp] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ChatApp] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ChatApp] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ChatApp] SET ARITHABORT OFF 
GO
ALTER DATABASE [ChatApp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChatApp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChatApp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChatApp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChatApp] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ChatApp] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ChatApp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChatApp] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ChatApp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChatApp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChatApp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChatApp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChatApp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChatApp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChatApp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChatApp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChatApp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChatApp] SET RECOVERY FULL 
GO
ALTER DATABASE [ChatApp] SET  MULTI_USER 
GO
ALTER DATABASE [ChatApp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChatApp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChatApp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChatApp] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ChatApp] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ChatApp', N'ON'
GO
USE [ChatApp]
GO
/****** Object:  DatabaseRole [login]    Script Date: 1/3/2021 7:55:59 PM ******/
CREATE ROLE [login]
GO
ALTER ROLE [db_datareader] ADD MEMBER [login]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [login]
GO
/****** Object:  UserDefinedFunction [dbo].[check_inbox_member]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[check_inbox_member](
	@ID_RECIVER INT,
	@ID_SENDER INT,
	@ID_CHAT INT
) RETURNS BIT AS
BEGIN
	IF ((
		dbo.get_id_user_member(@ID_RECIVER, @ID_CHAT) = @ID_RECIVER OR
		dbo.get_id_user_member(@ID_SENDER, @ID_CHAT) = @ID_SENDER
	)) AND
	((
		dbo.get_id_user_member(@ID_RECIVER, @ID_CHAT) = @ID_RECIVER OR
		dbo.get_id_user_member(@ID_SENDER, @ID_CHAT) = @ID_SENDER
	))
	BEGIN
		RETURN 1
	END
	RETURN 0
END
GO
/****** Object:  UserDefinedFunction [dbo].[get_id_user_member]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_id_user_member](@id_user_input INT,  @id_chat INT) RETURNS INT AS 
BEGIN
DECLARE @ID_USER INT
SELECT @ID_USER = MAX(id_user) FROM dbo.Members WHERE id_user = @id_user_input AND id_chat = @id_chat GROUP BY id_user
RETURN @ID_USER
END
GO
/****** Object:  Table [dbo].[ColorMessages]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ColorMessages](
	[id_color_message] [int] NOT NULL,
	[start_color] [varchar](6) NOT NULL,
	[end_color] [varchar](6) NULL,
	[name_color] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ColorMessage] PRIMARY KEY CLUSTERED 
(
	[id_color_message] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContentMessages]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContentMessages](
	[id_content_message] [bigint] IDENTITY(1,1) NOT NULL,
	[content_message] [nvarchar](max) NULL,
	[type_message] [varchar](15) NULL,
	[id_message] [bigint] NOT NULL,
 CONSTRAINT [PK_ContentMessage_1] PRIMARY KEY CLUSTERED 
(
	[id_content_message] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Members]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[id_user] [bigint] NOT NULL,
	[id_chat] [bigint] NOT NULL,
	[nick_name] [nvarchar](200) NULL,
	[date_of_join] [smalldatetime] NULL,
	[is_admin] [bit] NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC,
	[id_chat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Messages]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[id_message] [bigint] IDENTITY(1,1) NOT NULL,
	[id_chat] [bigint] NOT NULL,
	[sender] [bigint] NOT NULL,
	[send_time] [datetime] NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[id_message] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[id_chat] [bigint] IDENTITY(1,1) NOT NULL,
	[is_waiting] [bit] NOT NULL,
	[id_color_message] [int] NULL,
	[image_group] [nvarchar](max) NULL,
	[founded_time] [datetime] NULL,
	[name_group] [nvarchar](200) NULL,
 CONSTRAINT [PK_Chat_1] PRIMARY KEY CLUSTERED 
(
	[id_chat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settings]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[id_setting] [bigint] IDENTITY(1,1) NOT NULL,
	[theme] [nvarchar](20) NOT NULL,
	[is_show_email] [bit] NOT NULL,
	[is_show_phone] [bit] NOT NULL,
	[devices_logged] [bigint] NOT NULL,
 CONSTRAINT [PK_Settings] PRIMARY KEY CLUSTERED 
(
	[id_setting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[id_user] [bigint] IDENTITY(1,1) NOT NULL,
	[avatar] [nvarchar](max) NULL,
	[phone_number] [char](10) NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](16) NOT NULL,
	[first_name] [nvarchar](100) NOT NULL,
	[last_name] [nvarchar](100) NULL,
	[sex] [bit] NOT NULL,
	[birth_day] [date] NOT NULL,
	[address] [nvarchar](500) NULL,
	[status] [smalldatetime] NULL,
	[join_time] [date] NOT NULL,
	[id_setting] [bigint] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [EUK_Users] UNIQUE NONCLUSTERED 
(
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PUK_Users] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_Members_Group]    Script Date: 1/3/2021 7:55:59 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Members_Group] ON [dbo].[Members]
(
	[id_user] ASC,
	[id_chat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PhonePass]    Script Date: 1/3/2021 7:55:59 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PhonePass] ON [dbo].[Users]
(
	[phone_number] ASC,
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users]    Script Date: 1/3/2021 7:55:59 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users] ON [dbo].[Users]
(
	[id_setting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Settings] ADD  CONSTRAINT [DF_Settings_theme]  DEFAULT (N'light') FOR [theme]
GO
ALTER TABLE [dbo].[Settings] ADD  CONSTRAINT [DF_Settings_isShowEmail]  DEFAULT ((1)) FOR [is_show_email]
GO
ALTER TABLE [dbo].[Settings] ADD  CONSTRAINT [DF_Settings_isShowPhoneNumber]  DEFAULT ((1)) FOR [is_show_phone]
GO
ALTER TABLE [dbo].[Settings] ADD  CONSTRAINT [DF_Settings_devices_logged]  DEFAULT ((0)) FOR [devices_logged]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_avatar]  DEFAULT (NULL) FOR [avatar]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_status]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[ContentMessages]  WITH CHECK ADD  CONSTRAINT [FK_ContentMessages_Messages] FOREIGN KEY([id_message])
REFERENCES [dbo].[Messages] ([id_message])
GO
ALTER TABLE [dbo].[ContentMessages] CHECK CONSTRAINT [FK_ContentMessages_Messages]
GO
ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [FK_Members_Chat] FOREIGN KEY([id_chat])
REFERENCES [dbo].[Rooms] ([id_chat])
GO
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [FK_Members_Chat]
GO
ALTER TABLE [dbo].[Members]  WITH CHECK ADD  CONSTRAINT [FK_Members_Users] FOREIGN KEY([id_user])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Members] CHECK CONSTRAINT [FK_Members_Users]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Message_Chat] FOREIGN KEY([id_chat])
REFERENCES [dbo].[Rooms] ([id_chat])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Message_Chat]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Message_Users] FOREIGN KEY([sender])
REFERENCES [dbo].[Users] ([id_user])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Message_Users]
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Chat_ColorMessages] FOREIGN KEY([id_color_message])
REFERENCES [dbo].[ColorMessages] ([id_color_message])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Chat_ColorMessages]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Settings1] FOREIGN KEY([id_setting])
REFERENCES [dbo].[Settings] ([id_setting])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Settings1]
GO
ALTER TABLE [dbo].[ContentMessages]  WITH CHECK ADD  CONSTRAINT [CK_ContentMessages] CHECK  (([type_message]='text' OR [type_message]='voice' OR [type_message]='imgae' OR [type_message]='video' OR [type_message]='location' OR [type_message]='file'))
GO
ALTER TABLE [dbo].[ContentMessages] CHECK CONSTRAINT [CK_ContentMessages]
GO
ALTER TABLE [dbo].[Settings]  WITH CHECK ADD  CONSTRAINT [CK_Settings] CHECK  (([theme]='light' OR [theme]='dark' OR [theme]='auto'))
GO
ALTER TABLE [dbo].[Settings] CHECK CONSTRAINT [CK_Settings]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADDMEMBER]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ADDMEMBER](
	@ID_USER BIGINT,
	@ID_CHAT BIGINT
)
AS
BEGIN
	INSERT dbo.Members
	        ( id_user ,
	          id_chat ,
	          date_of_join ,
	          is_admin
	        )
	VALUES  ( @ID_USER , -- id_user - int
	          @ID_CHAT , -- id_chat - int
	          GETDATE() , -- date_of_join - smalldatetime
	          1  -- is_admin - bit
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHANGE_ROOMIMAGE]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHANGE_ROOMIMAGE](
	@ID_ROOM BIGINT,
	@NEW_IMAGE NVARCHAR(MAX)
)AS
BEGIN
	UPDATE Rooms
	SET image_group = @NEW_IMAGE
	WHERE id_chat = @ID_ROOM
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHANGEGROUPNAME]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHANGEGROUPNAME](
	@ID_CHAT BIGINT,
	@NEWNAME NVARCHAR(200)
)AS
BEGIN
	UPDATE Rooms
	SET name_group = @NEWNAME
	WHERE id_chat = @ID_CHAT
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHANGEPASSWORD]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHANGEPASSWORD](
	@ID_USER BIGINT,
	@NEWPASSWORD NVARCHAR(16)
)AS
BEGIN
	UPDATE Users
	SET password = @NEWPASSWORD
	WHERE
		id_user = @ID_USER
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CREATEGROUP]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CREATEGROUP](
	@ID_USER BIGINT,
	@ID_CHAT BIGINT OUTPUT
) AS
BEGIN
	INSERT Rooms(
		is_waiting,
		id_color_message,
		image_group,
		founded_time,
		name_group
	)
	VALUES(
		0,
		NULL,
		NULL,
		GETDATE(),
		NULL
	)

	SET @ID_CHAT = @@IDENTITY

	INSERT dbo.Members ( id_user, id_chat, date_of_join, is_admin )
	VALUES  ( @ID_USER, @ID_CHAT, GETDATE(), 1 )
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CREATEINBOXROOM]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CREATEINBOXROOM](
	@ID_CHAT BIGINT OUTPUT,
	@ID_SENDER BIGINT,
	@ID_RECIVER BIGINT
)AS
BEGIN
	SELECT @ID_CHAT = id_chat FROM dbo.Rooms WHERE id_chat IN (
			SELECT id_chat = IIF(COUNT(id_chat) = 2, id_chat, NULL) FROM dbo.Members WHERE id_user = @ID_RECIVER OR id_user = @ID_SENDER AND date_of_join IS NULL GROUP BY id_chat
		) AND founded_time IS NULL
		IF(@ID_CHAT IS NULL)
	INSERT dbo.Rooms(
			is_waiting ,
	        id_color_message ,
	        image_group ,
	        founded_time ,
	        name_group
	    )
	VALUES  (
			1 , -- is_waiting - bit
			NULL , -- id_color_message - int
			NULL , -- image_group - nvarchar(max)
			NULL , -- founded_time - smalldatetime
			NULL	 -- name_group - nvarchar(100)
		)
			SET @ID_CHAT = @@IDENTITY

			INSERT dbo.Members ( id_user, id_chat )
			VALUES  ( @ID_SENDER, @ID_CHAT )

			INSERT dbo.Members ( id_user, id_chat )
			VALUES  ( @ID_RECIVER, @ID_CHAT )
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EDITNICKNAME]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_EDITNICKNAME](
	@ID_CURRENT BIGINT,
	@ID_CHAT BIGINT OUTPUT,
	@ID_PARTNER BIGINT OUTPUT,
	@NEW_NICKNAME NVARCHAR(200),
	@FULLNAME NVARCHAR(200) OUTPUT
)AS
BEGIN
	IF(ISNULL(@ID_CHAT, -1) = -1)
	BEGIN
		SELECT @ID_CHAT = id_chat FROM dbo.Rooms WHERE id_chat IN (
			SELECT id_chat = IIF(COUNT(id_chat) = 2, id_chat, NULL)
			FROM dbo.Members
			WHERE 
				id_user = @ID_PARTNER
				OR
				id_user = @ID_CURRENT
				AND
				date_of_join IS NULL GROUP BY id_chat
		) AND founded_time IS NULL
		IF(@ID_CHAT IS NULL)
		BEGIN
			RETURN
		END
		ELSE
		BEGIN
			UPDATE Members
			SET nick_name = @NEW_NICKNAME
			WHERE
				id_chat = @ID_CHAT
				AND
				id_user = @ID_CURRENT
		END
	END
	ELSE
	BEGIN
		UPDATE Members
		SET nick_name = @NEW_NICKNAME
		WHERE
			id_chat = @ID_CHAT
			AND
			id_user = @ID_CURRENT
	END
	SELECT 
		@ID_PARTNER = Members.id_user,
		@FULLNAME = CONCAT(first_name,' ',last_name) FROM Members
	INNER JOIN(
		SELECT
			id_user,
			first_name,
			last_name
		FROM Users) PartnerInfor ON PartnerInfor.id_user = Members.id_user
	WHERE id_chat = @ID_CHAT
	AND
	Members.id_user <> @ID_CURRENT
	AND
	date_of_join IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EDITPROFILE]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_EDITPROFILE](
	@ID_USER BIGINT,
	@PHONE_NUMBER CHAR(10),
	@FIRST_NAME NVARCHAR(100),
	@LAST_NAME NVARCHAR(100),
	@SEX BIT,
	@BIRTH_DAY DATE,
	@ADDRESS NVARCHAR(500)
)AS
BEGIN
	UPDATE Users
	SET
		phone_number = @PHONE_NUMBER,
		first_name = @FIRST_NAME,
		last_name = @LAST_NAME,
		sex = @SEX,
		birth_day = @BIRTH_DAY,
		address = @ADDRESS
	WHERE
		id_user = @ID_USER
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETGROUPBY_IDUSER]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETGROUPBY_IDUSER](
	@ID_CURRENTUSER BIGINT
	, @ID_RECIVEID BIGINT OUTPUT,
	@ID_GROUP BIGINT
) AS
BEGIN
	IF(@ID_RECIVEID IS NULL)
	BEGIN
		SELECT @ID_RECIVEID = id_user
		FROM Members
		WHERE
			@ID_GROUP = id_chat
			AND
			id_user <> @ID_CURRENTUSER
	END
    SELECT
		id_chat ,
		is_waiting,
		image_group,
		founded_time,
		name_group,
		ColorMessages.id_color_message,
		start_color ,
		end_color ,
		name_color
	FROM dbo.Rooms
		LEFT JOIN dbo.ColorMessages ON ColorMessages.id_color_message = Rooms.id_color_message
	WHERE
		id_chat IN (
			SELECT id_chat 
			FROM dbo.Members
			WHERE
				Members.id_chat = Rooms.id_chat
				AND
				id_user = @ID_CURRENTUSER
				AND
				is_admin IS NOT NULL
		)
		AND
		(EXISTS(
			SELECT id_chat 
			FROM dbo.Members
			WHERE
				Members.id_chat = Rooms.id_chat
				AND
				id_user = @ID_RECIVEID
				AND
				is_admin IS NULL
			)
			OR
			NOT EXISTS(
				SELECT id_chat 
				FROM dbo.Members
				WHERE
					Members.id_chat = Rooms.id_chat
					AND
					id_user = @ID_RECIVEID
			))
		AND founded_time IS NOT NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETGROUPJOINED]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETGROUPJOINED](
	@ID_CURRENT INT
) AS
SELECT  id_chat FROM dbo.Rooms WHERE id_chat IN (
	SELECT id_chat FROM dbo.Members WHERE id_user = @ID_CURRENT AND founded_time IS NOT NULL AND is_admin IS NOT NULL GROUP BY id_chat 
) AND founded_time IS NOT NULL
GO
/****** Object:  StoredProcedure [dbo].[SP_GETINFORBYIDUSER]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETINFORBYIDUSER](
	@ID INT
)
AS
BEGIN
	SELECT id_user, avatar, phone_number, email, first_name, last_name, sex, birth_day, address, status
	FROM dbo.Users
	WHERE id_user = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETLAST_ROOM]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETLAST_ROOM] (
	@ID_USER BIGINT
)
AS
BEGIN
	SELECT
		Rooms.id_chat AS id_chat
	FROM (SELECT id_chat, founded_time FROM Rooms) Rooms
		LEFT JOIN (
			SELECT
				Messages.id_chat,
				send_time = MAX(dbo.Messages.send_time)
			FROM dbo.Messages GROUP BY id_chat
		) Mess ON Mess.id_chat = Rooms.id_chat
	WHERE
		--tim cac nhom da gia nhap
		Rooms.id_chat IN (
			SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NOT NULL AND is_admin IS NOT NULL GROUP BY id_chat 
		) AND founded_time IS NOT NULL OR
		--tim cac member da nhan tin
		Rooms.id_chat IN (
			SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NULL GROUP BY id_chat 
		) AND founded_time IS NULL
	ORDER BY ISNULL(Mess.send_time, founded_time) DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETLASTMESS]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETLASTMESS](
	@ID_CHAT BIGINT,
	@SENDER BIGINT
)AS
BEGIN
	 SELECT
		id_chat,
		Messages.id_message,
		sender,
		send_time,
		id_content_message,
		content_message,
		type_message
	FROM dbo.Messages
	LEFT JOIN dbo.ContentMessages ON ContentMessages.id_message = Messages.id_message
	WHERE 
		id_chat = @ID_CHAT AND
		sender = @SENDER
	ORDER BY send_time DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETMBERBYROOMIDWHENINBOX]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETMBERBYROOMIDWHENINBOX](
	@ID_CHAT BIGINT
) AS
BEGIN
	SELECT
		Members.id_chat,
		Members.id_user,
		avatar,
		first_name,
		last_name,
		nick_name,
		date_of_join,
		is_admin    
	FROM dbo.Members LEFT JOIN dbo.Users ON Users.id_user = Members.id_user
	WHERE @ID_CHAT = id_chat AND date_of_join IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETMEMBERBYROOMID]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETMEMBERBYROOMID](
	@ID_CHAT BIGINT) AS
BEGIN
	SELECT
		id_chat,
		Members.id_user,
		avatar,
		first_name,
		last_name,
		nick_name,
		date_of_join,
		is_admin    
	FROM dbo.Members LEFT JOIN dbo.Users ON Users.id_user = Members.id_user
	WHERE
		id_chat = @ID_CHAT
		AND
		((
			is_admin IS NOT NULL
			AND
			date_of_join IS NOT NULL
		)
		OR
		((EXISTS(SELECT id_chat FROM dbo.Rooms WHERE @ID_CHAT = id_chat AND founded_time IS NULL)
		AND
		date_of_join IS NULL)))
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETMEMBERBYUSERID]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETMEMBERBYUSERID](
	@ID_USER BIGINT
,	@ID_CHAT BIGINT) AS
BEGIN
	SELECT
		id_chat = MAX(Members.id_chat),
		id_user = MAX(Members.id_user),
		avatar = MAX(avatar),
		first_name = MAX(first_name),
		last_name = MAX(last_name),
		nick_name = MAX(nick_name),
		date_of_join = MAX(date_of_join),
		is_admin = MAX(convert(tinyint, is_admin))    
	FROM dbo.Members LEFT JOIN dbo.Users ON Users.id_user = Members.id_user
	WHERE Members.id_user = @ID_USER AND @ID_CHAT = id_chat AND is_admin IS NOT NULL
	GROUP BY id_chat 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETMESSAGESBYTYPE_PAGING]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETMESSAGESBYTYPE_PAGING](
	@ID_CHAT BIGINT,
	@PAGE BIGINT,
	@ROWSOFPAGE INT,
	@TYPE VARCHAR(15)
) AS
	DECLARE @count_mess INT
	DECLARE @page_display INT
	SELECT @count_mess = COUNT(id_chat) FROM  dbo.Messages
		LEFT JOIN dbo.ContentMessages ON ContentMessages.id_message = Messages.id_message
	WHERE id_chat = @ID_CHAT
		AND type_message = IIF(@TYPE IS NULL OR @TYPE = '', type_message, @TYPE)
	IF @count_mess > @ROWSOFPAGE
		SET @page_display = (@count_mess / @ROWSOFPAGE) - (@PAGE - 1)
	ELSE
		SET @page_display = 0
	SELECT
		id_chat,
		dbo.Messages.id_message,
		sender,
		send_time,
		id_content_message,
		content_message,
		type_message
	FROM  dbo.Messages
		LEFT JOIN dbo.ContentMessages ON ContentMessages.id_message = Messages.id_message
	WHERE dbo.Messages.id_chat = @ID_CHAT
		AND type_message = IIF(@TYPE IS NULL OR @TYPE = '', type_message, @TYPE)
	ORDER BY send_time ASC
GO
/****** Object:  StoredProcedure [dbo].[SP_GETROOMBY_IDROOM]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETROOMBY_IDROOM](
	@ID_CHAT BIGINT
)AS
BEGIN
	SELECT
		Rooms.id_chat AS id_chat,
		Rooms.is_waiting AS is_waiting,
		Rooms.name_group AS name_group,
		Rooms.image_group AS image_group,
		Rooms.founded_time AS founded_time,
		Color.id_color_message AS id_color_message,
		Color.start_color AS start_color,
		Color.end_color AS end_color,
		Color.name_color AS name_color,
		Mess.id_content_message AS id_content_message ,
		Mess.send_time AS send_time,
		Mess.sender AS sender,
		Mess.id_message AS id_message,
		Mess.type_message AS type_message,
		Mess.content_message AS content_message
	FROM dbo.Rooms
		LEFT JOIN (
			SELECT
				Messages.id_chat,
				id_message = MAX(Messages.id_message),
				send_time = MAX(dbo.Messages.send_time),
				content_message = MAX(content_message),
				type_message = MAX(dbo.ContentMessages.type_message),
				id_content_message = MAX(dbo.ContentMessages.id_content_message),
				sender = MAX(sender)
			FROM dbo.Messages
			LEFT JOIN
				dbo.ContentMessages ON Messages.id_message = ContentMessages.id_message GROUP BY id_chat
		) Mess ON Mess.id_chat = dbo.Rooms.id_chat
		LEFT JOIN(
			SELECT * FROM dbo.ColorMessages
		) Color ON dbo.Rooms.id_color_message = Color.id_color_message
	WHERE
		Rooms.id_chat = @ID_CHAT
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETROOMBY_IDUSER]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETROOMBY_IDUSER](
	@ID_CURRENTUSER BIGINT
	, @ID_RECIVEID BIGINT
) AS
BEGIN
    SELECT
		id_chat = MAX(id_chat),
		is_waiting = MAX(CONVERT(TINYINT,is_waiting)),
		image_group = MAX(image_group),
		founded_time = MAX(founded_time),
		name_group = MAX(name_group),
		id_color_message = MAX(ColorMessages.id_color_message),
		start_color = MAX(start_color),
		end_color = MAX(end_color),
		name_color =  MAX(name_color)
	FROM dbo.Rooms
		LEFT JOIN dbo.ColorMessages ON ColorMessages.id_color_message = Rooms.id_color_message
	WHERE
		EXISTS(SELECT id_chat FROM dbo.Members WHERE id_user = @ID_CURRENTUSER AND Members.id_chat = Rooms.id_chat)
		AND 
		EXISTS(SELECT id_chat FROM dbo.Members WHERE id_user = @ID_RECIVEID  AND Members.id_chat = Rooms.id_chat)
		AND founded_time IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETROOMBYIDROOM]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETROOMBYIDROOM](
	 @ID_ROOM BIGINT
	 , @ID_USER BIGINT
)AS
BEGIN
	SELECT
		id_chat = MAX(id_chat),
		is_waiting = MAX(CONVERT(TINYINT,is_waiting)),
		image_group = MAX(image_group),
		founded_time = MAX(founded_time),
		name_group = MAX(name_group),
		id_color_message = MAX(ColorMessages.id_color_message),
		start_color = MAX(start_color),
		end_color = MAX(end_color),
		name_color =  MAX(name_color)
	FROM dbo.Rooms
	LEFT JOIN dbo.ColorMessages ON ColorMessages.id_color_message = Rooms.id_color_message
	WHERE 
		id_chat = @ID_ROOM
		AND (
			--tim cac nhom da gia nhap
			dbo.Rooms.id_chat IN (
				SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NOT NULL AND is_admin IS NOT NULL GROUP BY id_chat 
			) AND founded_time IS NOT NULL OR
			--tim cac member da nhan tin
			dbo.Rooms.id_chat IN (
				SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NULL GROUP BY id_chat 
			) AND founded_time IS NULL
		)
	GROUP BY id_chat
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GETROOMCHAT_PAGING]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GETROOMCHAT_PAGING] (
	@ID_USER BIGINT,
	@PAGE INT,
	@ROW_OF_PAGE INT)
AS
BEGIN
	SELECT
		Rooms.id_chat AS id_chat,
		Rooms.is_waiting AS is_waiting,
		Rooms.name_group AS name_group,
		Rooms.image_group AS image_group,
		Rooms.founded_time AS founded_time,
		Color.id_color_message AS id_color_message,
		Color.start_color AS start_color,
		Color.end_color AS end_color,
		Color.name_color AS name_color,
		Mess.id_content_message AS id_content_message ,
		Mess.send_time AS send_time,
		Mess.sender AS sender,
		Mess.id_message AS id_message,
		Mess.type_message AS type_message,
		Mess.content_message AS content_message
	FROM dbo.Rooms
		LEFT JOIN (
			SELECT
				id_chat = Messages.id_chat,
				id_message = Messages.id_message,
				send_time = dbo.Messages.send_time,
				content_message = content_message,
				type_message = dbo.ContentMessages.type_message,
				id_content_message = dbo.ContentMessages.id_content_message,
				sender = sender
			FROM (
				SELECT send_time = MAX(send_time) FROM dbo.Messages  GROUP BY id_chat
			) MaxSendTime LEFT JOIN dbo.Messages ON MaxSendTime.send_time = Messages.send_time
			LEFT JOIN
				dbo.ContentMessages ON Messages.id_message = ContentMessages.id_message
		) Mess ON Mess.id_chat = dbo.Rooms.id_chat
		LEFT JOIN(
			SELECT * FROM dbo.ColorMessages
		) Color ON dbo.Rooms.id_color_message = Color.id_color_message
	WHERE
		--tim cac nhom da gia nhap
		dbo.Rooms.id_chat IN (
			SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NOT NULL AND is_admin IS NOT NULL GROUP BY id_chat 
		) AND founded_time IS NOT NULL OR
		--tim cac member da nhan tin
		dbo.Rooms.id_chat IN (
			SELECT id_chat FROM dbo.Members WHERE id_user = @ID_USER AND date_of_join IS NULL GROUP BY id_chat 
		) AND founded_time IS NULL
	ORDER BY ISNULL(Mess.send_time, founded_time) DESC
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LEAVEGROUP]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LEAVEGROUP](
	@ID_USER BIGINT,
	@ID_CHAT BIGINT
) AS
BEGIN
	UPDATE Members
	SET is_admin = NULL
	WHERE
		id_chat = @ID_CHAT
		AND
		id_user = @ID_USER
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGIN]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LOGIN](
	@USERNAME NVARCHAR(50),
	@PASSWORD NVARCHAR(16)
) AS
BEGIN
	DECLARE @CountAccount INT
	DECLARE @Email VARCHAR(50)
	SELECT @Email = dbo.Users.email FROM dbo.Users WHERE (email = @USERNAME OR phone_number = @USERNAME) AND password = @PASSWORD  COLLATE SQL_Latin1_General_CP1_CS_AS
	SELECT @CountAccount = @@ROWCOUNT
	IF (@CountAccount = 0) RETURN 0
	EXEC @CountAccount = dbo.SP_LOGINEMAIL
		@EMAIL = @Email, -- nvarchar(50)
	    @PASSWORD = @PASSWORD -- nvarchar(16)
	RETURN @CountAccount
END
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGINEMAIL]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_LOGINEMAIL](
	@EMAIL NVARCHAR(50),
	@PASSWORD NVARCHAR(16)
) AS
	DECLARE @CountAcc INT
	SELECT
		id_user, avatar, phone_number, email, password, first_name, last_name, sex, birth_day, address, status, join_time, Settings.id_setting, theme, is_show_email, is_show_phone, devices_logged
	FROM dbo.Users
	LEFT JOIN dbo.Settings ON Settings.id_setting = Users.id_setting
	WHERE dbo.Users.email = @EMAIL AND dbo.Users.password = @PASSWORD COLLATE SQL_Latin1_General_CP1_CS_AS
	SELECT @CountAcc = @@ROWCOUNT
	RETURN @CountAcc
GO
/****** Object:  StoredProcedure [dbo].[SP_REGISTERLOGIN]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_REGISTERLOGIN]( 
	@EMAIL NVARCHAR(50),
	@PHONE NVARCHAR(10),
	@PASSWORD NVARCHAR(16),
	@FIRSTNAME NVARCHAR(100),
	@LASTNAME NVARCHAR(100), --CAN NULL
	@SEX BINARY,
	@BIRTHDAY DATE,
	@ADDRESS NVARCHAR(500),
	@RET INT OUTPUT
)
AS
BEGIN
	DECLARE @ID_SETTING INT
	IF(EXISTS(SELECT @RET FROM Users WHERE email = @EMAIL))
	BEGIN
		SET @RET = 1
		RETURN @RET
	END
	ELSE IF(EXISTS(SELECT @RET FROM Users WHERE phone_number = @PHONE AND password = @PASSWORD))
	BEGIN
		SET @RET = 2
		RETURN @RET
	END
	ELSE
	BEGIN
		INSERT dbo.Settings
				( theme )
		VALUES  ( N'light'  -- id_setting - varchar(50)
			   )
		SET @ID_SETTING  = @@IDENTITY
	
		BEGIN TRY
			INSERT dbo.Users
					( 
					phone_number ,
					email ,
					password ,
					first_name ,
					last_name ,
					sex ,
					birth_day ,
					address ,
					join_time,
					id_setting
					)
			VALUES  ( 
					@PHONE , -- phone_number - char(10)
					@EMAIL , -- email - varchar(50)
					@PASSWORD , -- password - varchar(16)
					@FIRSTNAME , -- first_name - nvarchar(100)
					@LASTNAME , -- last_name - nvarchar(100)
					@SEX , -- sex - bit
					@BIRTHDAY , -- birth_day - date
					@ADDRESS , -- address - nvarchar(500)
					GETDATE(),
					@ID_SETTING
					)
				SET @RET = 0
			END TRY
			BEGIN CATCH
				SET @RET = 3
				DELETE FROM dbo.Settings WHERE id_setting = @ID_SETTING
			END CATCH
		RETURN @RET
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SEARCH]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SEARCH](
	@SEARCH NVARCHAR(MAX)
	, @ID_USER BIGINT
) AS
BEGIN
	SET @SEARCH = LTRIM(RTRIM(LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@SEARCH, '|','||'),'%','|%'),'_','|_'),'[','|['),']','|]'))))
	SET @SEARCH = ISNULL(@SEARCH,'')
	IF(@SEARCH <> '')
	BEGIN
		SET @SEARCH = CONCAT('%' , @SEARCH, '%')
	END
	SELECT
		id_user
		, avatar
		, first_name
		, last_name
		, sex
		, birth_day
		, address
		, status
		, join_time
	FROM dbo.Users
	WHERE id_user <> @ID_USER AND
		LOWER(LTRIM(RTRIM(CONCAT(first_name , ' ', last_name)))) LIKE @SEARCH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SENDMESSAGE]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SENDMESSAGE](
	@ID_CHAT BIGINT OUTPUT,
	@SENDER BIGINT,
	@CONTENT_MESS NVARCHAR(MAX),
	@TYPE_MESS VARCHAR(15)
)
AS
BEGIN
	INSERT dbo.Messages(
			id_chat,
			sender,
			send_time
			)
	VALUES  ( 
			  @ID_CHAT,
	          @SENDER, -- sender - int
	          GETDATE()  -- send_time - smalldatetime
	          )
	DECLARE @ID_MESS INT
	 SELECT
		@ID_CHAT = id_chat,
		@ID_MESS = id_message
	FROM dbo.Messages
	WHERE
		id_chat = @ID_CHAT AND
		sender = @SENDER AND
		id_message = IDENT_CURRENT('dbo.Messages')
	INSERT dbo.ContentMessages
	        (
				id_message,
				type_message,
				content_message
	        )
	VALUES  (
				@ID_MESS,
				@TYPE_MESS , -- message_type - varchar(15)
				@CONTENT_MESS  -- content_message - nvarchar(max)
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[SP_SENDNGETLASTMESS]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_SENDNGETLASTMESS](
	@CONTENT_MESS NVARCHAR(max),
	@TYPE_MESS VARCHAR(15),
	@ID_CHAT BIGINT,
	@ID_SENDER BIGINT,
	@ID_RECIVER BIGINT
)AS
BEGIN
	IF(ISNULL(@ID_CHAT, -1) = -1)
	BEGIN
		DECLARE @COUNT_CHAT INT = 0
		SELECT @ID_CHAT = id_chat FROM dbo.Rooms WHERE
			dbo.check_inbox_member(@ID_RECIVER, @ID_SENDER, id_chat) = 1
		SELECT @COUNT_CHAT = @@ROWCOUNT
		IF(@COUNT_CHAT = 0)
		BEGIN
			INSERT dbo.Rooms
			        ( is_waiting ,
			          id_color_message ,
			          image_group ,
			          founded_time ,
			          name_group
			        )
			VALUES  ( 1 , -- is_waiting - bit
			          NULL , -- id_color_message - int
			          NULL , -- image_group - nvarchar(max)
			          NULL , -- founded_time - smalldatetime
			          NULL	 -- name_group - nvarchar(100)
			        )
			SELECT
					@ID_CHAT = id_chat
			FROM dbo.Rooms
			WHERE
				id_chat = IDENT_CURRENT('dbo.Rooms') AND
				@ID_SENDER = (SELECT id_user FROM dbo.Members WHERE id_chat = id_chat AND id_user = @ID_SENDER)
			INSERT dbo.Members ( id_user, id_chat )
			VALUES  ( @ID_SENDER, @ID_CHAT )
			INSERT dbo.Members ( id_user, id_chat )
			VALUES  ( @ID_RECIVER, @ID_CHAT )
		END
	END
	DECLARE @SEND_TIME DATETIME
	EXEC dbo.SP_SENDMESSAGE
		@ID_CHAT = @ID_CHAT OUTPUT, -- int
	    @SENDER = @ID_SENDER, -- int
	    @CONTENT_MESS = @CONTENT_MESS, -- nvarchar(max)
	    @TYPE_MESS = @TYPE_MESS -- varchar(15)

		SELECT
		@ID_CHAT = id_chat,
		@SEND_TIME = send_time
	FROM dbo.Messages
	WHERE
		id_chat = @ID_CHAT AND
		sender = @ID_SENDER AND
		id_message = IDENT_CURRENT('dbo.Messages')
	 SELECT
		id_chat,
		Messages.id_message,
		sender,
		send_time,
		id_content_message,
		content_message,
		type_message
	FROM dbo.Messages
	LEFT JOIN dbo.ContentMessages ON ContentMessages.id_message = Messages.id_message
	WHERE 
		id_chat = @ID_CHAT AND
		sender = @ID_SENDER AND
		send_time = @SEND_TIME

	ORDER BY send_time DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
END
GO
/****** Object:  StoredProcedure [dbo].[SP_START_OFFLINET]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_START_OFFLINET]
	@ID_USER BIGINT
AS
BEGIN
	UPDATE dbo.Users SET status = GETDATE()
	WHERE id_user = @ID_USER
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPLOAD_AVATAR]    Script Date: 1/3/2021 7:55:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UPLOAD_AVATAR](
	@ID_USER BIGINT,
	@AVATAR NVARCHAR(MAX)
)
AS
BEGIN
	UPDATE Users
	SET avatar = @AVATAR
	WHERE id_user = @ID_USER
END

GO
USE [master]
GO
ALTER DATABASE [ChatApp] SET  READ_WRITE 
GO
