Return-Path: <stable+bounces-56815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41D924614
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4AF1C217BE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877341BD50C;
	Tue,  2 Jul 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpE5GhT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEF63D;
	Tue,  2 Jul 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941454; cv=none; b=gqgseooLmEnAHHM7oDoT66L6+o5+o+bfnu/ovLiHVAQg0A72bckZi6dWemWa+MRGeGPzstaiABUA5Mae5B9dgpdehakopAOaywEwB5E2cCdK769I4q1oVXIh3zZYuCUa1ZT+JDzekEq+Ni9Opd9iziD03FyI8C9NXuDsxduwZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941454; c=relaxed/simple;
	bh=YwVWOSBm6aN0fxwChCWWYz1Baxe9XMgbrXTP7LVgsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzDSDFKTwbepNb/8xM4LKQ/k5RWtpqXrAu3Ur+Jom35mDMTRjUQdlw1IK55oIivv2LkrfjTQKnxjKlCh5iDrcn+Be9CJGU4BeB3p2gMMyahlRVZm2aizPIGPp/NyI5QZZ0bhJTL550PQDvMKYuKmMlAe8ECNXbYjxYXRlAho2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpE5GhT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E02C116B1;
	Tue,  2 Jul 2024 17:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941454;
	bh=YwVWOSBm6aN0fxwChCWWYz1Baxe9XMgbrXTP7LVgsrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpE5GhT17ovwnvBecUgmC2PW5f07b1UJKHgfFzEluzgrF9GxYH3qAwsZeQJArONNo
	 oewj9h61Nt+330ZuaLquc5+aGEBztuBPd9LNeWFJuAX0CHh+AbsWFaH8Q5VN5/DrRK
	 hdrr92qPgsybpz37IuxOl9EwaHQ5+nn1RcaMCJCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	luoxuanqiang <luoxuanqiang@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 027/128] Fix race for duplicate reqsk on identical SYN
Date: Tue,  2 Jul 2024 19:03:48 +0200
Message-ID: <20240702170227.261483993@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
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

From: luoxuanqiang <luoxuanqiang@kylinos.cn>

[ Upstream commit ff46e3b4421923937b7f6e44ffcd3549a074f321 ]

When bonding is configured in BOND_MODE_BROADCAST mode, if two identical
SYN packets are received at the same time and processed on different CPUs,
it can potentially create the same sk (sock) but two different reqsk
(request_sock) in tcp_conn_request().

These two different reqsk will respond with two SYNACK packets, and since
the generation of the seq (ISN) incorporates a timestamp, the final two
SYNACK packets will have different seq values.

The consequence is that when the Client receives and replies with an ACK
to the earlier SYNACK packet, we will reset(RST) it.

========================================================================

This behavior is consistently reproducible in my local setup,
which comprises:

                  | NETA1 ------ NETB1 |
PC_A --- bond --- |                    | --- bond --- PC_B
                  | NETA2 ------ NETB2 |

- PC_A is the Server and has two network cards, NETA1 and NETA2. I have
  bonded these two cards using BOND_MODE_BROADCAST mode and configured
  them to be handled by different CPU.

- PC_B is the Client, also equipped with two network cards, NETB1 and
  NETB2, which are also bonded and configured in BOND_MODE_BROADCAST mode.

If the client attempts a TCP connection to the server, it might encounter
a failure. Capturing packets from the server side reveals:

10.10.10.10.45182 > localhost: Flags [S], seq 320236027,
10.10.10.10.45182 > localhost: Flags [S], seq 320236027,
localhost > 10.10.10.10.45182: Flags [S.], seq 2967855116,
localhost > 10.10.10.10.45182: Flags [S.], seq 2967855123, <==
10.10.10.10.45182 > localhost: Flags [.], ack 4294967290,
10.10.10.10.45182 > localhost: Flags [.], ack 4294967290,
localhost > 10.10.10.10.45182: Flags [R], seq 2967855117, <==
localhost > 10.10.10.10.45182: Flags [R], seq 2967855117,

Two SYNACKs with different seq numbers are sent by localhost,
resulting in an anomaly.

========================================================================

The attempted solution is as follows:
Add a return value to inet_csk_reqsk_queue_hash_add() to confirm if the
ehash insertion is successful (Up to now, the reason for unsuccessful
insertion is that a reqsk for the same connection has already been
inserted). If the insertion fails, release the reqsk.

Due to the refcnt, Kuniyuki suggests also adding a return value check
for the DCCP module; if ehash insertion fails, indicating a successful
insertion of the same connection, simply release the reqsk as well.

Simultaneously, In the reqsk_queue_hash_req(), the start of the
req->rsk_timer is adjusted to be after successful insertion.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240621013929.1386815-1-luoxuanqiang@kylinos.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h |  2 +-
 net/dccp/ipv4.c                    |  7 +++++--
 net/dccp/ipv6.c                    |  7 +++++--
 net/ipv4/inet_connection_sock.c    | 17 +++++++++++++----
 net/ipv4/tcp_input.c               |  7 ++++++-
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 8132f330306db..4242f863f5601 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -263,7 +263,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 				      struct request_sock *req,
 				      struct sock *child);
-void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
 				   unsigned long timeout);
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 					 struct request_sock *req,
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 9fe6d96797169..f4a2dce3e1048 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -654,8 +654,11 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_v4_send_response(sk, req))
 		goto drop_and_free;
 
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
-	reqsk_put(req);
+	if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT)))
+		reqsk_free(req);
+	else
+		reqsk_put(req);
+
 	return 0;
 
 drop_and_free:
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index e0b0bf75a46c2..016af0301366d 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -397,8 +397,11 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_v6_send_response(sk, req))
 		goto drop_and_free;
 
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
-	reqsk_put(req);
+	if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT)))
+		reqsk_free(req);
+	else
+		reqsk_put(req);
+
 	return 0;
 
 drop_and_free:
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8407098a59391..c267c5e066e94 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1113,25 +1113,34 @@ static void reqsk_timer_handler(struct timer_list *t)
 	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
 }
 
-static void reqsk_queue_hash_req(struct request_sock *req,
+static bool reqsk_queue_hash_req(struct request_sock *req,
 				 unsigned long timeout)
 {
+	bool found_dup_sk = false;
+
+	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
+		return false;
+
+	/* The timer needs to be setup after a successful insertion. */
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
 	mod_timer(&req->rsk_timer, jiffies + timeout);
 
-	inet_ehash_insert(req_to_sk(req), NULL, NULL);
 	/* before letting lookups find us, make sure all req fields
 	 * are committed to memory and refcnt initialized.
 	 */
 	smp_wmb();
 	refcount_set(&req->rsk_refcnt, 2 + 1);
+	return true;
 }
 
-void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
 				   unsigned long timeout)
 {
-	reqsk_queue_hash_req(req, timeout);
+	if (!reqsk_queue_hash_req(req, timeout))
+		return false;
+
 	inet_csk_reqsk_queue_added(sk);
+	return true;
 }
 EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d85dd394d5b44..852745a90aa8d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7053,7 +7053,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		tcp_rsk(req)->tfo_listener = false;
 		if (!want_cookie) {
 			req->timeout = tcp_timeout_init((struct sock *)req);
-			inet_csk_reqsk_queue_hash_add(sk, req, req->timeout);
+			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
+								    req->timeout))) {
+				reqsk_free(req);
+				return 0;
+			}
+
 		}
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
-- 
2.43.0




