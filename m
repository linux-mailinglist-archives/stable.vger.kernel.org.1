Return-Path: <stable+bounces-55013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE68914DFB
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D91C21CDC
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BD13DBAD;
	Mon, 24 Jun 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="AQqvyf/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868213D633
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234546; cv=none; b=GfsqRnCM651ml2fPBk5Ra8TQiyeXSPP8sZZ9j92a44pxareUCLdf4PgKN3Wt9fbF5C1sz1VGy2tHwyx64UV6nyQ/F5omsEbqA9syMYcKz3tdEOrrT+sOBw2s1kutYzV4zjp0Yopr1PkuAjdGdpgoLl7euno+L1GKFZDS6mWQuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234546; c=relaxed/simple;
	bh=8oaIXIe0+bbffU+4+tyy8R/V/TlWyVTDw3J9fG4MGsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAIpFTcVS0YNpuog5ttTaBgeSfXfrqOk2AMAxONsUkNs+BLKQOFoPDcGEL2rzNspMuKoInGyzlJcJAWq+s8r6/F/UYN2FQuQUOKKJD0rChYugj+e14nPnKt1vy5LZYqQWZoR3oXY+2vfaohSKJzLdUlF0PL164eq0HeOwxgRj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=AQqvyf/W; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-2ec1620a956so51598761fa.1
        for <stable@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeLUTTDqDBsmxH/CzCbI0wYe8vQnI0MozaiZWlhCOJE=;
        b=AQqvyf/WSThIg1dcIPAZ41xmnbVrJWe5IW83frtm4/8PJqpRB3ei1n6tUgiF4i27n6
         2fHHfXTLbZ8z0uyIR0jtitNmICVZ2QiAxRfTosXkpKjGbgHWYsxm3QlZ5n68FPkm4LnC
         nE54t7LC6m/fYQxtbDCjVF+yxcrdrbMbebZmBw8i2QNo4yeQOg7AoAEHrLqsyLBXZLVK
         HFKeuZSqJOOHWcGZ6Mxmlj//ZvHpZilz6f8ox4CWZOUmOujo4NgRzPgZ1JZtTBOdEZ5m
         Q2/KWpqRFZC6gYHSZvHgr2jljWQ7D4ogoJVPxoj61/pcGeeS1+PYdFts9oicrBRY2Ok1
         vIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeLUTTDqDBsmxH/CzCbI0wYe8vQnI0MozaiZWlhCOJE=;
        b=KBy+wcnXIyjryICJ93QB2DaKQMFpgh972NpNKsNkoVyNLol485xVqOC4/a7/xm6s1i
         iUVLziW8qWjlhS0YB7PeGvdOLwoIP5Cn9mI/Ds9bQtOrp+Z7Slj3Dnt05UrrlIk/txgm
         +MIb9RikPeZMTkRNCBpupTVv6SpcGw0H9rEBIu4/b08eLeuBFcUI07Y1HSV+T//mfj6E
         va0iYNqvkBWqxuObC25s/DA6sUtkbyXCiAZew0pS+sVNjs94Qrg916oCCegbf2tyMuBo
         5UqZKHRmLQPakdmsiHL1psKCpKTSungFv/YWVaREncxfxQUk0aSYGifNpZc18xkEmNqD
         DRZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+Xw8LZqwPKMqX4ZW/BK2jsUAkIhGmgpiBnFmyS9cNyGd9coA5TIBFJtrsasy27qPbENMiylsJ5a5fJpS5EgY9JCzHu8r
X-Gm-Message-State: AOJu0YzY43QV8BbrpU/8Mi9hJaGsNuzLpre0vCAa+V2KGhNdKwhiS+HB
	LXfB+gIcukMWx+VyQ7RJqQQ+Qj5vUorIPhk3ZZVHwXWlAk/gtrqiLF8fMDsO4DZq8TnarB3CscI
	v9tKhQdiGX3xxDhljxAdRNIR8TRClb8H5
X-Google-Smtp-Source: AGHT+IELmlE6/jT14ZDxmp+y2Ey92cZln6BwHTGXEgEmu0GwEmf4G62NZJLnWwhtXIIPSyY/YKkKI9ZTVudr
X-Received: by 2002:a05:651c:22f:b0:2ec:5128:1851 with SMTP id 38308e7fff4ca-2ec5b3197e3mr24276381fa.3.1719234542627;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-366efb23ee2sm95047f8f.105.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 5329D603A7;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRO-00406A-0g; Mon, 24 Jun 2024 15:09:02 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/4] ipv6: fix source address selection with route leak
Date: Mon, 24 Jun 2024 15:07:54 +0200
Message-ID: <20240624130859.953608-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
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
 include/net/ip6_route.h | 19 ++++++++++++-------
 net/ipv6/ip6_output.c   |  1 +
 net/ipv6/route.c        |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a18ed24fed94..62755fab1b52 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -127,18 +127,23 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
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
+	rcu_read_lock();
+	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
+	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
+	same_vrf = l3mdev && l3mdev_master_dev_rcu(dev) == l3mdev;
+	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
 		*saddr = f6i->fib6_prefsrc.addr;
-	} else {
-		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
-
-		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
-	}
+	else
+		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
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


