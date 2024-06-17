Return-Path: <stable+bounces-52422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3687790B10C
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7BFB33026
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA501B1426;
	Mon, 17 Jun 2024 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBNdTDPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C91B141B;
	Mon, 17 Jun 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630532; cv=none; b=bHKv+scxA8CEfCMWVemaCdT2On94BIlmgagpzCcBTp8oqamUUJjQsRFg7opg7xBOuk9dSkZmu9Os8ZUvHeF0AifJwB6CFg5WYSdOPy7EmW90JypEGoz68+9+fHLnDY2qzbpPiHcvY5h7Y7TofuUls7QHpMlp2mzFae5ztTGYJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630532; c=relaxed/simple;
	bh=yHfu11Q0TNfcdwLLbOwG08ojnZJ5W0mmaAwpwYhmZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYtDe1eWRh9F+Di4zAbdh+oiT47GJn/NbMgp+jOH6Pion/bxeySQk2mtq1KvPej2jCDxAMoMQrD2VSetKoDC+4w+T7znRC6o/fKaQ1cG6lr8Y6zh+BDNgDQchw4Do8O8HsBFPEVvCTK3ytv0+5ndKKhU04qDl47n392cv/870GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBNdTDPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1984C4AF1C;
	Mon, 17 Jun 2024 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630531;
	bh=yHfu11Q0TNfcdwLLbOwG08ojnZJ5W0mmaAwpwYhmZxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBNdTDPPwCFvI9qVDq2hlr8qhMJ7oHeGRSnKxh0p9Uwf2S9XDTY39yCERnI+1uPYd
	 L84JRQMMG0AQSFcTD/ttLCka4MqnDd6cK4BhT0opYRVqKSz+FcX3BnscVPYQ5w++KI
	 WrBBEBgBMBlXuKZgcU4rZX2egcVCn0HxxhjcsPlzJuxYAhuh60HWHBVWLpWgajdtHf
	 X7/mT1qmltBvQKTsnXA5exnU2LLB6lzwxQS5p3cH0k/1BdyhaLXY9DcslVpaXYgsRq
	 ZBrntvebDxLnReQ3hCIEGZ0PHL4ucfaBAlrZO982ASW7+T7iQsmmxotFd+hC/lNgxz
	 i/3DXjw6ZjacA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 35/44] ila: block BH in ila_output()
Date: Mon, 17 Jun 2024 09:19:48 -0400
Message-ID: <20240617132046.2587008-35-sashal@kernel.org>
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

[ Upstream commit cf28ff8e4c02e1ffa850755288ac954b6ff0db8c ]

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

ila_output() is called from lwtunnel_output()
possibly from process context, and under rcu_read_lock().

We might be interrupted by a softirq, re-enter ila_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240531132636.2637995-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ila/ila_lwt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 0601bad798221..ff7e734e335b0 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -58,7 +58,9 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return orig_dst->lwtstate->orig_output(net, sk, skb);
 	}
 
+	local_bh_disable();
 	dst = dst_cache_get(&ilwt->dst_cache);
+	local_bh_enable();
 	if (unlikely(!dst)) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -86,8 +88,11 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected)
+		if (ilwt->connected) {
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 	}
 
 	skb_dst_set(skb, dst);
-- 
2.43.0


