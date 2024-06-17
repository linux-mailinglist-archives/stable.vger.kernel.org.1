Return-Path: <stable+bounces-52538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A6190B16B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EBF1F23E6B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F891BA092;
	Mon, 17 Jun 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts7W/raA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64D1BA089;
	Mon, 17 Jun 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630871; cv=none; b=qrEFkP/J34lGXHg+DKwsQYFrw0gvOCH+ljTOv1hd8mrGVKJO8PLghw7t2Y8doI42sU+t+CDJZfs6UhUJZUplLKmokWlVJ6l5oQrFnxJUW4NRYDyr0TtG70QkoO/k4qQ/UyL+XjXpxprZOjSCdmRcTZD7jdloG3d/EOrT5QIzuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630871; c=relaxed/simple;
	bh=zo7vGdQmD/9WW6TxmkLYuuXaSiAwi6gfF0+dfbpj6Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcLlXmpkRgHq8a7Ii2lBKL+PSzAreaEeHLQNYXqjnMfpBleCxAlBZMyKorvh/dUXibrFqzhYKVJbcQGPEw7+OctWmfEbuLwO0FI92RqyPfWFnXkV4ktmuZ5sZRfqXB7WacPsKGOZLliOJJRRQbiRMuSLIfR/2VNkGjcDPIJkrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts7W/raA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926D0C4AF1C;
	Mon, 17 Jun 2024 13:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630871;
	bh=zo7vGdQmD/9WW6TxmkLYuuXaSiAwi6gfF0+dfbpj6Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ts7W/raALrA6pYoxS0Fl52M6QGrrEgNhizmAghxyFv03d+ab5cksf3+8mI2ESbxi/
	 RiU25e7heNWRQtshkIUZxC6z2NKYgWc8xQzUI5kc1SSwFkEEa0AZtOvfgPwwOGkFyV
	 S74uY63E8vmp3dNjofQLjFOJRqQqalA4wFK002QizFKjmvhW38SDNbJxWb5fGLcZlD
	 ex78/a7FqSxKzfcEMagB5CIQDTzPwBLOegJz2/QmxqOzQMlx9kMaOWjnL26u3u82+5
	 XU1r7E04Fb+o6jqTX7BlNKEBA86NCEl2YtQZsrRfRQPyowDvCWdULAN3UyrqHN/FEP
	 EDaHWY+ldPpKw==
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
Subject: [PATCH AUTOSEL 5.4 7/9] ila: block BH in ila_output()
Date: Mon, 17 Jun 2024 09:27:34 -0400
Message-ID: <20240617132739.2590390-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132739.2590390-1-sashal@kernel.org>
References: <20240617132739.2590390-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index 422dcc691f71c..6a6a30e82810d 100644
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


