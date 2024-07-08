Return-Path: <stable+bounces-58241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603A92A8D8
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694C41C21367
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA014B07B;
	Mon,  8 Jul 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cModQKmd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CD147C7B
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462560; cv=none; b=cazBrbGrraM1ZSOD7/D/M59nOZP5BK1EC2V2tacOvfQ65NQXFdtILiL11c/UvfPIbvDtYcaEo1jKm5qY8xGFv2c7iS6kWNv6Tu1LM2QW7lnmyeEu6CeOgdZH1C5yF9U9FXDn2QbDYud/pke4UiOwlfh8kgGDT6GCEEP03nmwVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462560; c=relaxed/simple;
	bh=DnDY1P9R7nc7R06ZlFBZmWwjWi9pu3p/GnwzVK4Bbks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsooB1YZADs9rF/NobtqZET1doyRW2l9XUWsnAGH/VqTVlyThZErDWyjSwwHKjKs4ziYUlZ23t4R8AypU/Q7dwX+PHzk9MbxilPcGhGzP4L9qBuinQntPGKK2kRzX3p2FFcP7LLHyaQZEXqpuUUylDRarMqXGVE4e5aOEWf/bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=cModQKmd; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-52ea0f18500so4043238e87.3
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462557; x=1721067357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44mUTW+IybRW7geQ6WseXm5KqvYB7rwIlQGrIeQ76L0=;
        b=cModQKmd2dgM9twtPd9ylhhHh7ctwqCLUUCjvXJPF6PVVKE7RRuzTmHzLdLDS9IpwV
         JSI9uiIIaiUQI8CswzYWvzz1xMkR5NnF4xC+1NBhjN0+lkilR2HsKWyvBKatK99gMGCm
         K1JHnTazm1pe3hKCPP9w/HIKlhnqHIU6ZI8flm8sOzwpXYg+5qUnTfJl/PWFLAzOWu1Q
         vDIxEgYx3QQyhVgD5vJJEonEeU9sv3y/btnrAV03vJVbBZQunezy3HrzTyggW65v4moz
         znz4NFU1fMEO1gkwlmPC2cvqAZNunDoUPU1oqxGEbAFDh5G7Mvb3fc1Se7UNFp0oyCDX
         zK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462557; x=1721067357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44mUTW+IybRW7geQ6WseXm5KqvYB7rwIlQGrIeQ76L0=;
        b=sLTUmvy1cnBZ0T487zPBG/3xGfuvqXpb36taAtroUxfKCz0z35pcSeV8wkm+WjIO+M
         0gAnxcSvfFifeu9RSA+hS+VcwoztyzdMOqvXcBoeomD2PYlotgzbfDLw58/SHSTJvTN/
         dygbM327jdvKM8K/ALyGLNb+zZi3Oayofjai7nK8XOXO4O0Tp7MMRhrgQczVt3uiLMLT
         w/UiTPLuRdBP/JxJzoZAkxDjiE9yNM6XC0mXYmbh0N4dJypV+MfzNeIry0aX1G4UVnEk
         3pfKz6WC7ORzd/GU9iVHkEXocBTXYjac/ZGbwTISq3suPOBRRri6UxO4+7MH8/iIKgfq
         2RdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU65bBgIRjVhpUfJpwBysXCuEXZ2HAtWTCfqG+1T1HfwEZ7R5/Ggms4QFEwrHogiXjCpFtjylSruHWbmSq4AQ2GVz3j9pQk
X-Gm-Message-State: AOJu0YyQCcRmAQru4E2M8Oy+Up/TMUeTK44k2sKRCUIF79HPU05/jgEG
	Yb9kwxcdhfXWo3x1HzFR6K4QKRVIi19jIMmuW60QI4K5viWvg6xMH+rg547FWkZ1Hm002OcnKj0
	DCPd9a4cTrwKHNZukdJiIT0GWez8eC1OH
X-Google-Smtp-Source: AGHT+IGkf0VCvYQSmdohF70R0Hk4JvCssPVxSWvsdSayojNHU/z/HE9SQ6YXRsp5J0geEq2XhU6mZySmE8jR
X-Received: by 2002:a05:6512:3b1f:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-52eb99d3dedmr87283e87.61.1720462556781;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-52eb9069cb5sm8018e87.106.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 2AC8C60466;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP90-Pj; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/4] ipv6: fix source address selection with route leak
Date: Mon,  8 Jul 2024 20:15:08 +0200
Message-ID: <20240708181554.4134673-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, an address assigned to the output interface is selected when
the source address is not specified. This is problematic when a route,
configured in a vrf, uses an interface from another vrf (aka route leak).
The original vrf does not own the selected source address.

Let's add a check against the output interface and call the appropriate
function to select the source address.

CC: stable@vger.kernel.org
Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/net/ip6_route.h | 21 ++++++++++++++-------
 net/ipv6/ip6_output.c   |  1 +
 net/ipv6/route.c        |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a18ed24fed94..667f0a517fd0 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -127,18 +127,25 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
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
+	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
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
index 27d8725445e3..784424ac4147 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1124,6 +1124,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		from = rt ? rcu_dereference(rt->from) : NULL;
 		err = ip6_route_get_saddr(net, from, &fl6->daddr,
 					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+					  fl6->flowi6_l3mdev,
 					  &fl6->saddr);
 		rcu_read_unlock();
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8d72ca0b086d..c9a9506b714d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5689,7 +5689,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
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


