Return-Path: <stable+bounces-40770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD98AF8AA
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 22:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4799B2A1DE
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA383142633;
	Tue, 23 Apr 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvZSScwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0F26288;
	Tue, 23 Apr 2024 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905896; cv=none; b=IfFW0OCisvS46nZll6nOUXo1t9Ge2iUWd1yYrlW//xwUvZlyHS/zo57yOUe9lyES8dYRIuL+VVfDnFk6JZJZ2QWXrovyNPi5kSUTMN2MdFKporzj27SNgReWO6F7DyX1rcEeDVT09klZhaEn2OIOgdkH/smqp/+gxNTNJNofeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905896; c=relaxed/simple;
	bh=YTBAuOQhGKoe4QaZ+aeBbXd+9zAupmWXWQFRpPq4r6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daCImeeg7yMNzh8Tfb6vUdEVUpYulsWWjiusODf/Gojnl+boik4vC/ocEMqkeYSrWdm2D7k34MP6W9Ar0pFYKPU/6bDeNwti09Vf/U2J5rqtJaossI/mCg92JDud2REohvJztgcpEwteVP0gh4RzbLsnYOSt/cu1YgH5aakRlAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvZSScwm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ae95468efso3208175e9.2;
        Tue, 23 Apr 2024 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713905892; x=1714510692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN7iHF8gpniIcCm6S6JY4+OgKkP+F5ovibtWwDaj03o=;
        b=ZvZSScwm515sEbXpu83hqCYjT0ORMBeuWvLSV6HigkcSYrrq+yYJVtSl3pmhvNSySg
         1T2BihJeNyBwIKIOb36OzEELapVLZ8Ee/YTqxpIZvMz6H2LAblQHw5C/YKqMwfHYrNPZ
         pAQfqMVh+onJprAky1F0x22AbCVc+P1rVFee/BDvPPLi6VEO31ZcDVkAOMSyP7Lc5yDP
         Qsq3UeBMWPCpakTkXU4cC5jNxcdtLL7DLOKqQkGZRTAAM+y5IUlOyPPxUZwX5S806lps
         Mm5N8Y8oNWalvwj/xuA5SjXHbq6tDJgUV7d1aRrnyHHOAOcYJ40yIyOLvwYBPrwCGAVw
         Xhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905892; x=1714510692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN7iHF8gpniIcCm6S6JY4+OgKkP+F5ovibtWwDaj03o=;
        b=aR9Pol0LhW+TWclpSizKLE9k6nnAuLe22ja4WC8nSRIbiMVYlUh9QcTTwa1glovhz6
         ocePim3DgtSxItnHXLTPvHUCXGEzF1TY5pME5RJwhU0eckVQmFlhrFD2sOh9WuakNzUw
         2r//kcGIykt4FToo8o/tZf84RoEgs/utohKHdrCQRAY8AG7ZnDIGsDlP1eOddhAA/w+S
         +2WulAuNmDha+KlmnDP098VC2TQ711HXs436AavcDaXp5kkE+A4i1vLOyPj1RwIx6qiI
         +CxHIeqZZ/lOpJm0LQLG4P8BDSuujfNpbG9KV0d77/800bd3EpHeLyNmEeDIOvGXPmV4
         wC9w==
X-Forwarded-Encrypted: i=1; AJvYcCXA2YzEqeKCves61R2Q71Wcj1ZCIwznF9oGl431ahTQoFv1Xc7Zyx+biOzzhfXD8rb4fpm8z/qSimPLnkL3AOgZD5EPZV4G+Lct/1OEt2/a/gIc80UdDoLLgdEt+sA9RcyhZA==
X-Gm-Message-State: AOJu0YwbAf2LFKSHUypZkWjKS52lVQe3fRO5MYSsrRSG6qLh6X1ULqWp
	efsecpLNTsoI9uxopsIttE2HVdTXs4IKb7aW2nAQ6EZ2d32FvadN
X-Google-Smtp-Source: AGHT+IHpVjMBbHL6UUyJ4DrXgeuQT6UaaUzhvBM7mbzOSEsDAoaA6c9fbjFqfpzc3vPs9FDsskAOKQ==
X-Received: by 2002:adf:c841:0:b0:347:3037:188d with SMTP id e1-20020adfc841000000b003473037188dmr272192wrh.34.1713905891406;
        Tue, 23 Apr 2024 13:58:11 -0700 (PDT)
Received: from eldamar.lan ([151.41.138.92])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a58864c88aesm629635ejb.225.2024.04.23.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:58:10 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8C9A5BE2EE8; Tue, 23 Apr 2024 22:58:09 +0200 (CEST)
Date: Tue, 23 Apr 2024 22:58:09 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, regressions@lists.linux.dev,
	Steve French <stfrench@microsoft.com>, gregkh@linuxfoundation.org,
	sashal@kernel.org, stable@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [regression 6.1.80+] "CIFS: VFS: directory entry name would
 overflow frame end of buf" and invisible files under certain conditions and
 at least with noserverino mount option
Message-ID: <Zigg4RWtRfQYW1RR@eldamar.lan>
References: <ZiBCsoc0yf_I8In8@eldamar.lan>
 <cc3eea56282f4b43d0fe151a9390c512@manguebit.com>
 <ZiCoYjr79HXxiTjr@eldamar.lan>
 <29e0cbcab5be560608d1dfbfb0ccbc96@manguebit.com>
 <ZiLQG4x0m1L70ugu@eldamar.lan>
 <adfd2a680e289404140ef917cf0bd0ab@manguebit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mgDXIK1+JR8P06qf"
Content-Disposition: inline
In-Reply-To: <adfd2a680e289404140ef917cf0bd0ab@manguebit.com>


--mgDXIK1+JR8P06qf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paulo,

On Mon, Apr 22, 2024 at 12:08:53PM -0300, Paulo Alcantara wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > I'm still failing to provide you a recipe with a minimal as possible
> > setup, but with the instance I was able to reproduce the issue the
> > regression seems gone with cherry-picking 35235e19b393 ("cifs: Replace
> > remaining 1-element arrays") .
> 
> It's OK, no problem.  Could you please provide the backport to stable
> team?

Sure, here it is. Greg or Sasha is it ok to pick that up for the 6.1.y
queues?

Regards,
Salvatore

--mgDXIK1+JR8P06qf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-cifs-Replace-remaining-1-element-arrays.patch"

From 515673c8dfed6cdc2ae1d7831cf884b578228d22 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Tue, 14 Feb 2023 16:09:45 -0800
Subject: [PATCH] cifs: Replace remaining 1-element arrays

commit 35235e19b393b54db0e0d7c424d658ba45f20468 upstream.

The kernel is globally removing the ambiguous 0-length and 1-element
arrays in favor of flexible arrays, so that we can gain both compile-time
and run-time array bounds checking[1].

Replace the trailing 1-element array with a flexible array in the
following structures:

	struct cifs_spnego_msg
	struct cifs_quota_data
	struct get_dfs_referral_rsp
	struct file_alt_name_info
	NEGOTIATE_RSP
	SESSION_SETUP_ANDX
	TCONX_REQ
	TCONX_RSP
	TCONX_RSP_EXT
	ECHO_REQ
	ECHO_RSP
	OPEN_REQ
	OPENX_REQ
	LOCK_REQ
	RENAME_REQ
	COPY_REQ
	COPY_RSP
	NT_RENAME_REQ
	DELETE_FILE_REQ
	DELETE_DIRECTORY_REQ
	CREATE_DIRECTORY_REQ
	QUERY_INFORMATION_REQ
	SETATTR_REQ
	TRANSACT_IOCTL_REQ
	TRANSACT_CHANGE_NOTIFY_REQ
	TRANSACTION2_QPI_REQ
	TRANSACTION2_SPI_REQ
	TRANSACTION2_FFIRST_REQ
	TRANSACTION2_GET_DFS_REFER_REQ
	FILE_UNIX_LINK_INFO
	FILE_DIRECTORY_INFO
	FILE_FULL_DIRECTORY_INFO
	SEARCH_ID_FULL_DIR_INFO
	FILE_BOTH_DIRECTORY_INFO
	FIND_FILE_STANDARD_INFO

Replace the trailing 1-element array with a flexible array, but leave
the existing structure padding:

	FILE_ALL_INFO
	FILE_UNIX_INFO

Remove unused structures:

	struct gea
	struct gealist

Adjust all related size calculations to match the changes to sizeof().

No machine code output differences are produced after these changes.

[1] For lots of details, see both:
    https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    https://people.kernel.org/kees/bounded-flexible-arrays-in-c

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Salvatore Bonaccorso: Patch does not apply cleanly only due to a
  whitespace difference in fs/smb/client/cifspdu.h . Fixed up manually. ]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 fs/smb/client/cifs_spnego.h |  2 +-
 fs/smb/client/cifspdu.h     | 96 ++++++++++++++++++-------------------
 fs/smb/client/readdir.c     |  6 +--
 fs/smb/client/smb2pdu.c     |  4 +-
 fs/smb/client/smb2pdu.h     |  2 +-
 5 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.h b/fs/smb/client/cifs_spnego.h
index 7f102ffeb675..e4d751b0c812 100644
--- a/fs/smb/client/cifs_spnego.h
+++ b/fs/smb/client/cifs_spnego.h
@@ -24,7 +24,7 @@ struct cifs_spnego_msg {
 	uint32_t	flags;
 	uint32_t	sesskey_len;
 	uint32_t	secblob_len;
-	uint8_t		data[1];
+	uint8_t		data[];
 };
 
 #ifdef __KERNEL__
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 97bb1838555b..94f86374f4b7 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -562,7 +562,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;
 		__le32 Capabilities;	/* see below */
 		__le16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 		/* STRING NativeOS */
 		/* STRING NativeLanMan */
 	} __attribute__((packed)) req;	/* NTLM request format (with
@@ -582,7 +582,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;	/* see below */
 		__le32 Capabilities;
 		__le16 ByteCount;
-		unsigned char CaseInsensitivePassword[1];     /* followed by: */
+		unsigned char CaseInsensitivePassword[];     /* followed by: */
 		/* unsigned char * CaseSensitivePassword; */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
@@ -599,7 +599,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 Action;	/* see below */
 		__le16 SecurityBlobLength;
 		__u16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 /*      unsigned char  * NativeOS;      */
 /*	unsigned char  * NativeLanMan;  */
 /*      unsigned char  * PrimaryDomain; */
@@ -618,7 +618,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 PasswordLength;
 		__u32 Reserved; /* encrypt key len and offset */
 		__le16 ByteCount;
-		unsigned char AccountPassword[1];	/* followed by */
+		unsigned char AccountPassword[];	/* followed by */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
 		/* STRING NativeOS */
@@ -632,7 +632,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 AndXOffset;
 		__le16 Action;	/* see below */
 		__u16 ByteCount;
-		unsigned char NativeOS[1];	/* followed by */
+		unsigned char NativeOS[];	/* followed by */
 /*	unsigned char * NativeLanMan; */
 /*      unsigned char * PrimaryDomain; */
 	} __attribute__((packed)) old_resp; /* pre-NTLM (LANMAN2.1) response */
@@ -693,7 +693,7 @@ typedef struct smb_com_tconx_req {
 	__le16 Flags;		/* see below */
 	__le16 PasswordLength;
 	__le16 ByteCount;
-	unsigned char Password[1];	/* followed by */
+	unsigned char Password[];	/* followed by */
 /* STRING Path    *//* \\server\share name */
 	/* STRING Service */
 } __attribute__((packed)) TCONX_REQ;
@@ -705,7 +705,7 @@ typedef struct smb_com_tconx_rsp {
 	__le16 AndXOffset;
 	__le16 OptionalSupport;	/* see below */
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP;
 
@@ -718,7 +718,7 @@ typedef struct smb_com_tconx_rsp_ext {
 	__le32 MaximalShareAccessRights;
 	__le32 GuestMaximalShareAccessRights;
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP_EXT;
 
@@ -755,14 +755,14 @@ typedef struct smb_com_echo_req {
 	struct	smb_hdr hdr;
 	__le16	EchoCount;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_REQ;
 
 typedef struct smb_com_echo_rsp {
 	struct	smb_hdr hdr;
 	__le16	SequenceNumber;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_RSP;
 
 typedef struct smb_com_logoff_andx_req {
@@ -862,7 +862,7 @@ typedef struct smb_com_open_req {	/* also handles create */
 	__le32 ImpersonationLevel;
 	__u8 SecurityFlags;
 	__le16 ByteCount;
-	char fileName[1];
+	char fileName[];
 } __attribute__((packed)) OPEN_REQ;
 
 /* open response: oplock levels */
@@ -939,7 +939,7 @@ typedef struct smb_com_openx_req {
 	__le32 Timeout;
 	__le32 Reserved;
 	__le16  ByteCount;  /* file name follows */
-	char   fileName[1];
+	char   fileName[];
 } __attribute__((packed)) OPENX_REQ;
 
 typedef struct smb_com_openx_rsp {
@@ -1087,7 +1087,7 @@ typedef struct smb_com_lock_req {
 	__le16 NumberOfUnlocks;
 	__le16 NumberOfLocks;
 	__le16 ByteCount;
-	LOCKING_ANDX_RANGE Locks[1];
+	LOCKING_ANDX_RANGE Locks[];
 } __attribute__((packed)) LOCK_REQ;
 
 /* lock type */
@@ -1116,7 +1116,7 @@ typedef struct smb_com_rename_req {
 	__le16 SearchAttributes;	/* target file attributes */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) RENAME_REQ;
@@ -1136,7 +1136,7 @@ typedef struct smb_com_copy_req {
 	__le16 Flags;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName string */
 } __attribute__((packed)) COPY_REQ;
@@ -1146,7 +1146,7 @@ typedef struct smb_com_copy_rsp {
 	__le16 CopyCount;    /* number of files copied */
 	__u16 ByteCount;    /* may be zero */
 	__u8 BufferFormat;  /* 0x04 - only present if errored file follows */
-	unsigned char ErrorFileName[1]; /* only present if error in copy */
+	unsigned char ErrorFileName[]; /* only present if error in copy */
 } __attribute__((packed)) COPY_RSP;
 
 #define CREATE_HARD_LINK		0x103
@@ -1160,7 +1160,7 @@ typedef struct smb_com_nt_rename_req {	/* A5 - also used for create hardlink */
 	__le32 ClusterCount;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) NT_RENAME_REQ;
@@ -1175,7 +1175,7 @@ typedef struct smb_com_delete_file_req {
 	__le16 SearchAttributes;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) DELETE_FILE_REQ;
 
 typedef struct smb_com_delete_file_rsp {
@@ -1187,7 +1187,7 @@ typedef struct smb_com_delete_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) DELETE_DIRECTORY_REQ;
 
 typedef struct smb_com_delete_directory_rsp {
@@ -1199,7 +1199,7 @@ typedef struct smb_com_create_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) CREATE_DIRECTORY_REQ;
 
 typedef struct smb_com_create_directory_rsp {
@@ -1211,7 +1211,7 @@ typedef struct smb_com_query_information_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;	/* 1 + namelen + 1 */
 	__u8 BufferFormat;      /* 4 = ASCII */
-	unsigned char FileName[1];
+	unsigned char FileName[];
 } __attribute__((packed)) QUERY_INFORMATION_REQ;
 
 typedef struct smb_com_query_information_rsp {
@@ -1231,7 +1231,7 @@ typedef struct smb_com_setattr_req {
 	__le16 reserved[5]; /* must be zero */
 	__u16  ByteCount;
 	__u8   BufferFormat; /* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) SETATTR_REQ;
 
 typedef struct smb_com_setattr_rsp {
@@ -1313,7 +1313,7 @@ typedef struct smb_com_transaction_ioctl_req {
 	__u8 IsRootFlag; /* 1 = apply command to root of share (must be DFS) */
 	__le16 ByteCount;
 	__u8 Pad[3];
-	__u8 Data[1];
+	__u8 Data[];
 } __attribute__((packed)) TRANSACT_IOCTL_REQ;
 
 typedef struct smb_com_transaction_compr_ioctl_req {
@@ -1431,8 +1431,8 @@ typedef struct smb_com_transaction_change_notify_req {
 	__u8 WatchTree;  /* 1 = Monitor subdirectories */
 	__u8 Reserved2;
 	__le16 ByteCount;
-/* 	__u8 Pad[3];*/
-/*	__u8 Data[1];*/
+/*	__u8 Pad[3];*/
+/*	__u8 Data[];*/
 } __attribute__((packed)) TRANSACT_CHANGE_NOTIFY_REQ;
 
 /* BB eventually change to use generic ntransact rsp struct
@@ -1521,7 +1521,7 @@ struct cifs_quota_data {
 	__u64	space_used;
 	__u64	soft_limit;
 	__u64	hard_limit;
-	char	sid[1];  /* variable size? */
+	char	sid[];  /* variable size? */
 } __attribute__((packed));
 
 /* quota sub commands */
@@ -1673,7 +1673,7 @@ typedef struct smb_com_transaction2_qpi_req {
 	__u8 Pad;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_QPI_REQ;
 
 typedef struct smb_com_transaction2_qpi_rsp {
@@ -1706,7 +1706,7 @@ typedef struct smb_com_transaction2_spi_req {
 	__u16 Pad1;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_SPI_REQ;
 
 typedef struct smb_com_transaction2_spi_rsp {
@@ -1813,7 +1813,7 @@ typedef struct smb_com_transaction2_ffirst_req {
 	__le16 SearchFlags;
 	__le16 InformationLevel;
 	__le32 SearchStorageType;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_FFIRST_REQ;
 
 typedef struct smb_com_transaction2_ffirst_rsp {
@@ -2024,7 +2024,7 @@ typedef struct smb_com_transaction2_get_dfs_refer_req {
 				   perhaps?) followed by one byte pad - doesn't
 				   seem to matter though */
 	__le16 MaxReferralLevel;
-	char RequestFileName[1];
+	char RequestFileName[];
 } __attribute__((packed)) TRANSACTION2_GET_DFS_REFER_REQ;
 
 #define DFS_VERSION cpu_to_le16(0x0003)
@@ -2053,7 +2053,7 @@ struct get_dfs_referral_rsp {
 	__le16 PathConsumed;
 	__le16 NumberOfReferrals;
 	__le32 DFSFlags;
-	REFERRAL3 referrals[1];	/* array of level 3 dfs_referral structures */
+	REFERRAL3 referrals[];	/* array of level 3 dfs_referral structures */
 	/* followed by the strings pointed to by the referral structures */
 } __packed;
 
@@ -2292,7 +2292,10 @@ typedef struct { /* data block encoding of response to level 263 QPathInfo */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_ALL_INFO;	/* level 0x107 QPathInfo */
 
 typedef struct {
@@ -2330,7 +2333,7 @@ typedef struct {
 } __attribute__((packed)) FILE_UNIX_BASIC_INFO;	/* level 0x200 QPathInfo */
 
 typedef struct {
-	char LinkDest[1];
+	DECLARE_FLEX_ARRAY(char, LinkDest);
 } __attribute__((packed)) FILE_UNIX_LINK_INFO;	/* level 0x201 QPathInfo */
 
 /* The following three structures are needed only for
@@ -2380,7 +2383,7 @@ struct file_end_of_file_info {
 } __attribute__((packed)); /* size info, level 0x104 for set, 0x106 for query */
 
 struct file_alt_name_info {
-	__u8   alt_name[1];
+	DECLARE_FLEX_ARRAY(__u8, alt_name);
 } __attribute__((packed));      /* level 0x0108 */
 
 struct file_stream_info {
@@ -2490,7 +2493,10 @@ typedef struct {
 	__le32 NextEntryOffset;
 	__u32 ResumeKey; /* as with FileIndex - no need to convert */
 	FILE_UNIX_BASIC_INFO basic;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_UNIX_INFO; /* level 0x202 */
 
 typedef struct {
@@ -2504,7 +2510,7 @@ typedef struct {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_DIRECTORY_INFO;   /* level 0x101 FF resp data */
 
 typedef struct {
@@ -2519,7 +2525,7 @@ typedef struct {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize; /* length of the xattrs */
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_FULL_DIRECTORY_INFO; /* level 0x102 rsp data */
 
 typedef struct {
@@ -2536,7 +2542,7 @@ typedef struct {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
 
 typedef struct {
@@ -2554,7 +2560,7 @@ typedef struct {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
 
 typedef struct {
@@ -2569,7 +2575,7 @@ typedef struct {
 	__le32 AllocationSize;
 	__le16 Attributes; /* verify not u32 */
 	__u8   FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FIND_FILE_STANDARD_INFO; /* level 0x1 FF resp data */
 
 
@@ -2579,16 +2585,6 @@ struct win_dev {
 	__le64 minor;
 } __attribute__((packed));
 
-struct gea {
-	unsigned char name_len;
-	char name[1];
-} __attribute__((packed));
-
-struct gealist {
-	unsigned long list_len;
-	struct gea list[1];
-} __attribute__((packed));
-
 struct fea {
 	unsigned char EA_flags;
 	__u8 name_len;
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 5990bdbae598..9a1f1913fb59 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -497,7 +497,7 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 		FIND_FILE_STANDARD_INFO *pfData;
 		pfData = (FIND_FILE_STANDARD_INFO *)pDirInfo;
 
-		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) +
+		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 +
 				pfData->FileNameLength;
 	} else {
 		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
@@ -515,9 +515,9 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 			 new_entry, end_of_smb, old_entry);
 		return NULL;
 	} else if (((level == SMB_FIND_FILE_INFO_STANDARD) &&
-		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) > end_of_smb))
+		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 > end_of_smb))
 		  || ((level != SMB_FIND_FILE_INFO_STANDARD) &&
-		   (new_entry + sizeof(FILE_DIRECTORY_INFO) > end_of_smb)))  {
+		   (new_entry + sizeof(FILE_DIRECTORY_INFO) + 1 > end_of_smb)))  {
 		cifs_dbg(VFS, "search entry %p extends after end of SMB %p\n",
 			 new_entry, end_of_smb);
 		return NULL;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cc425a616899..e15bf116c755 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5073,10 +5073,10 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 
 	switch (srch_inf->info_level) {
 	case SMB_FIND_FILE_DIRECTORY_INFO:
-		info_buf_size = sizeof(FILE_DIRECTORY_INFO) - 1;
+		info_buf_size = sizeof(FILE_DIRECTORY_INFO);
 		break;
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
-		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
+		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO);
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
 		/* note that posix payload are variable size */
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 8d011fedecd0..3a13b9b56452 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -373,7 +373,7 @@ struct smb2_file_id_extd_directory_info {
 	__le32 EaSize; /* EA size */
 	__le32 ReparsePointTag; /* valid if FILE_ATTR_REPARSE_POINT set in FileAttributes */
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit */
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 60 */
 
 extern char smb2_padding[7];
-- 
2.43.0


--mgDXIK1+JR8P06qf--

