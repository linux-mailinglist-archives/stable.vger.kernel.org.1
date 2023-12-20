Return-Path: <stable+bounces-8067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67CA81A465
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D51F26AAB
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194948789;
	Wed, 20 Dec 2023 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYnqbGHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5648786;
	Wed, 20 Dec 2023 16:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEB1C433C7;
	Wed, 20 Dec 2023 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088817;
	bh=XQxt7+J5VyGZnSiZJqcIA3Lyd2Ylnnem4jLQu4wKMfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYnqbGHuhsw9BrFzoBm+bqV2tRIEKrXjwYiUcgJEJMcXJ3PJyT7tPrfFtrnraAbpW
	 HYjC3rwEZeQ8EZm6HlzJfuJa7WeyEQWXPLZtqYh3jWonPOMhyMm7KsjjYY/7jtK+Qo
	 m1xdiQc7ekFsWLxCWhdqFtpWi91N+FsMlgXytQRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 070/159] ksmbd: Implements sess->ksmbd_chann_list as xarray
Date: Wed, 20 Dec 2023 17:08:55 +0100
Message-ID: <20231220160934.633061439@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Li <set_pte_at@outlook.com>

[ Upstream commit 1d9c4172110e645b383ff13eee759728d74f1a5d ]

For some ops on channel:
1. lookup_chann_list(), possibly on high frequency.
2. ksmbd_chann_del().

Connection is used as indexing key to lookup channel, in that case,
linear search based on list may suffer a bit for performance.

Implements sess->ksmbd_chann_list as xarray.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/mgmt/user_session.c |   59 ++++++++++++++++---------------------------
 fs/ksmbd/mgmt/user_session.h |    4 --
 fs/ksmbd/smb2pdu.c           |   34 +++---------------------
 3 files changed, 29 insertions(+), 68 deletions(-)

--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -30,15 +30,15 @@ struct ksmbd_session_rpc {
 
 static void free_channel_list(struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
+	unsigned long index;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		list_del(&chann->chann_list);
+	xa_for_each(&sess->ksmbd_chann_list, index, chann) {
+		xa_erase(&sess->ksmbd_chann_list, index);
 		kfree(chann);
 	}
-	write_unlock(&sess->chann_lock);
+
+	xa_destroy(&sess->ksmbd_chann_list);
 }
 
 static void __session_rpc_close(struct ksmbd_session *sess,
@@ -190,21 +190,15 @@ int ksmbd_session_register(struct ksmbd_
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
+	struct channel *chann;
 
-	write_lock(&sess->chann_lock);
-	list_for_each_entry_safe(chann, tmp, &sess->ksmbd_chann_list,
-				 chann_list) {
-		if (chann->conn == conn) {
-			list_del(&chann->chann_list);
-			kfree(chann);
-			write_unlock(&sess->chann_lock);
-			return 0;
-		}
-	}
-	write_unlock(&sess->chann_lock);
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
+
+	kfree(chann);
 
-	return -ENOENT;
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
@@ -234,7 +228,7 @@ void ksmbd_sessions_deregister(struct ks
 	return;
 
 sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
+	if (xa_empty(&sess->ksmbd_chann_list)) {
 		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
@@ -320,6 +314,9 @@ static struct ksmbd_session *__session_c
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -329,30 +326,20 @@ static struct ksmbd_session *__session_c
 
 	set_session_flag(sess, protocol);
 	xa_init(&sess->tree_conns);
-	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	xa_init(&sess->ksmbd_chann_list);
 	INIT_LIST_HEAD(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
-	rwlock_init(&sess->chann_lock);
-
-	switch (protocol) {
-	case CIFDS_SESSION_FLAG_SMB2:
-		ret = __init_smb2_session(sess);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
 
+	ret = __init_smb2_session(sess);
 	if (ret)
 		goto error;
 
 	ida_init(&sess->tree_conn_ida);
 
-	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
-		down_write(&sessions_table_lock);
-		hash_add(sessions_table, &sess->hlist, sess->id);
-		up_write(&sessions_table_lock);
-	}
+	down_write(&sessions_table_lock);
+	hash_add(sessions_table, &sess->hlist, sess->id);
+	up_write(&sessions_table_lock);
+
 	return sess;
 
 error:
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -21,7 +21,6 @@ struct ksmbd_file_table;
 struct channel {
 	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	struct ksmbd_conn	*conn;
-	struct list_head	chann_list;
 };
 
 struct preauth_session {
@@ -50,8 +49,7 @@ struct ksmbd_session {
 	char				sess_key[CIFS_KEY_SIZE];
 
 	struct hlist_node		hlist;
-	rwlock_t			chann_lock;
-	struct list_head		ksmbd_chann_list;
+	struct xarray			ksmbd_chann_list;
 	struct xarray			tree_conns;
 	struct ida			tree_conn_ida;
 	struct list_head		rpc_handle_list;
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -75,14 +75,7 @@ static inline bool check_session_id(stru
 
 struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn *conn)
 {
-	struct channel *chann;
-
-	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
-		if (chann->conn == conn)
-			return chann;
-	}
-
-	return NULL;
+	return xa_load(&sess->ksmbd_chann_list, (long)conn);
 }
 
 /**
@@ -626,6 +619,7 @@ static void destroy_previous_session(str
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -639,10 +633,8 @@ static void destroy_previous_session(str
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
 		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
@@ -1549,19 +1541,14 @@ static int ntlm_authenticate(struct ksmb
 
 binding_session:
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -1636,19 +1623,14 @@ static int krb5_authenticate(struct ksmb
 	}
 
 	if (conn->dialect >= SMB30_PROT_ID) {
-		read_lock(&sess->chann_lock);
 		chann = lookup_chann_list(sess, conn);
-		read_unlock(&sess->chann_lock);
 		if (!chann) {
 			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			INIT_LIST_HEAD(&chann->chann_list);
-			write_lock(&sess->chann_lock);
-			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
-			write_unlock(&sess->chann_lock);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
 		}
 	}
 
@@ -8463,14 +8445,11 @@ int smb3_check_sign_req(struct ksmbd_wor
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return 0;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key) {
@@ -8530,14 +8509,11 @@ void smb3_set_sign_rsp(struct ksmbd_work
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
 		signing_key = work->sess->smb3signingkey;
 	} else {
-		read_lock(&work->sess->chann_lock);
 		chann = lookup_chann_list(work->sess, work->conn);
 		if (!chann) {
-			read_unlock(&work->sess->chann_lock);
 			return;
 		}
 		signing_key = chann->smb3signingkey;
-		read_unlock(&work->sess->chann_lock);
 	}
 
 	if (!signing_key)



