Return-Path: <stable+bounces-52514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761B90B10A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EAF1F2B643
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407B1A8C0B;
	Mon, 17 Jun 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrdIcDKA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A61A8C03;
	Mon, 17 Jun 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630813; cv=none; b=kh9vMisrOaQjl3GMh2+MBuuOG0Y0WpKooRHlX1QpuH1uf+fsm1G2Y3wTKlGmwHhCwDp4b9wHZSm2wtaSJFbUrTsMxfbGV0Vb/Gn9ksgiBZGGSk4s06MtkC18lij6eYQtEs+xbFLw3EKCgYBM2WRDhtuHweKd9F+aiizwX9NrROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630813; c=relaxed/simple;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCTjEo3wBVoSvPcdK+5Hy3F2wtYq2rlasOaH5yRHnNc7hLvhqJMBmKCYqvjQFuWw0RadyMa9p35z2SWzNl4uBuxM7Zh6KxL86wxKhyfQxUUF8pzOpy6f/NPuFtMyKhnf+7w08CzCFUOb2EQDy8//9ihNzhvpPqecGe2sAWCWvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrdIcDKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E78C4AF1C;
	Mon, 17 Jun 2024 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630813;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrdIcDKApwcF/m+sowm1CaXlYlq6/YRHupqKY8q4Py3pNz4LRx6toClGYvfmJX82R
	 FrnT0XQAcIDN1C5jAmsaU1nPB0MI54jTsF2ugf+1P84J1oCly9uHvdVXhQeyxlb28j
	 2ZC+x6RNh/7ZakCbOlVe2/FqPkGodgmHTIIjKcP2kHxIGwd+MtqmXBdvLqDE6mXByd
	 E49ksybkodldRc8lnZ9YwSdlNoZIztav7XWlNOCkye18FZdxlmcyAL0smdY0AwXSuE
	 ZqyUu3bDHz0X+QGm6Uox4o39pedMZN3o5HypK674MVtVIU7D/7hm9b4J0BU4WDEae9
	 X3RoNcsHEnOkw==
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
Subject: [PATCH AUTOSEL 5.15 17/21] ila: block BH in ila_output()
Date: Mon, 17 Jun 2024 09:25:54 -0400
Message-ID: <20240617132617.2589631-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 8c1ce78956bae..9d37f7164e732 100644
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


