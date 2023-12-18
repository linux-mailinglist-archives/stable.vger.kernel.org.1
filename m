Return-Path: <stable+bounces-7682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D698175C4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79DC283B36
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CA5A87F;
	Mon, 18 Dec 2023 15:38:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF985B1E6
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28659348677so2286759a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913895; x=1703518695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QQ+Ugl5FhkvCcdvfLrnrUtuJ7Z7gg/eU1pFG4ZbbU0=;
        b=cao/pmPyORBBnTdkBeuPwM2vfZCTHly6aJb50gb5rcnEuAQEYyzHI1B/A5ZsGhYs4k
         BnvTm4GBIfV4q2jEfeQHGcuNyrpX3lTSthKp2wv2Zp1hY8HZd0XDgJdJfxr2IM0B45Hg
         2zii95hu+rw0PuKbmYhP1yU0u8at9qah7blB2fqso3vnRrddGU1flFEEZh26ORHDnvkD
         6bGRFD4f1we7XatGi5J9909dvLPnodS8wYtD07z1mfyh9i6PoCP+r+2T3gnmD4jqxANa
         CI+8SwTWoqtyVZzLSzWDQhVC7U6IMjMdKYUkBy4FOfxDLWial+KLO+sD04rJblj1Yp6f
         AbZQ==
X-Gm-Message-State: AOJu0Yw3WNV68c+No3WWsSPtyEiNf1TtwRNZM5foVtTzd7tpbjYEQoUu
	KrsLocn4udZK8JO9GeLlQLo=
X-Google-Smtp-Source: AGHT+IHVcIf9HSmAl+xRGGZeB74COCbOILiGti9lCuoFijOWIZja1A717kTWS8X895uXN3HfPra99w==
X-Received: by 2002:a17:90a:2dc4:b0:28b:9d23:fd3e with SMTP id q4-20020a17090a2dc400b0028b9d23fd3emr913678pjm.44.1702913895343;
        Mon, 18 Dec 2023 07:38:15 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:14 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 053/154] ksmbd: change security id to the one samba used for posix extension
Date: Tue, 19 Dec 2023 00:33:13 +0900
Message-Id: <20231218153454.8090-54-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 5609bdd9ffdccd83f9003511b1801584b703baa5 ]

Samba set SIDOWNER and SIDUNIX_GROUP in create posix context and
set SIDUNIX_USER/GROUP in other sids for posix extension.
This patch change security id to the one samba used.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 17 ++++++++++++++---
 fs/ksmbd/smb2pdu.c |  9 +++++++--
 fs/ksmbd/smb2pdu.h |  6 ++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index b527f451d7a4..c2a19328f01d 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1615,7 +1615,11 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 	memset(buf, 0, sizeof(struct create_posix_rsp));
 	buf->ccontext.DataOffset = cpu_to_le16(offsetof
 			(struct create_posix_rsp, nlink));
-	buf->ccontext.DataLength = cpu_to_le32(52);
+	/*
+	 * DataLength = nlink(4) + reparse_tag(4) + mode(4) +
+	 * domain sid(28) + unix group sid(16).
+	 */
+	buf->ccontext.DataLength = cpu_to_le32(56);
 	buf->ccontext.NameOffset = cpu_to_le16(offsetof
 			(struct create_posix_rsp, Name));
 	buf->ccontext.NameLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
@@ -1640,12 +1644,19 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 	buf->nlink = cpu_to_le32(inode->i_nlink);
 	buf->reparse_tag = cpu_to_le32(fp->volatile_id);
 	buf->mode = cpu_to_le32(inode->i_mode);
+	/*
+	 * SidBuffer(44) contain two sids(Domain sid(28), UNIX group sid(16)).
+	 * Domain sid(28) = revision(1) + num_subauth(1) + authority(6) +
+	 *		    sub_auth(4 * 4(num_subauth)) + RID(4).
+	 * UNIX group id(16) = revision(1) + num_subauth(1) + authority(6) +
+	 *		       sub_auth(4 * 1(num_subauth)) + RID(4).
+	 */
 	id_to_sid(from_kuid_munged(&init_user_ns,
 				   i_uid_into_mnt(user_ns, inode)),
-		  SIDNFS_USER, (struct smb_sid *)&buf->SidBuffer[0]);
+		  SIDOWNER, (struct smb_sid *)&buf->SidBuffer[0]);
 	id_to_sid(from_kgid_munged(&init_user_ns,
 				   i_gid_into_mnt(user_ns, inode)),
-		  SIDNFS_GROUP, (struct smb_sid *)&buf->SidBuffer[20]);
+		  SIDUNIX_GROUP, (struct smb_sid *)&buf->SidBuffer[28]);
 }
 
 /*
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9aad3d7e0c95..e78b36d74baa 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3619,10 +3619,15 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
 			posix_info->DosAttributes |= ATTR_HIDDEN_LE;
+		/*
+		 * SidBuffer(32) contain two sids(Domain sid(16), UNIX group sid(16)).
+		 * UNIX sid(16) = revision(1) + num_subauth(1) + authority(6) +
+		 *		  sub_auth(4 * 1(num_subauth)) + RID(4).
+		 */
 		id_to_sid(from_kuid_munged(&init_user_ns, ksmbd_kstat->kstat->uid),
-			  SIDNFS_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
+			  SIDUNIX_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
 		id_to_sid(from_kgid_munged(&init_user_ns, ksmbd_kstat->kstat->gid),
-			  SIDNFS_GROUP, (struct smb_sid *)&posix_info->SidBuffer[20]);
+			  SIDUNIX_GROUP, (struct smb_sid *)&posix_info->SidBuffer[16]);
 		memcpy(posix_info->name, conv_name, conv_len);
 		posix_info->name_len = cpu_to_le32(conv_len);
 		posix_info->NextEntryOffset = cpu_to_le32(next_entry_offset);
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 10776df5baa7..fe391b8afa9c 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -724,7 +724,8 @@ struct create_posix_rsp {
 	__le32 nlink;
 	__le32 reparse_tag;
 	__le32 mode;
-	u8 SidBuffer[40];
+	/* SidBuffer contain two sids(Domain sid(28), UNIX group sid(16)) */
+	u8 SidBuffer[44];
 } __packed;
 
 #define SMB2_LEASE_NONE_LE			cpu_to_le32(0x00)
@@ -1617,7 +1618,8 @@ struct smb2_posix_info {
 	__le32 HardLinks;
 	__le32 ReparseTag;
 	__le32 Mode;
-	u8 SidBuffer[40];
+	/* SidBuffer contain two sids (UNIX user sid(16), UNIX group sid(16)) */
+	u8 SidBuffer[32];
 	__le32 name_len;
 	u8 name[1];
 	/*
-- 
2.25.1


