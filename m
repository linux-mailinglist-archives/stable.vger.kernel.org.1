Return-Path: <stable+bounces-114139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C56A2AE31
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6285516B103
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5323718A;
	Thu,  6 Feb 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="EE4+oooB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E794148FED
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860702; cv=none; b=dte15sRN2kwUlEv+6OdA9nbD2lEPboj/r5SKfu2vg26ZBIu2A2qQNvhVrrjsaUkA0MD/RnA2cwYIvWM7QvSyvEcSs4ukk9P+mkpPkorSqFqeiVKp/uFvdrXYLB41ofjAjvuv3W6YkhMVn7M9LEGte9Cv3DvCiH26CcunYsDNgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860702; c=relaxed/simple;
	bh=qhfrF8rOfWi9BMPzEW1K1lhSoKZWMdMKypOVywawQxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWW7Gemp/5hvBJf3d2gbraK2dmTQpkY2AEGch0ON83CdKnpA2R7V9w6Cg60tKt+rfDjd6r/XJvTSjbnvL6k7pwMkf3WXVazzCpKDbwD1ihdKt1gx8bxWjXujEosTT+sdG8YG186lj32sPw/tyl0iLVos3F3+XcetOTH933RdyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=EE4+oooB; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-aa6b500a685so14479266b.2
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738860698; x=1739465498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uTxvJx8XP29oBONkH9ilUZCu0gHXNxSpo7+j7SmAsw=;
        b=EE4+oooBS1/xZ4kM6ROhRdy8yyl4D4A9HA7OyKwZCn98r4+ga9PCu060nbnq2IMB+P
         oQxa3/EZN5335daf1U9sUi1weHi7ZvyLHy07FpHwMN4DwNMDXgFIYjJl2prV3/LqxXSV
         Kj8tLFLDvbUGSUBWEVQp3HR/vgx/B22z0a1RS2A81my5PnQqBQdfeh3Eg04rSRIsgPUR
         Tcvz2NF4JrM4pzVbxXxfy1IetFUK8llbXSFlRqfYTgD3921xpEmEm6k8A7ZXSLHHZl2b
         04kw2LKb6fAVLg71XSW+9zbHIYGmVrOrdY/9w5nRILIopEzNLmi6exMFoW4zjonrpPIo
         82iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860698; x=1739465498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uTxvJx8XP29oBONkH9ilUZCu0gHXNxSpo7+j7SmAsw=;
        b=Fw1RMo+jcZe5BStwDSmRb61u3eguf41GVPkspYS3sbZH1mv5Bgh/4mRxj3ZJq7vOS5
         SlQtYUYh0DdOJftdxIjgKkgB4/e3i6Z+/vkiZ6Yv7JUk9W4SgngWXH2OyneQ2wbMmcAu
         NvM9nH+T7FD2aJ54DdO0yYwHNUG3RNFZuDxcJk0Lr1uXoIvO4PmiSg3/UG6DgOXDBDB0
         3m8CKKM8BzX8DMYwGYETVfaOAJk7Ggy2eT1FO+Cvoo27YDxilSPd+kzuw7A65mURhTfR
         P+4HXqItrILqPC7eEWsniFSwOqlof00lMun461xdixQTiDvdgoWgqQdUc4phY6KBzqov
         6h5w==
X-Forwarded-Encrypted: i=1; AJvYcCUfwKorV1OhYMuxaWtizazZkRfevw6GjcEGCn0y3yeBN3haD+isVOJxZBagFZi7FlSCIaycUrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXRn8PBm1lfFS2lsDmmhenIAcXwEK6ym8Si0JyE5LbT8rhPKq
	7Z4nUbzsu9Or8FfvDocMuhU6lrGSNrG7UXNHBp6kj54T7pHt3dbkrlmnVX3xB8qIDsFgdZFctup
	IXM2+B9yPYLntab3S3ycU/clPoCPaj2qV
X-Gm-Gg: ASbGncvHQKnIQhHUX0kDJ3qvlUDvFrMz0O1UtkeplAHQZMU3GBiTcB87t/rC7bP93Gn
	xP7G92sTJWMO2BYVxf1BTxIVapMegDGjoyIKFNvymvFau/bVOoSn1drapVV01hBagtmBC81YCtq
	b0zOSu8vOtYB+dGFkYA/FFEan8oqJaQ+D/DyV+AoX1C97s7JcX6AGcZtZRvRiZ82eDQwd6XP3sZ
	honJSUi55WpAOJncADcQNwKa8E8c6UpSlDxL/ZRqD/O51HvKWEGKjyHT2VjeB0065t1Y1Ui8NI+
	0/Gm03WPC/PTC8HoVoYPmL/dPfRyOR9JMkoNDsiUZQv02wJfqUoERV0AItqe
X-Google-Smtp-Source: AGHT+IGAx0Q/H2eQHoYeawfbxSgrNNhWSWM7mPVrJrWkJiQzRfOQKr8QsT0MnRmkOORHMt0dDZNv2kJwAjCq
X-Received: by 2002:a17:907:d9f:b0:a9e:80ed:5cc6 with SMTP id a640c23a62f3a-ab75e35d3femr321004666b.13.1738860698137;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ab77332cb11sm5164966b.172.2025.02.06.08.51.38;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id D26731CD32;
	Thu,  6 Feb 2025 17:51:37 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tg56H-00CA04-JR; Thu, 06 Feb 2025 17:51:37 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: advertise 'netns local' property via netlink
Date: Thu,  6 Feb 2025 17:50:26 +0100
Message-ID: <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
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
 include/uapi/linux/if_link.h | 1 +
 net/core/rtnetlink.c         | 3 +++
 2 files changed, 4 insertions(+)

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
index d1e559fce918..5032e65b8faa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1287,6 +1287,7 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4) /* IFLA_TSO_MAX_SEGS */
 	       + nla_total_size(1) /* IFLA_OPERSTATE */
 	       + nla_total_size(1) /* IFLA_LINKMODE */
+	       + nla_total_size(1) /* IFLA_NETNS_LOCAL */
 	       + nla_total_size(4) /* IFLA_CARRIER_CHANGES */
 	       + nla_total_size(4) /* IFLA_LINK_NETNSID */
 	       + nla_total_size(4) /* IFLA_GROUP */
@@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
 					    IF_OPER_DOWN) ||
 	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
+	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||
 	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
 	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
 	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||
@@ -2229,6 +2231,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
+	[IFLA_NETNS_LOCAL]	= { .type = NLA_U8 },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.1


