Return-Path: <stable+bounces-52526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610890B158
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA37B33BD6
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E391AF68F;
	Mon, 17 Jun 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv0evPvE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7EC1AF681;
	Mon, 17 Jun 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630844; cv=none; b=eX/1wR2mBCm5KCeHrB72jvX7HcQZivzh5kmcl6YzmifB1k9bpMJJfdv01XUgnayXQ2cXugSyPBbw1KZRPNww71mNbVeV4AOoVc6+qJzxYbHYElfRTlV7s3L8rEKdiDf9imVlxhTCCzSkbiZtBqDrCiXlcdde93maRYQpW3Tk1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630844; c=relaxed/simple;
	bh=gPsiLfMm2VpB7pQB/oWnBPAvw4xKkVsQZL1yUz4av58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxhT1EdoYQDz4NxnctH+sT6+1mkhU4QeIJnyutgX/09vDfAxQ1NkskyXwPbiRA8zvm9vjTcaE1jVhfunWX0ZAyjW/j5n1HcZOci+qdUHzu1Tx2Z2toZ6QczBJyESMcMtAiPGHj5Aew7aYcjwFumca8Altlmna5f5VR8W4rSW7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv0evPvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDEC2BD10;
	Mon, 17 Jun 2024 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630844;
	bh=gPsiLfMm2VpB7pQB/oWnBPAvw4xKkVsQZL1yUz4av58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uv0evPvEV2A3wCJEW4ZaLq0ob9LEu83p/FurspB3FBLs/2Jyu7RgN3b1BUhKabXvl
	 IzfNZnfpHTiVN4s0tt8TifSSVd05CgeXZ1Azsp9uG2MgYVDBbe4W8QJ1hXz5vuP/8b
	 B5Q4aM9MYc0Dy9N50w7EPOcqQNxsWh5jDr3DwXdUBj4y4wB4lyHwnTOhpxWYIE2RJN
	 1HPov6OPQ6JInQ9MnigPw9yYWY9NPzQ0Ln3LU28oy5gNibDEs3J3Jh0hLBZwK5HyhH
	 F6elzmTujzuC7Ukck3l6TeuQcUdYoJ4u8+/uXwVM8OfhR5TxRh70U6JRZ7Cm7uKtyn
	 o3bTzSjd/4fFg==
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
Subject: [PATCH AUTOSEL 5.10 08/13] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
Date: Mon, 17 Jun 2024 09:26:57 -0400
Message-ID: <20240617132710.2590101-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
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
index 5fdf3ebb953fb..2ba605db69769 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -217,9 +217,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
+	local_bh_enable();
 
 	if (unlikely(!dst)) {
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -239,9 +239,9 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		preempt_disable();
+		local_bh_disable();
 		dst_cache_set_ip6(&rlwt->cache, dst, &fl6.saddr);
-		preempt_enable();
+		local_bh_enable();
 	}
 
 	skb_dst_drop(skb);
@@ -273,9 +273,8 @@ static int rpl_input(struct sk_buff *skb)
 		return err;
 	}
 
-	preempt_disable();
+	local_bh_disable();
 	dst = dst_cache_get(&rlwt->cache);
-	preempt_enable();
 
 	skb_dst_drop(skb);
 
@@ -283,14 +282,13 @@ static int rpl_input(struct sk_buff *skb)
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


