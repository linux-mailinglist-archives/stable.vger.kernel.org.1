Return-Path: <stable+bounces-86317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CD99ED3C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71E61F24A01
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD3227BB7;
	Tue, 15 Oct 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="knav4zDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742120B1EA;
	Tue, 15 Oct 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998502; cv=none; b=LoNINt6g+k1hurGS2YDRow0g/k8ekdJ+YH/7rW99BIbQ8tbs52m0tjCDw28GMYJ+tdn9B9m0Lq2QFqBSusel8vrmNxpJXxmARCKa7oPLtkjs4GPc4DvvXyqurmkMzVYfALXgka1UrPmyZcU4fB3nYoTfCpKwdRuHaSGZlvXSI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998502; c=relaxed/simple;
	bh=OHs3YQ5yyK2MhkeXmiJmoEj+uxT7IW+h+1uzgzfmxYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KetkkNRM2Odh/1qgQHXmkeK2GZhqc/LgDk2x0DrOnme1oVepFJscNBHPlnym47lERY948XoaNNrKXNyyhoOCKHU7M7a9yMzHmce4drHHTPKgVFgjFhtG3SBRvvmOP/hRxmiNKsn2AHrVPjyUZqWSuvtvCJjV2sC6Cs6DFUNhSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=knav4zDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3248EC4CEC6;
	Tue, 15 Oct 2024 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998501;
	bh=OHs3YQ5yyK2MhkeXmiJmoEj+uxT7IW+h+1uzgzfmxYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knav4zDDg2jOicgduN50LBvyevt6g86TaaI6eIqQ/uYiH7IgJseLts/GJrIjqfOdj
	 i24q2ke12QrKF7IcxuHT/k75KEo14Un/W/0lJrS5NFdUhU1i0faGK98WXWjtATKhlg
	 ugtN7oZRB+xhGUh8AR7NJgLXv6Y9LuiDDG9r//Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 495/518] netfilter: rpfilter/fib: Set ->flowic_uid correctly for user namespaces.
Date: Tue, 15 Oct 2024 14:46:39 +0200
Message-ID: <20241015123936.102143152@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 1fcc064b305a1aadeff0d4bff961094d27660acd ]

Currently netfilter's rpfilter and fib modules implicitely initialise
->flowic_uid with 0. This is normally the root UID. However, this isn't
the case in user namespaces, where user ID 0 is mapped to a different
kernel UID. By initialising ->flowic_uid with sock_net_uid(), we get
the root UID of the user namespace, thus keeping the same behaviour
whether or not we're running in a user namepspace.

Note, this is similar to commit 8bcfd0925ef1 ("ipv4: add missing
initialization for flowi4_uid"), which fixed the rp_filter sysctl.

Fixes: 622ec2c9d524 ("net: core: add UID to flows, rules, and routes")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 05ef7055debc ("netfilter: fib: check correct rtable in vrf setups")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/ipt_rpfilter.c  | 1 +
 net/ipv4/netfilter/nft_fib_ipv4.c  | 1 +
 net/ipv6/netfilter/ip6t_rpfilter.c | 1 +
 net/ipv6/netfilter/nft_fib_ipv6.c  | 2 ++
 4 files changed, 5 insertions(+)

diff --git a/net/ipv4/netfilter/ipt_rpfilter.c b/net/ipv4/netfilter/ipt_rpfilter.c
index 63f3e8219dd5a..26b3b0e2adcd7 100644
--- a/net/ipv4/netfilter/ipt_rpfilter.c
+++ b/net/ipv4/netfilter/ipt_rpfilter.c
@@ -79,6 +79,7 @@ static bool rpfilter_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	flow.flowi4_tos = iph->tos & IPTOS_RT_MASK;
 	flow.flowi4_scope = RT_SCOPE_UNIVERSE;
 	flow.flowi4_l3mdev = l3mdev_master_ifindex_rcu(xt_in(par));
+	flow.flowi4_uid = sock_net_uid(xt_net(par), NULL);
 
 	return rpfilter_lookup_reverse(xt_net(par), &flow, xt_in(par), info->flags) ^ invert;
 }
diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 22168f12b3819..0f6a58558bab6 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -65,6 +65,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct flowi4 fl4 = {
 		.flowi4_scope = RT_SCOPE_UNIVERSE,
 		.flowi4_iif = LOOPBACK_IFINDEX,
+		.flowi4_uid = sock_net_uid(nft_net(pkt), NULL),
 	};
 	const struct net_device *oif;
 	const struct net_device *found;
diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 69d86b040a6af..a01d9b842bd07 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -40,6 +40,7 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		.flowi6_l3mdev = l3mdev_master_ifindex_rcu(dev),
 		.flowlabel = (* (__be32 *) iph) & IPV6_FLOWINFO_MASK,
 		.flowi6_proto = iph->nexthdr,
+		.flowi6_uid = sock_net_uid(net, NULL),
 		.daddr = iph->saddr,
 	};
 	int lookup_flags;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 72a9a04920ab2..4239b8056b5bd 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -62,6 +62,7 @@ static u32 __nft_fib6_eval_type(const struct nft_fib *priv,
 	struct flowi6 fl6 = {
 		.flowi6_iif = LOOPBACK_IFINDEX,
 		.flowi6_proto = pkt->tprot,
+		.flowi6_uid = sock_net_uid(nft_net(pkt), NULL),
 	};
 	u32 ret = 0;
 
@@ -159,6 +160,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct flowi6 fl6 = {
 		.flowi6_iif = LOOPBACK_IFINDEX,
 		.flowi6_proto = pkt->tprot,
+		.flowi6_uid = sock_net_uid(nft_net(pkt), NULL),
 	};
 	struct rt6_info *rt;
 	int lookup_flags;
-- 
2.43.0




