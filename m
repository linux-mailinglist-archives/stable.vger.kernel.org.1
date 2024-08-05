Return-Path: <stable+bounces-65378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E0947B4E
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 553F2B21C3D
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1510158DC8;
	Mon,  5 Aug 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XkEqAbaf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BB158DD4
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862445; cv=none; b=l9aEn7B3ieYrgJGpDjrfsBxdaZ8rjgZDpG8n7mJqPQ47TlqKfxWN/BUgwm2pBaaSv5vqnu8QjoH+IqyQwKge56qZIB6ywQ2d5NIXjBEGheqWwtNbPfgzFaVpt6aGKY1gdj/dmN+8wvPpMMw5ROO6GKuUyKbJIaIsNs7QWqa5cAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862445; c=relaxed/simple;
	bh=LivNclhMTmtQ6E8SD3a/UC1RPMQYwE634kfinaKS2xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm63YB5mh47SV6oH64UMKy8WcBSI7sLWFOyiyOwhg7h91RQ+PDeuVIvu7m8kzEUShyAH9cggYPwl9Dm+jxgNU0UFJom+w6/sm5NPuTKaRfivDo3EnP1dgubkN65IL2RzVK730q2QvMUmRXp4YDnD+HMwXU+pBPaxdgKoSLYJydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XkEqAbaf; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-2f1870c355cso4432641fa.1
        for <stable@vger.kernel.org>; Mon, 05 Aug 2024 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1722862441; x=1723467241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKYBsrFqvmiI4DnPHLVli80trR1Fq2t7QPfCuegsyU0=;
        b=XkEqAbafvu/9SsjyEI7i0SDpmh83zzhwRn7ASZ5//LillmfFAyUTNj4hKBVm1nPibf
         UPRGBdzIzSZCm3pveSMat94M0dCBbYZBrC+qOZKRoaCzj9LA3k8oi5ssclYiNIGWptpo
         6ngb2+E8cx9OQ9+EmAsttvX75jb0vzF6eBhMpFVXHJXRHsVIZc4FVv+7LpX75vTkrdsI
         50Nt2d3LJLlvop8YjyQ+6tr7Nhd6PO0r2Qur7Am0sXXBG3WUUxIALvYrgdgR3vrGV4/q
         hWXvyoUYYPHQ4KlaefyCe33y6MEtGyw9SXXg3NOr1ay+Tij8Ru89kOI88ykr2dwYNOJa
         eBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862441; x=1723467241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKYBsrFqvmiI4DnPHLVli80trR1Fq2t7QPfCuegsyU0=;
        b=wPGK7jmbabUQRIK2063N1nRLUfgiVXDgVq8GV3rgF46CGptCjTIMHG4E/j7gO3LDCy
         60h7GAy7nExQwRxFK+V8CdSbDppJ/KEKNFKxbFfzO5dTBGheT+dX5S7TPMsPcZWOAG5k
         bQTZl6QHkPLsIpmzLLMQi3sRrVDsh8K3KkcuI7zOHit+uX69EDv9nBquNMBbvRt5HRM3
         knG6Cz8z9qc19cmXu6pYDwOjntFsPifqOWQ5xxJwAtvsMOZGUxFcpHZTOaJqNW87vi0z
         QIR8xGUKwACVYaB1kUxSBiuzrESTenaQJPaaKxxomBenFf+KXTDbFbgG/bhtPdBlpJ9C
         l5xQ==
X-Gm-Message-State: AOJu0YzKAzALVJhURTuRPViruxIRhR2zRReSwYEpn7iXUZa6ndKzN8UH
	fX97F9QybBA2jKgFAPIKWjfOhdorQhrEyi6AKg5rPMH4wbccfdd806N0++sEa5Z1fBGqUW90efD
	yXB2hYHRYQux6JXP3vH+j61/XA3dLEn1E
X-Google-Smtp-Source: AGHT+IGTIE/hutkmNhD1iKzwfXD+Sd6J1vb6oOsXDCV3FUM9ncvO2Pp+Pg3fO8IjMX3HndL03Wu5KxLOtQya
X-Received: by 2002:a2e:8609:0:b0:2ef:2016:2637 with SMTP id 38308e7fff4ca-2f15a9fbd86mr80854891fa.0.1722862441282;
        Mon, 05 Aug 2024 05:54:01 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-428ec7d98b9sm5081225e9.44.2024.08.05.05.54.01;
        Mon, 05 Aug 2024 05:54:01 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id F189514ED1;
	Mon,  5 Aug 2024 14:54:00 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1saxDs-004MTf-Nu; Mon, 05 Aug 2024 14:54:00 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] ipv6: fix source address selection with route leak
Date: Mon,  5 Aug 2024 14:53:40 +0200
Message-ID: <20240805125340.1039685-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <2024072906-causation-conceal-2567@gregkh>
References: <2024072906-causation-conceal-2567@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 252442f2ae317d109ef0b4b39ce0608c09563042 upstream.

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

There was a conflict during the backport in the function
ip6_dst_lookup_tail(). The upstream commit fa17a6d8a5bd ("ipv6: lockless
IPV6_ADDR_PREFERENCES implementation") added a READ_ONCE() on
inet6_sk(sk)->srcprefs.

CC: stable@vger.kernel.org
Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://patch.msgid.link/20240710081521.3809742-3-nicolas.dichtel@6wind.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/net/ip6_route.h | 22 +++++++++++++++-------
 net/ipv6/ip6_output.c   |  1 +
 net/ipv6/route.c        |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index b32539bb0fb0..61cfc8891f82 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -128,18 +128,26 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
 static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
 				      const struct in6_addr *daddr,
-				      unsigned int prefs,
+				      unsigned int prefs, int l3mdev_index,
 				      struct in6_addr *saddr)
 {
+	struct net_device *l3mdev;
+	struct net_device *dev;
+	bool same_vrf;
 	int err = 0;
 
-	if (f6i && f6i->fib6_prefsrc.plen) {
-		*saddr = f6i->fib6_prefsrc.addr;
-	} else {
-		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	rcu_read_lock();
 
-		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
-	}
+	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
+	if (!f6i || !f6i->fib6_prefsrc.plen || l3mdev)
+		dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
+	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
+		*saddr = f6i->fib6_prefsrc.addr;
+	else
+		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
+
+	rcu_read_unlock();
 
 	return err;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f97cb368e5a8..db8d0e1bf69f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1122,6 +1122,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		from = rt ? rcu_dereference(rt->from) : NULL;
 		err = ip6_route_get_saddr(net, from, &fl6->daddr,
 					  sk ? inet6_sk(sk)->srcprefs : 0,
+					  fl6->flowi6_l3mdev,
 					  &fl6->saddr);
 		rcu_read_unlock();
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index eb3afaee62e8..49ef5623c55e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5678,7 +5678,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 				goto nla_put_failure;
 	} else if (dest) {
 		struct in6_addr saddr_buf;
-		if (ip6_route_get_saddr(net, rt, dest, 0, &saddr_buf) == 0 &&
+		if (ip6_route_get_saddr(net, rt, dest, 0, 0, &saddr_buf) == 0 &&
 		    nla_put_in6_addr(skb, RTA_PREFSRC, &saddr_buf))
 			goto nla_put_failure;
 	}
-- 
2.43.1


