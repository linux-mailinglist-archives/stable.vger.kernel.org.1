Return-Path: <stable+bounces-254125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHSSF8snFGrfKAcAu9opvQ
	(envelope-from <stable+bounces-254125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:43:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B38545C9536
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AAD4302C0DB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4271360722;
	Mon, 25 May 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="crIl8uzs"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FF36213D;
	Mon, 25 May 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705716; cv=none; b=qyXHQuX1retmW9zKuZ/ExAQF8VuTyyQNreWIJa8eNEh8V57TICJG7MPACfnkPE4Zk4vPghmsAlse3BMfu5PbErleeZFnna8NhX8PslrTJXZ6xImfHT6mgCyej8+pMchsddV8dx6vPa1wzQfHk5VYqKJnSfAptxdV+hLlKdhFdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705716; c=relaxed/simple;
	bh=CMsDg3vvVGtWJvenvgagJtOTfaapo+mBUtzO8Yo1xxc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FTVlkpdsrHJo9GWyoMaTnBFVpfPqjzo9XJ4TQtQaDzyK7ao54gYeytz4Sy0Vkd01HK28RKqNUhfaSh5hX7NtfA71/SfD6oydabXXP++6mb9yo7mU/Z93mfNJcdvrWawV6AmwG7M4uTYithkSnQ0hLPYvx3PByfuwj1j51grGf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=crIl8uzs; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779705710;
	bh=R2atoRMa0cTFaHP9+y4m/W55QgYj+emS7oqkok6Vho4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=crIl8uzs5NbNasUsrOVtD/fak6lHGwrgENdp8TLO2YBd2Oo1WbL0klRn/ZK65LSEZ
	 gfcL3gcjMpV7/2+mdISk36zVITNWeAux3zSQKAj+4wc61JxmJ2wLCQ1a7CMRJ23FFt
	 fMef6UPSHqQqa853P3k8SkObZEo8yjR64bCBGtgI=
Received: from China-team ([183.241.55.175])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A60AAA03; Mon, 25 May 2026 18:41:32 +0800
X-QQ-mid: xmsmtpt1779705707tj0rehjoc
Message-ID: <tencent_731C871F46ACE19476A0C6FEA34672C87A05@qq.com>
X-QQ-XMAILINFO: MJf32pulH481bGVQsT4W28cZC/piyejNc2WO7yzi7xQtFvAlduGtwBn6j39w+A
	 i9yVSqJFE30oz/Y6HmYUmqHSdAfbtDvMCJaFsES1VGX3lOwvd6O/MQ0GaThggpScxWT6QfR8gslZ
	 XqIJCCMH+NK5NyYt0WWgY/AQ78qnbxUL2+GvIlPpqEnFutU3Ra8KPb3VEUv2UW10VBQeOGcbDLcI
	 +A989omle0P2QkiGuuIbC7lE//cb/aFnwLNS6FTqr7ikvO7EaHJ6SYqamW4UrdWx01+7QhdvE36D
	 l3AdOWcUVHuA0f2Bphowfmd+SL74IR4zSPEmfl3H91lA6/kskNerjLg+geV1vIf20H8YLZPaP1r3
	 GZ8Vi7/XvtTgyILiDdppFT+LUv3/AnZacc0DRdfm2RIXVcQUxspXb9I9AfmzHeEw0vIXxfsgNVp2
	 E9SKiM6emdQ2GZvwzGswFyfvoyvQAszTXvIah9durrOjlfjXQGYkiF2za/aT47iDJ7shflbt3jdC
	 TgV5/XkrXrRf5HeoVU3KpGFUG5g7NwSIFnWwzQxBY1VDYqQTIEnRmRvgF9OwyBKHiflI9jB7niME
	 y2WJM/vvFMwq+emAnnsyvo5CYTX/33EkUsiRmlxmPjtRkv9grtScmH9V5m8OdV1PL8l4MTbjVHg/
	 nqw2kQhs5wgoZ2WjilDNBFS71el8D3eqLTi8wTiic2h4AUUpnLwRGTteeRo7M9uN3kUlPKmiNRl4
	 iWbR8W9xUNKQK+gKicolnjID1dnaeLJ/dvQl+J9/vD0sw4vlbwjsf0Ri9Eo7l++gWiHNIAzqTQWK
	 /Hatfn2cbkaQEW2PuGC9d5U7HvBa4S7Rt+NYF7LUtEmyVNmfwMJT2Q6XH1oEBQqFZ4WbPqE/0jYq
	 Peq5Jj3Wj/CGfMhtybOreHgt1/giJQuWmbGUc2aRaotuak/Sc1DDDMMbf6IK1r4FkOlcPnZYzPfc
	 l7dCHrb8t334BIVFTtx8vSyNAGnOhaS7Z1wGmH0OEr7VD8/IbKnQiWEaU+2gzy+3FkygsBX59EBb
	 BuaI0oNK84KH59qHjfP39v1Wv69UXlk6kwi7N/AYnanxgijzdh0DwOdhLXvVNb7cNRJZIrfbPf4r
	 EhnGQtscqkZ/h3KKQjueANZKgL7/GaPkbqIwfW
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v2 3/3] ksmbd: validate owner of durable handle on reconnect
Date: Mon, 25 May 2026 18:41:30 +0800
X-OQ-MSGID: <20260525104130.1252-3-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525104130.1252-1-alvalan9@foxmail.com>
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
 <20260525104130.1252-1-alvalan9@foxmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254125-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B38545C9536
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
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/smb/server/mgmt/user_session.c |  8 +--
 fs/smb/server/oplock.c            |  7 +++
 fs/smb/server/oplock.h            |  1 +
 fs/smb/server/smb2pdu.c           |  3 +-
 fs/smb/server/vfs_cache.c         | 87 +++++++++++++++++++++++++++----
 fs/smb/server/vfs_cache.h         | 12 ++++-
 6 files changed, 103 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index b4a1bd037b9e..d9768f88aabc 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -159,11 +159,10 @@ void ksmbd_session_destroy(struct ksmbd_session *sess)
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
@@ -397,7 +396,8 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 		ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 		goto out;
 	}
-	ksmbd_destroy_file_table(&prev_sess->file_table);
+
+	ksmbd_destroy_file_table(prev_sess);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 	ksmbd_all_conn_set_status(id, KSMBD_SESS_NEED_SETUP);
 	ksmbd_launch_ksmbd_durable_scavenger();
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index c49a75ff5fbb..8487fca425bd 100644
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
index f8da0bba766b..e6c4fbe5cf4e 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -133,5 +133,6 @@ int smb2_check_durable_oplock(struct ksmbd_conn *conn,
 			      struct ksmbd_share_config *share,
 			      struct ksmbd_file *fp,
 			      struct lease_ctx_info *lctx,
+			      struct ksmbd_user *user,
 			      char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 66163a464c56..04d4a784deaf 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2994,7 +2994,8 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		if (dh_info.reconnected == true) {
-			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp,
+					lc, sess->user, name);
 			if (rc) {
 				ksmbd_put_durable_fd(dh_info.fp);
 				goto err_out2;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 913c2a8d2b0e..544387c9a6f4 100644
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
@@ -904,8 +910,62 @@ void ksmbd_stop_durable_scavenger(void)
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
@@ -915,6 +975,9 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	if (!is_reconnectable(fp))
 		return false;
 
+	if (ksmbd_vfs_copy_durable_owner(fp, user))
+		return false;
+
 	conn = fp->conn;
 	ci = fp->f_ci;
 	down_write(&ci->m_lock);
@@ -946,7 +1009,7 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 tree_conn_fd_check);
 
@@ -955,7 +1018,7 @@ void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
 
 void ksmbd_close_session_fds(struct ksmbd_work *work)
 {
-	int num = __close_file_table_ids(&work->sess->file_table,
+	int num = __close_file_table_ids(work->sess,
 					 work->tcon,
 					 session_fd_check);
 
@@ -1052,6 +1115,10 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 	}
 	up_write(&ci->m_lock);
 
+	fp->owner.uid = fp->owner.gid = 0;
+	kfree(fp->owner.name);
+	fp->owner.name = NULL;
+
 	return 0;
 }
 
@@ -1066,12 +1133,14 @@ int ksmbd_init_file_table(struct ksmbd_file_table *ft)
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
index b0f6d0f94cb8..79d85cf4e13b 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -67,6 +67,13 @@ enum {
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
@@ -111,6 +118,7 @@ struct ksmbd_file {
 	bool				is_durable;
 	bool				is_persistent;
 	bool				is_resilient;
+	struct durable_owner		owner;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -137,7 +145,7 @@ static inline bool ksmbd_stream_fd(struct ksmbd_file *fp)
 }
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft);
-void ksmbd_destroy_file_table(struct ksmbd_file_table *ft);
+void ksmbd_destroy_file_table(struct ksmbd_session *sess);
 int ksmbd_close_fd(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_fd_fast(struct ksmbd_work *work, u64 id);
 struct ksmbd_file *ksmbd_lookup_foreign_fd(struct ksmbd_work *work, u64 id);
@@ -163,6 +171,8 @@ void ksmbd_free_global_file_table(void);
 void ksmbd_set_fd_limit(unsigned long limit);
 void ksmbd_update_fstate(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 			 unsigned int state);
+bool ksmbd_vfs_compare_durable_owner(struct ksmbd_file *fp,
+		struct ksmbd_user *user);
 
 /*
  * INODE hash
-- 
2.43.0


