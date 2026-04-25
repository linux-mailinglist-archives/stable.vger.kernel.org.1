Return-Path: <stable+bounces-241109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLtbGFaE7GnGZQAAu9opvQ
	(envelope-from <stable+bounces-241109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:07:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576804659B9
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18C853007204
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E606361DD2;
	Sat, 25 Apr 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiBFwyPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B312D77EE
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108046; cv=none; b=XFZObGbD8i6k7k0x7MYI3ft2HG5p7YStCOhpI+dflDtzPqVdeW8x41BkhKKls20R2PhNX9ft+X49IPbUhQVr7xZ0mBkbrMbLmnfk8UqRbJ+4YE/FFHJLxvrJ5QWsknTpwyahqvrYgEIsGbzhCDwMxSPqrLwJmvIEOZnv++RnBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108046; c=relaxed/simple;
	bh=TpE8CM8dr5gJRMAjFiVy+4INe5103VgTw6De3qXlsxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNdOe4OFF0jobnCWwqFn6dZjA82s7oafOSFZd8yRAUz7bbKFadN/k3gAQQaLLu9krFzZ+wWWS/JYTK8J+XBOJLbJYmrwnWQmiPLg43ronsOeNLcY1BOz66e2KirMyCO3t7Dw3POSclFvxJK3RQ9OupkHp51RCWtqOxXUM0hLSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiBFwyPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D677C2BCB2;
	Sat, 25 Apr 2026 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777108045;
	bh=TpE8CM8dr5gJRMAjFiVy+4INe5103VgTw6De3qXlsxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiBFwyPRM8P0AH0xHUxC3d6glLfBqtXIn183KXFhFO/2fWRideayOaCWSSLADNleD
	 URM8A6qo67pct/28DxCi4pt1lahEXm3ZV02Aom5Gs2kgd5DQCdtPpUiA4OflBHGycf
	 Q63WnVkZPKtT/y/PhXjNhJjpezZiKp5vHfbaI2lQRsY/qyy9yIUnJ6TLcj7ugnTBxk
	 nSx1RpSVSJ+7Nl4PeZevT0/LaHtCSPmlE5XqOZv+45V5w+eiVdViLFpxZKj8T74C2h
	 PzksXwQbjuFe9hauDrvNupp9bVqmP7ybYfdPNAs9xYuqp1H/K6/6sZmI1UEbRwoyV7
	 +gXLhLXldgiZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ksmbd: replace connection list with hash table
Date: Sat, 25 Apr 2026 05:07:21 -0400
Message-ID: <20260425090722.3316820-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425090722.3316820-1-sashal@kernel.org>
References: <2026042410-cinch-frostbite-b760@gregkh>
 <20260425090722.3316820-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 576804659B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241109-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 0bcc831be535269556f59cb70396f7e34f03a276 ]

Replace connection list with hash table to improve lookup performance.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: def036ef87f8 ("ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c     | 23 +++++++++++------------
 fs/smb/server/connection.h     |  6 ++++--
 fs/smb/server/smb2pdu.c        |  4 ++--
 fs/smb/server/transport_rdma.c |  5 +++++
 fs/smb/server/transport_tcp.c  | 25 +++++++++++++++++++++----
 5 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 1b96d58183cdf..076f704b37a7b 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -19,7 +19,7 @@ static DEFINE_MUTEX(init_lock);
 
 static struct ksmbd_conn_ops default_conn_ops;
 
-LIST_HEAD(conn_list);
+DEFINE_HASHTABLE(conn_list, CONN_HASH_BITS);
 DECLARE_RWSEM(conn_list_lock);
 
 /**
@@ -33,7 +33,7 @@ DECLARE_RWSEM(conn_list_lock);
 void ksmbd_conn_free(struct ksmbd_conn *conn)
 {
 	down_write(&conn_list_lock);
-	list_del(&conn->conns_list);
+	hash_del(&conn->hlist);
 	up_write(&conn_list_lock);
 
 	xa_destroy(&conn->sessions);
@@ -78,7 +78,6 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 
 	init_waitqueue_head(&conn->req_running_q);
 	init_waitqueue_head(&conn->r_count_q);
-	INIT_LIST_HEAD(&conn->conns_list);
 	INIT_LIST_HEAD(&conn->requests);
 	INIT_LIST_HEAD(&conn->async_requests);
 	spin_lock_init(&conn->request_lock);
@@ -91,19 +90,17 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 
 	init_rwsem(&conn->session_lock);
 
-	down_write(&conn_list_lock);
-	list_add(&conn->conns_list, &conn_list);
-	up_write(&conn_list_lock);
 	return conn;
 }
 
 bool ksmbd_conn_lookup_dialect(struct ksmbd_conn *c)
 {
 	struct ksmbd_conn *t;
+	int bkt;
 	bool ret = false;
 
 	down_read(&conn_list_lock);
-	list_for_each_entry(t, &conn_list, conns_list) {
+	hash_for_each(conn_list, bkt, t, hlist) {
 		if (memcmp(t->ClientGUID, c->ClientGUID, SMB2_CLIENT_GUID_SIZE))
 			continue;
 
@@ -164,9 +161,10 @@ void ksmbd_conn_unlock(struct ksmbd_conn *conn)
 void ksmbd_all_conn_set_status(u64 sess_id, u32 status)
 {
 	struct ksmbd_conn *conn;
+	int bkt;
 
 	down_read(&conn_list_lock);
-	list_for_each_entry(conn, &conn_list, conns_list) {
+	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id))
 			WRITE_ONCE(conn->status, status);
 	}
@@ -182,14 +180,14 @@ int ksmbd_conn_wait_idle_sess_id(struct ksmbd_conn *curr_conn, u64 sess_id)
 {
 	struct ksmbd_conn *conn;
 	int rc, retry_count = 0, max_timeout = 120;
-	int rcount = 1;
+	int rcount = 1, bkt;
 
 retry_idle:
 	if (retry_count >= max_timeout)
 		return -EIO;
 
 	down_read(&conn_list_lock);
-	list_for_each_entry(conn, &conn_list, conns_list) {
+	hash_for_each(conn_list, bkt, conn, hlist) {
 		if (conn->binding || xa_load(&conn->sessions, sess_id)) {
 			if (conn == curr_conn)
 				rcount = 2;
@@ -480,10 +478,11 @@ static void stop_sessions(void)
 {
 	struct ksmbd_conn *conn;
 	struct ksmbd_transport *t;
+	int bkt;
 
 again:
 	down_read(&conn_list_lock);
-	list_for_each_entry(conn, &conn_list, conns_list) {
+	hash_for_each(conn_list, bkt, conn, hlist) {
 		t = conn->transport;
 		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
@@ -494,7 +493,7 @@ static void stop_sessions(void)
 	}
 	up_read(&conn_list_lock);
 
-	if (!list_empty(&conn_list)) {
+	if (!hash_empty(conn_list)) {
 		msleep(100);
 		goto again;
 	}
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 2aa8084bb5930..78633ad1175c8 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -52,11 +52,12 @@ struct ksmbd_conn {
 		u8			inet6_addr[16];
 #endif
 	};
+	unsigned int			inet_hash;
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
 	struct unicode_map		*um;
-	struct list_head		conns_list;
+	struct hlist_node		hlist;
 	struct rw_semaphore		session_lock;
 	/* smb session 1 per user */
 	struct xarray			sessions;
@@ -151,7 +152,8 @@ struct ksmbd_transport {
 #define KSMBD_TCP_SEND_TIMEOUT	(5 * HZ)
 #define KSMBD_TCP_PEER_SOCKADDR(c)	((struct sockaddr *)&((c)->peer_addr))
 
-extern struct list_head conn_list;
+#define CONN_HASH_BITS	12
+extern DECLARE_HASHTABLE(conn_list, CONN_HASH_BITS);
 extern struct rw_semaphore conn_list_lock;
 
 bool ksmbd_conn_alive(struct ksmbd_conn *conn);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 733c0bace6182..83b83b6d950cd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7425,7 +7425,7 @@ int smb2_lock(struct ksmbd_work *work)
 	int nolock = 0;
 	LIST_HEAD(lock_list);
 	LIST_HEAD(rollback_list);
-	int prior_lock = 0;
+	int prior_lock = 0, bkt;
 
 	WORK_BUFFERS(work, req, rsp);
 
@@ -7535,7 +7535,7 @@ int smb2_lock(struct ksmbd_work *work)
 		nolock = 1;
 		/* check locks in connection list */
 		down_read(&conn_list_lock);
-		list_for_each_entry(conn, &conn_list, conns_list) {
+		hash_for_each(conn_list, bkt, conn, hlist) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
 				if (file_inode(cmp_lock->fl->c.flc_file) !=
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index d15c33480e0a9..3976009596d99 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -381,6 +381,11 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	conn = ksmbd_conn_alloc();
 	if (!conn)
 		goto err;
+
+	down_write(&conn_list_lock);
+	hash_add(conn_list, &conn->hlist, 0);
+	up_write(&conn_list_lock);
+
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_smb_direct_transport_ops;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 9ad9b50bf93e8..7da25c16051ce 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -89,13 +89,21 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (client_sk->sk->sk_family == AF_INET6)
+	if (client_sk->sk->sk_family == AF_INET6) {
 		memcpy(&conn->inet6_addr, &client_sk->sk->sk_v6_daddr, 16);
-	else
+		conn->inet_hash = ipv6_addr_hash(&client_sk->sk->sk_v6_daddr);
+	} else {
 		conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+		conn->inet_hash = ipv4_addr_hash(inet_sk(client_sk->sk)->inet_daddr);
+	}
 #else
 	conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+	conn->inet_hash = ipv4_addr_hash(inet_sk(client_sk->sk)->inet_daddr);
 #endif
+	down_write(&conn_list_lock);
+	hash_add(conn_list, &conn->hlist, conn->inet_hash);
+	up_write(&conn_list_lock);
+
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
@@ -240,7 +248,7 @@ static int ksmbd_kthread_fn(void *p)
 	struct socket *client_sk = NULL;
 	struct interface *iface = (struct interface *)p;
 	struct ksmbd_conn *conn;
-	int ret;
+	int ret, inet_hash;
 	unsigned int max_ip_conns;
 
 	while (!kthread_should_stop()) {
@@ -265,9 +273,18 @@ static int ksmbd_kthread_fn(void *p)
 		/*
 		 * Limits repeated connections from clients with the same IP.
 		 */
+#if IS_ENABLED(CONFIG_IPV6)
+		if (client_sk->sk->sk_family == AF_INET6)
+			inet_hash = ipv6_addr_hash(&client_sk->sk->sk_v6_daddr);
+		else
+			inet_hash = ipv4_addr_hash(inet_sk(client_sk->sk)->inet_daddr);
+#else
+		inet_hash = ipv4_addr_hash(inet_sk(client_sk->sk)->inet_daddr);
+#endif
+
 		max_ip_conns = 0;
 		down_read(&conn_list_lock);
-		list_for_each_entry(conn, &conn_list, conns_list) {
+		hash_for_each_possible(conn_list, conn, hlist, inet_hash) {
 #if IS_ENABLED(CONFIG_IPV6)
 			if (client_sk->sk->sk_family == AF_INET6) {
 				if (memcmp(&client_sk->sk->sk_v6_daddr,
-- 
2.53.0


