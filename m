Return-Path: <stable+bounces-239949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HpgOEdp5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1B432582
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25872304948A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663734CFA1;
	Mon, 20 Apr 2026 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WACV5liB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC534DB56
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703137; cv=none; b=gTGS4MU5k0/r4lz2wR01L5sTK6Xyeg7WYXDQdI19pdE3gHS9m79YQIBJg4+hlI1U2RZNUzAD3C9S7XvCqy7qTYFNPmvOva064bUp+/b65/F9Eq0Y1p5cJClGq2fUqlh46cX1B23cW+dir+pV4fX6ph+HSitnMzczImqqNEzGjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703137; c=relaxed/simple;
	bh=GUtrb9/tnSofrhtafnLXSNqr56SXhWK4iSgzY4PnI30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4JjeMJBqpmEbJFO2M1R4h/ZpPj1qMUKSLugG5iJHp9kKpP0gil2RLIs21cnNBv6qUSwXcDQMO94rtoR7iedFnntGQrJXI/ttDlk2FJiI2ex+4FCmHpYATOLkn4pdzKsri0Da7u4n+98agdSAAsITwhsUxC+AE1Q7a3IB9Y/W8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WACV5liB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB12C19425;
	Mon, 20 Apr 2026 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776703137;
	bh=GUtrb9/tnSofrhtafnLXSNqr56SXhWK4iSgzY4PnI30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WACV5liBmpapfx34okkKwGQwKrIu20ILJbQbRxXUTnLhQeXwDqa/OmAT5Gx6vLb5U
	 JuGt+vGPFElQvEsTnmRTHIKKcclZ81cHQj8Lt/jZ6tlfHFDI3ohGtme4K36PPxMkWd
	 leUaZPBiB9lv0ImQdKDowtwcaW2XTUnOot1kVAaF+D8j8I3kaB8rHFtwtbFK1OS3UZ
	 QZd/QsZRu/D3UXMl1FjwwJ6FZt+muHjdMJ5qe3rUnmfuXyZaQ99WZUhnRw7lJrPjnf
	 ysztbwAMd1OSIljHBj7gL5gZ9gJ1lvZ9CV5ykhEI5IxR+hMYsAB8b9x82kzLfJ2OO2
	 KyE2MPYhdpP0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Davide Ornaghi <d.ornaghi97@gmail.com>,
	Navaneeth K <knavaneeth786@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ksmbd: validate owner of durable handle on reconnect
Date: Mon, 20 Apr 2026 12:38:54 -0400
Message-ID: <20260420163854.1302592-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420163854.1302592-1-sashal@kernel.org>
References: <2026042009-snarl-stagnant-e64b@gregkh>
 <20260420163854.1302592-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,microsoft.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-239949-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DC1B432582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 49110a8ce654bbe56bef7c5e44cce31f4b102b8a ]

Currently, ksmbd does not verify if the user attempting to reconnect
to a durable handle is the same user who originally opened the file.
This allows any authenticated user to hijack an orphaned durable handle
by predicting or brute-forcing the persistent ID.

According to MS-SMB2, the server MUST verify that the SecurityContext
of the reconnect request matches the SecurityContext associated with
the existing open.
Add a durable_owner structure to ksmbd_file to store the original opener's
UID, GID, and account name. and catpure the owner information when a file
handle becomes orphaned. and implementing ksmbd_vfs_compare_durable_owner()
to validate the identity of the requester during SMB2_CREATE (DHnC).

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Reported-by: Davide Ornaghi <d.ornaghi97@gmail.com>
Reported-by: Navaneeth K <knavaneeth786@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/user_session.c |  7 ++-
 fs/smb/server/oplock.c            |  7 +++
 fs/smb/server/oplock.h            |  1 +
 fs/smb/server/smb2pdu.c           |  3 +-
 fs/smb/server/vfs_cache.c         | 87 +++++++++++++++++++++++++++----
 fs/smb/server/vfs_cache.h         | 12 ++++-
 6 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 26cb87625f1c6..ed343807660fa 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -161,11 +161,10 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
 	if (!sess)
 		return;
 
+	ksmbd_tree_conn_session_logoff(sess);
+	ksmbd_destroy_file_table(sess);
 	if (sess->user)
 		ksmbd_free_user(sess->user);
-
-	ksmbd_tree_conn_session_logoff(sess);
-	ksmbd_destroy_file_table(&sess->file_table);
 	ksmbd_launch_ksmbd_durable_scavenger();
 	ksmbd_session_rpc_clear_list(sess);
 	free_channel_list(sess);
@@ -396,7 +395,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	ksmbd_destroy_file_table(&prev_sess->file_table);
+	ksmbd_destroy_file_table(prev_sess);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 	ksmbd_launch_ksmbd_durable_scavenger();
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 590ddd31a68da..bbb2cb3782d0c 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1841,6 +1841,7 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 			      struct ksmbd_share_config *share,
 			      struct ksmbd_file *fp,
 			      struct lease_ctx_info *lctx,
+			      struct ksmbd_user *user,
 			      char *name)
 {
 	struct oplock_info *opinfo = opinfo_get(fp);
@@ -1849,6 +1850,12 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 	if (!opinfo)
 		return 0;
 
+	if (ksmbd_vfs_compare_durable_owner(fp, user) == false) {
+		ksmbd_debug(SMB, "Durable handle reconnect failed: owner mismatch\n");
+		ret = -EBADF;
+		goto out;
+	}
+
 	if (opinfo->is_lease == false) {
 		if (lctx) {
 			pr_err("create context include lease\n");
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 921e3199e4df4..d91a8266e065e 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -126,5 +126,6 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 			      struct ksmbd_share_config *share,
 			      struct ksmbd_file *fp,
 			      struct lease_ctx_info *lctx,
+			      struct ksmbd_user *user,
 			      char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c10c4e0756d22..7d0d8a419ca4f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3022,7 +3022,8 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		if (dh_info.reconnected == true) {
-			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp,
+					lc, sess->user, name);
 			if (rc) {
 				ksmbd_put_durable_fd(dh_info.fp);
 				goto err_out2;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 08f25a2d75416..d29cc1d01bd2c 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -18,6 +18,7 @@
 #include "connection.h"
 #include "mgmt/tree_connect.h"
 #include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
 #include "smb_common.h"
 #include "server.h"
 
@@ -383,6 +384,8 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
+	kfree(fp->owner.name);
+
 	kmem_cache_free(filp_cache, fp);
 }
 
@@ -694,11 +697,13 @@ void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 }
 
 static int
-__close_file_table_ids(struct ksmbd_file_table *ft,
+__close_file_table_ids(struct ksmbd_session *sess,
 		       struct ksmbd_tree_connect *tcon,
 		       bool (*skip)(struct ksmbd_tree_connect *tcon,
-				    struct ksmbd_file *fp))
+				    struct ksmbd_file *fp,
+				    struct ksmbd_user *user))
 {
+	struct ksmbd_file_table *ft = &sess->file_table;
 	struct ksmbd_file *fp;
 	unsigned int id = 0;
 	int num = 0;
@@ -711,7 +716,7 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 			break;
 		}
 
-		if (skip(tcon, fp) ||
+		if (skip(tcon, fp, sess->user) ||
 		    !atomic_dec_and_test(&fp->refcount)) {
 			id++;
 			write_unlock(&ft->lock);
@@ -763,7 +768,8 @@ static inline bool is_reconnectable(struct ksmbd_file *fp)
 }
 
 static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
-			       struct ksmbd_file *fp)
+			       struct ksmbd_file *fp,
+			       struct ksmbd_user *user)
 {
 	return fp->tcon != tcon;
 }
@@ -898,8 +904,62 @@ void ksmbd_stop_durable_scavenger(void)
 	kthread_stop(server_conf.dh_task);
 }
 
+/*
+ * ksmbd_vfs_copy_durable_owner - Copy owner info for durable reconnect
+ * @fp: ksmbd file pointer to store owner info
+ * @user: user pointer to copy from
+ *
+ * This function binds the current user's identity to the file handle
+ * to satisfy MS-SMB2 Step 8 (SecurityContext matching) during reconnect.
+ *
+ * Return: 0 on success, or negative error code on failure
+ */
+static int ksmbd_vfs_copy_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user)
+{
+	if (!user)
+		return -EINVAL;
+
+	/* Duplicate the user name to ensure identity persistence */
+	fp->owner.name = kstrdup(user->name, GFP_KERNEL);
+	if (!fp->owner.name)
+		return -ENOMEM;
+
+	fp->owner.uid = user->uid;
+	fp->owner.gid = user->gid;
+
+	return 0;
+}
+
+/**
+ * ksmbd_vfs_compare_durable_owner - Verify if the requester is original owner
+ * @fp: existing ksmbd file pointer
+ * @user: user pointer of the reconnect requester
+ *
+ * Compares the UID, GID, and name of the current requester against the
+ * original owner stored in the file handle.
+ *
+ * Return: true if the user matches, false otherwise
+ */
+bool ksmbd_vfs_compare_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user)
+{
+	if (!user || !fp->owner.name)
+		return false;
+
+	/* Check if the UID and GID match first (fast path) */
+	if (fp->owner.uid != user->uid || fp->owner.gid != user->gid)
+		return false;
+
+	/* Validate the account name to ensure the same SecurityContext */
+	if (strcmp(fp->owner.name, user->name))
+		return false;
+
+	return true;
+}
+
 static bool session_fd_check(struct ksmbd_tree_connect *tcon,
-			     struct ksmbd_file *fp)
+			     struct ksmbd_file *fp, struct ksmbd_user *user)
 {
 	struct ksmbd_inode *ci;
 	struct oplock_info *op;
@@ -909,6 +969,9 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	if (!is_reconnectable(fp))
 		return false;
 
+	if (ksmbd_vfs_copy_durable_owner(fp, user))
+		return false;
+
 	conn = fp->conn;
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
@@ -940,7 +1003,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 tree_conn_fd_check);
 
@@ -949,7 +1012,7 @@ void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 
 void ksmbd_close_session_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 session_fd_check);
 
@@ -1046,6 +1109,10 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 	up_write(&ci->m_lock);
 
+	fp->owner.uid = fp->owner.gid = 0;
+	kfree(fp->owner.name);
+	fp->owner.name = NULL;
+
 	return 0;
 }
 
@@ -1060,12 +1127,14 @@ int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 	return 0;
 }
 
-void ksmbd_destroy_file_table(struct ksmbd_file_table *ft)
+void ksmbd_destroy_file_table(struct ksmbd_session *sess)
 {
+	struct ksmbd_file_table *ft = &sess->file_table;
+
 	if (!ft->idr)
 		return;
 
-	__close_file_table_ids(ft, NULL, session_fd_check);
+	__close_file_table_ids(sess, NULL, session_fd_check);
 	idr_destroy(ft->idr);
 	kfree(ft->idr);
 	ft->idr = NULL;
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 78b506c5ef03b..866f32c10d4dd 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -68,6 +68,13 @@ enum {
 	FP_CLOSED
 };
 
+/* Owner information for durable handle reconnect */
+struct durable_owner {
+	unsigned int uid;
+	unsigned int gid;
+	char *name;
+};
+
 struct ksmbd_file {
 	struct file			*filp;
 	u64				persistent_id;
@@ -114,6 +121,7 @@ struct ksmbd_file {
 	bool				is_resilient;
 
 	bool                            is_posix_ctxt;
+	struct durable_owner		owner;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -140,7 +148,7 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
 }
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft);
-void ksmbd_destroy_file_table(struct ksmbd_file_table *ft);
+void ksmbd_destroy_file_table(struct ksmbd_session *sess);
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
@@ -166,6 +174,8 @@ void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
 void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 			 unsigned int state);
+bool ksmbd_vfs_compare_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user);
 
 /*
  * INODE hash
-- 
2.53.0


