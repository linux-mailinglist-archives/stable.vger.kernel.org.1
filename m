Return-Path: <stable+bounces-95408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0AC9D8914
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4235228783F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890F1B2196;
	Mon, 25 Nov 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul8JSpOj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832C171CD
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548061; cv=none; b=bMADUeeo6P2AwvQihS7i8eJhDRzYigJxQeBxkLdoGa+F6N6JlDFuReLjiHCGsYpOumyCf9NTn6BMUn/mukskrFd+Z2S4cTw05cqmSFX9HhGScbaS+jo9zGJf13sJh6pu57T80BguXuJJUx+BFn3lh3+igE+axacDUeLBj6nxM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548061; c=relaxed/simple;
	bh=yOWby2ta9KaKqrllrXExrCzS+5os5jPlhrGIrGjrZi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQTlhAUptFFcfGHTTHTzlJv9++qpUYGOT7MQeN/rmedZyT/aU+4Ymc52ua/h7a3RiwNXTRJb2bJ6KdzTo3WG/Aa+3+QWmM4vm/go0iVtWMb8T+SFwhl7RNJkAbcJntC734eWPfOPu9PyNuvEEaqO1TnIEU+Nf1ZPDkdJiIvVbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul8JSpOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E69C4CECF;
	Mon, 25 Nov 2024 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548061;
	bh=yOWby2ta9KaKqrllrXExrCzS+5os5jPlhrGIrGjrZi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ul8JSpOjYC1Oliqn/zmW15MCdetdCP8PywvlB9O80/s6TwM2csuUio/cVPoW6Jnvh
	 phgIG8x4Su5dqKcDdPN++NI5YtQr8Y1HFI3AJSZAw1ZUkmBPhuPC0CGArvkeEh8Wxp
	 Z9wHKebobYvnnkxh7dtaTmelDFJjJSYaTNgkdh3IJ0rRyJUokkd7qFpN01s5WTsi7G
	 Zi3vyIPkKhikc4Bx54I6KxFOjsGZHJhpQ/tnP5OtE2rcxkErRyV7fJuR7+v76uCN75
	 MjOxn8UnjPTaObfQV6pGZWpYGySEdOZ+RNS4pI2n8TWe0r3et9F1FBgwpOcFqZOL9W
	 RCGtmhjDFNV0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] fpga: bridge: add owner module and take its refcount
Date: Mon, 25 Nov 2024 10:20:59 -0500
Message-ID: <20241125100821-c497bd65ad3e3730@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125053816.1914594-2-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 1da11f822042eb6ef4b6064dc048f157a7852529

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Marco Pagani <marpagan@redhat.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d7c4081c54a1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 10:03:24.580903183 -0500
+++ /tmp/tmp.dgudhG3mc3	2024-11-25 10:03:24.569117471 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 1da11f822042eb6ef4b6064dc048f157a7852529 ]
+
 The current implementation of the fpga bridge assumes that the low-level
 module registers a driver for the parent device and uses its owner pointer
 to take the module's refcount. This approach is problematic since it can
@@ -27,6 +29,8 @@
 Acked-by: Xu Yilun <yilun.xu@intel.com>
 Link: https://lore.kernel.org/r/20240322171839.233864-1-marpagan@redhat.com
 Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
  drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
@@ -34,7 +38,7 @@
  3 files changed, 43 insertions(+), 31 deletions(-)
 
 diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
-index 6042085340953..833f68fb07008 100644
+index 604208534095..833f68fb0700 100644
 --- a/Documentation/driver-api/fpga/fpga-bridge.rst
 +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
 @@ -6,9 +6,12 @@ API to implement a new FPGA bridge
@@ -61,7 +65,7 @@
  .. kernel-doc:: drivers/fpga/fpga-bridge.c
     :functions: fpga_bridge_unregister
 diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
-index 79c473b3c7c3d..8ef395b49bf8a 100644
+index 833ce13ff6f8..698d6cbf782a 100644
 --- a/drivers/fpga/fpga-bridge.c
 +++ b/drivers/fpga/fpga-bridge.c
 @@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
@@ -106,7 +110,7 @@
  }
  
  /**
-@@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+@@ -97,13 +90,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
  				       struct fpga_image_info *info)
  {
@@ -114,9 +118,9 @@
 +	struct fpga_bridge *bridge;
 +	struct device *bridge_dev;
  
--	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+-	dev = class_find_device_by_of_node(fpga_bridge_class, np);
 -	if (!dev)
-+	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
++	bridge_dev = class_find_device_by_of_node(fpga_bridge_class, np);
 +	if (!bridge_dev)
  		return ERR_PTR(-ENODEV);
  
@@ -129,15 +133,15 @@
  }
  EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
  
-@@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
+@@ -124,6 +122,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
  struct fpga_bridge *fpga_bridge_get(struct device *dev,
  				    struct fpga_image_info *info)
  {
 +	struct fpga_bridge *bridge;
  	struct device *bridge_dev;
  
- 	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
-@@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
+ 	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
+@@ -131,7 +130,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
  	if (!bridge_dev)
  		return ERR_PTR(-ENODEV);
  
@@ -150,7 +154,7 @@
  }
  EXPORT_SYMBOL_GPL(fpga_bridge_get);
  
-@@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
+@@ -145,7 +148,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
  	dev_dbg(&bridge->dev, "put\n");
  
  	bridge->info = NULL;
@@ -159,7 +163,7 @@
  	mutex_unlock(&bridge->mutex);
  	put_device(&bridge->dev);
  }
-@@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
+@@ -312,18 +315,19 @@ static struct attribute *fpga_bridge_attrs[] = {
  ATTRIBUTE_GROUPS(fpga_bridge);
  
  /**
@@ -183,7 +187,7 @@
  {
  	struct fpga_bridge *bridge;
  	int id, ret;
-@@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
+@@ -353,6 +357,7 @@ fpga_bridge_register(struct device *parent, const char *name,
  
  	bridge->name = name;
  	bridge->br_ops = br_ops;
@@ -191,7 +195,7 @@
  	bridge->priv = priv;
  
  	bridge->dev.groups = br_ops->groups;
-@@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
+@@ -382,7 +387,7 @@ fpga_bridge_register(struct device *parent, const char *name,
  
  	return ERR_PTR(ret);
  }
@@ -201,7 +205,7 @@
  /**
   * fpga_bridge_unregister - unregister an FPGA bridge
 diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
-index 223da48a6d18b..94c4edd047e54 100644
+index 223da48a6d18..94c4edd047e5 100644
 --- a/include/linux/fpga/fpga-bridge.h
 +++ b/include/linux/fpga/fpga-bridge.h
 @@ -45,6 +45,7 @@ struct fpga_bridge_info {
@@ -236,3 +240,6 @@
  void fpga_bridge_unregister(struct fpga_bridge *br);
  
  #endif /* _LINUX_FPGA_BRIDGE_H */
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

