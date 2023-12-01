Return-Path: <stable+bounces-3644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5B800C1F
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 14:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A7A1C20FC4
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F433998;
	Fri,  1 Dec 2023 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fITOrdtW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE41131
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 05:31:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332f90a375eso1483769f8f.3
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 05:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701437469; x=1702042269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arJqDarvGraX8S3BBFPFXTHvWw5i4BYD5hU9uEGY+Hs=;
        b=fITOrdtW7pRZylNC/L6+9lfVszXmxA5WHAHe5NK4rECGKn9m03Q7Ctw+d2185ko+zn
         LWL61mG1oDAIz82njT9R9WKYnWVH/ViL6bjN8sXiXr9buEgKD5ESeJ5pEf+M35izO+Sy
         /cDnfK38XBlHFkBwtyiyP0C7FzfbYWzXD+oi4x21lat9vAk5WKOXvHX39RglH3jTiMaG
         u2IYzMVJ3Rw1yDsyXDTBO3zfCuas+L/15o085nfOre3yw5DuMXG21+CDqer3ZzqBYqze
         yFsePyWpVrTcs7b0l3v23hdKFgDVhJMtGQ+cDTp4pzgwV2m/A6ofLf0F+4tuMwQYgrwS
         syTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701437469; x=1702042269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arJqDarvGraX8S3BBFPFXTHvWw5i4BYD5hU9uEGY+Hs=;
        b=RQ8RZ6TfRc6zWu8C3iLfhPe/QvplikewnOLlg3rwFzuXsyaUmv2I3vnzxQqq9IEhAe
         pWBV13ZAl4L2VbCUJ1U8KkSegfKvEL7+Z/r1PnoZJTKhjRbm7Uw1ayDd7fgnxlrTerWF
         3nJcFBGzBevlkX9QFTfXDUPsc2XcyHusmVyJnWlfiq+XdvyY37+Rnb6bsAFr90uRhx31
         EzmR6KwMIFNqrq0s2Im/EbSud+u0VmJo68Fon57FN0fmPFIdDKrCCPrebP11rOGWJj2E
         ijiwmZ/xfpKyziG0VcFO2ew8i8aDfjp5hWXgv6PcWRu5bLM9piQkpH+TlfcC/+iDwUTm
         kzhA==
X-Gm-Message-State: AOJu0YytaRP8nmzdoiN4Kt2/zObdgHMNbEMu8TNVJ7187e5bnLvFEQqc
	w/v3/Ffh4gdu9ttmQv0YivT0i6pVRSt49+ZVc3M=
X-Google-Smtp-Source: AGHT+IE4/Rt61rOloV49Os+54saGOkMaROqDR0G38E6ONf5tCkR1m9qb422CU06umSwiX2+bcL3R5w==
X-Received: by 2002:adf:f144:0:b0:333:1907:c2a3 with SMTP id y4-20020adff144000000b003331907c2a3mr872956wro.21.1701437468827;
        Fri, 01 Dec 2023 05:31:08 -0800 (PST)
Received: from gojira.dev.6wind.com ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm9081931wmq.18.2023.12.01.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:31:08 -0800 (PST)
From: Olivier Matz <olivier.matz@6wind.com>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 1/2] vlan: introduce vlan_dev_free_egress_priority
Date: Fri,  1 Dec 2023 14:30:03 +0100
Message-Id: <20231201133004.3853933-2-olivier.matz@6wind.com>
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

commit 37aa50c539bcbcc01767e515bd170787fcfc0f33 upstream.

This patch is to introduce vlan_dev_free_egress_priority() to
free egress priority for vlan dev, and keep vlan_dev_uninit()
static as .ndo_uninit. It makes the code more clear and safer
when adding new code in vlan_dev_uninit() in the future.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
---
 net/8021q/vlan.h         | 2 +-
 net/8021q/vlan_dev.c     | 7 ++++++-
 net/8021q/vlan_netlink.c | 7 ++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 1a705a4ef7fa..5eaf38875554 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -129,6 +129,7 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio);
+void vlan_dev_free_egress_priority(const struct net_device *dev);
 int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
 			       size_t size);
@@ -139,7 +140,6 @@ int vlan_check_real_dev(struct net_device *real_dev,
 void vlan_setup(struct net_device *dev);
 int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack);
 void unregister_vlan_dev(struct net_device *dev, struct list_head *head);
-void vlan_dev_uninit(struct net_device *dev);
 bool vlan_dev_inherit_address(struct net_device *dev,
 			      struct net_device *real_dev);
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 3d0f0d0a323b..cf66be83fb77 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -622,7 +622,7 @@ static int vlan_dev_init(struct net_device *dev)
 }
 
 /* Note: this function might be called multiple times for the same device. */
-void vlan_dev_uninit(struct net_device *dev)
+void vlan_dev_free_egress_priority(const struct net_device *dev)
 {
 	struct vlan_priority_tci_mapping *pm;
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
@@ -636,6 +636,11 @@ void vlan_dev_uninit(struct net_device *dev)
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
index 0db85aeb119b..53b1955b027f 100644
--- a/net/8021q/vlan_netlink.c
+++ b/net/8021q/vlan_netlink.c
@@ -183,10 +183,11 @@ static int vlan_newlink(struct net *src_net, struct net_device *dev,
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
2.30.2


