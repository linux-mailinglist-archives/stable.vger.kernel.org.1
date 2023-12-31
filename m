Return-Path: <stable+bounces-9079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93908820A20
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207481F22135
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4B17C2;
	Sun, 31 Dec 2023 07:16:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B1185D
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc00dbb560so2433855a34.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006980; x=1704611780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQYxKyBNeGLJCPD4K84244+rf3j1oqGCpyqRzta6raU=;
        b=gyPiLiZ5uMD7t7muPvyTv2j34MciDNGrK6Au6o38hv3ZTPovhtd2PZIyqMFnw9cB3B
         fwpaa4xKqGOTQJFrgTUPKbpJZO0ppijeQf8iKmAMJRO5r5WAd/zgIiFM4T1ZfelPmlVZ
         ZTtw/jg9905fmqMYKB6LyBEmxK8DESLJJuoiodoS6ZVygOQSQ/27IdcpEZEgTD0HsH+q
         UcInvX0m1uO4fYtOIMp8iypSCFYt1T8i1T7GSvUCXVmZjPHN55oGqY7y+T5fA+e8S8Uh
         rD7kd18G1NuuGOaH3qmeEWyAKoftVYZL+dhpDy51VehvPIyWXo5pKIqsV356ZsPBXKWb
         KgjQ==
X-Gm-Message-State: AOJu0YwdOG2ii186TqUdIXpPkVaKN1Phxd3LtCH6zEjVWUCcrHmQFvfL
	HtQMz6dsV0txToB5fJTWwXU=
X-Google-Smtp-Source: AGHT+IG9JaMzD6KvfeI96Hy631QfP1rNvOrkZl2TAZ3Yqn6lAc95tJKG7gQ7BHnsYO3t1loozVgrWA==
X-Received: by 2002:a05:6808:1389:b0:3bb:caca:a8e6 with SMTP id c9-20020a056808138900b003bbcacaa8e6mr8487142oiw.28.1704006980614;
        Sat, 30 Dec 2023 23:16:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:20 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 45/73] ksmbd: fix race condition with fp
Date: Sun, 31 Dec 2023 16:13:04 +0900
Message-Id: <20231231071332.31724-46-linkinjeon@kernel.org>
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
 fs/smb/server/smb2pdu.c   |  4 +++-
 fs/smb/server/vfs_cache.c | 23 ++++++++++++++++++++---
 fs/smb/server/vfs_cache.h |  9 +++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3c53f0e9b59a..94213d0fd95f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3370,8 +3370,10 @@ int smb2_open(struct ksmbd_work *work)
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
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 94ad8fa07b46..f600279b0a9e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
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
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index fcb13413fa8d..03d0bf941216 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
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


