Return-Path: <stable+bounces-57819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98D925E5C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CE429A8BA
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A655917C237;
	Wed,  3 Jul 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv0gH3Tu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FC17C202;
	Wed,  3 Jul 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006028; cv=none; b=A5mSdNDaUV2AlAkUWeEJ39olQ5kxdqVAd23czMj0tt3GQ0x6EbTLf015k6bQNhtk6gpUKh7u1XyYnLYfIfIT4xtriT6FMQ7c8xlOldMGLjG3vHPhtF5skQRf4hXvrdcPx7qKPGW4Zh81aLC8clr9x1lMqWcDln/m9oLvE/oz9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006028; c=relaxed/simple;
	bh=V4Thayet0nyqnoC54hNzU9fWnJ/G8ZIXsARMuHuStP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKsOYzCQPb+Aiz7YWjNCKSgyd6tKS2IWIyRk201LZ64ajhpHxrdCVmYHxc2zooLlup++s6jDSLEQFiRG6EcniGzsicBYBYp6AD+JBk+otlcfxRz9FpY7QYz83i1wRuW1T2lqYwzlvQ2ZtFYthJoeDkKoTXrfGE9fBTMhA7R6VVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv0gH3Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E1DC32781;
	Wed,  3 Jul 2024 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006027;
	bh=V4Thayet0nyqnoC54hNzU9fWnJ/G8ZIXsARMuHuStP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cv0gH3TupZHNJmb33bc80OuiFc4kGQsBvxP6JGbwLAaUya0NLd2o6fIeMK+Mxvq0u
	 ELt0pLh0jneYaC5lrVIvi+5PagMAMWXwDJvnFNzJdlVkROLtvtXOU/RihE5WCRwjTv
	 EqYSThUqK9ppkwEvUipTMQN9tHZdRKH/W3J7/6rw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhmat Karakotov <hmukos@yandex-team.ru>,
	Martin KaFai Lau <kafai@fb.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 275/356] tcp: Use BPF timeout setting for SYN ACK RTO
Date: Wed,  3 Jul 2024 12:40:11 +0200
Message-ID: <20240703102923.517310031@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Akhmat Karakotov <hmukos@yandex-team.ru>

[ Upstream commit 5903123f662ed18483f05cac3f9e800a074c29ff ]

When setting RTO through BPF program, some SYN ACK packets were unaffected
and continued to use TCP_TIMEOUT_INIT constant. This patch adds timeout
option to struct request_sock. Option is initialized with TCP_TIMEOUT_INIT
and is reassigned through BPF using tcp_timeout_init call. SYN ACK
retransmits now use newly added timeout option.

Signed-off-by: Akhmat Karakotov <hmukos@yandex-team.ru>
Acked-by: Martin KaFai Lau <kafai@fb.com>

v2:
	- Add timeout option to struct request_sock. Do not call
	  tcp_timeout_init on every syn ack retransmit.

v3:
	- Use unsigned long for min. Bound tcp_timeout_init to TCP_RTO_MAX.

v4: - Refactor duplicate code by adding reqsk_timeout function.
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ff46e3b44219 ("Fix race for duplicate reqsk on identical SYN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 8 ++++++++
 include/net/request_sock.h         | 2 ++
 include/net/tcp.h                  | 2 +-
 net/ipv4/inet_connection_sock.c    | 5 +----
 net/ipv4/tcp_input.c               | 8 +++++---
 net/ipv4/tcp_minisocks.c           | 5 ++---
 6 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index b6b7e210f9d7a..7794cf2b5ef50 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -284,6 +284,14 @@ static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req);
 
+static inline unsigned long
+reqsk_timeout(struct request_sock *req, unsigned long max_timeout)
+{
+	u64 timeout = (u64)req->timeout << req->num_timeout;
+
+	return (unsigned long)min_t(u64, timeout, max_timeout);
+}
+
 static inline void inet_csk_prepare_for_destroy_sock(struct sock *sk)
 {
 	/* The below has to be done to allow calling inet_csk_destroy_sock */
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 29e41ff3ec933..144c39db9898a 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -70,6 +70,7 @@ struct request_sock {
 	struct saved_syn		*saved_syn;
 	u32				secid;
 	u32				peer_secid;
+	u32				timeout;
 };
 
 static inline struct request_sock *inet_reqsk(const struct sock *sk)
@@ -104,6 +105,7 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	sk_node_init(&req_to_sk(req)->sk_node);
 	sk_tx_queue_clear(req_to_sk(req));
 	req->saved_syn = NULL;
+	req->timeout = 0;
 	req->num_timeout = 0;
 	req->num_retrans = 0;
 	req->sk = NULL;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 08923ed4278f0..30f8111f750b5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2362,7 +2362,7 @@ static inline u32 tcp_timeout_init(struct sock *sk)
 
 	if (timeout <= 0)
 		timeout = TCP_TIMEOUT_INIT;
-	return timeout;
+	return min_t(int, timeout, TCP_RTO_MAX);
 }
 
 static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 27975a44d1f9d..43e370f45b81d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -889,12 +889,9 @@ static void reqsk_timer_handler(struct timer_list *t)
 	    (!resend ||
 	     !inet_rtx_syn_ack(sk_listener, req) ||
 	     inet_rsk(req)->acked)) {
-		unsigned long timeo;
-
 		if (req->num_timeout++ == 0)
 			atomic_dec(&queue->young);
-		timeo = min(TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
-		mod_timer(&req->rsk_timer, jiffies + timeo);
+		mod_timer(&req->rsk_timer, jiffies + reqsk_timeout(req, TCP_RTO_MAX));
 
 		if (!nreq)
 			return;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5ad7e6965a645..ca72dbaa27b46 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6769,6 +6769,7 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 		ireq->ireq_state = TCP_NEW_SYN_RECV;
 		write_pnet(&ireq->ireq_net, sock_net(sk_listener));
 		ireq->ireq_family = sk_listener->sk_family;
+		req->timeout = TCP_TIMEOUT_INIT;
 	}
 
 	return req;
@@ -6991,9 +6992,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		sock_put(fastopen_sk);
 	} else {
 		tcp_rsk(req)->tfo_listener = false;
-		if (!want_cookie)
-			inet_csk_reqsk_queue_hash_add(sk, req,
-				tcp_timeout_init((struct sock *)req));
+		if (!want_cookie) {
+			req->timeout = tcp_timeout_init((struct sock *)req);
+			inet_csk_reqsk_queue_hash_add(sk, req, req->timeout);
+		}
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
 						   TCP_SYNACK_COOKIE,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2606a5571116a..d84b71f70766b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -593,7 +593,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			 * it can be estimated (approximately)
 			 * from another data.
 			 */
-			tmp_opt.ts_recent_stamp = ktime_get_seconds() - ((TCP_TIMEOUT_INIT/HZ)<<req->num_timeout);
+			tmp_opt.ts_recent_stamp = ktime_get_seconds() - reqsk_timeout(req, TCP_RTO_MAX) / HZ;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}
@@ -632,8 +632,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		    !inet_rtx_syn_ack(sk, req)) {
 			unsigned long expires = jiffies;
 
-			expires += min(TCP_TIMEOUT_INIT << req->num_timeout,
-				       TCP_RTO_MAX);
+			expires += reqsk_timeout(req, TCP_RTO_MAX);
 			if (!fastopen)
 				mod_timer_pending(&req->rsk_timer, expires);
 			else
-- 
2.43.0




