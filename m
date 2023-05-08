Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F58E6FAA02
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjEHK5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjEHK5h (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8529CA1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF481629AF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8304EC433D2;
        Mon,  8 May 2023 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543393;
        bh=kPNl469362QWFoy2yqO8AY3S9hUIQD7AEX22BHFIANQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMInKLMnBOaLA6/WZsAdfszVmfpEbZHRO9Vpqev4nJqoMzOWgnQLKIg/KopLaP9fr
         8eSXLz2nJQsC0ysA7zRskVN9vsQRlDlF/XP9+4U1pJEQXJybxzuDJezly1hYgxvS8Y
         +J5aqEqMDk7DLVD9u2l9i0eRhk8TfJIybDK42PMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 075/694] ksmbd: fix racy issue from smb2 close and logoff with multichannel
Date:   Mon,  8 May 2023 11:38:30 +0200
Message-Id: <20230508094434.975924557@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit abcc506a9a71976a8b4c9bf3ee6efd13229c1e19 upstream.

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
@@ -360,10 +388,10 @@ int ksmbd_conn_handler_loop(void *p)
 	}
 
 out:
+	ksmbd_conn_set_releasing(conn);
 	/* Wait till all reference dropped to the Server object*/
 	wait_event(conn->r_count_q, atomic_read(&conn->r_count) == 0);
 
-
 	if (IS_ENABLED(CONFIG_UNICODE))
 		utf8_unload(conn->um);
 	unload_nls(conn->local_nls);
@@ -407,7 +435,7 @@ static void stop_sessions(void)
 	struct ksmbd_transport *t;
 
 again:
-	read_lock(&conn_list_lock);
+	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
@@ -418,12 +446,12 @@ again:
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
@@ -137,6 +137,9 @@ int ksmbd_tree_conn_session_logoff(struc
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
@@ -2110,21 +2110,22 @@ int smb2_session_logoff(struct ksmbd_wor
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
@@ -2137,7 +2138,7 @@ int smb2_session_logoff(struct ksmbd_wor
 
 	ksmbd_free_user(sess->user);
 	sess->user = NULL;
-	ksmbd_conn_set_need_negotiate(conn);
+	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 	return 0;
 }
 
@@ -6969,7 +6970,7 @@ int smb2_lock(struct ksmbd_work *work)
 
 		nolock = 1;
 		/* check locks in connection list */
-		read_lock(&conn_list_lock);
+		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
@@ -6986,7 +6987,7 @@ int smb2_lock(struct ksmbd_work *work)
 						list_del(&cmp_lock->flist);
 						list_del(&cmp_lock->clist);
 						spin_unlock(&conn->llist_lock);
-						read_unlock(&conn_list_lock);
+						up_read(&conn_list_lock);
 
 						locks_free_lock(cmp_lock->fl);
 						kfree(cmp_lock);
@@ -7008,7 +7009,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    cmp_lock->start > smb_lock->start &&
 				    cmp_lock->start < smb_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("previous lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7017,7 +7018,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    smb_lock->start > cmp_lock->start &&
 				    smb_lock->start < cmp_lock->end) {
 					spin_unlock(&conn->llist_lock);
-					read_unlock(&conn_list_lock);
+					up_read(&conn_list_lock);
 					pr_err("current lock conflict with zero byte lock range\n");
 					goto out;
 				}
@@ -7028,14 +7029,14 @@ int smb2_lock(struct ksmbd_work *work)
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


