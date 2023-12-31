Return-Path: <stable+bounces-9035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1A8209F3
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A7B1C20FED
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2700B17D3;
	Sun, 31 Dec 2023 07:13:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54817C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc025dd9a9so2679999a34.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006826; x=1704611626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrtURb/ScOmrZhltO5saXB6hdKo1aeTgWAGU2VqgKAs=;
        b=A1lbgDv9vegIfEp5F8mO1cKw6SrPgGYT3kag3Y4jny1VNl6mZoq++URg0LU/4+Hvvi
         p2m2EjsNwhANxi5jqjR8mL6w7rHjMpBPBRfhkwzM6cTi8jVdStAyCQ+CJAnb9lv7EwXb
         p4WfXxbNfi/Q9tMoGoT4keGHygeYx4wUh7KDQLkD700FoCrhbg/H1vurzBC24sSuknwJ
         XrxdkJbJgLDulU7/ga8L/owIaPJMok3XjcHaaK3sFIhGkw9BFn0NSXdRT/FRgY3CmJFO
         gJwOGAO6THPoLlVVxb9dflH8EGgv4kZsKqYPTcUinN+bzMimLRQTQEyoZPyumKJAJH6+
         7zjQ==
X-Gm-Message-State: AOJu0Ywnqw9vEWenyCT64ijiBs57od56PC5C+qqUZUPFRXf3GewiI1vn
	402cE7hygVR4X12RCcL/ao+NdT6Gdu0=
X-Google-Smtp-Source: AGHT+IHSyMSTNYWhwGXOPz4srTgG+7DUvaKZT7xxEzvPmmfKKDRQYNdOc2RLqJ6lLZaRjPsmQeFzeg==
X-Received: by 2002:a05:6870:d610:b0:204:1ddb:b862 with SMTP id a16-20020a056870d61000b002041ddbb862mr17652281oaq.70.1704006826471;
        Sat, 30 Dec 2023 23:13:46 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:13:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1.y 01/73] ksmbd: replace one-element arrays with flexible-array members
Date: Sun, 31 Dec 2023 16:12:20 +0900
Message-Id: <20231231071332.31724-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit d272e01fa0a2f15c5c331a37cd99c6875c7b7186 ]

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in multiple structs in fs/ksmbd/smb_common.h and one in
fs/ksmbd/smb2pdu.h.

Important to mention is that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help us make progress towards globally enabling
-fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/242
Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/Y3OxronfaPYv9qGP@work
---
 fs/smb/server/smb2pdu.c    |  4 ++--
 fs/smb/server/smb2pdu.h    |  2 +-
 fs/smb/server/smb_common.h | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1598ad6155fe..3f4f6b038565 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3525,7 +3525,7 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		goto free_conv_name;
 	}
 
-	struct_sz = readdir_info_level_struct_sz(info_level) - 1 + conv_len;
+	struct_sz = readdir_info_level_struct_sz(info_level) + conv_len;
 	next_entry_offset = ALIGN(struct_sz, KSMBD_DIR_INFO_ALIGNMENT);
 	d_info->last_entry_off_align = next_entry_offset - struct_sz;
 
@@ -3777,7 +3777,7 @@ static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
 		return -EOPNOTSUPP;
 
 	conv_len = (d_info->name_len + 1) * 2;
-	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+	next_entry_offset = ALIGN(struct_sz + conv_len,
 				  KSMBD_DIR_INFO_ALIGNMENT);
 
 	if (next_entry_offset > d_info->out_buf_len) {
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 665a83737854..f13bd65993cc 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -446,7 +446,7 @@ struct smb2_posix_info {
 	/* SidBuffer contain two sids (UNIX user sid(16), UNIX group sid(16)) */
 	u8 SidBuffer[32];
 	__le32 name_len;
-	u8 name[1];
+	u8 name[];
 	/*
 	 * var sized owner SID
 	 * var sized group SID
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 1cbb492cdefe..f0134d16067f 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -263,14 +263,14 @@ struct file_directory_info {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0x101 FF resp data */
 
 struct file_names_info {
 	__le32 NextEntryOffset;
 	__u32 FileIndex;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __packed;   /* level 0xc FF resp data */
 
 struct file_full_directory_info {
@@ -285,7 +285,7 @@ struct file_full_directory_info {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize;
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x102 FF resp */
 
 struct file_both_directory_info {
@@ -303,7 +303,7 @@ struct file_both_directory_info {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x104 FFrsp data */
 
 struct file_id_both_directory_info {
@@ -323,7 +323,7 @@ struct file_id_both_directory_info {
 	__u8   ShortName[24];
 	__le16 Reserved2;
 	__le64 UniqueId;
-	char FileName[1];
+	char FileName[];
 } __packed;
 
 struct file_id_full_dir_info {
@@ -340,7 +340,7 @@ struct file_id_full_dir_info {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 0x105 FF rsp data */
 
 struct smb_version_values {
-- 
2.25.1


