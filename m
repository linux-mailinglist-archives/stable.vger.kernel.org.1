Return-Path: <stable+bounces-8128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1C81A4A8
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E4A1C25976
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CA482E7;
	Wed, 20 Dec 2023 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oyU/dWeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F548CEB;
	Wed, 20 Dec 2023 16:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D49C433C8;
	Wed, 20 Dec 2023 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088991;
	bh=HBpdyEBcDPXdghZDEk6lyv6OyNL/Yz0Ow82Euzd9JhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyU/dWePhWW5Aob6tkYiwoxhPawA+e46KtoQZz4/akhHVFLb0Ds9emre9gl6a5q78
	 pgyWc88d9v+zp0unHML8tAjqfHdZQrROFc3ejk5zBmtjeGM+v/0G5wkzYJi2S4RkC/
	 8qFiY3vau2Ai+6x4L/LVnhKJidMS8iEiN7sico7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 091/159] ksmbd: fix racy issue from smb2 close and logoff with multichannel
Date: Wed, 20 Dec 2023 17:09:16 +0100
Message-ID: <20231220160935.625989411@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit abcc506a9a71976a8b4c9bf3ee6efd13229c1e19 ]

When smb client send concurrent smb2 close and logoff request
with multichannel connection, It can cause racy issue. logoff request
free tcon and can cause UAF issues in smb2 close. When receiving logoff
request with multichannel, ksmbd should wait until all remaning requests
complete as well as ones in the current connection, and then make
session expired.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20796 ZDI-CAN-20595
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c        |   54 ++++++++++++++++++++++++++++++++-----------
 fs/ksmbd/connection.h        |   19 ++++++++++++---
 fs/ksmbd/mgmt/tree_connect.c |    3 ++
 fs/ksmbd/mgmt/user_session.c |   36 +++++++++++++++++++++++-----
 fs/ksmbd/smb2pdu.c           |   21 ++++++++--------
 5 files changed, 101 insertions(+), 32 deletions(-)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -20,7 +20,7 @@ static DEFINE_MUTEX(init_lock);
 static struct ksmbd_conn_ops default_conn_ops;
 
 LIST_HEAD(conn_list);
-DEFINE_RWLOCK(conn_list_lock);
+DECLARE_RWSEM(conn_list_lock);
 
 /**
  * ksmbd_conn_free() - free resources of the connection instance
@@ -32,9 +32,9 @@ DEFINE_RWLOCK(conn_list_lock);
  */
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_del(&conn->conns_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
@@ -84,9 +84,9 @@ struct ksmbd_conn *ksmbd_conn_alloc(void
 	spin_lock_init(&conn->llist_lock);
 	INIT_LIST_HEAD(&conn->lock_list);
 
-	write_lock(&conn_list_lock);
+	down_write(&conn_list_lock);
 	list_add(&conn->conns_list, &conn_list);
-	write_unlock(&conn_list_lock);
+	up_write(&conn_list_lock);
 	return conn;
 }
 
@@ -95,7 +95,7 @@ bool ksmbd_conn_lookup_dialect(struct ks
 	struct ksmbd_conn *t;
 	bool ret = false;
 
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(t, &conn_list, conns_list) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
@@ -103,7 +103,7 @@ bool ksmbd_conn_lookup_dialect(struct ks
 		ret = true;
 		break;
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 	return ret;
 }
 
@@ -157,9 +157,37 @@ void ksmbd_conn_unlock(struct ksmbd_conn
 	mutex_unlock(&conn->srv_mutex);
 }
 
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 {
+	struct ksmbd_conn *conn;
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(conn, &conn_list, conns_list) {
+		if (conn->binding || xa_load(&conn->sessions, sess_id))
+			WRITE_ONCE(conn->status, status);
+	}
+	up_read(&conn_list_lock);
+}
+
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
+{
+	struct ksmbd_conn *bind_conn;
+
 	wait_event(conn->req_running_q, atomic_read(&conn->req_running) < 2);
+
+	down_read(&conn_list_lock);
+	list_for_each_entry(bind_conn, &conn_list, conns_list) {
+		if (bind_conn == conn)
+			continue;
+
+		if ((bind_conn->binding || xa_load(&bind_conn->sessions, sess_id)) &&
+		    !ksmbd_conn_releasing(bind_conn) &&
+		    atomic_read(&bind_conn->req_running)) {
+			wait_event(bind_conn->req_running_q,
+				atomic_read(&bind_conn->req_running) == 0);
+		}
+	}
+	up_read(&conn_list_lock);
 }
 
 int ksmbd_conn_write(struct ksmbd_work *work)
@@ -361,10 +389,10 @@ int ksmbd_conn_handler_loop(void *p)
 	}
 
 out:
+	ksmbd_conn_set_releasing(conn);
 	/* Wait till all reference dropped to the Server object*/
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
-
 	if (IS_ENABLED(CONFIG_UNICODE))
 		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
@@ -408,7 +436,7 @@ static void stop_sessions(void)
 	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
@@ -419,12 +447,12 @@ again:
 				    task->comm, task_pid_nr(task));
 		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
-			read_unlock(&conn_list_lock);
+			up_read(&conn_list_lock);
 			t->ops->shutdown(t);
-			read_lock(&conn_list_lock);
+			down_read(&conn_list_lock);
 		}
 	}
-	read_unlock(&conn_list_lock);
+	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
 		schedule_timeout_interruptible(HZ / 10); /* 100ms */
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -26,7 +26,8 @@ enum {
 	KSMBD_SESS_GOOD,
 	KSMBD_SESS_EXITING,
 	KSMBD_SESS_NEED_RECONNECT,
-	KSMBD_SESS_NEED_NEGOTIATE
+	KSMBD_SESS_NEED_NEGOTIATE,
+	KSMBD_SESS_RELEASING
 };
 
 struct ksmbd_stats {
@@ -140,10 +141,10 @@ struct ksmbd_transport {
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
 extern struct list_head conn_list;
-extern rwlock_t conn_list_lock;
+extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
-void ksmbd_conn_wait_idle(struct ksmbd_conn *conn);
+void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id);
 struct ksmbd_conn *ksmbd_conn_alloc(void);
 void ksmbd_conn_free(struct ksmbd_conn *conn);
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c);
@@ -191,6 +192,11 @@ static inline bool ksmbd_conn_exiting(st
 	return READ_ONCE(conn->status) == KSMBD_SESS_EXITING;
 }
 
+static inline bool ksmbd_conn_releasing(struct ksmbd_conn *conn)
+{
+	return READ_ONCE(conn->status) == KSMBD_SESS_RELEASING;
+}
+
 static inline void ksmbd_conn_set_new(struct ksmbd_conn *conn)
 {
 	WRITE_ONCE(conn->status, KSMBD_SESS_NEW);
@@ -215,4 +221,11 @@ static inline void ksmbd_conn_set_exitin
 {
 	WRITE_ONCE(conn->status, KSMBD_SESS_EXITING);
 }
+
+static inline void ksmbd_conn_set_releasing(struct ksmbd_conn *conn)
+{
+	WRITE_ONCE(conn->status, KSMBD_SESS_RELEASING);
+}
+
+void ksmbd_all_conn_set_status(u64 sess_id, u32 status);
 #endif /* __CONNECTION_H__ */
--- a/fs/ksmbd/mgmt/tree_connect.c
+++ b/fs/ksmbd/mgmt/tree_connect.c
@@ -129,6 +129,9 @@ int ksmbd_tree_conn_session_logoff(struc
 	struct ksmbd_tree_connect *tc;
 	unsigned long id;
 
+	if (!sess)
+		return -EINVAL;
+
 	xa_for_each(&sess->tree_conns, id, tc)
 		ret |= ksmbd_tree_conn_disconnect(sess, tc);
 	xa_destroy(&sess->tree_conns);
--- a/fs/ksmbd/mgmt/user_session.c
+++ b/fs/ksmbd/mgmt/user_session.c
@@ -144,10 +144,6 @@ void ksmbd_session_destroy(struct ksmbd_
 	if (!sess)
 		return;
 
-	down_write(&sessions_table_lock);
-	hash_del(&sess->hlist);
-	up_write(&sessions_table_lock);
-
 	if (sess->user)
 		ksmbd_free_user(sess->user);
 
@@ -178,15 +174,18 @@ static void ksmbd_expire_session(struct
 	unsigned long id;
 	struct ksmbd_session *sess;
 
+	down_write(&sessions_table_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		if (sess->state != SMB2_SESSION_VALID ||
 		    time_after(jiffies,
 			       sess->last_active + SMB2_SESSION_TIMEOUT)) {
 			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
 			ksmbd_session_destroy(sess);
 			continue;
 		}
 	}
+	up_write(&sessions_table_lock);
 }
 
 int ksmbd_session_register(struct ksmbd_conn *conn,
@@ -198,15 +197,16 @@ int ksmbd_session_register(struct ksmbd_
 	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
 }
 
-static void ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
+static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
 {
 	struct channel *chann;
 
 	chann = xa_erase(&sess->ksmbd_chann_list, (long)conn);
 	if (!chann)
-		return;
+		return -ENOENT;
 
 	kfree(chann);
+	return 0;
 }
 
 void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
@@ -214,13 +214,37 @@ void ksmbd_sessions_deregister(struct ks
 	struct ksmbd_session *sess;
 	unsigned long id;
 
+	down_write(&sessions_table_lock);
+	if (conn->binding) {
+		int bkt;
+		struct hlist_node *tmp;
+
+		hash_for_each_safe(sessions_table, bkt, tmp, sess, hlist) {
+			if (!ksmbd_chann_del(conn, sess) &&
+			    xa_empty(&sess->ksmbd_chann_list)) {
+				hash_del(&sess->hlist);
+				ksmbd_session_destroy(sess);
+			}
+		}
+	}
+
 	xa_for_each(&conn->sessions, id, sess) {
+		unsigned long chann_id;
+		struct channel *chann;
+
+		xa_for_each(&sess->ksmbd_chann_list, chann_id, chann) {
+			if (chann->conn != conn)
+				ksmbd_conn_set_exiting(chann->conn);
+		}
+
 		ksmbd_chann_del(conn, sess);
 		if (xa_empty(&sess->ksmbd_chann_list)) {
 			xa_erase(&conn->sessions, sess->id);
+			hash_del(&sess->hlist);
 			ksmbd_session_destroy(sess);
 		}
 	}
+	up_write(&sessions_table_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2111,21 +2111,22 @@ int smb2_session_logoff(struct ksmbd_wor
 	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess;
 	struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
+	u64 sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
-	ksmbd_conn_set_need_reconnect(conn);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
 	ksmbd_close_session_fds(work);
-	ksmbd_conn_wait_idle(conn);
+	ksmbd_conn_wait_idle(conn, sess_id);
 
 	/*
 	 * Re-lookup session to validate if session is deleted
 	 * while waiting request complete
 	 */
-	sess = ksmbd_session_lookup(conn, le64_to_cpu(req->hdr.SessionId));
+	sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (ksmbd_tree_conn_session_logoff(sess)) {
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2138,7 +2139,7 @@ int smb2_session_logoff(struct ksmbd_wor
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-	ksmbd_conn_set_need_negotiate(conn);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 	return 0;
 }
 
@@ -6892,7 +6893,7 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
+		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
@@ -6909,7 +6910,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						up_read(&conn_list_lock);
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -6931,7 +6932,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6940,7 +6941,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -6951,14 +6952,14 @@ int smb2_lock(struct ksmbd_work *work)
 				      cmp_lock->end >= smb_lock->end)) &&
 				    !cmp_lock->zero_len && !smb_lock->zero_len) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("Not allow lock operation on exclusive lock range\n");
 					goto out;
 				}
 			}
 			spin_unlock(&conn->llist_lock);
 		}
-		read_unlock(&conn_list_lock);
+		up_read(&conn_list_lock);
 out_check_cl:
 		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");



