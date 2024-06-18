Return-Path: <stable+bounces-52743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74090CCAF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF984283EFF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FA18EFE7;
	Tue, 18 Jun 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4HitReN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577718EFDE;
	Tue, 18 Jun 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714378; cv=none; b=WjtV7dbJOkAcVtQRwSvb3Jc5Ous/nUMZ4nGYrxy6cb8HzsaAIvjeq3Hzgu542HLigzaSiB12wbjuJEimAYCZwo4t8qZPcun9C0SYPe2gjTiArLa1x28FMrIPOR4EhMpnXx03PNNjgvDOm0DC4Azukgc5cs5F7HQ5fjLmwm5AmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714378; c=relaxed/simple;
	bh=gBBmWF8YTIjh0DlT+b6kdKqtSsPfi3eXXh024j8qgOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8OeM+mBqXCMHOWDJznqe2Oe2X/7MxW7T1VSjUmVo0b8mb3qHuje81LWAbJf3VWrqN7/DSWUJ7kp3l6Ygbtzrz+VIhhtDpJ0DR6kfuC/ZRos5memAYgDI2TX/6gYlMeHD5lViGTISKInAXm6tmD4ud3MHOuwwcZ2z4W+o2gM+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4HitReN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F14C3277B;
	Tue, 18 Jun 2024 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714378;
	bh=gBBmWF8YTIjh0DlT+b6kdKqtSsPfi3eXXh024j8qgOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4HitReNYJkWQJ6iKqRbkzKC8L6zK8dRT+64SIXT59/OQ3AR7c7b45+q+IdeY6u1V
	 po8lAr7opuICeEO7AttfC/idlZ8tDDj9Rxpk6W7hr56qCBoJGBFeUhwZY8iMHPXjkn
	 pHW/k2fHGKrmztzyQiBoYUiXAxyp7gsVqqIOxL2748+73ncfeBbiM3C3W6rc77W1rL
	 Z/2k9XBBrB1QWpE/K7N3aHyUcnYwrOunCh5qlDQxJuaEasiDP5mVj46rGwjtrd/Xlc
	 1N5M4yF//Rcxwpy2vn9FwewzsGpBdqzKqOmvIHnUtjyTHrlzeJW3JTx1X09bZ0W4sm
	 /zjZyGQq+3n6Q==
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
Subject: [PATCH AUTOSEL 6.6 27/35] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
Date: Tue, 18 Jun 2024 08:37:47 -0400
Message-ID: <20240618123831.3302346-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index a013b92cbb860..2c83b7586422d 100644
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
@@ -268,23 +268,21 @@ static int rpl_input(struct sk_buff *skb)
 		return err;
 	}
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
 
 	if (!dst) {
 		ip6_route_input(skb);
 		dst = skb_dst(skb);
 		if (!dst->error) {
-			preempt_disable();
 			dst_cache_set_ip6(&rlwt->cache, dst,
 					  &ipv6_hdr(skb)->saddr);
-			preempt_enable();
 		}
 	} else {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 	}
+	local_bh_enable();
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-- 
2.43.0


