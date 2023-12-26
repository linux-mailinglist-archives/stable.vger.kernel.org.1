Return-Path: <stable+bounces-8581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553781E700
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AB728300E
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE884CE1F;
	Tue, 26 Dec 2023 10:54:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BF4E1A1
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5943a178d57so1853870eaf.1
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588060; x=1704192860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYm3czAFr77uIyMWVWlizeaYvVGECIZcxtScat+MfjM=;
        b=LWtRYI7TnGHMmFE4U6HIeDr42C3fRtRzaIYZTzlHe/C0L4unTH9mrpOly9oyolFaET
         M2WJVXwnF1wUp7dDFgxnBwDNJPlxwz46ZqmmmHJNsi4S1WqNgWlXSNqRgynpKUsuIuhC
         ax6DBslLdMNO2L12wM67dWtkfn1nwg+r6nBrDnNTFzrZaOCJlalMZr0ZVz+W/7Rs6aY4
         DoVxvBODx6Laf7raEEOD6sUD/1kDJrYiqG7BG7QFgAtk3beE50YKlVT+CRHUtmIBCalD
         htHD1MSQUv1BBx8yfpUDxCWYZrcu0zHnO/erVGj9/M66FCabjWUVSCtX39IuMzaQt+V6
         8pYQ==
X-Gm-Message-State: AOJu0YwOLo9+KlkNdTOiZalbT2fkNavOYzur3UfSRzGmQXINg8rTwgCS
	3DSi1IqUJGUzH0oTWyQcjEU=
X-Google-Smtp-Source: AGHT+IFQombqigdhRnHLT37hhblwUiMBFMA0EEwewwPugDECKfFVLCSAh+IzvOg3gzDC57+sODKORw==
X-Received: by 2002:a05:6358:9141:b0:170:c36a:a2ad with SMTP id r1-20020a056358914100b00170c36aa2admr5020833rwr.36.1703588059990;
        Tue, 26 Dec 2023 02:54:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 6/8] ksmbd: lazy v2 lease break on smb2_write()
Date: Tue, 26 Dec 2023 19:53:31 +0900
Message-Id: <20231226105333.5150-7-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
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
 fs/ksmbd/oplock.c    | 45 ++++++++++++++++++++++++++++++++++++++++++--
 fs/ksmbd/oplock.h    |  1 +
 fs/ksmbd/vfs.c       |  3 +++
 fs/ksmbd/vfs_cache.h |  1 +
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index df6f00f58f19..2da256259722 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
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
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index b64d1536882a..5b93ea9196c0 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -129,4 +129,5 @@ int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 void destroy_lease_table(struct ksmbd_conn *conn);
 void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				      struct lease_ctx_info *lctx);
+void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index a89529b21c86..173a488bfeee 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -517,6 +517,9 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		}
 	}
 
+	/* Reserve lease break for parent dir at closing time */
+	fp->reserve_lease_break = true;
+
 	/* Do we need to break any of a levelII oplock? */
 	smb_break_all_levII_oplock(work, fp, 1);
 
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 4d4938d6029b..a528f0cc775a 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -105,6 +105,7 @@ struct ksmbd_file {
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
 	unsigned int			f_state;
+	bool				reserve_lease_break;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
-- 
2.25.1


