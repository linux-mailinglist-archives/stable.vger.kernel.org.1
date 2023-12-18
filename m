Return-Path: <stable+bounces-7699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899238175DB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E761F24B9B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1B760AA;
	Mon, 18 Dec 2023 15:39:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C83D549
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c239897895so965918a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913947; x=1703518747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjY9jeqYNA6Qxnea0iqgVO8TWeqFBOlbbh9mhU3CHfg=;
        b=EvhtblyMVik9Os+hCosjw9/P2kumwCuY6uf70pEAVRg+7FEQoN7KSU/XCq6SCm3lxO
         CAKJdm6d7L2CqGxHEGu2+3mBCrHQGwgnfuzWG9r6YYf8mRM+NndBqzRJqyoAMv1QZ5S2
         WdUe3qyZWHuqrq7HUDKabp1IHX14a4oqKVH9f3UwCFsomLBCReob9xGCAEcaes60/LpM
         Sq5EAJ7hxIvSOpKcVxgzilgBR/lvcAhfKC+HZZzfCXCEeH5P5LP3w3KTaXjSf9s6uWww
         r7HLR4gBNK6LMvurpVS+ftdkwAW44A1LdKmN034fwpRQzR+pY1nqjVgVBTVB6r2JrWK5
         mr4Q==
X-Gm-Message-State: AOJu0YyXbZ1F5Ox6bf4Mv8Z0n4xdvxebQhrEJ3HQlyGdBponi4WyeArs
	ytsSSDKfOS8IhbqRrt6XeII=
X-Google-Smtp-Source: AGHT+IFJfUp2YbDDUqezSa0/2l+67vXi1h4X07A224xydfE6CltzJcDrwZheIX3SKIPTzNBtkGdKPQ==
X-Received: by 2002:a17:90b:46c7:b0:28b:558e:9af5 with SMTP id jx7-20020a17090b46c700b0028b558e9af5mr816517pjb.92.1702913947052;
        Mon, 18 Dec 2023 07:39:07 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:06 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Dawei Li <set_pte_at@outlook.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 070/154] ksmbd: Implements sess->ksmbd_chann_list as xarray
Date: Tue, 19 Dec 2023 00:33:30 +0900
Message-Id: <20231218153454.8090-71-linkinjeon@kernel.org>
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
---
 fs/ksmbd/mgmt/user_session.c | 61 ++++++++++++++----------------------
 fs/ksmbd/mgmt/user_session.h |  4 +--
 fs/ksmbd/smb2pdu.c           | 34 +++-----------------
 3 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index 92b1603b5abe..a2b128dedcfc 100644
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
@@ -190,21 +190,15 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
-	struct channel *chann, *tmp;
-
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
+	struct channel *chann;
+
+	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
+	if (!chann)
+		return -ENOENT;
 
-	return -ENOENT;
+	kfree(chann);
+
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
@@ -234,7 +228,7 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 	return;
 
 sess_destroy:
-	if (list_empty(&sess->ksmbd_chann_list)) {
+	if (xa_empty(&sess->ksmbd_chann_list)) {
 		xa_erase(&conn->sessions, sess->id);
 		ksmbd_session_destroy(sess);
 	}
@@ -320,6 +314,9 @@ static struct ksmbd_session *__session_create(int protocol)
 	struct ksmbd_session *sess;
 	int ret;
 
+	if (protocol != CIFDS_SESSION_FLAG_SMB2)
+		return NULL;
+
 	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
 	if (!sess)
 		return NULL;
@@ -329,30 +326,20 @@ static struct ksmbd_session *__session_create(int protocol)
 
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
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index 8934b8ee275b..44a3c67b2bd9 100644
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
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 14619b074bc3..8c0872074d1b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -75,14 +75,7 @@ static inline bool check_session_id(struct ksmbd_conn *conn, u64 id)
 
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
@@ -626,6 +619,7 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
 	struct ksmbd_user *prev_user;
 	struct channel *chann;
+	long index;
 
 	if (!prev_sess)
 		return;
@@ -639,10 +633,8 @@ static void destroy_previous_session(struct ksmbd_conn *conn,
 		return;
 
 	prev_sess->state = SMB2_SESSION_EXPIRED;
-	write_lock(&prev_sess->chann_lock);
-	list_for_each_entry(chann, &prev_sess->ksmbd_chann_list, chann_list)
+	xa_for_each(&prev_sess->ksmbd_chann_list, index, chann)
 		chann->conn->status = KSMBD_SESS_EXITING;
-	write_unlock(&prev_sess->chann_lock);
 }
 
 /**
@@ -1549,19 +1541,14 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 
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
 
@@ -1636,19 +1623,14 @@ static int krb5_authenticate(struct ksmbd_work *work)
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
 
@@ -8462,14 +8444,11 @@ int smb3_check_sign_req(struct ksmbd_work *work)
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
@@ -8529,14 +8508,11 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
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
-- 
2.25.1


