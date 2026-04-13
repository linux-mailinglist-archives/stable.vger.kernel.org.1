Return-Path: <stable+bounces-235979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EENaDBO63GlCVwkAu9opvQ
	(envelope-from <stable+bounces-235979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:40:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B27263E9F0A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352B1301385C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA67382F1C;
	Mon, 13 Apr 2026 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="iT9XmzFG"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B683AC0C4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073230; cv=none; b=VqtFHWulsEZTKNjeLs2XJnfCn6KsU2TKZ+seg8aWpONPF8RSyu9undeej32jSWrAObu/41wIkqa+GQ6ShSDDeki5AEmQYno9F1PRj+SD2jn2551Q0QcljP2+SFbneYFkuH6FwH0VWhebr9+DQNKUCMxdbuJY2j3QQ12kcKfWHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073230; c=relaxed/simple;
	bh=gIf/Zyr9MnRe5D1cHj8TCZIvcxyMRs5UAO1yDXXSzbQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GxWBsZBpRp1yctw7g8yjTYqYXZVmZlXtqXdAZEKfWgmA/RNJ28aoOW/0hbsBBmdJVnx9nXD2finqryocw+uoZhj2iIlhXHPfG3mx+Q5SRJgwyl28Xw0Nj24YrorbBq6S7+47k7ke+fPvOw++JIQguvtviqQLVpSaxidrfnMPh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=iT9XmzFG; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=iT9XmzFGphjuHMo+7vCZhOISkEzhE4B9ZOE7SGf62IWrBnh0N0utg4/6AMPRSZXDLxpnVzJQM5V+5
	 kL/goSUIpzMCOZY10VBwlR+GUgbexOBO/93alrgoATqGm/ly3Eh3CdR5CUUViGtUgvi2WZDetW6fG2
	 HyJnbzo9jIpKShLw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-Mobile-Kernel-Team (unknown[223.104.41.220])
	by rmsmtp-lg-appmail-38-12052 (RichMail) with SMTP id 2f1469dcb9fddf5-bad59;
	Mon, 13 Apr 2026 17:40:15 +0800 (CST)
X-RM-TRANSID:2f1469dcb9fddf5-bad59
From: Leon Chen <leonchen.oss@139.com>
To: stable@vger.kernel.org,
	edumazet@google.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	willemdebruijn.kernel@gmail.com,
	kuniyu@google.com,
	kuba@kernel.org
Subject: [PATCH 6.12.y] net: annotate data-races around sk->sk_{data_ready,write_space}
Date: Mon, 13 Apr 2026 17:40:12 +0800
Message-Id: <20260413094012.10489-1-leonchen.oss@139.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235979-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[139.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,google.com,iogearbox.net,gmail.com,cloudflare.com,kernel.org];
	NEURAL_SPAM(0.00)[0.776];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonchen.oss@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,msgid.link:url,appspotmail.com:email,139.com:email,139.com:mid]
X-Rspamd-Queue-Id: B27263E9F0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2ef2b20cf4e04ac8a6ba68493f8780776ff84300 ]

skmsg (and probably other layers) are changing these pointers
while other cpus might read them concurrently.

Add corresponding READ_ONCE()/WRITE_ONCE() annotations
for UDP, TCP and AF_UNIX.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: syzbot+87f770387a9e5dc6b79b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/699ee9fc.050a0220.1cd54b.0009.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260225131547.1085509-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Leon Chen <leonchen.oss@139.com>
---
 net/core/skmsg.c         | 14 +++++++-------
 net/ipv4/tcp.c           |  4 ++--
 net/ipv4/tcp_bpf.c       |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++++------
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/udp.c           |  3 ++-
 net/ipv4/udp_bpf.c       |  2 +-
 net/unix/af_unix.c       |  8 ++++----
 8 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2e89087b95c2..e1e0283e53c1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1204,8 +1204,8 @@ void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	psock->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_strp_data_ready;
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_data_ready, sk_psock_strp_data_ready);
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
@@ -1215,8 +1215,8 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 	if (!psock->saved_data_ready)
 		return;
 
-	sk->sk_data_ready = psock->saved_data_ready;
-	psock->saved_data_ready = NULL;
+	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
+	WRITE_ONCE(psock->saved_data_ready, NULL);
 	strp_stop(&psock->strp);
 }
 
@@ -1298,8 +1298,8 @@ void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
 		return;
 
 	psock->saved_data_ready = sk->sk_data_ready;
-	sk->sk_data_ready = sk_psock_verdict_data_ready;
-	sk->sk_write_space = sk_psock_write_space;
+	WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
+	WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
 }
 
 void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
@@ -1310,6 +1310,6 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	if (!psock->saved_data_ready)
 		return;
 
-	sk->sk_data_ready = psock->saved_data_ready;
+	WRITE_ONCE(sk->sk_data_ready, psock->saved_data_ready);
 	psock->saved_data_ready = NULL;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c532803b9957..9c5fc4464783 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1346,7 +1346,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	err = sk_stream_error(sk, flags, err);
 	/* make sure we wake any epoll edge trigger waiter */
 	if (unlikely(tcp_rtx_and_write_queues_empty(sk) && err == -EAGAIN)) {
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 	}
 	return err;
@@ -4023,7 +4023,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	case TCP_NOTSENT_LOWAT:
 		WRITE_ONCE(tp->notsent_lowat, val);
-		sk->sk_write_space(sk);
+		READ_ONCE(sk->sk_write_space)(sk);
 		break;
 	case TCP_INQ:
 		if (val > 1 || val < 0)
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f5817438f173..b9a58fde9c31 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -725,7 +725,7 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 			WRITE_ONCE(sk->sk_prot->unhash, psock->saved_unhash);
 			tcp_update_ulp(sk, psock->sk_proto, psock->saved_write_space);
 		} else {
-			sk->sk_write_space = psock->saved_write_space;
+			WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 			/* Pairs with lockless read in sk_clone_lock() */
 			sock_replace_proto(sk, psock->sk_proto);
 		}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1d9e93a04930..c498588c021d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5034,7 +5034,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(tcp_try_rmem_schedule(sk, skb, skb->truesize))) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPOFODROP);
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 		tcp_drop_reason(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		return;
 	}
@@ -5241,7 +5241,7 @@ int tcp_send_rcvq(struct sock *sk, struct msghdr *msg, size_t size)
 void tcp_data_ready(struct sock *sk)
 {
 	if (tcp_epollin_ready(sk, sk->sk_rcvlowat) || sock_flag(sk, SOCK_DONE))
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 }
 
 static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
@@ -5297,7 +5297,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 			inet_csk(sk)->icsk_ack.pending |=
 					(ICSK_ACK_NOMEM | ICSK_ACK_NOW);
 			inet_csk_schedule_ack(sk);
-			sk->sk_data_ready(sk);
+			READ_ONCE(sk->sk_data_ready)(sk);
 
 			if (skb_queue_len(&sk->sk_receive_queue) && skb->len) {
 				reason = SKB_DROP_REASON_PROTO_MEM;
@@ -5735,7 +5735,9 @@ static void tcp_new_space(struct sock *sk)
 		tp->snd_cwnd_stamp = tcp_jiffies32;
 	}
 
-	INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
+	INDIRECT_CALL_1(READ_ONCE(sk->sk_write_space),
+			sk_stream_write_space,
+			sk);
 }
 
 /* Caller made space either from:
@@ -5941,7 +5943,7 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 				BUG();
 			WRITE_ONCE(tp->urg_data, TCP_URG_VALID | tmp);
 			if (!sock_flag(sk, SOCK_DEAD))
-				sk->sk_data_ready(sk);
+				READ_ONCE(sk->sk_data_ready)(sk);
 		}
 	}
 }
@@ -7341,7 +7343,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			sock_put(fastopen_sk);
 			goto drop_and_free;
 		}
-		sk->sk_data_ready(sk);
+		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
 		sock_put(fastopen_sk);
 	} else {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f3e4fc957219..adddfb7d934c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -928,7 +928,7 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 		reason = tcp_rcv_state_process(child, skb);
 		/* Wakeup parent, send SIGIO */
 		if (state == TCP_SYN_RECV && child->sk_state != state)
-			parent->sk_data_ready(parent);
+			READ_ONCE(parent->sk_data_ready)(parent);
 	} else {
 		/* Alas, it is possible again, because we do lookup
 		 * in main socket hash table and lock on listening
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d1090a1f860c..27694334e410 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1622,7 +1622,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	spin_unlock(&list->lock);
 
 	if (!sock_flag(sk, SOCK_DEAD))
-		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
+		INDIRECT_CALL_1(READ_ONCE(sk->sk_data_ready),
+				sock_def_readable, sk);
 
 	busylock_release(busy);
 	return 0;
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97..779a3a03762f 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
 
 	if (restore) {
-		sk->sk_write_space = psock->saved_write_space;
+		WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
 		sock_replace_proto(sk, psock->sk_proto);
 		return 0;
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 59911ac719b1..aa6395fd58bb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1707,7 +1707,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 	sock_put(other);
 	return 0;
 
@@ -2175,7 +2175,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 	sock_put(other);
 	scm_destroy(&scm);
 	return len;
@@ -2243,7 +2243,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
-	other->sk_data_ready(other);
+	READ_ONCE(other->sk_data_ready)(other);
 
 	return err;
 }
@@ -2354,7 +2354,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
 		unix_state_unlock(other);
-		other->sk_data_ready(other);
+		READ_ONCE(other->sk_data_ready)(other);
 		sent += size;
 	}
 
-- 
2.35.3



