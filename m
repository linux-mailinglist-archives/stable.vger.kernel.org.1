Return-Path: <stable+bounces-153332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A268BADD3F0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC4405441
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BB02EE604;
	Tue, 17 Jun 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LjQR65vo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8A2EF291;
	Tue, 17 Jun 2025 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175607; cv=none; b=Pd5y7/o6ADIOZPLdepWIn+KywWLGZm20lCWTCgLDR2K+XjnHf+Dkk3AW1MB0uxE8djw9l0i+C/z+7djZrthm7RUnEhLF4x6yG2mleP2atUfsMYKnLOnyTrGHVNDySjymuRShMEbadOy7ssKiTHPLexGOf+WdxS25pJge/8lIj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175607; c=relaxed/simple;
	bh=Q34ftcpV6hRYPhhNJ8UNTpZBTY/Yvi963AwCVigx850=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXbIk0RQZDy+pXDAPwp9HlO4UrXaU0Q86Co/oFYnGtjBfbysoQ2e27WFr8qdA1l4yhxz/lssdC0qMDor88Q8YQU3yviHKwQITlg3MP9kDpzKddHWVS7GJ6PjI2ZV6A/TArCkyQSdHjcZ8RI/HC2ncnpjyuut0BkGZmdaPMPkYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LjQR65vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1042C4CEE3;
	Tue, 17 Jun 2025 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175607;
	bh=Q34ftcpV6hRYPhhNJ8UNTpZBTY/Yvi963AwCVigx850=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjQR65voijeIEpeHwshO27ULOtuWiCfafWnJ6tEbwmxen0Kw4IU9xfEavJXfc/PJ7
	 BBusNNlahrLsiUE7YLZpomiv1WVrTSBb+zwqUI9U5YXP+IK1/wNFHjFUasy5WNCi69
	 /W4jnlTIM765mvLqKaxfBvpSTxCo1NMeN1wulvSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huajian Yang <huajianyang@asrmicro.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 146/512] netfilter: bridge: Move specific fragmented packet to slow_path instead of dropping it
Date: Tue, 17 Jun 2025 17:21:52 +0200
Message-ID: <20250617152425.522497140@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huajian Yang <huajianyang@asrmicro.com>

[ Upstream commit aa04c6f45b9224b949aa35d4fa5f8d0ba07b23d4 ]

The config NF_CONNTRACK_BRIDGE will change the bridge forwarding for
fragmented packets.

The original bridge does not know that it is a fragmented packet and
forwards it directly, after NF_CONNTRACK_BRIDGE is enabled, function
nf_br_ip_fragment and br_ip6_fragment will check the headroom.

In original br_forward, insufficient headroom of skb may indeed exist,
but there's still a way to save the skb in the device driver after
dev_queue_xmit.So droping the skb will change the original bridge
forwarding in some cases.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Signed-off-by: Huajian Yang <huajianyang@asrmicro.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 12 ++++++------
 net/ipv6/netfilter.c                       | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718e..6482de4d87509 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -60,19 +60,19 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 		struct ip_fraglist_iter iter;
 		struct sk_buff *frag;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < ll_rs)
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < ll_rs)
 			goto slow_path;
 
 		skb_walk_frags(skb, frag) {
-			if (frag->len > mtu ||
-			    skb_headroom(frag) < hlen + ll_rs)
+			if (frag->len > mtu)
 				goto blackhole;
 
-			if (skb_shared(frag))
+			if (skb_shared(frag) ||
+			    skb_headroom(frag) < hlen + ll_rs)
 				goto slow_path;
 		}
 
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 581ce055bf520..4541836ee3da2 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -164,20 +164,20 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		struct ip6_fraglist_iter iter;
 		struct sk_buff *frag2;
 
-		if (first_len - hlen > mtu ||
-		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
+		if (first_len - hlen > mtu)
 			goto blackhole;
 
-		if (skb_cloned(skb))
+		if (skb_cloned(skb) ||
+		    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
 			goto slow_path;
 
 		skb_walk_frags(skb, frag2) {
-			if (frag2->len > mtu ||
-			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
+			if (frag2->len > mtu)
 				goto blackhole;
 
 			/* Partially cloned skb? */
-			if (skb_shared(frag2))
+			if (skb_shared(frag2) ||
+			    skb_headroom(frag2) < (hlen + hroom + sizeof(struct frag_hdr)))
 				goto slow_path;
 		}
 
-- 
2.39.5




