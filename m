Return-Path: <stable+bounces-52744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35490CCB6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E89282B72
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC87199EBC;
	Tue, 18 Jun 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RabkTEnu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DC18EFE6;
	Tue, 18 Jun 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714381; cv=none; b=AzooBvzf/6AOSLSMhYOi62QK/R+yWX0jrx6CvMWvIKhgQWwNHa1FlrMWKBDYhNOsE0V6FYAvunHtDfr7a0s7gSog1LeeO/Hs+4zbePddXbDVYYJV779iMartYajQMMPm5p54emPW4i5jA3V5QrLPJNTrOfBq/YQz0rjorTSlS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714381; c=relaxed/simple;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb2VSZqsSnZsnP1wHgCO9kfGKOmMYM2/K9KMa+OpgHeSs2T87rcSsfTQ0RxurQb4QyZclIxbrGxMzNzoCJBxLR0MnFjcmH1ABu3EayWF0FIyFcPfVzJf98mEkozqpf+GEZ87QeqHOaVAp5sclc/oGCGtiP5ELiPB7sBjyp/muuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RabkTEnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB782C4AF1D;
	Tue, 18 Jun 2024 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714380;
	bh=7mGrHxL0HdzTrs7BZbgAKSPQi9Yjl+WUY+0IgMEes/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RabkTEnuQb+yPUMXAQ31VaB4gBu6EWvNbaus0ld49u23OLhpZZ/1JYyIAGYMQmulo
	 pIdB50zaVSAQHq/8jfcoWtJpHou1decGBKCAIjWKFFLiYT05FSEb1sotdOp8riT7Lm
	 7+fvhnAFowPwZwELLPdHuURAkpZpVHx5jN+4IEwOSTWHDPWeHhuKrfGXuYAkYDJWMK
	 676UQKH+F6z/U/e0K0Bd2I6ho4+yShuo7YjJmXGBGrera07c+tKCu36x9dCn4ykMmL
	 ua8PuhCwU9ToJG7YY3zNsdwgcPKltsblKae8MVYdncCoMjnbP8FydoSgPRM8Lfauov
	 L64wfWUrq/lHg==
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
Subject: [PATCH AUTOSEL 6.6 28/35] ila: block BH in ila_output()
Date: Tue, 18 Jun 2024 08:37:48 -0400
Message-ID: <20240618123831.3302346-28-sashal@kernel.org>
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


