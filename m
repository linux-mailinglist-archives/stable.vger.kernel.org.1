Return-Path: <stable+bounces-253703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPOFFB8GEGqLSQYAu9opvQ
	(envelope-from <stable+bounces-253703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:30:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A9C5B0023
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A3443010BB8
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE1348C6B;
	Fri, 22 May 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="S845sud2"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313D3905EF;
	Fri, 22 May 2026 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434746; cv=none; b=Qaq++78/NSA0+9JauOCCccKxVCO0E4m+LAWPMR/r3I6O+Nx+5Hk4rWfZoK6WpPgmKKSWOUM85YZQG1hIHhd5l4BH7+UilE2Sw8y4VmnkXyaXsG7n6QT7iHd/wGQ4t4vELRZihqcpyHGk9b262PzCQcHrLG/nbVDYjDlY3FaSSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434746; c=relaxed/simple;
	bh=fr1yRPh65coXQhJQgCUEuDtGYjBBMQxD6k3LHq9zJxE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bjgJb1CF3wbt7efp/qBKJ/YJJs0/zYZ/sCNf4jlsT4bIfURwXzbWpPpFpUepSJCLB9NJvRKET8vTURskDd8Dzgf6R+lA5JAn1oZfzuEkAW66kaAxm5JWkVH42nOsykIBhjEpxvY0GQNFIGohs39z+ert96YEnEitklY+UVAAbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=S845sud2; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779434733;
	bh=ZV5Ah4MrTcFyU8FezRZSMfzlfA5TjwIwXCIuA8ZvC3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S845sud23QN2G9UBnCLZeoyiNc4m4kdpDaixNMt7ROIACwOFs9qx1aYNgmJwGFP/m
	 +gs2pT3iKRAU4YgPn3S0rZR6sYbw305Yjh5i+Vf2X/iQsJA5uf70R4j64SOqtsGIF4
	 mIwVneCeucZ71eTR+4Qo8CkOU0iJvGJ9oucZN/MU=
Received: from China-team ([120.244.195.95])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 650A5A34; Fri, 22 May 2026 15:25:16 +0800
X-QQ-mid: xmsmtpt1779434716tlyf1kxrp
Message-ID: <tencent_37EC3410D226D49C7C304BCE596FE0CCC30A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XW6tuVU+M8KacpvHYuKYeUcq8aee8oKbxu0rG4O6sTQIT6KbMQX
	 qQGSoPOOxifXuWmP91qDTiucbv2hfnRNbXAZrWFEb7FAgipV8g8zzjuHNPZcCGmO8MQXOYVf/9ci
	 oFm97RsRQ3vJLrFRXwAQkuo/bu7uuPMn5RKPNVgqjH8XXHr2jGAUrm8GPnBTrWctbXZgVzORGq+I
	 wnXYwGOvYLZEkTj8J1NNcOv65gJ0/QVA2FR8VNMmZfEwJa5PUL5lbU1IfVrAthNyNOCl91qpzBYN
	 5/ZUeca24X7AXk/xQqaP0RwIkvTRVlmu1h0K1fc9T0gBPRXfWLM5GLnpjqmcN8odTe/uNfc5l8jd
	 9hjTWwPZg+pY5RkABdtjQYpf3LNXMqBNGGcnc2MOGkf0AoUuMFmFEulOIneKlmV/6Bd+pLz/hiAd
	 1jiGYbRf6Yu3IA2huYHlEzWKyXi9Ab0DOiOfQK7ktLt6O3pevAE0dfFVu6LwHWoQ7T1K9BAXRA2L
	 6sWcXx3GTDG58UXR7kLaQFPtgsZD5rw7wo96AWjTbOaZhrZAiSgZBuWLyVtWsntN9mKBB+SVoJeP
	 NwQi/4MnRUSgMliVPJR0mTBSeXf/xv8epMBn7VDg/BvMQJTyiJfPW/ryltySuhX5b9/SPLNFVAwE
	 FaAP5YO2GrwzBBUaRrspzRXgRyHaAiw4ESq4traFZigop50h/I9B+I3kBiBGj49FgdVT2HjD9OrP
	 hNPFGDoHo6V+QzxkT2TsPZtWSFdXV1ffG1bI+W+nRBnASirj9xkgZLiZeNPZ0U8CSizb1QZrhmCk
	 l+0osnoHg7QlUQtSi4SZTzvrjSBEVXy6oXXgyg6qqNylJdxIfreSaBaQaGBFfVsCTi+/pkA/zH/z
	 QDLGS92mCykRA5G014qOD+39acyizMpBFMZkl6qMjq2lZSxN0gzMVuFOKpDYACFZL3ze+EpxJVrT
	 yk3vI+zg1huHngIToJxBQw5y8Rx3muXat2fn4XL1RR+kkJljrZLpQyMA0XkBPDwtDw9mKfvBXfs6
	 avNcaFi+6yBi83zf20s0dIo8NGCVV2WK7z/LlZ98HuQuqU+upcIVDyflvYcc3slwcidJY3f13ymC
	 DMTn+sdN1b9E1TVORpakHLYcUys3yxANtB6oqQyE7GFO0L9i4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	alvalan9@foxmail.com
Subject: [PATCH 6.12.y 1/1] ksmbd: validate owner of durable handle on reconnect
Date: Fri, 22 May 2026 15:25:12 +0800
X-OQ-MSGID: <20260522072512.1155-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_0E921F0C9250D64D384E305D0D4EB46C3508@qq.com>
References: <tencent_0E921F0C9250D64D384E305D0D4EB46C3508@qq.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253703-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,foxmail.com:email,foxmail.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: A7A9C5B0023
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
 fs/smb/server/mgmt/user_session.c |  7 ++-
 fs/smb/server/oplock.c            |  7 +++
 fs/smb/server/oplock.h            |  1 +
 fs/smb/server/smb2pdu.c           |  3 +-
 fs/smb/server/vfs_cache.c         | 87 +++++++++++++++++++++++++++----
 fs/smb/server/vfs_cache.h         | 12 ++++-
 6 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 352cf9e47ebe..1e3d76e93335 100644
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
index 590ddd31a68d..bbb2cb3782d0 100644
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
index 921e3199e4df..d91a8266e065 100644
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
index 29fbdada7259..cb6be1948e59 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3014,7 +3014,8 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		if (dh_info.reconnected == true) {
-			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp,
+					lc, sess->user, name);
 			if (rc) {
 				ksmbd_put_durable_fd(dh_info.fp);
 				goto err_out2;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 08f25a2d7541..d29cc1d01bd2 100644
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
index 5bbb179736c2..1b2a947490ca 100644
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


