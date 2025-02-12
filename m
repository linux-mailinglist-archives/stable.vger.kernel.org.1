Return-Path: <stable+bounces-114991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCDCA31C64
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 03:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F1D188A0A7
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2981D63F5;
	Wed, 12 Feb 2025 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="De0SoMQR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA541D63DF
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328945; cv=none; b=QGs6l3iKxlEWxBA/VdwXdZoTOHoFZg2Ni1sl9Gf0HBA0FrnmVIqM1K6Z+64y8d0PfB7PecJTYZTT0ePkszYJ3aJ4GEbtiaExWDTfH3rbP/R6ELYC13cUXXU9emS5QM8lCleh38Mo+iAvdtNwYy9SFYD33tGU19pNN/lTXPdgwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328945; c=relaxed/simple;
	bh=yxtVEC6wVjEg7+cT9vfC0p87CO/To1gyhDinXZV9hZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IVDxii7P4lMOUrMl8tQXdy/bF9U42p2dPvHzXK1kQ+B2oAd6jshSQZ8IweWACrlT6JkRoYmoaSNiwZGpKe9KIH9asTekLwXm6HfMkIFfnw9ULIlOIEUCjkfgem18KPTCyeVWcr+vBn4L9MsqFNs6yNT8beHVDwJZXQhPnY6ZBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=De0SoMQR; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4718fa2e66eso24847121cf.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 18:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328939; x=1739933739;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KDvwSXlkrknuS/1CBGqbWRd+wHZnbKqUNmogKzbLmA=;
        b=Ka94PhFB+HUzazWGD7izT1hZEcXL50lmznduABonL7K0Zht03NYModLDqJHEduZA5K
         HHubejfdFWizu+WLD+9K/d6T7ooy06jwBZjVSpqqvqr1atkWF1Wx/b/RWGb/F4ecCiAp
         pBd0xCx/ZfCzyAQPZkt1Ybr++R8821bhpbY/6Zzo3PKpMHhaEFjnGqQtGoAsO2THsd37
         lyD3VpdAWySJ0Csnk8W3AjBg9fl5CpMMNFfG+n4tQF7tdbZYoEKo1xNQo+n9jFZmXEcv
         42JgEJzpFrCWB0V+nYpcQ3CmjYWA73Ti/yJtOncNYvpClczPqciBEaTDf8l29nm5Ck42
         +qlw==
X-Gm-Message-State: AOJu0YybPtv9B9aXp7BsYBbyv9yb7M2R/WVseLAgh1p/S2DnPEU1WLTO
	sDI3rITz8dTqGoqHpBxgARq3xvQJwH03B4CNHqB2L6CLhhHc1y9eVtMrva0QzziOFhJTm54Spgo
	Wt7V904tLcbCko54p7EYC7rnGuV6Hzw==
X-Gm-Gg: ASbGnctWCnwEdClgeVTK2Q6Lax2h/2RnKjgPbdglC0guW6DzW9TDCMuiJcVGmoQ3bIg
	Iel8lOCET3YlpIIn5FfP35qICIm9o6ui6CwVEMQ+daSYZM4qQ52oKcD5Qb+O+YUsQAMb4nxHy8x
	9QxTzcpr4u5Ax4x2HT3qCXaWkWl8a4q47x19mYSw1FzAhQ4YumeOn8eD9e2q+73IKVDJPu+rFjH
	myZRUoik9NvgMCz5bsmoaI3peweAdv0x7hfQeF6xAeDTZ7sW26jNdy95diC09CxGg/eWAO221C3
	Y1FqfPDnnABgaoY=
X-Google-Smtp-Source: AGHT+IHiijqTowo6Aou7bCZq6IeFQfaxl3aR9PRJzq1608JqxpSzJmKw946ads3gCidaxCJLCfPYuEEmgMMq
X-Received: by 2002:a05:6214:e85:b0:6dd:d317:e0aa with SMTP id 6a1803df08f44-6e46ed75dc9mr31644446d6.8.1739328939134;
        Tue, 11 Feb 2025 18:55:39 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e45db0890fsm3940056d6.33.2025.02.11.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:55:39 -0800 (PST)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1739328938;
	bh=1KDvwSXlkrknuS/1CBGqbWRd+wHZnbKqUNmogKzbLmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=De0SoMQR5pHZIkAIvgc9PEHB8AVa638UlMJOdZtB17ZhpUBoX5+D96s5JP1vTZXtg
	 fZpBF14jmGHj48F/GuUK5vmJmV9YTxwriUhL2GhD8QH9EQ7WVmshLMHozajkdktEm7
	 K5qEcLbuqF6iYbXreO2RUX5rQudABaPjy30Ay5EJimAjgI6t3z23xRYqT55mb4g6bZ
	 ZAs0fMwuiobDrredqOCUNkhhg3tYsi2Igcn2vXJECmvc5GlXeoJkfift/CjPBQUA5H
	 7mR+Iwgp9w7wJe3UhuFQ0SNOaVsR/M2BWTioTJ2mxn9yum54ETHVU7m9GONhz9lUxd
	 HofoR30rOzNow==
Received: from visor.sjc.aristanetworks.com. (unknown [172.22.75.75])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 87C1A10023B;
	Wed, 12 Feb 2025 02:55:38 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: stable@vger.kernel.org
Cc: Olivier Matz <olivier.matz@6wind.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Ivan Delalande <colona@arista.com>
Subject: [PATCH 5.4/5.10 1/2] vlan: introduce vlan_dev_free_egress_priority
Date: Tue, 11 Feb 2025 18:54:54 -0800
Message-Id: <20250212025455.252772-2-colona@arista.com>
In-Reply-To: <20250212025455.252772-1-colona@arista.com>
References: <20250212025455.252772-1-colona@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

commit 37aa50c539bcbcc01767e515bd170787fcfc0f33 upstream.

This patch is to introduce vlan_dev_free_egress_priority() to
free egress priority for vlan dev, and keep vlan_dev_uninit()
static as .ndo_uninit. It makes the code more clear and safer
when adding new code in vlan_dev_uninit() in the future.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 net/8021q/vlan.h         | 2 +-
 net/8021q/vlan_dev.c     | 7 ++++++-
 net/8021q/vlan_netlink.c | 7 ++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 953405362795..c37349277114 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -124,6 +124,7 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio);
+void vlan_dev_free_egress_priority(const struct net_device *dev);
 int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result);
 
@@ -133,7 +134,6 @@ int vlan_check_real_dev(struct net_device *real_dev,
 void vlan_setup(struct net_device *dev);
 int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack);
 void unregister_vlan_dev(struct net_device *dev, struct list_head *head);
-void vlan_dev_uninit(struct net_device *dev);
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev);
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 8edac9307868..fefc5ed6704d 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -613,7 +613,7 @@ static int vlan_dev_init(struct net_device *dev)
 }
 
 /* Note: this function might be called multiple times for the same device. */
-void vlan_dev_uninit(struct net_device *dev)
+void vlan_dev_free_egress_priority(const struct net_device *dev)
 {
 	struct vlan_priority_tci_mapping *pm;
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
@@ -627,6 +627,11 @@ void vlan_dev_uninit(struct net_device *dev)
 	}
 }
 
+static void vlan_dev_uninit(struct net_device *dev)
+{
+	vlan_dev_free_egress_priority(dev);
+}
+
 static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
diff --git a/net/8021q/vlan_netlink.c b/net/8021q/vlan_netlink.c
index 99b277775257..dca1ec705b6c 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -187,10 +187,11 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
 		return -EINVAL;
 
 	err = vlan_changelink(dev, tb, data, extack);
-	if (!err)
-		err = register_vlan_dev(dev, extack);
 	if (err)
-		vlan_dev_uninit(dev);
+		return err;
+	err = register_vlan_dev(dev, extack);
+	if (err)
+		vlan_dev_free_egress_priority(dev);
 	return err;
 }
 
-- 
2.34.1


