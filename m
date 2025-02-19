Return-Path: <stable+bounces-117612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C3A3B74D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB64E18861BA
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4991D9A50;
	Wed, 19 Feb 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2r57Ltw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D01C701E;
	Wed, 19 Feb 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955830; cv=none; b=TeKpM6x0N5q1q8toaF1Rh5CyXNhI42Gc5RVhqmGY3hU/TBygtQujLAhMEjTSXVhKrU3C9YJvn2jc0Oe5IBCdHJhKLiMZOIP3MMXubQZVV0N8y428yZXJ8wdd6N4fv35RREsGdlvP6rw/MGT4Gx1BqijHgoBOVIvkrm+fegYyMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955830; c=relaxed/simple;
	bh=JDI/bF3QrCBA6rjCEOWtGaVIvF+dXo3cbb1CbMue/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX9j2kuJwcdMlFGdQ0xnXgkMh0DSLrlAYLwhHZCjBmkRuhG2mjYXXjQGQ/8SgBH8ph0eI8TeGB711OP2z8dm09Ln0Bx6gAR/G9P4BscY7U0WjqsHacRqSCm2Ly4WsWFhoon84MOo+BN8r7pL2sFdcfsPjB+wndbeZGGzqiIi5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2r57Ltw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE3C4CED1;
	Wed, 19 Feb 2025 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955830;
	bh=JDI/bF3QrCBA6rjCEOWtGaVIvF+dXo3cbb1CbMue/DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x2r57LtwaTKqI8s7AwdP43v2la+vDkMpMiYpqmK3gnGRnM1eqEskeMT5VTnW3OECt
	 /OC3zPaXDnmlDIAyeT3EuFiUekXVCduVq30cr1Bvt/v1eApwPTEK7OLlyRAFI9KPgc
	 KGZcxBBcomkog/cMqwyTy6UbplKm1icqF7iIwehs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 126/152] ndisc: extend RCU protection in ndisc_send_skb()
Date: Wed, 19 Feb 2025 09:28:59 +0100
Message-ID: <20250219082555.032916615@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ed6ae1f325d3c43966ec1b62ac1459e2b8e45640 ]

ndisc_send_skb() can be called without RTNL or RCU held.

Acquire rcu_read_lock() earlier, so that we can use dev_net_rcu()
and avoid a potential UAF.

Fixes: 1762f7e88eb3 ("[NETNS][IPV6] ndisc - make socket control per namespace")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250207135841.1948589-8-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ndisc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ea3cb26da5846..8d853971f2f68 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -471,16 +471,20 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		    const struct in6_addr *saddr)
 {
+	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(skb->dev);
-	struct sock *sk = net->ipv6.ndisc_sk;
 	struct inet6_dev *idev;
+	struct net *net;
+	struct sock *sk;
 	int err;
-	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	u8 type;
 
 	type = icmp6h->icmp6_type;
 
+	rcu_read_lock();
+
+	net = dev_net_rcu(skb->dev);
+	sk = net->ipv6.ndisc_sk;
 	if (!dst) {
 		struct flowi6 fl6;
 		int oif = skb->dev->ifindex;
@@ -488,6 +492,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 		icmpv6_flow_init(sk, &fl6, type, saddr, daddr, oif);
 		dst = icmp6_dst_alloc(skb->dev, &fl6);
 		if (IS_ERR(dst)) {
+			rcu_read_unlock();
 			kfree_skb(skb);
 			return;
 		}
@@ -502,7 +507,6 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, inet6_sk(sk)->hop_limit, skb->len);
 
-	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
-- 
2.39.5




