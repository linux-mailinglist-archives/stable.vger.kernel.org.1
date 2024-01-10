Return-Path: <stable+bounces-10235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E665A8273E0
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188D11C22D3B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECB524D1;
	Mon,  8 Jan 2024 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SA5XlBO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1795100F;
	Mon,  8 Jan 2024 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D4AC433C7;
	Mon,  8 Jan 2024 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728413;
	bh=2SiLvK7LLdHbG2X9/veHHo1aYEb4qtIWEEvwANcBN9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA5XlBO8BksIwBDvk+OP8rfd3d3CCWnPrTWOWt0bv1V04F+ax7OoUcBM3U2QbLRRU
	 Rx0Piby3zYxasUEVS8KH89kz56XzzKSwv6TDQCg8kAEHHMEwgmnsVlsK/JFzikeIdt
	 hxLswdLUxVVbT9u5rPIGSD0dC5QLaDC0GRnCvWEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 069/150] udp: move udp->no_check6_rx to udp->udp_flags
Date: Mon,  8 Jan 2024 16:35:20 +0100
Message-ID: <20240108153514.405898674@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit bcbc1b1de884647aa0318bf74eb7f293d72a1e40 ]

syzbot reported that udp->no_check6_rx can be read locklessly.
Use one atomic bit from udp->udp_flags.

Fixes: 1c19448c9ba6 ("net: Make enabling of zero UDP6 csums more restrictive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 10 +++++-----
 net/ipv4/udp.c      |  4 ++--
 net/ipv6/udp.c      |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index b5ca5760ae34b..e6cd46e2b0831 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -33,6 +33,7 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
+	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
 };
 
 struct udp_sock {
@@ -46,8 +47,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
-			 encap_enabled:1, /* This socket enabled encap
+	unsigned char	 encap_enabled:1, /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
 					   * this
@@ -117,7 +117,7 @@ static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 
 static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
 {
-	udp_sk(sk)->no_check6_rx = val;
+	udp_assign_bit(NO_CHECK6_RX, sk, val);
 }
 
 static inline bool udp_get_no_check6_tx(const struct sock *sk)
@@ -125,9 +125,9 @@ static inline bool udp_get_no_check6_tx(const struct sock *sk)
 	return udp_test_bit(NO_CHECK6_TX, sk);
 }
 
-static inline bool udp_get_no_check6_rx(struct sock *sk)
+static inline bool udp_get_no_check6_rx(const struct sock *sk)
 {
-	return udp_sk(sk)->no_check6_rx;
+	return udp_test_bit(NO_CHECK6_RX, sk);
 }
 
 static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 513035e83a820..01e74919885ad 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2715,7 +2715,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		up->no_check6_rx = valbool;
+		udp_set_no_check6_rx(sk, valbool);
 		break;
 
 	case UDP_SEGMENT:
@@ -2812,7 +2812,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		val = up->no_check6_rx;
+		val = udp_get_no_check6_rx(sk);
 		break;
 
 	case UDP_SEGMENT:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c6e20293c521f..ae4f7f983f951 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -882,7 +882,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		/* If zero checksum and no_check is not on for
 		 * the socket then skip it.
 		 */
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			continue;
 		if (!first) {
 			first = sk;
@@ -1000,7 +1000,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
 			udp6_sk_rx_dst_set(sk, dst);
 
-		if (!uh->check && !udp_sk(sk)->no_check6_rx) {
+		if (!uh->check && !udp_get_no_check6_rx(sk)) {
 			if (refcounted)
 				sock_put(sk);
 			goto report_csum_error;
@@ -1022,7 +1022,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk) {
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			goto report_csum_error;
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
-- 
2.43.0




