Return-Path: <stable+bounces-7764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FCC817629
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B8B1F24F5B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BB49895;
	Mon, 18 Dec 2023 15:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5974FF61
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cd82917ecfso1527931a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914155; x=1703518955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6VeDvZiFhD8zD7EWQXzamy4geskqyHFFfe3gjnW1Sw=;
        b=IDfMGhzwhGQ+Y/j9/k1LavDFTNh3bOOIeq8DZV3DVtsyQmnE1d1WadzLqPVhOkgVXr
         dyLYni5UK7jsz+rkWZ+eFKPta5BL17KaE7NDYknkEJW4z/5Rf8fbjRbgY1V5D6T7u0Q8
         i4QyOEY+kA4LdLf3GhPfkCnXLpyqs7mBA4ec2JYRkMagJ3lHTi+DL3r1V8GS39OA8GUi
         kdBdRv8+wTLSRSe+PMpmOKG3yMi27B726xIsVK9KGFOzzxOzx+06rKZMb9ohWt/eio7i
         oz0zY2rPG0IiPKR8h4KuSyoWSp0nLvmPwTy2Xy/uYPVlj1/7HXMgWp1H2xr5jTH726mH
         R7mw==
X-Gm-Message-State: AOJu0YzcSwZVJhX+n2pFBrAtwLoqofm1lORmWr1vWQGSHxVp68mr1CO/
	jYYCCNXOILxLETohU9c0150=
X-Google-Smtp-Source: AGHT+IGSviHBl4swE4RGR+ferGIiB8ObVU9Pe3x3diqcrGJP2NbOUHT4abKSHCZxyXcMJ4kDYenO1Q==
X-Received: by 2002:a17:90a:43e2:b0:28b:b209:2290 with SMTP id r89-20020a17090a43e200b0028bb2092290mr6288pjg.1.1702914155447;
        Mon, 18 Dec 2023 07:42:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:35 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	luosili <rootlab@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 135/154] ksmbd: fix race condition between tree conn lookup and disconnect
Date: Tue, 19 Dec 2023 00:34:35 +0900
Message-Id: <20231218153454.8090-136-linkinjeon@kernel.org>
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

[ Upstream commit 33b235a6e6ebe0f05f3586a71e8d281d00f71e2e ]

if thread A in smb2_write is using work-tcon, other thread B use
smb2_tree_disconnect free the tcon, then thread A will use free'd tcon.

                            Time
                             +
 Thread A                    | Thread A
 smb2_write                  | smb2_tree_disconnect
                             |
                             |
                             |   kfree(tree_conn)
                             |
  // UAF!                    |
  work->tcon->share_conf     |
                             +

This patch add state, reference count and lock for tree conn to fix race
condition issue.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/mgmt/tree_connect.c | 42 +++++++++++++++++++++++++++---
 fs/ksmbd/mgmt/tree_connect.h | 11 ++++++--
 fs/ksmbd/mgmt/user_session.c |  1 +
 fs/ksmbd/mgmt/user_session.h |  1 +
 fs/ksmbd/server.c            |  2 ++
 fs/ksmbd/smb2pdu.c           | 50 +++++++++++++++++++++++++++---------
 6 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
index 408cddf2f094..d2c81a8a11dd 100644
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -73,7 +73,10 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 
 	tree_conn->user = sess->user;
 	tree_conn->share_conf = sc;
+	tree_conn->t_state = TREE_NEW;
 	status.tree_conn = tree_conn;
+	atomic_set(&tree_conn->refcount, 1);
+	init_waitqueue_head(&tree_conn->refcount_q);
 
 	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
 			      GFP_KERNEL));
@@ -93,14 +96,33 @@ ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	return status;
 }
 
+void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon)
+{
+	/*
+	 * Checking waitqueue to releasing tree connect on
+	 * tree disconnect. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&tcon->refcount) &&
+	    waitqueue_active(&tcon->refcount_q))
+		wake_up(&tcon->refcount_q);
+}
+
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn)
 {
 	int ret;
 
+	write_lock(&sess->tree_conns_lock);
+	xa_erase(&sess->tree_conns, tree_conn->id);
+	write_unlock(&sess->tree_conns_lock);
+
+	if (!atomic_dec_and_test(&tree_conn->refcount))
+		wait_event(tree_conn->refcount_q,
+			   atomic_read(&tree_conn->refcount) == 0);
+
 	ret = ksmbd_ipc_tree_disconnect_request(sess->id, tree_conn->id);
 	ksmbd_release_tree_conn_id(sess, tree_conn->id);
-	xa_erase(&sess->tree_conns, tree_conn->id);
 	ksmbd_share_config_put(tree_conn->share_conf);
 	kfree(tree_conn);
 	return ret;
@@ -111,11 +133,15 @@ struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
 {
 	struct ksmbd_tree_connect *tcon;
 
+	read_lock(&sess->tree_conns_lock);
 	tcon = xa_load(&sess->tree_conns, id);
 	if (tcon) {
-		if (test_bit(TREE_CONN_EXPIRE, &tcon->status))
+		if (tcon->t_state != TREE_CONNECTED)
+			tcon = NULL;
+		else if (!atomic_inc_not_zero(&tcon->refcount))
 			tcon = NULL;
 	}
+	read_unlock(&sess->tree_conns_lock);
 
 	return tcon;
 }
@@ -129,8 +155,18 @@ int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
 	if (!sess)
 		return -EINVAL;
 
-	xa_for_each(&sess->tree_conns, id, tc)
+	xa_for_each(&sess->tree_conns, id, tc) {
+		write_lock(&sess->tree_conns_lock);
+		if (tc->t_state == TREE_DISCONNECTED) {
+			write_unlock(&sess->tree_conns_lock);
+			ret = -ENOENT;
+			continue;
+		}
+		tc->t_state = TREE_DISCONNECTED;
+		write_unlock(&sess->tree_conns_lock);
+
 		ret |= ksmbd_tree_conn_disconnect(sess, tc);
+	}
 	xa_destroy(&sess->tree_conns);
 	return ret;
 }
diff --git a/fs/ksmbd/mgmt/tree_connect.h b/fs/ksmbd/mgmt/tree_connect.h
index 562d647ad9fa..6377a70b811c 100644
--- a/fs/ksmbd/mgmt/tree_connect.h
+++ b/fs/ksmbd/mgmt/tree_connect.h
@@ -14,7 +14,11 @@ struct ksmbd_share_config;
 struct ksmbd_user;
 struct ksmbd_conn;
 
-#define TREE_CONN_EXPIRE		1
+enum {
+	TREE_NEW = 0,
+	TREE_CONNECTED,
+	TREE_DISCONNECTED
+};
 
 struct ksmbd_tree_connect {
 	int				id;
@@ -27,7 +31,9 @@ struct ksmbd_tree_connect {
 
 	int				maximal_access;
 	bool				posix_extensions;
-	unsigned long			status;
+	atomic_t			refcount;
+	wait_queue_head_t		refcount_q;
+	unsigned int			t_state;
 };
 
 struct ksmbd_tree_conn_status {
@@ -46,6 +52,7 @@ struct ksmbd_session;
 struct ksmbd_tree_conn_status
 ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 			const char *share_name);
+void ksmbd_tree_connect_put(struct ksmbd_tree_connect *tcon);
 
 int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
 			       struct ksmbd_tree_connect *tree_conn);
diff --git a/fs/ksmbd/mgmt/user_session.c b/fs/ksmbd/mgmt/user_session.c
index b8be14a96cf6..15f68ee05089 100644
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -355,6 +355,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	xa_init(&sess->ksmbd_chann_list);
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
+	rwlock_init(&sess->tree_conns_lock);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/ksmbd/mgmt/user_session.h b/fs/ksmbd/mgmt/user_session.h
index f99d475b28db..63cb08fffde8 100644
--- a/fs/ksmbd/mgmt/user_session.h
+++ b/fs/ksmbd/mgmt/user_session.h
@@ -60,6 +60,7 @@ struct ksmbd_session {
 
 	struct ksmbd_file_table		file_table;
 	unsigned long			last_active;
+	rwlock_t			tree_conns_lock;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 633383e55723..11b201e6ee44 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -241,6 +241,8 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	} while (is_chained == true);
 
 send:
+	if (work->tcon)
+		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 560d81799647..358ff5bf6dcc 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1993,6 +1993,9 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	if (conn->posix_ext_supported)
 		status.tree_conn->posix_extensions = true;
 
+	write_lock(&sess->tree_conns_lock);
+	status.tree_conn->t_state = TREE_CONNECTED;
+	write_unlock(&sess->tree_conns_lock);
 	rsp->StructureSize = cpu_to_le16(16);
 out_err1:
 	rsp->Capabilities = 0;
@@ -2122,27 +2125,50 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "request\n");
 
+	if (!tcon) {
+		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	ksmbd_close_tree_conn_fds(work);
+
+	write_lock(&sess->tree_conns_lock);
+	if (tcon->t_state == TREE_DISCONNECTED) {
+		write_unlock(&sess->tree_conns_lock);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	WARN_ON_ONCE(atomic_dec_and_test(&tcon->refcount));
+	tcon->t_state = TREE_DISCONNECTED;
+	write_unlock(&sess->tree_conns_lock);
+
+	err = ksmbd_tree_conn_disconnect(sess, tcon);
+	if (err) {
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		goto err_out;
+	}
+
+	work->tcon = NULL;
+
 	rsp->StructureSize = cpu_to_le16(4);
 	err = ksmbd_iov_pin_rsp(work, rsp,
 				sizeof(struct smb2_tree_disconnect_rsp));
 	if (err) {
 		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
-		smb2_set_err_rsp(work);
-		return err;
+		goto err_out;
 	}
 
-	if (!tcon || test_and_set_bit(TREE_CONN_EXPIRE, &tcon->status)) {
-		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+	return 0;
 
-		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
-		smb2_set_err_rsp(work);
-		return -ENOENT;
-	}
+err_out:
+	smb2_set_err_rsp(work);
+	return err;
 
-	ksmbd_close_tree_conn_fds(work);
-	ksmbd_tree_conn_disconnect(sess, tcon);
-	work->tcon = NULL;
-	return 0;
 }
 
 /**
-- 
2.25.1


