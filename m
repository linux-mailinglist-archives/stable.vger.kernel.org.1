Return-Path: <stable+bounces-60863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1193A5C1
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EAB1C21CA6
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CBD1586CB;
	Tue, 23 Jul 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGfV7wrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E3158872;
	Tue, 23 Jul 2024 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759276; cv=none; b=D+TuEnZkzGTSkQhXJLUMmImOGZISGssMyNLilXz3FmgIoPkhZNKGoyzs1KEyWk01Iin9yC+pSQ/qh+B2QgQr5BX/S7wtJ1ni/At8PtqbMLHcJEZ4e+3slTivXdZIzMrW/okIhcUpmfYkuR9QBJR9D669aE8JBwj8uJB+iK/ZxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759276; c=relaxed/simple;
	bh=ls0YnJV2IEGiJjdU4JmOcna4t1VjJtBmoudK1O4H5VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o47TNNKXh0phqJMA0xJYxjZhg0FuhJsMmlUEeOKTdazustkSY1oxoQ2OpVpn4EbNeZm6Mck+7IZrw6mGA067nV1m8PMvsbrxtDh1xPwrpmu315YSM2MSIrohBO7uf+76TkgjmtSduJnS6W0ImoUZilDfs6D3Y+Eh5oVvJdfxr9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGfV7wrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FAAC4AF0A;
	Tue, 23 Jul 2024 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759276;
	bh=ls0YnJV2IEGiJjdU4JmOcna4t1VjJtBmoudK1O4H5VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGfV7wrpomMkpJQ2ttajrY2ExVFfYOZiqj21lILRILUsn+xb8eTvRvW59gX26q54g
	 1VwFNb1FN+3ClqRusb69A62O8zA8S4g1hkXLidcl5DDjnl5mzMpItDY9rNuIfsd4a3
	 GcMzRPFVN+xqlvkx6yTigMbWHdkLwJas8CJOTfaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Alexander Aring <aahringo@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/105] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
Date: Tue, 23 Jul 2024 20:23:08 +0200
Message-ID: <20240723180404.378758542@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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




