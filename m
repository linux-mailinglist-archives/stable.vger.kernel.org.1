Return-Path: <stable+bounces-194893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E9C61F94
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 02:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A16635A651
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FDB1A3179;
	Mon, 17 Nov 2025 01:02:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121D2C9D;
	Mon, 17 Nov 2025 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341367; cv=none; b=eexCPugiWFW/nZ76GHX/AumqfBG+aTJD7VhjeeRY9nVQUViozUR1XAZG36uQdIxRbS3cJSppAg4X5KrBjDEsgdGQv31ByZlGlfnmijQHsXAym7VdHJOTYc4vnycihUe3ikmsNoX+1eWHTHQJ9rGg5xWVSfBAjt2HhNsuN5OykfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341367; c=relaxed/simple;
	bh=iYQl/szgxWSm/SEE6z4BQet/6LleiP2FiJFN15D/TeE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AKEz0X7mpj9gYsQ5xFHXRPSgumcpd48PQJXtglRtdIb4RH2U10gD6c6liq7fec6ZY/68p9g3FXMnFD7PFp3ItgQHbuxeQUAzplJv6LmTqP7ZR9xtPrRP7ZeVQPUPuPocHgjB6lizjRMB/zgP933GxyyzidGWXHh2yi9pKZHQItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowABXU2QkdBppz4ICAQ--.23440S2;
	Mon, 17 Nov 2025 09:02:35 +0800 (CST)
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
Subject: [PATCH v2] phy: HiSilicon: Fix error handling in hi3670_pcie_get_resources_from_pcie
Date: Mon, 17 Nov 2025 09:02:27 +0800
Message-Id: <20251117010227.17238-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowABXU2QkdBppz4ICAQ--.23440S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfJr4rCw18ZrW5tF4xJFb_yoW8KFyfpF
	WUKFWakryUJ397uFWSvF45XFyYkFs0ka45A34Ik34fZFnYvryqqayUtFy0qF129FWkZFWU
	KFyUtF4DGF48trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LU
	UUUU=
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
Changes in v2:
- modified the patch for the warning that variable 'ret' is set but not used.
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index dbc7dcce682b..9960c9da9b4a 100644
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
@@ -586,10 +588,15 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
 	if (!phy->apb) {
 		dev_err(dev, "Failed to get APB regmap\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_device;
 	}
 
-	return 0;
+out_put_device:
+	put_device(pcie_dev);
+out_put_node:
+	of_node_put(pcie_port);
+	return ret;
 }
 
 static int kirin_pcie_clk_ctrl(struct hi3670_pcie_phy *phy, bool enable)
-- 
2.17.1


