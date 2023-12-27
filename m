Return-Path: <stable+bounces-8607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCE81EE2F
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E971FB21043
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BD2C872;
	Wed, 27 Dec 2023 10:26:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442E2C867
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3966144a12.0
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672803; x=1704277603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0B2RRs2CydUNcrY8Xwuu51cZcfeA984rIHDnRvXMj8=;
        b=BA0WguacqyM/y4qh4ZcB4JZXTjNULNDGdtpL2ESFToEgrSeyp0Wa998gsRZL8BOP8J
         ZYdKHpKBDizaYxcMV4lARpxwLuwqnWcmshkej5Utfl6oMhYMGzVzJPIpLdb3brrc5ttq
         GldSyCCEqjrxnKI/RWwyooZ4zn/M6vZaKLgjTWoiUZ15kVHyoNaMKJnjAl02ZSTZe1cy
         7tQM/wfGbmSaHU43j/ixkv6KuUM3IA1+xsdSgyu29W3fxBSR9g3Z4fIRoblIxk0b+tDv
         nHg4PfIKZfob2JvZYQE0glOq34s2zowtFoayAGYOVLKfJBPdYIvI/jZWXAda2l1VDvN0
         ardg==
X-Gm-Message-State: AOJu0YxzBQlIk6vlAKqv9GadD5qth64Nrk46DLJG4BvtV2uujopIeyF2
	hD00VJPZpAYIIG6yhr4mLww=
X-Google-Smtp-Source: AGHT+IEB/YB+PLxnnuCYfBrCA9VjFB0u1JZeLjhrqhWeCZ9vz5gDo/gkNZOtfPd91qNFotNrYjoJRg==
X-Received: by 2002:a05:6a20:3c90:b0:196:21e2:d0f6 with SMTP id b16-20020a056a203c9000b0019621e2d0f6mr851231pzj.60.1703672803588;
        Wed, 27 Dec 2023 02:26:43 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:43 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH v2 5.15.y 5/8] ksmbd: send v2 lease break notification for directory
Date: Wed, 27 Dec 2023 19:26:02 +0900
Message-Id: <20231227102605.4766-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d47d9886aeef79feba7adac701a510d65f3682b5 ]

If client send different parent key, different client guid, or there is
no parent lease key flags in create context v2 lease, ksmbd send lease
break to client.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c    | 56 ++++++++++++++++++++++++++++++++++++++++----
 fs/ksmbd/oplock.h    |  4 ++++
 fs/ksmbd/smb2pdu.c   |  7 ++++++
 fs/ksmbd/smb2pdu.h   |  1 +
 fs/ksmbd/vfs_cache.c | 13 +++++++++-
 fs/ksmbd/vfs_cache.h |  2 ++
 6 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 600312e2c6c2..df6f00f58f19 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -102,6 +102,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 	lease->new_state = 0;
 	lease->flags = lctx->flags;
 	lease->duration = lctx->duration;
+	lease->is_dir = lctx->is_dir;
 	memcpy(lease->parent_lease_key, lctx->parent_lease_key, SMB2_LEASE_KEY_SIZE);
 	lease->version = lctx->version;
 	lease->epoch = le16_to_cpu(lctx->epoch);
@@ -543,12 +544,13 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
-				if (lease->state ==
-				    (lctx->req_state & lease->state)) {
+				if (lease->state != SMB2_LEASE_NONE_LE &&
+				    lease->state == (lctx->req_state & lease->state)) {
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
 						lease_read_to_write(opinfo);
+
 				}
 			} else if ((atomic_read(&ci->op_count) +
 				    atomic_read(&ci->sop_count)) > 1) {
@@ -900,7 +902,8 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 			} else {
-				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE &&
+						!lease->is_dir)
 					lease->new_state =
 						SMB2_LEASE_READ_CACHING_LE;
 				else
@@ -1082,6 +1085,48 @@ static void set_oplock_level(struct oplock_info *opinfo, int level,
 	}
 }
 
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	struct ksmbd_inode *p_ci = NULL;
+
+	if (lctx->version != 2)
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
+		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
+		    (!(lctx->flags & SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE) ||
+		     !compare_guid_key(opinfo, fp->conn->ClientGUID,
+				      lctx->parent_lease_key))) {
+			if (!atomic_inc_not_zero(&opinfo->refcount))
+				continue;
+
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				continue;
+			}
+
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
@@ -1420,10 +1465,11 @@ struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		if (is_dir)
+		if (is_dir) {
 			lreq->req_state = lc->lcontext.LeaseState &
 				~SMB2_LEASE_WRITE_CACHING_LE;
-		else
+			lreq->is_dir = true;
+		} else
 			lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 672127318c75..b64d1536882a 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -36,6 +36,7 @@ struct lease_ctx_info {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	__le16			epoch;
 	int			version;
+	bool			is_dir;
 };
 
 struct lease_table {
@@ -54,6 +55,7 @@ struct lease {
 	__u8			parent_lease_key[SMB2_LEASE_KEY_SIZE];
 	int			version;
 	unsigned short		epoch;
+	bool			is_dir;
 	struct lease_table	*l_lb;
 };
 
@@ -125,4 +127,6 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
+void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
+				      struct lease_ctx_info *lctx);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 6a3cd6ea3af1..c1dde4204366 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3222,6 +3222,13 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			/*
+			 * Compare parent lease using parent key. If there is no
+			 * a lease that has same parent key, Send lease break
+			 * notification.
+			 */
+			smb_send_parent_lease_break_noti(fp, lc);
+
 			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
 			ksmbd_debug(SMB,
 				    "lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index e1d0849ee68f..912bd94257ec 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -737,6 +737,7 @@ struct create_posix_rsp {
 #define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
 
 #define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+#define SMB2_LEASE_FLAG_PARENT_LEASE_KEY_SET_LE	cpu_to_le32(0x04)
 
 #define SMB2_LEASE_KEY_SIZE			16
 
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 774a387fccce..2528ce8aeebb 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -86,6 +86,17 @@ static struct ksmbd_inode *ksmbd_inode_lookup(struct ksmbd_file *fp)
 	return __ksmbd_inode_lookup(fp->filp->f_path.dentry);
 }
 
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d)
+{
+	struct ksmbd_inode *ci;
+
+	read_lock(&inode_hash_lock);
+	ci = __ksmbd_inode_lookup(d);
+	read_unlock(&inode_hash_lock);
+
+	return ci;
+}
+
 int ksmbd_query_inode_status(struct dentry *dentry)
 {
 	struct ksmbd_inode *ci;
@@ -198,7 +209,7 @@ static void ksmbd_inode_free(struct ksmbd_inode *ci)
 	kfree(ci);
 }
 
-static void ksmbd_inode_put(struct ksmbd_inode *ci)
+void ksmbd_inode_put(struct ksmbd_inode *ci)
 {
 	if (atomic_dec_and_test(&ci->m_count))
 		ksmbd_inode_free(ci);
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 8325cf4527c4..4d4938d6029b 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -138,6 +138,8 @@ struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 					u64 pid);
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
+void ksmbd_inode_put(struct ksmbd_inode *ci);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
-- 
2.25.1


