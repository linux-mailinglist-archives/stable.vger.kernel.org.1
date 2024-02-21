Return-Path: <stable+bounces-22493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DC85DC49
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352F6B24F0A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DB7BAFF;
	Wed, 21 Feb 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEb4ECnC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6E78B7C;
	Wed, 21 Feb 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523488; cv=none; b=Q1y5fca0xhBSk2s21BUm4aP8cApv0VpiMvbAT/le3kDHMZwABW3BTuWsCGsPzkTitUzAiN60my3hgWC591u/giJ8zqnIN6IsLiGBtILej9EXH1RJCvE003rLVN9L+r9aA9WwGOYPQ8R9pN8e3tilK8ip+1uY45job6VxDjf0MNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523488; c=relaxed/simple;
	bh=6oHrQiD3DRlv5OvTanFYdpIjhG7h+tLdmBqDKnrOuaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuZ57in+QGwZky5kt/f4Lq5MkXoOlW1KoqftbFP7qzre5PaghZvPBCEZ1sp3HseJ2qFT7N8PMoP0CxCX5o7sh79gM3mX5oYwrAlooZ07LEMCCNcVq/+JxvV5Ki16tEmyemrOQyL0nFGFO38iiEo8IuukQPu+ziseNH5l0WUnpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEb4ECnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03DFC433C7;
	Wed, 21 Feb 2024 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523488;
	bh=6oHrQiD3DRlv5OvTanFYdpIjhG7h+tLdmBqDKnrOuaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEb4ECnCj6dUp4qlltOO/ZOq9HMeZM+uNvKtFq2lvWT6GfaLUAwMTP5hwyJIni2uR
	 gTrCh/aUdEAFRzd1vBAVIYwv5fklrb+qF2fa/capw9GE1iy1I9VVvwkgu0Y3/tOBgf
	 ylvh6h1AVjduu14omMF8JV732ONGyaX8DCjQ/AcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
	Ziqi Zhao <astrajoan@yahoo.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 421/476] can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
Date: Wed, 21 Feb 2024 14:07:52 +0100
Message-ID: <20240221130023.603027199@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

From: Ziqi Zhao <astrajoan@yahoo.com>

commit 6cdedc18ba7b9dacc36466e27e3267d201948c8d upstream.

The following 3 locks would race against each other, causing the
deadlock situation in the Syzbot bug report:

- j1939_socks_lock
- active_session_list_lock
- sk_session_queue_lock

A reasonable fix is to change j1939_socks_lock to an rwlock, since in
the rare situations where a write lock is required for the linked list
that j1939_socks_lock is protecting, the code does not attempt to
acquire any more locks. This would break the circular lock dependency,
where, for example, the current thread already locks j1939_socks_lock
and attempts to acquire sk_session_queue_lock, and at the same time,
another thread attempts to acquire j1939_socks_lock while holding
sk_session_queue_lock.

NOTE: This patch along does not fix the unregister_netdevice bug
reported by Syzbot; instead, it solves a deadlock situation to prepare
for one or more further patches to actually fix the Syzbot bug, which
appears to be a reference counting problem within the j1939 codebase.

Reported-by: <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/all/20230721162226.8639-1-astrajoan@yahoo.com
[mkl: remove unrelated newline change]
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/j1939-priv.h |    2 +-
 net/can/j1939/main.c       |    2 +-
 net/can/j1939/socket.c     |   24 ++++++++++++------------
 3 files changed, 14 insertions(+), 14 deletions(-)

--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -86,7 +86,7 @@ struct j1939_priv {
 	unsigned int tp_max_packet_size;
 
 	/* lock for j1939_socks list */
-	spinlock_t j1939_socks_lock;
+	rwlock_t j1939_socks_lock;
 	struct list_head j1939_socks;
 
 	struct kref rx_kref;
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -270,7 +270,7 @@ struct j1939_priv *j1939_netdev_start(st
 		return ERR_PTR(-ENOMEM);
 
 	j1939_tp_init(priv);
-	spin_lock_init(&priv->j1939_socks_lock);
+	rwlock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
 	mutex_lock(&j1939_netdev_lock);
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_p
 	jsk->state |= J1939_SOCK_BOUND;
 	j1939_priv_get(priv);
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_del_init(&jsk->list);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 
 	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
@@ -329,13 +329,13 @@ bool j1939_sk_recv_match(struct j1939_pr
 	struct j1939_sock *jsk;
 	bool match = false;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		match = j1939_sk_recv_match_one(jsk, skcb);
 		if (match)
 			break;
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 
 	return match;
 }
@@ -344,11 +344,11 @@ void j1939_sk_recv(struct j1939_priv *pr
 {
 	struct j1939_sock *jsk;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		j1939_sk_recv_one(jsk, skb);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_sk_sock_destruct(struct sock *sk)
@@ -1078,12 +1078,12 @@ void j1939_sk_errqueue(struct j1939_sess
 	}
 
 	/* spread RX notifications to all sockets subscribed to this session */
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		if (j1939_sk_recv_match_one(jsk, &session->skcb))
 			__j1939_sk_errqueue(session, &jsk->sk, type);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 };
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
@@ -1271,7 +1271,7 @@ void j1939_sk_netdev_event_netdown(struc
 	struct j1939_sock *jsk;
 	int error_code = ENETDOWN;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		jsk->sk.sk_err = error_code;
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
@@ -1279,7 +1279,7 @@ void j1939_sk_netdev_event_netdown(struc
 
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,



