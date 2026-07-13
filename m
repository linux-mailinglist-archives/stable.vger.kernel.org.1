Return-Path: <stable+bounces-273541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8EmlJjpSVGqVkgMAu9opvQ
	(envelope-from <stable+bounces-273541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:49:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29623746CAF
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:49:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=ODhvo5Y+;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273541-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273541-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 824713004618
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 02:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67933F598;
	Mon, 13 Jul 2026 02:49:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A323164D8;
	Mon, 13 Jul 2026 02:49:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910965; cv=none; b=a8KFHMG/5b5191tl/us/rm7XuI/3ilEuyzpOSVcdcHno8LqNof9TC1Rt5i4hQGtP4eVoL+yYRX/ly0K/ZEZwNblXro9M4vifwDZqfsNFdvA7vCje1j7ZJ8zeRg2dpDbc9aXNyqhI4HX9FaJoRMYqRrRONN8NqW5Tkk3Zq5Smxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910965; c=relaxed/simple;
	bh=VAZoRxPSYfk8gAKWaxC8EYdBMTrC1+1jGrsyn+Jo2lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpW68lx6XdZmwi0/zVWttnjbofbUa790vHFAfyA5kqHTHhiw3xdQoAktjFIiLTlNPpmkAsATOfZZWgwrKyM1Rez7hc3ZxMcnw9iYFQ4nLJ2ejOtcef2cm1WJI9ffMe5XBHd1N4eEwSIZMdHQwyXx5ae2X/EgSlfW/0W0EOvozC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ODhvo5Y+; arc=none smtp.client-ip=115.124.30.130
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783910954; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=05yePzfKJumy9hVGqULpfJ2/gstIRsXkfmnj+SFp9bs=;
	b=ODhvo5Y+1GWWSI4VAaXQ5hKMTmZYE92C7u+d06aByETRk9DsShDdHuRVvjyk441/X43ztwpXxvWY06Fuxbo82/K1S08CFM0PRKbuAXvKhIKLyhwb0UE3blrm4mYZOl4UvnUh7y+WKwxTU6k1zJq9CFa3fbJmKlW3nPUE24x30YU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X6tGtlB_1783910952;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X6tGtlB_1783910952 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 10:49:13 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: bigeasy@linutronix.de,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	heiko.stuebner@cherry.de
Subject: [PATCH 6.1.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Mon, 13 Jul 2026 10:49:12 +0800
Message-Id: <20260713024912.36991-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273541-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,google.com,gmail.com,redhat.com,linux.alibaba.com,davemloft.net,kernel.org,vger.kernel.org,cherry.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bigeasy@linutronix.de,m:willemb@google.com,m:kerneljasonxing@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:lulie@linux.alibaba.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dust.li@linux.alibaba.com,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email,msgid.link:url,linutronix.de:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29623746CAF

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 upstream.

skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
not be taken in IRQ context, only softirq is okay. A few drivers receive
the timestamp via a dedicated interrupt and complete the TX timestamp
from that handler. This will lead to a deadlock if the lock is already
write-locked on the same CPU.

Taking the lock can be avoided. The socket (pointed by the skb) will
remain valid until the skb is released. The ->sk_socket and ->file
member will be set to NULL once the user closes the socket which may
happen before the timestamp arrives.
If we happen to observe the pointer while the socket is closing but
before the pointer is set to NULL then we may use it because both
pointer (and the file's cred member) are RCU freed.

Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
matching WRITE_ONCE() where the pointer are cleared.

Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260220183858.N4ERjFW6@linutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ adapted sk_set_socket() in include/net/sock.h to fix the conflict from
 not having commit 5d6b58c932ec ("net: lockless sock_i_ino()") and the
 additional previous changes required by it.
 It comes down to just now having the lines of
    if (sock) {
            WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
            WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
    }
 below the changed line. ]
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
This patch is same as that in 6.12 (c770217044d9)
---
 include/net/sock.h |  2 +-
 net/core/skbuff.c  | 23 ++++++++++++++++++-----
 net/socket.c       |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1e7096e9bc484..9fe621f985740 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2181,7 +2181,7 @@ static inline int sk_rx_queue_get(const struct sock *sk)
 
 static inline void sk_set_socket(struct sock *sk, struct socket *sock)
 {
-	sk->sk_socket = sock;
+	WRITE_ONCE(sk->sk_socket, sock);
 }
 
 static inline wait_queue_head_t *sk_sleep(struct sock *sk)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f41dd20991c3d..6575a76a312e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4948,15 +4948,28 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 
 static bool skb_may_tx_timestamp(struct sock *sk, bool tsonly)
 {
-	bool ret;
+	struct socket *sock;
+	struct file *file;
+	bool ret = false;
 
 	if (likely(READ_ONCE(sysctl_tstamp_allow_data) || tsonly))
 		return true;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	ret = sk->sk_socket && sk->sk_socket->file &&
-	      file_ns_capable(sk->sk_socket->file, &init_user_ns, CAP_NET_RAW);
-	read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	rcu_read_lock();
+	sock = READ_ONCE(sk->sk_socket);
+	if (!sock)
+		goto out;
+	file = READ_ONCE(sock->file);
+	if (!file)
+		goto out;
+	ret = file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
+out:
+	rcu_read_unlock();
 	return ret;
 }
 
diff --git a/net/socket.c b/net/socket.c
index f2b4cf9b09a32..8bf415a59e55c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -666,7 +666,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		iput(SOCK_INODE(sock));
 		return;
 	}
-	sock->file = NULL;
+	WRITE_ONCE(sock->file, NULL);
 }
 
 /**
-- 
2.47.3


