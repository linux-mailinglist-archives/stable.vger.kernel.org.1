Return-Path: <stable+bounces-52421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9DF90AF82
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAAD1C22FCE
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95591B0133;
	Mon, 17 Jun 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2yfcADe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942231B0129;
	Mon, 17 Jun 2024 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630529; cv=none; b=FGKAH7uhZEP9Bebt+E4cBft2t6LF8nZgfCQAx7AMCfDzGSZTHI0+ilxT5Gulb55ioLpabBwtZBnZCIQ/1Dz1i3ZXgwZ7yYOn3+CLYCWrr/LcRLLwmp2aHIgqKLrF7ca0j4gBzyykMVoslptbz2ETltkfwbStvnp4AyCYhsq/sgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630529; c=relaxed/simple;
	bh=gBBmWF8YTIjh0DlT+b6kdKqtSsPfi3eXXh024j8qgOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3Dcm/dI2yXaYHWf6QKJIo8kM2FJm8tQY76wKzSEMBmOtyCLwd6plO3ZRtk3x3qc0FXNMNVEnSn/62ntqVb+zMqaSMOwtXT5RJPGi5sHN8t6kybh8T4yAgRhRStd93mtuzhIVMEwr2fBelzTV6sz0gFIZg2WhV5mW18q8f3IM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2yfcADe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2536EC4AF1D;
	Mon, 17 Jun 2024 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630529;
	bh=gBBmWF8YTIjh0DlT+b6kdKqtSsPfi3eXXh024j8qgOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2yfcADerqKpHXm0GRwG/W8jTlWDk1hgtFKhLoXmWiOgYydTKJcXixzpbUxhl6I4L
	 9DbsOG2IK3tGD2M6O3ssB9/Vvltoy+T2V1m+4ejsyJh1+6R3G2dbwI91FtbAau5gwn
	 134z3o1uZxp4PghqISwnxulx9/c6uvArDjKSzpts87hA5LQTencNtrwpkzl1srIGx/
	 6GFlW9h+/dvF9Off1/vhzI9t2GypjckeyjpJlEmOMTYyxM5sJ32A2Dn7BQGINdQSW/
	 TEnR6EhwWxWo4jWMyheSCWzbfxbJEiPIFzYUxVrZI68JAShoJ5XXmk5BiLPoTVGqYo
	 YSJ55WCGkZpng==
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
Subject: [PATCH AUTOSEL 6.9 34/44] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
Date: Mon, 17 Jun 2024 09:19:47 -0400
Message-ID: <20240617132046.2587008-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132046.2587008-1-sashal@kernel.org>
References: <20240617132046.2587008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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


