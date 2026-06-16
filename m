Return-Path: <stable+bounces-266140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EvUoOXyYMWoHnwUAu9opvQ
	(envelope-from <stable+bounces-266140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:39:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34E6944F5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:39:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=as+oM8Ed;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266140-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266140-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345B8300B464
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA554418D7;
	Tue, 16 Jun 2026 18:34:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E413DC86D;
	Tue, 16 Jun 2026 18:34:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634871; cv=none; b=SI0Ko5uWW+LYEe9aUMo4sXLv/jUtnXEswekh+dd+SgQlKBFdAfV7kP7g8+oP+BAIQT5fFtIEJVTT1n0h7GE8E8h039CeLUrZoplwki3hzwH7yPvqBaYiA/OUXO0/zIqoVnZRDKlfcqy0Nl+85lZaZoNEBXY0YZWutzRebq6dtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634871; c=relaxed/simple;
	bh=LNVXMmlsApbNkT7bUzmj3aTaROa2GI59V/rPbVKjwaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvv17uPMso18L6o1VcGcCFSwI+6sgIR57QCNSY+oR2sI++m9mjzkIDIvR+KFTV/4edDKn+hbQJBI/lrbKLgba7eJxaj/CqM8rj3dpdBQ0Q7YIun2G1c2QbhtNrguk+7UfPnxG68+jTbaLEk7lyPnHSywfWu6fPgyabsvrFkgqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=as+oM8Ed; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE91F000E9;
	Tue, 16 Jun 2026 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634870;
	bh=wTD39nqSk56LqTiTz3W/mts9kXhMXoMcKcTAloYUY34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=as+oM8Edxj5nha6GpOzypvw04muM+tJHksyhK8Slz3fmJr4lVBU5jPKMSdKgi67dv
	 jzDrK1RC9tC1n7hzoe0OoZqHwxhzlUS4gIGOHKIm+Et5du3o2asEB9sakKpiNTcBgt
	 teE94Yvxfnse2G28EFduGdA6fs+R9C7fmQbBDwJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 347/411] Bluetooth: serialize accept_q access
Date: Tue, 16 Jun 2026 20:29:45 +0530
Message-ID: <20260616145119.736753329@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-266140-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jannh@google.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:wangjiexun2025@gmail.com,m:n05ec@lzu.edu.cn,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,lzu.edu.cn,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lzu.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C34E6944F5

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiexun Wang <wangjiexun2025@gmail.com>

[ Upstream commit e83f5e24da741fa9405aeeff00b08c5ee7c37b88 ]

bt_sock_poll() walks the accept queue without synchronization, while
child teardown can unlink the same socket and drop its last reference.
The unsynchronized accept queue walk has existed since the initial
Bluetooth import.

Protect accept_q with a dedicated lock for queue updates and polling.
Also rework bt_accept_dequeue() to take temporary child references under
the queue lock before dropping it and locking the child socket.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/bluetooth.h |    1 
 net/bluetooth/af_bluetooth.c      |   87 ++++++++++++++++++++++++++++----------
 2 files changed, 66 insertions(+), 22 deletions(-)

--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -291,6 +291,7 @@ void baswap(bdaddr_t *dst, const bdaddr_
 struct bt_sock {
 	struct sock sk;
 	struct list_head accept_q;
+	spinlock_t accept_q_lock; /* protects accept_q */
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -149,6 +149,7 @@ struct sock *bt_sock_alloc(struct net *n
 
 	sock_init_data(sock, sk);
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+	spin_lock_init(&bt_sk(sk)->accept_q_lock);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
@@ -209,6 +210,7 @@ void bt_accept_enqueue(struct sock *pare
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
+	struct bt_sock *par = bt_sk(parent);
 
 	BT_DBG("parent %p, sk %p", parent, sk);
 
@@ -219,9 +221,13 @@ void bt_accept_enqueue(struct sock *pare
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
-	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	spin_lock_bh(&par->accept_q_lock);
+	list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
+	sk_acceptq_added(parent);
+	spin_unlock_bh(&par->accept_q_lock);
+
 	/* Copy credentials from parent since for incoming connections the
 	 * socket is allocated by the kernel.
 	 */
@@ -239,8 +245,6 @@ void bt_accept_enqueue(struct sock *pare
 		bh_unlock_sock(sk);
 	else
 		release_sock(sk);
-
-	sk_acceptq_added(parent);
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
@@ -249,45 +253,72 @@ EXPORT_SYMBOL(bt_accept_enqueue);
  */
 void bt_accept_unlink(struct sock *sk)
 {
+	struct sock *parent = bt_sk(sk)->parent;
+
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
 	list_del_init(&bt_sk(sk)->accept_q);
-	sk_acceptq_removed(bt_sk(sk)->parent);
+	sk_acceptq_removed(parent);
+	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
+static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
+{
+	struct bt_sock *bt = bt_sk(parent);
+	struct sock *next = NULL;
+
+	/* accept_q is modified from child teardown paths too, so take a
+	 * temporary reference before dropping the queue lock.
+	 */
+	spin_lock_bh(&bt->accept_q_lock);
+
+	if (sk) {
+		if (bt_sk(sk)->parent != parent)
+			goto out;
+
+		if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
+			next = &list_next_entry(bt_sk(sk), accept_q)->sk;
+			sock_hold(next);
+		}
+	} else if (!list_empty(&bt->accept_q)) {
+		next = &list_first_entry(&bt->accept_q,
+					 struct bt_sock, accept_q)->sk;
+		sock_hold(next);
+	}
+
+out:
+	spin_unlock_bh(&bt->accept_q_lock);
+	return next;
+}
+
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 {
-	struct bt_sock *s, *n;
-	struct sock *sk;
+	struct sock *sk, *next;
 
 	BT_DBG("parent %p", parent);
 
 restart:
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
-		sk = (struct sock *)s;
-
+	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
 		/* Prevent early freeing of sk due to unlink and sock_kill */
-		sock_hold(sk);
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
 		 * bt_accept_unlink() due to serialisation caused by sk locking
 		 */
-		if (!bt_sk(sk)->parent) {
+		if (bt_sk(sk)->parent != parent) {
 			BT_DBG("sk %p, already unlinked", sk);
 			release_sock(sk);
 			sock_put(sk);
 
-			/* Restart the loop as sk is no longer in the list
-			 * and also avoid a potential infinite loop because
-			 * list_for_each_entry_safe() is not thread safe.
-			 */
 			goto restart;
 		}
 
+		next = bt_accept_get(parent, sk);
+
 		/* sk is safely in the parent list so reduce reference count */
 		sock_put(sk);
 
@@ -315,6 +346,8 @@ restart:
 			sock_hold(sk);
 
 			release_sock(sk);
+			if (next)
+				sock_put(next);
 			return sk;
 		}
 
@@ -513,18 +546,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
 
 static inline __poll_t bt_accept_poll(struct sock *parent)
 {
-	struct bt_sock *s, *n;
+	struct bt_sock *bt = bt_sk(parent);
+	struct bt_sock *s;
 	struct sock *sk;
+	__poll_t mask = 0;
+
+	spin_lock_bh(&bt->accept_q_lock);
+	list_for_each_entry(s, &bt->accept_q, accept_q) {
+		int state;
 
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
-		if (sk->sk_state == BT_CONNECTED ||
-		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
-			return EPOLLIN | EPOLLRDNORM;
+		state = READ_ONCE(sk->sk_state);
+
+		if (state == BT_CONNECTED ||
+		    (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
+		     state == BT_CONNECT2)) {
+			mask = EPOLLIN | EPOLLRDNORM;
+			break;
+		}
 	}
+	spin_unlock_bh(&bt->accept_q_lock);
 
-	return 0;
+	return mask;
 }
 
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,



