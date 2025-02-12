Return-Path: <stable+bounces-114992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6AA31C65
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 03:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDA63A54F4
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ACB1D63C4;
	Wed, 12 Feb 2025 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="T2eey5y4"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCF1D47AD
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328946; cv=none; b=sXApwMQwFxCLkQ2u2dtb0LLJpuAwLj/BUJ8o4x4Ns55La/CqPjeMNKH+iEW/X5paJPjgZG6DIqHWAJQMCOpV2uELe4m4yF8fL7+dg3mBfLAXFg6Ak8oO6CB02GonG6DIjjcQW7/dbDsMyfTAvw8Vp2OHy+TACj5ubtKBUYzx8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328946; c=relaxed/simple;
	bh=nJ1+6T/iMN1d715e44BYBA2wZzNUnnRSue2vC2ob++w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LT0fkBW2AkTXPthebO+zkry2Q0yewhHUJYsOfv2Rp2WYAw8SpumPJPzUu9Uz17kGToI8JjpGPNbZQq4quWhfF7e3HIfmfPcnTQu4M1GGG6hy80ttkkgyUTRUpuaE/+4Ogziz7TMxlVIhmj3tmLU8yhEmcOpCwBsut173pyClLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=T2eey5y4; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-855353491d7so68908939f.3
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 18:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328941; x=1739933741;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufOvK0ICjLwwv3AooMUi20OpvUxPTSR0kxfwqxAeEok=;
        b=IDOop6RdMzBrIbMxh/+BWGGSiOQxvI63AIHy79A93cxw6LbuT0SutQqtVzNNHnYzCf
         sKAqNwYH/EfuKGrJEvOz6xE/9PKovjDZ3YiDaVXokP/qzrBPjrEOOZ0CMwTMP44Gia7b
         YEv0qdmahdOaC4pwFNbaPU8+LP79kxwqyHURoD5v/zNsp3eABSheK6oV0faHod2IA1eY
         C8QY/lZr3N/GoVsPKVWRhEoEUz9MQjD4QNC1iFIlK/5rHuGmTXsU9gFp2d82CAR41X3w
         d7olCHxzwtBlv/6rKbrNFGRlfjZzEWlzSQ+GlBcAyOPzQePDT0o+YoP4Wn4K0IDWkGwy
         wAfA==
X-Gm-Message-State: AOJu0Yzn6dpFbwhZBwlf+y8y3glv68DCPWNsGnB/9ZseWZRjgA3T6zXM
	eguiwtk8R8KI1NwQRLlDNJKaVJRkCEv0uAkuop+EEesL9F2h7nHCBQdlR0VDVgvCcZso5LFbeEl
	LebM3JsUZdic2tZCMoMa4a1IpXfSYRQ==
X-Gm-Gg: ASbGncs06/pDgmMbnsNw197uyH0KCQIrUzWrf98Mo/ayp0pulinBq1sExomLtw8ti0m
	OEULNOV4egMJgi2CQ+aj1P6qLa4wEJXcEhRz5+HlO2WJlu7YWtl4X9Hw9hNdVLpbcBkA4vi2EM0
	qJ19T1e0F6PYU4vsffYVNg7C6zyNi2A+ThDXAMfDGRTQyyKScNjNSsnu+v1Rr1S7oipekMN0+Mz
	bKbpxdT2ZPlnaQfhuzor62cAVLj8CUEpsVqb3lBlCxw13rZWzfoDDIvK+PIIEncyo9LsTjaMjn1
	y8N6NxCxFEEtlWI=
X-Google-Smtp-Source: AGHT+IH0z2RHXyHm7ttM3Xd4Eno5ENrqiK7RiVnEUUWVqZQFo2I23O8xrL5ehAuO1J6+LraFBku2rkgI/gRC
X-Received: by 2002:a05:6602:2cd2:b0:844:e06e:53c6 with SMTP id ca18e2360f4ac-85555da813amr149217339f.11.1739328941579;
        Tue, 11 Feb 2025 18:55:41 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4ecfb2b9f7asm297467173.62.2025.02.11.18.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:55:41 -0800 (PST)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1739328940;
	bh=ufOvK0ICjLwwv3AooMUi20OpvUxPTSR0kxfwqxAeEok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T2eey5y4HHFYHrpfXLx8iHjkIXxqMhEMtQ58PPS6h+L0vSW60is/WGRo+BRoLAkQP
	 IFHVGFY8iJXgB7RI+Xt+U931idH20sqmqUAgO29bEdJ9gaESAyBrzyVvpn4vLFY+19
	 guuKAw6YSDhxqtMOSB56Qe0AVcxmHLAfJS0Hpo0Wb4RS8jwwJQKoshviwnDtQxtlfC
	 tm2yDm+Q2uCPLrpjow0EhE6PbVCBfgEi6bK1M+L2v+DKaIvDL/533LSP1mNM6SzCY2
	 1b18nRARciO+v9IuieeLAyFBDm28mVPfYEHowvrwVSKKR5vRV0Nicb6kFXInRIGMwx
	 ePn1ceVh1Eq9A==
Received: from visor.sjc.aristanetworks.com. (unknown [172.22.75.75])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 9258310023B;
	Wed, 12 Feb 2025 02:55:40 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: stable@vger.kernel.org
Cc: Olivier Matz <olivier.matz@6wind.com>,
	Xin Long <lucien.xin@gmail.com>,
	Shuang Li <shuali@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Ivan Delalande <colona@arista.com>
Subject: [PATCH 5.4/5.10 2/2] vlan: move dev_put into vlan_dev_uninit
Date: Tue, 11 Feb 2025 18:54:55 -0800
Message-Id: <20250212025455.252772-3-colona@arista.com>
In-Reply-To: <20250212025455.252772-1-colona@arista.com>
References: <20250212025455.252772-1-colona@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

commit d6ff94afd90b0ce8d1715f8ef77d4347d7a7f2c0 upstream.

Shuang Li reported an QinQ issue by simply doing:

  # ip link add dummy0 type dummy
  # ip link add link dummy0 name dummy0.1 type vlan id 1
  # ip link add link dummy0.1 name dummy0.1.2 type vlan id 2
  # rmmod 8021q

 unregister_netdevice: waiting for dummy0.1 to become free. Usage count = 1

When rmmods 8021q, all vlan devs are deleted from their real_dev's vlan grp
and added into list_kill by unregister_vlan_dev(). dummy0.1 is unregistered
before dummy0.1.2, as it's using for_each_netdev() in __rtnl_kill_links().

When unregisters dummy0.1, dummy0.1.2 is not unregistered in the event of
NETDEV_UNREGISTER, as it's been deleted from dummy0.1's vlan grp. However,
due to dummy0.1.2 still holding dummy0.1, dummy0.1 will keep waiting in
netdev_wait_allrefs(), while dummy0.1.2 will never get unregistered and
release dummy0.1, as it delays dev_put until calling dev->priv_destructor,
vlan_dev_free().

This issue was introduced by Commit 563bcbae3ba2 ("net: vlan: fix a UAF in
vlan_dev_real_dev()"), and this patch is to fix it by moving dev_put() into
vlan_dev_uninit(), which is called after NETDEV_UNREGISTER event but before
netdev_wait_allrefs().

Fixes: 563bcbae3ba2 ("net: vlan: fix a UAF in vlan_dev_real_dev()")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 net/8021q/vlan_dev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index fefc5ed6704d..b7cf430006e5 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -629,7 +629,12 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 
 static void vlan_dev_uninit(struct net_device *dev)
 {
+	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+
 	vlan_dev_free_egress_priority(dev);
+
+	/* Get rid of the vlan's reference to real_dev */
+	dev_put(vlan->real_dev);
 }
 
 static netdev_features_t vlan_dev_fix_features(struct net_device *dev,
@@ -821,9 +826,6 @@ static void vlan_dev_free(struct net_device *dev)
 
 	free_percpu(vlan->vlan_pcpu_stats);
 	vlan->vlan_pcpu_stats = NULL;
-
-	/* Get rid of the vlan's reference to real_dev */
-	dev_put(vlan->real_dev);
 }
 
 void vlan_setup(struct net_device *dev)
-- 
2.34.1


