Return-Path: <stable+bounces-9349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D47A8231F6
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1292B22D18
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE831BDFF;
	Wed,  3 Jan 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVni3vhc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268291BDFB;
	Wed,  3 Jan 2024 17:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFC1C433C8;
	Wed,  3 Jan 2024 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301244;
	bh=YdTEcpBQJz4LRokrkgETTP8oBOJ5UxUhBOUb2jqebys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVni3vhcBeJCsb83oTwPsUrdLG2DtWMQ/4vd6gTbfz9V+QRg2K/E2RGGvznQXgmhI
	 vzd/mWVCazzERB3d2BeVlL/eUmsiMOQ+C7CvWF+26l4/xRqNi3NU/kIILqGlsr5lXQ
	 wZo1jhWL+m3HYo1Dy6AHmWyG5av+SBoCd2uMRy6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	luosili <rootlab@huawei.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 048/100] ksmbd: fix race condition between tree conn lookup and disconnect
Date: Wed,  3 Jan 2024 17:54:37 +0100
Message-ID: <20240103164903.274381623@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/tree_connect.c | 42 ++++++++++++++++++++++++--
 fs/smb/server/mgmt/tree_connect.h | 11 +++++--
 fs/smb/server/mgmt/user_session.c |  1 +
 fs/smb/server/mgmt/user_session.h |  1 +
 fs/smb/server/server.c            |  2 ++
 fs/smb/server/smb2pdu.c           | 50 +++++++++++++++++++++++--------
 6 files changed, 90 insertions(+), 17 deletions(-)

diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index 408cddf2f094a..d2c81a8a11dda 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
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
diff --git a/fs/smb/server/mgmt/tree_connect.h b/fs/smb/server/mgmt/tree_connect.h
index 562d647ad9fad..6377a70b811c8 100644
--- a/fs/smb/server/mgmt/tree_connect.h
+++ b/fs/smb/server/mgmt/tree_connect.h
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
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index b8be14a96cf66..15f68ee050894 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -355,6 +355,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	xa_init(&sess->ksmbd_chann_list);
 	xa_init(&sess->rpc_handle_list);
 	sess->sequence_number = 1;
+	rwlock_init(&sess->tree_conns_lock);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index f99d475b28db4..63cb08fffde84 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -60,6 +60,7 @@ struct ksmbd_session {
 
 	struct ksmbd_file_table		file_table;
 	unsigned long			last_active;
+	rwlock_t			tree_conns_lock;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 633383e55723c..11b201e6ee44b 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -241,6 +241,8 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	} while (is_chained == true);
 
 send:
+	if (work->tcon)
+		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index a76529512acfb..aad08866746c8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
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
2.43.0




