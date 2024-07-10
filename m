Return-Path: <stable+bounces-58969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E355A92CCA4
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 10:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124641C214CB
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0612C465;
	Wed, 10 Jul 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="a/P6/amg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40314A9B0
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599328; cv=none; b=hvV/IEnOU0FWquk+U5SoH+voOVEj4Qm5cWZ2+8JM8PRc17jLclX+r8BQfXbA1nSAWXIQRIIOMWTHDtjwDzNnHVEEVUobWQLbyWQl08vHKfgwsIHmjx42Y4WfWFhIQpbJ60RHgAj0W2zrNJ64pB+WwB85QTLAUSe4oIo5FYqPdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599328; c=relaxed/simple;
	bh=WZApNyTcpnq80ps4e5r7dxC8IiIumlq5ELs8f32jb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STUoQIcTfdBzLr6EIceLZ8DWItkJLTv1zOcoVz+EWyKrGl4fHGLNjAk6HDWm6ijtZNz8tbTkt1poXG9auDNsBiwBUI2Ucg3xxoGVBxcO/XW0u550liOK1Dn+p83SmT0tA1YXaBSfP91DgeyictQxg94VPwH69Z8XezzalWRXP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=a/P6/amg; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-4266fd39527so13998035e9.1
        for <stable@vger.kernel.org>; Wed, 10 Jul 2024 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720599324; x=1721204124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y/N5FajcPj742c7WgLRR706htS9YsQC2raVIyjDgLk=;
        b=a/P6/amgG07erx4NuisTBbFDjSQj+v7Hzcb/70xK4pKRAmeBQeac6y60wz9ysUt73G
         tdrfloy7da5zIxOqLkZoccXeR0DAy1J6xLMLOFOBqSEsUdW6NAKNsCsVxQR5crZ5FWRv
         CzhhoefMZxTnPJcZfprAuBjwLIubAg24K/4GpevUaHwf6MNmU6UIkyi1mEIO2wlUVrLL
         AjjVmLuVQXlXz1DqHswS5vBoAyPRx0xTlHmAgMeiIdyDQPuedk7rUyGCfm+tp2gZhIQu
         BQEecCoNnMGYert0qQfNGABz7wCqTfYJGwx88gaIeI6pdEWOiD+NGn1li+kMqWXFndHb
         pQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599324; x=1721204124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y/N5FajcPj742c7WgLRR706htS9YsQC2raVIyjDgLk=;
        b=Rp4jQU9AVfOla2yDPhla6trkBR43eiTQPH1IRRfYd4iX/3S26RnYdO3c+RMJJG8aIQ
         cCRmWEvfRQA7agoVgkHTX8O+sGMlzcYeLYWN0/4VJVfysPA+Rp6PrC5GMqfbeVVYS6Gj
         Etp3d0HZM6rGVgz3HEuWzdvQ7wSfwHfBfgLFD0KND8htdG81ZkrMoCECMDsiZ6CP+9Kv
         /Z9Ta2up3qUXLPJOooKOcgz8lweNs3e8YQbv1KVuFqwhw6hsqQ5lsBUuQIL/eQMsAoP9
         e0SbXGcj1WAM+hJUt4/nGLYh+3yYIVxomwqENdGsFyThDuyOEWtgLv7DiP/vNYO8aWhq
         Oo2w==
X-Forwarded-Encrypted: i=1; AJvYcCVnE6nsSkONAcnooQgdK2dNV6Eudz+6UeIcSab4DlyH61uI4FF+FsvwV3QJDZpVxHDL2gakj2KZfjs4MB0gTbTNUAUWWR7i
X-Gm-Message-State: AOJu0Yy1KK/ZAfyltv+mg/O8T+mv8QDew6opDgGXbK3/Ib0AbTrX51Ru
	e2wR+mXq3gkrSFzmiBaJber3PdrD2wampp/AEBRNPH7VgBw49+eM7ka+hrhxdh7Z/lgT18uC/oa
	wk9p63CXmFMdEEjGHK+9V8kWO8hbD6byp
X-Google-Smtp-Source: AGHT+IEUCpL4kst+YlcjK8la07ODZird0pOyMgL1T9uX8wzg5oFEVx9Ynk5A95G0GXH+zUvQo4Z1dhY6W5Ln
X-Received: by 2002:a7b:cd1a:0:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-426707d7914mr30021045e9.19.1720599324008;
        Wed, 10 Jul 2024 01:15:24 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4279554c9d6sm239865e9.15.2024.07.10.01.15.23;
        Wed, 10 Jul 2024 01:15:23 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 8C633602B0;
	Wed, 10 Jul 2024 10:15:23 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sRSTz-00Fz6z-8G; Wed, 10 Jul 2024 10:15:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/4] ipv6: fix source address selection with route leak
Date: Wed, 10 Jul 2024 10:14:28 +0200
Message-ID: <20240710081521.3809742-3-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
References: <20240710081521.3809742-1-nicolas.dichtel@6wind.com>
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
 include/net/ip6_route.h | 22 +++++++++++++++-------
 net/ipv6/ip6_output.c   |  1 +
 net/ipv6/route.c        |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a18ed24fed94..6dbdf60b342f 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -127,18 +127,26 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 
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


