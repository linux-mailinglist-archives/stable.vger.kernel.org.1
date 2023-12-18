Return-Path: <stable+bounces-7683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58E88175C5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF76B283DE7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277635B1F1;
	Mon, 18 Dec 2023 15:38:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C35BF84
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so2610546a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913898; x=1703518698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBEWn9bC0R5HDUzT4YqzQGwNtQEUbpi6mFZbMqOyH9k=;
        b=YeSgb48o9+AI7eM2o1sVRSYoofWwU5A7LElv3Vf3cCQvD7Kvz6HN4U5PZc1svwqJwM
         IodjGwbGt40MCBvAbekyr3rqrIaAY8ESY7Q03IHBzndwZWWqQgh/alTBrJvJdI6BRpSH
         MAi4oJ/XlbFLVTiWivhmGVHvi+n8P+VGGV8HuDi8c4jo/Q5LKzvW68f9xKn1CvtbVnav
         VMfe0owAH+KEiK2Iluzdp9siVOBxLxc+pqXbPTB5oiat081Bv7jMLKkfJlBY1pJ0EdAW
         Yfxzs3NXi+OxdnzikEzgl7VfZgq/xTbk6jMuCzitJhvXRPGHchlfEwipFven+x/abETp
         uTLw==
X-Gm-Message-State: AOJu0YyxQV8K1HmqQn7FtMp8UZ8zJguWWA16TY/ffoJjrKq0wgpFUsIY
	r6lBMQwB2tgQo78tzyn9XYY=
X-Google-Smtp-Source: AGHT+IG56y73o2tny3mkTEsO6sVXQ7QdgBWmuT5yfZCro70dC83PuHNozBTEk/Uxuc9dFjwIjaxQQw==
X-Received: by 2002:a17:90a:cf16:b0:28b:4e65:a782 with SMTP id h22-20020a17090acf1600b0028b4e65a782mr1494180pju.3.1702913898137;
        Mon, 18 Dec 2023 07:38:18 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:17 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 054/154] ksmbd: set file permission mode to match Samba server posix extension behavior
Date: Tue, 19 Dec 2023 00:33:14 +0900
Message-Id: <20231218153454.8090-55-linkinjeon@kernel.org>
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

[ Upstream commit f6c2b201da7588f7f7688ddc99b7bb000609129c ]

Set file permission mode to match Samba server posix extension behavior.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 2 +-
 fs/ksmbd/smb2pdu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index c2a19328f01d..919c598a9d66 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1643,7 +1643,7 @@ void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
 
 	buf->nlink = cpu_to_le32(inode->i_nlink);
 	buf->reparse_tag = cpu_to_le32(fp->volatile_id);
-	buf->mode = cpu_to_le32(inode->i_mode);
+	buf->mode = cpu_to_le32(inode->i_mode & 0777);
 	/*
 	 * SidBuffer(44) contain two sids(Domain sid(28), UNIX group sid(16)).
 	 * Domain sid(28) = revision(1) + num_subauth(1) + authority(6) +
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index e78b36d74baa..9e9ba815ffa3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3613,7 +3613,7 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		posix_info->AllocationSize = cpu_to_le64(ksmbd_kstat->kstat->blocks << 9);
 		posix_info->DeviceId = cpu_to_le32(ksmbd_kstat->kstat->rdev);
 		posix_info->HardLinks = cpu_to_le32(ksmbd_kstat->kstat->nlink);
-		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode);
+		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode & 0777);
 		posix_info->Inode = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		posix_info->DosAttributes =
 			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
@@ -4769,7 +4769,7 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	file_info->EndOfFile = cpu_to_le64(inode->i_size);
 	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
 	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
-	file_info->Mode = cpu_to_le32(inode->i_mode);
+	file_info->Mode = cpu_to_le32(inode->i_mode & 0777);
 	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb311_posix_qinfo));
-- 
2.25.1


