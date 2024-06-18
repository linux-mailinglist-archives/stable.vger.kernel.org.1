Return-Path: <stable+bounces-52800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2690CD68
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847BA2853AC
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787C1AED27;
	Tue, 18 Jun 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQbdRu57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847521AE87B;
	Tue, 18 Jun 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714535; cv=none; b=jj/t8DssZRIGHCOVUvaBeWOdt6I3LZEOX1ecDHxk36Ss0Jd822IT6HdEnWhQVE9HwIvrXhf7azEIqsX7eaN3DPQhWkT1Z6tyAYjKr9KwYuOzMhNv0PgtV0ZruHiwIqAHpc1+EM3qfwQj6WJ5oz5OHzBE9Kp/JQfwiPsAmGkxBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714535; c=relaxed/simple;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcc+GhxmtbU2QtBiUIgextsueXcrOIjL3gUxznxDpA7rKZATJg4JAIoj0CVNRIJ0WlaU138LuuvgKFPuktNFuiC6CGGowjm78Xabc4NqNTGlQlPW8qiL4kkDouuK2ish2E9mLLWPyu8VfwsKgStUL4aV8+bpMN8wJ5QyP4Q5xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQbdRu57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED4C3277B;
	Tue, 18 Jun 2024 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714535;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQbdRu571GM2XPviZyhpv0cJ//5O4eGoEpohLe6rRB6inrzb9n/tjcbFNQ7OF2J8y
	 cD8ofrF88913ZjSyIkTtdYHkqmQUm5M//IW6Qv+7GfgBdtx6n4JzNZH7jVQdg+EMgA
	 MAeCFhpadFkbOTmvgOJDoI1Yudb5BSy1MojPGxSSmGrZx5WKWwV0tEfRyiZuH33NEC
	 3H/YpAgXQiXr8kjg8Gtg+IxB8TKy0rYItLQCFNQ7jwqm2y7vl5gWcNRjcug8/3PCiU
	 iRf6TARxJ1EJQWfcMLQBOy5Kq9m33Rrlb3aC0LbjHsTzZfq0lYTbAiLFZ1XWjb92AZ
	 E4yJdTQUFOd5g==
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
Date: Tue, 18 Jun 2024 08:41:16 -0400
Message-ID: <20240618124139.3303801-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
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


