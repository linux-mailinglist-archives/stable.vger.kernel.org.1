Return-Path: <stable+bounces-52492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFF90B0B7
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79FF28CB29
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0741891DE;
	Mon, 17 Jun 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaTE9P4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AD1891D3;
	Mon, 17 Jun 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630747; cv=none; b=eCkjGwYV+gay6oxmosqXwfvK/ZzB0SyQFFysV6+6feW8H1nTfxfOumOW1pEVnRx79osWaEhDG1hTPmLkAhjA8cLClVjMeinMjQ/iKltJzIJ5hhQF832DPmGZCtenW93Etmm7ExmDMTNi1V0ebQb3Uj30P41kPXLnx1guv4KeDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630747; c=relaxed/simple;
	bh=/nnsUQdE5YTf+S/puaXWvhWSGWHuL07yhsepzBghLlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRBXBI6bMfUfiW9HKjDIrLpw7ko1Wklo+0KzcwShnXZFokJu7j/OcAPhBm0fBBy142cyPX21Wqxf/xHvIeBgdyMIkY5Jxn3vSxoL0Yph5bTlAV2wbj+IhMGn0V/RNPt9DB5ymjGbHfyLWhaUEeMGMvCB2LGCUKgF12viCe908PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaTE9P4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DDC2BD10;
	Mon, 17 Jun 2024 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630747;
	bh=/nnsUQdE5YTf+S/puaXWvhWSGWHuL07yhsepzBghLlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JaTE9P4uLUSL0moDEN0IPf0QWZ3orrvL5qJipTbAh+NX4TAKoqEbhouWa1DQ4x9/G
	 UrsftSAtjYRxkotWjkZWiBI9HyYJ1dnWJ+Pt2FRrWIHTROmxm3VGu49tBfZR82BcAN
	 xfteqaK4jB9zscdHk1pz3gweqLHj0Nf1ehxuelB7Fhvaeig81q/tLqY43/IDPsQnPY
	 jdtwoSqzz86+l8cJCCCyYxC8TsGzTFm/UN9ixo5vqbe2mKl9vl/lhrCH0BO2EPFvHs
	 /FG1rHen4wkF4WhZZOP7hz7Px4jGb/QBeDG5t4WjR3QAmCZmooJEFw2YHTAbzBiLQp
	 e+m3cUTlyNIMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Alexander Aring <aahringo@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/29] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
Date: Mon, 17 Jun 2024 09:24:28 -0400
Message-ID: <20240617132456.2588952-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit db0090c6eb12c31246438b7fe2a8f1b833e7a653 ]

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

Disabling preemption in rpl_output() is not good enough,
because rpl_output() is called from process context,
lwtunnel_output() only uses rcu_read_lock().

We might be interrupted by a softirq, re-enter rpl_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable() instead of
preempt_disable().

Apply a similar change in rpl_input().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Alexander Aring <aahringo@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240531132636.2637995-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/rpl_iptunnel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index ff691d9f4a04f..26adbe7f8a2f0 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -212,9 +212,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -234,9 +234,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
@@ -268,9 +268,8 @@ static int rpl_input(struct sk_buff *skb)
 		return err;
 	}
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
 
 	skb_dst_drop(skb);
 
@@ -278,14 +277,13 @@ static int rpl_input(struct sk_buff *skb)
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-- 
2.43.0


