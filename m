Return-Path: <stable+bounces-75067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C819733EB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EE9B2B1E8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544918E77F;
	Tue, 10 Sep 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jPKcl2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453417BEAD;
	Tue, 10 Sep 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963653; cv=none; b=cWdUVUn18LCIdfDoi6bMMd/W56Hu9BMB1zJxdNjGFgSmDWo+LdpmAFf42blkzrf5XoaO2GqcIfH1mJJz9oLVTScmmPtusVDcrpOYX2VNcmM43UCp/HzP1WDAPQzYU4yO9CV7p/9oBNPseCNCU0cYovpEn0dXE8uJ1u5hsY8q38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963653; c=relaxed/simple;
	bh=x9+dzmoZ764HzupR0rXd6SvamTcE71mMrsZqnjvJHZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzbhAYsBGQtok9UymoAwvbDDz6wmSCNm38bx2qgvtHeHytX3/sHqUr+J69yDusPdzf3C3dIL8rfPjOTr1jloY6hpqf2dCJgasLH0KJhr2QdD3irDpartYErHL4KLZ5oPgXUgp6kaCCcD/Gq1GODpE90GpVUX03M66IpGxrnkkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jPKcl2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E201C4CEC3;
	Tue, 10 Sep 2024 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963652;
	bh=x9+dzmoZ764HzupR0rXd6SvamTcE71mMrsZqnjvJHZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1jPKcl2CKVWdYN+ph+AanfZgzIIz7Myd8WYLCEdan9l7rXZuk0kmPlmlsa0eER95k
	 sMqwfnLHsVY6OyuSPbsKZfKqut19GzCk4cJzAKi+NZexNofZlvDuMu/pCNkoPyShNn
	 USOp5quz6fMNp1rO1lBBXQPLrB7MxFbs+GFt0ap8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 131/214] gro: remove rcu_read_lock/rcu_read_unlock from gro_complete handlers
Date: Tue, 10 Sep 2024 11:32:33 +0200
Message-ID: <20240910092604.099561135@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 627b94f75b82d13d1530b59155a545fd99d807db ]

All gro_complete() handlers are called from napi_gro_complete()
while rcu_read_lock() has been called.

There is no point stacking more rcu_read_lock()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7e4196935069 ("fou: Fix null-ptr-deref in GRO.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c   |  3 ---
 net/8021q/vlan_core.c  |  2 --
 net/ethernet/eth.c     |  2 --
 net/ipv4/af_inet.c     |  7 ++-----
 net/ipv4/fou.c         | 13 ++++---------
 net/ipv4/gre_offload.c |  3 ---
 net/ipv4/udp_offload.c |  2 --
 net/ipv6/ip6_offload.c |  8 ++------
 8 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index eb5b7c66db93..1bff01f8b16d 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -558,13 +558,10 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = ptype->callbacks.gro_complete(skb, nhoff + gh_len);
 
-	rcu_read_unlock();
-
 	skb_set_inner_mac_header(skb, nhoff + gh_len);
 
 	return err;
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 40bbe08c1aa4..29c326f98743 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -520,14 +520,12 @@ static int vlan_gro_complete(struct sk_buff *skb, int nhoff)
 	struct packet_offload *ptype;
 	int err = -ENOENT;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
 					 skb, nhoff + sizeof(*vhdr));
 
-	rcu_read_unlock();
 	return err;
 }
 
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 72841efebcb1..ab2ef6250142 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -455,14 +455,12 @@ int eth_gro_complete(struct sk_buff *skb, int nhoff)
 	if (skb->encapsulation)
 		skb_set_inner_mac_header(skb, nhoff);
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype != NULL)
 		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
 					 ipv6_gro_complete, inet_gro_complete,
 					 skb, nhoff + sizeof(*eh));
 
-	rcu_read_unlock();
 	return err;
 }
 EXPORT_SYMBOL(eth_gro_complete);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c9156e7605db..b225e049daea 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1639,10 +1639,9 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	csum_replace2(&iph->check, iph->tot_len, newlen);
 	iph->tot_len = newlen;
 
-	rcu_read_lock();
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	/* Only need to add sizeof(*iph) to get to the next hdr below
 	 * because any hdr with option will have been flushed in
@@ -1652,9 +1651,7 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 			      tcp4_gro_complete, udp4_gro_complete,
 			      skb, nhoff + sizeof(*iph));
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 5aacc75e495c..605d9673d6ec 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -265,19 +265,16 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 	const struct net_offload *ops;
 	int err = -ENOSYS;
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	err = ops->callbacks.gro_complete(skb, nhoff);
 
 	skb_set_inner_mac_header(skb, nhoff);
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
@@ -479,18 +476,16 @@ static int gue_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 		return err;
 	}
 
-	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	err = ops->callbacks.gro_complete(skb, nhoff + guehlen);
 
 	skb_set_inner_mac_header(skb, nhoff + guehlen);
 
-out_unlock:
-	rcu_read_unlock();
+out:
 	return err;
 }
 
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index c12b4b2fc638..9a18fd1d5648 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -252,13 +252,10 @@ static int gre_gro_complete(struct sk_buff *skb, int nhoff)
 	if (greh->flags & GRE_CSUM)
 		grehlen += GRE_HEADER_SECTION;
 
-	rcu_read_lock();
 	ptype = gro_find_complete_by_type(type);
 	if (ptype)
 		err = ptype->callbacks.gro_complete(skb, nhoff + grehlen);
 
-	rcu_read_unlock();
-
 	skb_set_inner_mac_header(skb, nhoff + grehlen);
 
 	return err;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 0406097e7c29..feb40325f8d7 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -657,7 +657,6 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 
 	uh->len = newlen;
 
-	rcu_read_lock();
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
 				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
 	if (sk && udp_sk(sk)->gro_complete) {
@@ -678,7 +677,6 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
-	rcu_read_unlock();
 
 	if (skb->remcsum_offload)
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TUNNEL_REMCSUM;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 46587894c8c9..30c56143d79b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -329,18 +329,14 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 
 	iph->payload_len = htons(skb->len - nhoff - sizeof(*iph));
 
-	rcu_read_lock();
-
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
-		goto out_unlock;
+		goto out;
 
 	err = INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_complete,
 			       udp6_gro_complete, skb, nhoff);
 
-out_unlock:
-	rcu_read_unlock();
-
+out:
 	return err;
 }
 
-- 
2.43.0




