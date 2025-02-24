Return-Path: <stable+bounces-119051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65150A423FF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C49169DE4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904A314A62A;
	Mon, 24 Feb 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m8kIoC3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5862A8D0;
	Mon, 24 Feb 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408153; cv=none; b=N4UlWEStNlWlNnrN2UBugld/5mo8V2z1HkvmkDk/8ioGP0sxvN/Sp5vR0XqlBtTEUSWnxqnk12xtsx7oiilj/ug/FXWk9dmUhD5dv/Ne0iqs/JwlwsEU2UAe8NkeYhJlI1JEIhZqrwmNoD/Z0pn6obcH6QG5s9udOtHoUhwTqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408153; c=relaxed/simple;
	bh=mGnVqT/T08xjX5+FYCx3RDjqZxMufGld7iFPQVByM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDqtBKZSmxZfoGaeQYw9EovRfySZ0FgDC74GDiB+GG7fxF3BpZed8z0zda71bjLSopxeeWIf0MnWwKd7jN7WWGLLqF0Vi2GVMLbtpVFWRMFDM/xMFQPTpXSjRVgRHTjSL8uTFn5QxQrYrxKMRj2jNAdRH4G/Ch8xIUUmLiN2yYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m8kIoC3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF372C4CED6;
	Mon, 24 Feb 2025 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408153;
	bh=mGnVqT/T08xjX5+FYCx3RDjqZxMufGld7iFPQVByM8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8kIoC3uMT+CATfe6BAJFKxG+mZ6BQIc6mqEa4QYyiSwvBYZkJtVxP/ma616iQ+J9
	 8ZrOIZTiIbEIJ8VdyY5D2Nqh00rhqzbECk2D+XuUaLzK/gp9zOiHhPyGKwYU4jfc5G
	 YCSuH//TUgQgSNCEaKj6oCzoaybDEF4rNMqdLn5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <mrpre@163.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 098/140] bpf: Fix wrong copied_seq calculation
Date: Mon, 24 Feb 2025 15:34:57 +0100
Message-ID: <20250224142606.867016278@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <mrpre@163.com>

[ Upstream commit 36b62df5683c315ba58c950f1a9c771c796c30ec ]

'sk->copied_seq' was updated in the tcp_eat_skb() function when the action
of a BPF program was SK_REDIRECT. For other actions, like SK_PASS, the
update logic for 'sk->copied_seq' was moved to tcp_bpf_recvmsg_parser()
to ensure the accuracy of the 'fionread' feature.

It works for a single stream_verdict scenario, as it also modified
sk_data_ready->sk_psock_verdict_data_ready->tcp_read_skb
to remove updating 'sk->copied_seq'.

However, for programs where both stream_parser and stream_verdict are
active (strparser purpose), tcp_read_sock() was used instead of
tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock).
tcp_read_sock() now still updates 'sk->copied_seq', leading to duplicate
updates.

In summary, for strparser + SK_PASS, copied_seq is redundantly calculated
in both tcp_read_sock() and tcp_bpf_recvmsg_parser().

The issue causes incorrect copied_seq calculations, which prevent
correct data reads from the recv() interface in user-land.

We do not want to add new proto_ops to implement a new version of
tcp_read_sock, as this would introduce code complexity [1].

We could have added noack and copied_seq to desc, and then called
ops->read_sock. However, unfortunately, other modules didn’t fully
initialize desc to zero. So, for now, we are directly calling
tcp_read_sock_noack() in tcp_bpf.c.

[1]: https://lore.kernel.org/bpf/20241218053408.437295-1-mrpre@163.com

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://patch.msgid.link/20250122100917.49845-3-mrpre@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h |  2 ++
 include/net/tcp.h     |  8 ++++++++
 net/core/skmsg.c      |  7 +++++++
 net/ipv4/tcp.c        | 29 ++++++++++++++++++++++++-----
 net/ipv4/tcp_bpf.c    | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 6ccfd9236387c..32bbebf5b71e3 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -87,6 +87,8 @@ struct sk_psock {
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
 	struct strparser		strp;
+	u32				copied_seq;
+	u32				ingress_bytes;
 #endif
 	struct sk_buff_head		ingress_skb;
 	struct list_head		ingress_msg;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 78c755414fa87..a6def0aab3ed3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -690,6 +690,9 @@ void tcp_get_info(struct sock *, struct tcp_info *);
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		  sk_read_actor_t recv_actor);
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off);
 void tcp_read_done(struct sock *sk, size_t len);
@@ -2404,6 +2407,11 @@ struct sk_psock;
 #ifdef CONFIG_BPF_SYSCALL
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+#ifdef CONFIG_BPF_STREAM_PARSER
+struct strparser;
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor);
+#endif /* CONFIG_BPF_STREAM_PARSER */
 #endif /* CONFIG_BPF_SYSCALL */
 
 #ifdef CONFIG_INET
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 902098e221b39..b9b941c487c8a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -548,6 +548,9 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 			return num_sge;
 	}
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+	psock->ingress_bytes += len;
+#endif
 	copied = len;
 	msg->sg.start = 0;
 	msg->sg.size = copied;
@@ -1143,6 +1146,10 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
+	if (sk_is_tcp(sk)) {
+		psock->strp.cb.read_sock = tcp_bpf_strp_read_sock;
+		psock->copied_seq = tcp_sk(sk)->copied_seq;
+	}
 	return ret;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5e6615f69f175..7ad82be40f348 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1553,12 +1553,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor, bool noack,
+			   u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1612,9 +1613,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1623,10 +1627,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, bool noack,
+			u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, noack, copied_seq);
+}
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f882054fae5ee..5312237e80409 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -646,6 +646,42 @@ static int tcp_bpf_assert_proto_ops(struct proto *ops)
 	       ops->sendmsg  == tcp_sendmsg ? 0 : -ENOTSUPP;
 }
 
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
+			   sk_read_actor_t recv_actor)
+{
+	struct sock *sk = strp->sk;
+	struct sk_psock *psock;
+	struct tcp_sock *tp;
+	int copied = 0;
+
+	tp = tcp_sk(sk);
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (WARN_ON_ONCE(!psock)) {
+		desc->error = -EINVAL;
+		goto out;
+	}
+
+	psock->ingress_bytes = 0;
+	copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
+				     &psock->copied_seq);
+	if (copied < 0)
+		goto out;
+	/* recv_actor may redirect skb to another socket (SK_REDIRECT) or
+	 * just put skb into ingress queue of current socket (SK_PASS).
+	 * For SK_REDIRECT, we need to ack the frame immediately but for
+	 * SK_PASS, we want to delay the ack until tcp_bpf_recvmsg_parser().
+	 */
+	tp->copied_seq = psock->copied_seq - psock->ingress_bytes;
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, copied - psock->ingress_bytes);
+out:
+	rcu_read_unlock();
+	return copied;
+}
+#endif /* CONFIG_BPF_STREAM_PARSER */
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
 	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
-- 
2.39.5




