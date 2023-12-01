Return-Path: <stable+bounces-3645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232B9800C22
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1706281A99
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65F33998;
	Fri,  1 Dec 2023 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="U+60L0R4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501713E
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:31:15 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bbb4de875so2928603e87.0
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701437473; x=1702042273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ8k4KwRkH+XGgjRhtoQxt2t2ooWmizNTX60XMUothI=;
        b=U+60L0R4MdZys5Fo3EUlbec7kIgBsSet2eFkktm4PLUebZZYmU80lB5l5w/S8MPjR9
         zHI8SWDTBKeUv8+Mnf/0N7UY570UPrMTXbM9dgys6nkoRO9MjdllEqCYYklwsvSE8sTG
         +RgP6T24RuvE3CZNyaHOVhTvF82R/+LrcyodyLfRMNpSgr8fhArG/HJe/CkBh1cKwmBj
         l57JSvfgtxcvb8htGm1eoXbCW1zHu02uhS8s14qIJ1rjRFx7Yx1XDWOAbE7iYEbTf1R9
         0D9ze+9/yJ45EyYidA4TDQUgAMOyI+rcoPX5vhdfuzOT/wpxm8PG+h7clGeXLciRkPR6
         zuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701437473; x=1702042273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ8k4KwRkH+XGgjRhtoQxt2t2ooWmizNTX60XMUothI=;
        b=Vl0wu9nFCLdZFatYk74EzXbW7d0LjqDHuYhknM1ZWosnZSxhLRBoOgya4OMwLfpdvn
         z6x5QxpCENxeDic1EROTSnSMkvS5C9r0bmS79n0xcQJL33Piirylj/MJqfpuLGpzVV1u
         YVx7CmNPVadIQ3CbWyzQWfr1sP2DABwLnh0lqy+c/D3CNZf04PQUBMlBtiTCiLTxKheh
         zFmgfvGpJHa+CQnDZA2QvVcOIvaNB1PX7LQzNQ3orJHKyjmsbKplNpGrOGUvF28JFQdL
         73fBN1SHvXTAtgDawkU+jqOh3ulGkBIgEHfW+T0w+IfLbgXWLA8FCmrAfhEhNny+DVmY
         3FKw==
X-Gm-Message-State: AOJu0Yy5W4mrZ0WvyWhhnTPewjbZMEvh4i/URqijBltP3yivE+h7yA0w
	wGjCxlfSSyaNyI3tReFN+wwNrVl+TfHIIlP0I8c=
X-Google-Smtp-Source: AGHT+IEkQGsNT+4Me+CLPjFUQ0ak86tYyAN1lKTselnzPreCN+H39u/0OL1iU49W5ucO5OPxlouU2w==
X-Received: by 2002:a19:670f:0:b0:50b:d1ac:1fcb with SMTP id b15-20020a19670f000000b0050bd1ac1fcbmr663475lfc.44.1701437473609;
        Fri, 01 Dec 2023 05:31:13 -0800 (PST)
Received: from gojira.dev.6wind.com ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm9081931wmq.18.2023.12.01.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:31:12 -0800 (PST)
From: Olivier Matz <olivier.matz@6wind.com>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Shuang Li <shuali@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 2/2] vlan: move dev_put into vlan_dev_uninit
Date: Fri,  1 Dec 2023 14:30:04 +0100
Message-Id: <20231201133004.3853933-3-olivier.matz@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231201133004.3853933-1-olivier.matz@6wind.com>
References: <20231201133004.3853933-1-olivier.matz@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/8021q/vlan_dev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index cf66be83fb77..ad2d3ad34b7d 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -638,7 +638,12 @@ void vlan_dev_free_egress_priority(const struct net_device *dev)
 
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
@@ -851,9 +856,6 @@ static void vlan_dev_free(struct net_device *dev)
 
 	free_percpu(vlan->vlan_pcpu_stats);
 	vlan->vlan_pcpu_stats = NULL;
-
-	/* Get rid of the vlan's reference to real_dev */
-	dev_put(vlan->real_dev);
 }
 
 void vlan_setup(struct net_device *dev)
-- 
2.30.2


