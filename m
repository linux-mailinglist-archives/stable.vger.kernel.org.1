Return-Path: <stable+bounces-7761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B3817625
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417C6B245BC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF60498B9;
	Mon, 18 Dec 2023 15:42:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5974E04
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28b012f93eeso1221464a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914146; x=1703518946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq7CLOEUepFXBJkm2sJDAaW7StXppT+58+8/hoUxHZY=;
        b=E32QaN29kZlOAL0NN6snickzl0SsaEY323l4ER797+cGu+ArPVmIm1AIMJ5Hn3YTHa
         qwuZuqbjOwChUQDaADeHcqGNU3IE9snj1+XEXw2w0XjJRCkn25Yy6GYiGX4d5MN5GCbj
         hl5t8mjJ4A5AK7K2V3i347L1/Ns1aCTl9fcXXE8vKeN/IHyoYe0EpDBmz6+/L03K4RrU
         KPwB1HhkFLqrNUuGrUaNOokZwViCwetp13qQ4A6XtVhREuHtnPfl6e7do7/fn/pU5A6D
         dOXt0e2XkUz4B9WPLCJBCM8ATyi29C9V+CnkRjInwxX1PSl1vb7EDYHVNsYLjQFxFZLN
         d8hQ==
X-Gm-Message-State: AOJu0Yx3frpykF9eWGbnbcaKZJWHUh059M/RWBd7TchqQBgSpw2aWoic
	rEXsQLvRLZb6H61hDz+D62Y=
X-Google-Smtp-Source: AGHT+IHE2MnDfO4Lh7c60egSy02NwZ47qT3tUXCz/8iGTYbhUQ8GJ51WkpQCkwdF4MOjEMQEn8YjQQ==
X-Received: by 2002:a17:90b:1d0b:b0:28b:5c89:b378 with SMTP id on11-20020a17090b1d0b00b0028b5c89b378mr938212pjb.12.1702914146074;
        Mon, 18 Dec 2023 07:42:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 132/154] ksmbd: fix race condition with fp
Date: Tue, 19 Dec 2023 00:34:32 +0900
Message-Id: <20231218153454.8090-133-linkinjeon@kernel.org>
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

[ Upstream commit 5a7ee91d1154f35418367a6eaae74046fd06ed89 ]

fp can used in each command. If smb2_close command is coming at the
same time, UAF issue can happen by race condition.

                           Time
                            +
Thread A                    | Thread B1 B2 .... B5
smb2_open                   | smb2_close
                            |
 __open_id                  |
   insert fp to file_table  |
                            |
                            |   atomic_dec_and_test(&fp->refcount)
                            |   if fp->refcount == 0, free fp by kfree.
 // UAF!                    |
 use fp                     |
                            +
This patch add f_state not to use freed fp is used and not to free fp in
use.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c   |  4 +++-
 fs/ksmbd/vfs_cache.c | 23 ++++++++++++++++++++---
 fs/ksmbd/vfs_cache.h |  9 +++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 26aa554a4f6c..2f1ffd3bf2fb 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3367,8 +3367,10 @@ int smb2_open(struct ksmbd_work *work)
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
-	if (!rc)
+	if (!rc) {
+		ksmbd_update_fstate(&work->sess->file_table, fp, FP_INITED);
 		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
+	}
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 94ad8fa07b46..f600279b0a9e 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -332,6 +332,9 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 static struct ksmbd_file *ksmbd_fp_get(struct ksmbd_file *fp)
 {
+	if (fp->f_state != FP_INITED)
+		return NULL;
+
 	if (!atomic_inc_not_zero(&fp->refcount))
 		return NULL;
 	return fp;
@@ -381,15 +384,20 @@ int ksmbd_close_fd(struct ksmbd_work *work, u64 id)
 		return 0;
 
 	ft = &work->sess->file_table;
-	read_lock(&ft->lock);
+	write_lock(&ft->lock);
 	fp = idr_find(ft->idr, id);
 	if (fp) {
 		set_close_state_blocked_works(fp);
 
-		if (!atomic_dec_and_test(&fp->refcount))
+		if (fp->f_state != FP_INITED)
 			fp = NULL;
+		else {
+			fp->f_state = FP_CLOSED;
+			if (!atomic_dec_and_test(&fp->refcount))
+				fp = NULL;
+		}
 	}
-	read_unlock(&ft->lock);
+	write_unlock(&ft->lock);
 
 	if (!fp)
 		return -EINVAL;
@@ -569,6 +577,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	fp->tcon		= work->tcon;
 	fp->volatile_id		= KSMBD_NO_FID;
 	fp->persistent_id	= KSMBD_NO_FID;
+	fp->f_state		= FP_NEW;
 	fp->f_ci		= ksmbd_inode_get(fp);
 
 	if (!fp->f_ci) {
@@ -590,6 +599,14 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	return ERR_PTR(ret);
 }
 
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state)
+{
+	write_lock(&ft->lock);
+	fp->f_state = state;
+	write_unlock(&ft->lock);
+}
+
 static int
 __close_file_table_ids(struct ksmbd_file_table *ft,
 		       struct ksmbd_tree_connect *tcon,
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index fcb13413fa8d..03d0bf941216 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -60,6 +60,12 @@ struct ksmbd_inode {
 	__le32				m_fattr;
 };
 
+enum {
+	FP_NEW = 0,
+	FP_INITED,
+	FP_CLOSED
+};
+
 struct ksmbd_file {
 	struct file			*filp;
 	u64				persistent_id;
@@ -98,6 +104,7 @@ struct ksmbd_file {
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
+	unsigned int			f_state;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -142,6 +149,8 @@ int ksmbd_close_inode_fds(struct ksmbd_work *work, struct inode *inode);
 int ksmbd_init_global_file_table(void);
 void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
+void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
+			 unsigned int state);
 
 /*
  * INODE hash
-- 
2.25.1


