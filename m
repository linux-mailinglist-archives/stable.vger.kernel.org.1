Return-Path: <stable+bounces-119281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853ADA42594
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7A619C5FA3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF1624D9;
	Mon, 24 Feb 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9ohOcXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66B2571CB;
	Mon, 24 Feb 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408931; cv=none; b=PNDxVVOIoOiQEp3GOW5YAW0hE4+i0C6r0yw90h9jAIpQlV/LTjUxSMCBdb2G0+vde3BQy180xmFu5GfnvFJ/H5kbSSsGiNTC1aFrFQiG7N9iR0yWM94qG8uxvWpF0vSWgYPsQVyPcyZGGrtO2Gu8yWpi4gqxMAdaa6BGxyAPTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408931; c=relaxed/simple;
	bh=T0j19amZxheRLXgjxUako6YqyKIEB+hpK6aPnWcs8gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTSv4FVA5m5V5+GToVhLn6YGel2xh1RYQuqIpsotoRRAdRLPdNfFwQdohF9Hz0eo6+f+liTh7A1gi2FqrgDyLXaeqzsCx9eCVPshWHqVKbQKwhCCZ3j5kzaDlf35HPhyU4MMulMmvDFOc4Av73uDRMMGyP6nk9ucgMZMBv4cS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9ohOcXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F8DC4CED6;
	Mon, 24 Feb 2025 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408931;
	bh=T0j19amZxheRLXgjxUako6YqyKIEB+hpK6aPnWcs8gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c9ohOcXr27EEqIl7RRuAJqP05KjkOUXhPPaEFYLYxKYVknoeheCemrqIDHSXDFjRW
	 19A0R6jWujQidyMJLl/NNp4JHmzyJAJ/o+1b44MpQWabchTkrORPxoP6itHJWPBVzl
	 5XH2zjq+o+v3NhM2cBffZrS2PARdBky754dhI8tI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiumei Mu <xmu@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 047/138] tcp: drop secpath at the same time as we currently drop dst
Date: Mon, 24 Feb 2025 15:34:37 +0100
Message-ID: <20250224142606.325671970@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 9b6412e6979f6f9e0632075f8f008937b5cd4efd ]

Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
running tests that boil down to:
 - create a pair of netns
 - run a basic TCP test over ipcomp6
 - delete the pair of netns

The xfrm_state found on spi_byaddr was not deleted at the time we
delete the netns, because we still have a reference on it. This
lingering reference comes from a secpath (which holds a ref on the
xfrm_state), which is still attached to an skb. This skb is not
leaked, it ends up on sk_receive_queue and then gets defer-free'd by
skb_attempt_defer_free.

The problem happens when we defer freeing an skb (push it on one CPU's
defer_list), and don't flush that list before the netns is deleted. In
that case, we still have a reference on the xfrm_state that we don't
expect at this point.

We already drop the skb's dst in the TCP receive path when it's no
longer needed, so let's also drop the secpath. At this point,
tcp_filter has already called into the LSM hooks that may require the
secpath, so it should not be needed anymore. However, in some of those
places, the MPTCP extension has just been attached to the skb, so we
cannot simply drop all extensions.

Fixes: 68822bdf76f1 ("net: generalize skb freeing deferral to per-cpu lists")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h       | 14 ++++++++++++++
 net/ipv4/tcp_fastopen.c |  4 ++--
 net/ipv4/tcp_input.c    |  8 ++++----
 net/ipv4/tcp_ipv4.c     |  2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894b..bc04599547c36 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -41,6 +41,7 @@
 #include <net/inet_ecn.h>
 #include <net/dst.h>
 #include <net/mptcp.h>
+#include <net/xfrm.h>
 
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
@@ -683,6 +684,19 @@ void tcp_fin(struct sock *sk);
 void tcp_check_space(struct sock *sk);
 void tcp_sack_compress_send_ack(struct sock *sk);
 
+static inline void tcp_cleanup_skb(struct sk_buff *skb)
+{
+	skb_dst_drop(skb);
+	secpath_reset(skb);
+}
+
+static inline void tcp_add_receive_queue(struct sock *sk, struct sk_buff *skb)
+{
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(secpath_exists(skb));
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+}
+
 /* tcp_timer.c */
 void tcp_init_xmit_timers(struct sock *);
 static inline void tcp_clear_xmit_timers(struct sock *sk)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329e..32b28fc21b63c 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -178,7 +178,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return;
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	/* segs_in has been initialized to 1 in tcp_create_openreq_child().
 	 * Hence, reset segs_in to 0 before calling tcp_segs_in()
 	 * to avoid double counting.  Also, tcp_segs_in() expects
@@ -195,7 +195,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4ffebfb503269..0ee22e10fcfae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4970,7 +4970,7 @@ static void tcp_ofo_queue(struct sock *sk)
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 		if (!eaten)
-			__skb_queue_tail(&sk->sk_receive_queue, skb);
+			tcp_add_receive_queue(sk, skb);
 		else
 			kfree_skb_partial(skb, fragstolen);
 
@@ -5162,7 +5162,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				  skb, fragstolen)) ? 1 : 0;
 	tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
 	if (!eaten) {
-		__skb_queue_tail(&sk->sk_receive_queue, skb);
+		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
 	return eaten;
@@ -5245,7 +5245,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		__kfree_skb(skb);
 		return;
 	}
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 	__skb_pull(skb, tcp_hdr(skb)->doff * 4);
 
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
@@ -6214,7 +6214,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPHITS);
 
 			/* Bulk data transfer: receiver */
-			skb_dst_drop(skb);
+			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c26f6c4b7bb4a..96d68f9b1bb9d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2025,7 +2025,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	skb_condense(skb);
 
-	skb_dst_drop(skb);
+	tcp_cleanup_skb(skb);
 
 	if (unlikely(tcp_checksum_complete(skb))) {
 		bh_unlock_sock(sk);
-- 
2.39.5




