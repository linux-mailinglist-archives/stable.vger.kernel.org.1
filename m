Return-Path: <stable+bounces-9105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39998820A3A
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B81C1C215FE
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017817C3;
	Sun, 31 Dec 2023 07:17:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAA917C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbca115636so4928447a34.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007068; x=1704611868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTAfBL+N/VBHo5/CEnatBO/fmE3/tmA1of91bDShWwU=;
        b=WOABKYXPY3OyQMlOGjNXE3UFTAX0438WiW7S3F0SmPKiD7nJGH+VeXtJ7M7HH2D6p9
         9gmxN5OxzZgzfwxo52rFBPq7/1Uy9d19jvpMvZDQx7jsRu+jzKaOIKtE6x48RJfgTZd0
         Ur3EwiqF5uO2nguDmucgLskPGD68T1PGdku5DvfY9yzgvdQ1fs1THeefiS7240mXJv6J
         pKz3dqudzfFEtc3mk2fRdy9Kp3wf12/GgRXTGvhKnzFOuCJfKEIP9iVkbeDAh2wudVtt
         uy/QpKy9sjkrKCC8JlGT4+0M14h/nM3fdSpc4Q8k1GK06U+24aWKxqg+mCj7JklxXX8r
         srvg==
X-Gm-Message-State: AOJu0YyjCKmpbQbENQdlp2+Su5KyX6m43zVnt9Fb6RgNrlMBCJ0agm/O
	lIk6opsnO/I5KHdMdayhLZA=
X-Google-Smtp-Source: AGHT+IGVnLq2gQOwNNiV2smW89gCttgWRw0nqBL/KAbQvOc1UzEEcuafg+hkANMvBkRTtgK/8zuxsw==
X-Received: by 2002:a05:6808:e8e:b0:3bb:ed04:f3d4 with SMTP id k14-20020a0568080e8e00b003bbed04f3d4mr3244844oil.36.1704007068586;
        Sat, 30 Dec 2023 23:17:48 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:48 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 71/73] ksmbd: lazy v2 lease break on smb2_write()
Date: Sun, 31 Dec 2023 16:13:30 +0900
Message-Id: <20231231071332.31724-72-linkinjeon@kernel.org>
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

[ Upstream commit c2a721eead71202a0d8ddd9b56ec8dce652c71d1 ]

Don't immediately send directory lease break notification on smb2_write().
Instead, It postpones it until smb2_close().

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c    | 45 +++++++++++++++++++++++++++++++++++++--
 fs/smb/server/oplock.h    |  1 +
 fs/smb/server/vfs.c       |  3 +++
 fs/smb/server/vfs_cache.h |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 4a8745b3e830..af0f6914eca4 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -396,8 +396,8 @@ void close_id_del_oplock(struct ksmbd_file *fp)
 {
 	struct oplock_info *opinfo;
 
-	if (S_ISDIR(file_inode(fp->filp)->i_mode))
-		return;
+	if (fp->reserve_lease_break)
+		smb_lazy_parent_lease_break_close(fp);
 
 	opinfo = opinfo_get(fp);
 	if (!opinfo)
@@ -1127,6 +1127,47 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 	ksmbd_inode_put(p_ci);
 }
 
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	rcu_read_unlock();
+
+	if (!opinfo->is_lease || opinfo->o_lease->version != 2)
+		return;
+
+	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
+	if (!p_ci)
+		return;
+
+	read_lock(&p_ci->m_lock);
+	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+			read_unlock(&p_ci->m_lock);
+			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
+			opinfo_conn_put(opinfo);
+			read_lock(&p_ci->m_lock);
+		}
+	}
+	read_unlock(&p_ci->m_lock);
+
+	ksmbd_inode_put(p_ci);
+}
+
 /**
  * smb_grant_oplock() - handle oplock/lease request on file open
  * @work:		smb work
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index b64d1536882a..5b93ea9196c0 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -129,4 +129,5 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 void destroy_lease_table(struct ksmbd_conn *conn);
 void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				      struct lease_ctx_info *lctx);
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 42f270ee399c..fe2c80ea2e47 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -518,6 +518,9 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		}
 	}
 
+	/* Reserve lease break for parent dir at closing time */
+	fp->reserve_lease_break = true;
+
 	/* Do we need to break any of a levelII oplock? */
 	smb_break_all_levII_oplock(work, fp, 1);
 
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 4d4938d6029b..a528f0cc775a 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -105,6 +105,7 @@ struct ksmbd_file {
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
 	unsigned int			f_state;
+	bool				reserve_lease_break;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
-- 
2.25.1


