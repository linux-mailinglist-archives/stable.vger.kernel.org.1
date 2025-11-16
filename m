Return-Path: <stable+bounces-194860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1837AC61121
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 08:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19CFD358B3D
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960B23D7C3;
	Sun, 16 Nov 2025 07:32:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39D8462;
	Sun, 16 Nov 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763278379; cv=none; b=oa1K0guKY3egldB99W5BEI3pXmqfAUeZXisOxQswDBPu2XxZpTf8SNX5qrmwbcIIl3pF4vf7F0hYC+zByHyRhbmZtiDddauomVz1vkmMzDSwXrklpz7YtLJ68rvE8SS18xE/5yt/S+NKvnxrvEw/KK0IpXTWFGFdIjtmi4K95jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763278379; c=relaxed/simple;
	bh=b9jOgx/zaEV61jEE9oHVa9jOaMm0I7kVsNBgz2bVBkc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ElmJamZButMaGfbMii8hd/zmO4/PMsvUIlOWkXfONjHwWtLJNEHVp1rlAZubGaHXy07UvvX/0r29/N9mZj5X8/SJrDCOREZgX2D9+7lvse1SZJXhGWNbQ4hUFdCrpzHGMZ8xESS7l3T8H8+K8DwMMjd+c3IvHSgwM4cMiRWtEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAAnstQZfhlp_+TxAA--.28161S2;
	Sun, 16 Nov 2025 15:32:44 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: vkoul@kernel.org,
	kishon@kernel.org,
	make24@iscas.ac.cn,
	andriy.shevchenko@linux.intel.com,
	mchehab+huawei@kernel.org,
	mani@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH] phy: HiSilicon: Fix error handling in hi3670_pcie_get_resources_from_pcie
Date: Sun, 16 Nov 2025 15:32:31 +0800
Message-Id: <20251116073231.22676-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAAnstQZfhlp_+TxAA--.28161S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfJr4rCw18ZrW5tF4xJFb_yoW8tr1DpF
	W7KFWakry8J393uF1FvF45WFyYkFs0ka45A34xK34SvFnaqr90qayUtFy0q3W2vFWkZFWU
	KFyUtF4kJa18trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbsmitUU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In hi3670_pcie_get_resources_from_pcie(), the reference obtained via
bus_find_device_by_of_node() is never released with put_device(). Each
call to this function increments the reference count of the PCIe
device without decrementing it, preventing proper device cleanup. And
the device node obtained via of_get_child_by_name() is never released
with of_node_put(). This could cause a leak of the node reference.

Add proper resource cleanup using goto labels to ensure all acquired
references are released before function return, regardless of the exit
path.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index dbc7dcce682b..4c67a7613261 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -560,7 +560,8 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 {
 	struct device_node *pcie_port;
 	struct device *dev = phy->dev;
-	struct device *pcie_dev;
+	struct device *pcie_dev = NULL;
+	int ret = 0;
 
 	pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
 	if (!pcie_port) {
@@ -572,7 +573,8 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
 	if (!pcie_dev) {
 		dev_err(dev, "Didn't find pcie device\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	/*
@@ -586,9 +588,14 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
 	if (!phy->apb) {
 		dev_err(dev, "Failed to get APB regmap\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_device;
 	}
 
+out_put_device:
+	put_device(pcie_dev);
+out_put_node:
+	of_node_put(pcie_port);
 	return 0;
 }
 
-- 
2.17.1


