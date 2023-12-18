Return-Path: <stable+bounces-7678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F002F8175BA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E701F21367
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C37D4FF81;
	Mon, 18 Dec 2023 15:38:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB864FF7D
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d32c5ce32eso30929925ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913883; x=1703518683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH1BH57NcDYk0kItJ9z6Dso2CTcpGcfhJap//b/6mTs=;
        b=YEMptwWSST4lUnTepYxI1ebVh7G0SWUMnhmEfOyPHER+TlyuUmhgZsuQdFC/lBMYC/
         h6jtM4NIj8VZIPOSkZFfj4NTt3pKApWMvvBUwEQo9Z3sADNVMB+h1NjX/JYTJYIkf5ZV
         dySd7b5KIJbnYPAohVcwhcF0qQ+Ra8f4Xh4zO5reRH8KXS+LPWoxNn9WgMgv1F33/o9c
         b2grs8+XhUA98Mi3AoEUxJu1x6JF1W0mkcSJZdcph7ynOiEP3P4TBPzp5k/u2erpKrcu
         +j8i6/y8sg9u3G7KqYCxU5kj86o9P6SFb0c6ld+wiF6YE7lZSHqZ8loeub2uhG1xXg3f
         lwuQ==
X-Gm-Message-State: AOJu0YzioG5ihm8kQn33N03Jttt7XVs9Bn1b7fgUFZAMb/0E6aEnpWGv
	6iv/+Js4pW/5yFNi+9I7SrI=
X-Google-Smtp-Source: AGHT+IHA4M7xAvssOvdQz5NQhC6oeOQkxkLYhF79n12sgsPEamPfBauXxe8WTNAoymdkW0BGBv4Vpw==
X-Received: by 2002:a17:90a:e2c8:b0:28b:26d1:ae8e with SMTP id fr8-20020a17090ae2c800b0028b26d1ae8emr6658129pjb.35.1702913882849;
        Mon, 18 Dec 2023 07:38:02 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:02 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 049/154] ksmbd: don't open-code %pD
Date: Tue, 19 Dec 2023 00:33:09 +0900
Message-Id: <20231218153454.8090-50-linkinjeon@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 369c1634cc7ae8645a5cba4c7eb874755c2a6a07 ]

a bunch of places used %pd with file->f_path.dentry; shorter (and saner)
way to spell that is %pD with file...

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 11 +++++------
 fs/ksmbd/vfs.c     | 14 ++++++--------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 5ca491e73c6d..61811c10ec93 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3939,8 +3939,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 	    inode_permission(file_mnt_user_ns(dir_fp->filp),
 			     file_inode(dir_fp->filp),
 			     MAY_READ | MAY_EXEC)) {
-		pr_err("no right to enumerate directory (%pd)\n",
-		       dir_fp->filp->f_path.dentry);
+		pr_err("no right to enumerate directory (%pD)\n", dir_fp->filp);
 		rc = -EACCES;
 		goto err_out2;
 	}
@@ -6309,8 +6308,8 @@ int smb2_read(struct ksmbd_work *work)
 		goto out;
 	}
 
-	ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-		    fp->filp->f_path.dentry, offset, length);
+	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+		    fp->filp, offset, length);
 
 	work->aux_payload_buf = kvmalloc(length, GFP_KERNEL | __GFP_ZERO);
 	if (!work->aux_payload_buf) {
@@ -6574,8 +6573,8 @@ int smb2_write(struct ksmbd_work *work)
 		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
 				    le16_to_cpu(req->DataOffset));
 
-		ksmbd_debug(SMB, "filename %pd, offset %lld, len %zu\n",
-			    fp->filp->f_path.dentry, offset, length);
+		ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
+			    fp->filp, offset, length);
 		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
 				      writethrough, &nbytes);
 		if (err < 0)
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 0092e6911b14..8c542581f62a 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -376,8 +376,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-			pr_err("no right to read(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to read(%pD)\n", fp->filp);
 			return -EACCES;
 		}
 	}
@@ -486,8 +485,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	if (work->conn->connection_type) {
 		if (!(fp->daccess & FILE_WRITE_DATA_LE)) {
-			pr_err("no right to write(%pd)\n",
-			       fp->filp->f_path.dentry);
+			pr_err("no right to write(%pD)\n", fp->filp);
 			err = -EACCES;
 			goto out;
 		}
@@ -526,8 +524,8 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (sync) {
 		err = vfs_fsync_range(filp, offset, offset + *written, 0);
 		if (err < 0)
-			pr_err("fsync failed for filename = %pd, err = %d\n",
-			       fp->filp->f_path.dentry, err);
+			pr_err("fsync failed for filename = %pD, err = %d\n",
+			       fp->filp, err);
 	}
 
 out:
@@ -1742,11 +1740,11 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 	*total_size_written = 0;
 
 	if (!(src_fp->daccess & (FILE_READ_DATA_LE | FILE_EXECUTE_LE))) {
-		pr_err("no right to read(%pd)\n", src_fp->filp->f_path.dentry);
+		pr_err("no right to read(%pD)\n", src_fp->filp);
 		return -EACCES;
 	}
 	if (!(dst_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE))) {
-		pr_err("no right to write(%pd)\n", dst_fp->filp->f_path.dentry);
+		pr_err("no right to write(%pD)\n", dst_fp->filp);
 		return -EACCES;
 	}
 
-- 
2.25.1


