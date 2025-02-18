Return-Path: <stable+bounces-116809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B49A3A3DE
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 18:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B973B1B94
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B126FA57;
	Tue, 18 Feb 2025 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LNHwCgYP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F726E648
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898826; cv=none; b=C1fr9YgyaEMTy5kgHtcElE/D1qC2tHFb9CqcD1BnRnmMxogvbgePq28D9ZtOYTSCLp8DYG0iyNgZ4Qq1NhCVQsGpt2BUbF7jwOGdnRHyZaNCx8i6TLvkSVdz/KNGS2HwvqcXlZZKv0R4orWaMqHXzPddJ6M9vxdmNSyDRsB+hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898826; c=relaxed/simple;
	bh=Qo0S1t6YIppK843HPI/H3rLHJ7+t4I4Hq9t1sU6dC3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1Q6Oc2Sy0pLMVfGxjKRe0GD76ULUbEQhKIGGDue986QU2mCJxZY+u1Ja+Lsg8+Hm/SDLxB3ZVYuih6GUESIhTSkn2uQTIZgsryT5U93GlIzIsLiTV8C1JcenT5xB31Har62vBIoLAmCArS7xLufUkwoMO8LulhvNq85NF9Iv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LNHwCgYP; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-439999d2bbfso223965e9.2
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 09:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739898823; x=1740503623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzn8I7zdwu9Nfuw3jXMjrxnmSQyAGZFeFVvTe44zzC0=;
        b=LNHwCgYPg+hchZsp2k7yH8HBHXXy1EqIg/13NJ7GHMof3Jw16bmqGLDKBt/UHxDhO+
         qRjqYRPAXS+PipfwsygE5WUGU45rxe3wur4OPkXsRfeDKGlnfm2Pwjg0U7s03al2QTSW
         Mc5/GQ37mHZwf4KEVlhjyy9aoLVSoC5sDaDwenrUlnLU5YKv3q8edfjWV5vOx73M12o8
         3hA0jARS0nfaswJDsl4dG9Dp+7kfHTH4goeUd5XbGzXTENwbF8c9ZkZXviHDCQ8UCQu8
         5SkG3qkTsEWC64fwkOIJf5KUt1XadMtXCgUOeQo+murteMzlgC4TkNM7Xa9xbws1D6Yc
         n3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898823; x=1740503623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzn8I7zdwu9Nfuw3jXMjrxnmSQyAGZFeFVvTe44zzC0=;
        b=IOMAPc0L6KcNppUT6TcZYSTgI5DgDpm/Lp9uoG2hWiDGI00V2bO9Ben39YWHjQKUI7
         O5kwb4xANIlQhTN+qvXyLGUeh9h8CQPIrHT8jW6btX00mURevjHov1JvRxQ+lJrVcVUX
         BzKtkUVFryWNA2dBB9pi3qH/bHsgKsR5ld//Vs+Fj+98JyAVoO4ks83uu45Bkvn2dzqW
         lgszZ0piBKnmCVQioR9Yknz4MQRASRtgq9GsJKbe0v+CoOM6KNos2BQSMXeRY3W9AYJA
         s/o1hrkp+4Fg5GxLitMuDJ66amTFvP6jadoPo9AcR9EiBroZpVByuIQF8RMEYcxJB6+/
         zGbg==
X-Forwarded-Encrypted: i=1; AJvYcCXHDmCa1jyxebix/cYyL08tmTpnhajVD0LARFt1ybsJhiSxcsVAK8UDqZfRCedjmOZwVa/X0wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5B3BATFQ8au46MUdKV6hnnuJ+DdF23XDKncXl1aUgXWOtLQp
	xRFHS+5zWSYDaM9J7OBPXze0Cg1lhPdqp5Lc9MF19GBZpmAu6zbwX7nSLetS4Mq/OWXlRKCJH5M
	bmPKfuUAAFPUjpM4y7P/pCB6r0kl0TQHd
X-Gm-Gg: ASbGncuSMSmT5+zodkDjwsuNC09q4XJcGgu2acSUvX4uSXxfnituquPU2VlwD+hWT+5
	jAcr3SPZiF+hI1Xu3rjmAqMZVP1LpRFnvHq4IB2Sm4BY6Sb8jlQJiP+jgXFBpXuxDSWqgun/5Ew
	qrgFmO1CBcO35PIWlwkYmefSWBJ89VkbC3XI67k1Mm9Zs+ks8kEhQhSKQE7XOApaKdOz2qOPF1e
	Cs8AvPCKzpuXuFA3TqKVV/M9YnUK9c5RfidJP/1GXbn5H05kB1XM7KrIy1pF0sgmIPssVLp7OoH
	micQg/NiKOm8glPkvY0uqDuDDEZHg0inHFQKbPop6MioxNQtt0uQfB4aopXC
X-Google-Smtp-Source: AGHT+IFNQqtGeAZNgxJpSvbJhpdKIJQbyW6N4hLVjLofuP7lseEyzf4l9BWUDL6hyrX4RsN9IVcRDOn08TR6
X-Received: by 2002:a05:600c:1ca4:b0:439:9595:c8f4 with SMTP id 5b1f17b1804b1-4399595cb7bmr11661635e9.0.1739898822483;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43964eb6919sm9239635e9.45.2025.02.18.09.13.42;
        Tue, 18 Feb 2025 09:13:42 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4FA8A12516;
	Tue, 18 Feb 2025 18:13:42 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tkRAE-00F4xJ-2J; Tue, 18 Feb 2025 18:13:42 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: advertise 'netns local' property via netlink
Date: Tue, 18 Feb 2025 18:12:35 +0100
Message-ID: <20250218171334.3593873-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the below commit, there is no way to see if the netns_local property
is set on a device. Let's add a netlink attribute to advertise it.

CC: stable@vger.kernel.org
Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/netlink/specs/rt_link.yaml | 3 +++
 include/uapi/linux/if_link.h             | 1 +
 net/core/rtnetlink.c                     | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e5..a646d8a6bf9d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1148,6 +1148,9 @@ attribute-sets:
         name: max-pacing-offload-horizon
         type: uint
         doc: EDT offload horizon supported by the device (in nsec).
+      -
+        name: netns-local
+        type: u8
   -
     name: af-spec-attrs
     attributes:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index bfe880fbbb24..ed4a64e1c8f1 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -378,6 +378,7 @@ enum {
 	IFLA_GRO_IPV4_MAX_SIZE,
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
+	IFLA_NETNS_LOCAL,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index abe1a461ea67..acf787e4d22d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1292,6 +1292,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_LOCAL */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2046,6 +2047,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2234,6 +2236,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_LOCAL]	= { .type = NLA_REJECT },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


