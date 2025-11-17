Return-Path: <stable+bounces-194925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF94C62414
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 04:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3577A358340
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 03:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0F2EC56E;
	Mon, 17 Nov 2025 03:40:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E61531C8;
	Mon, 17 Nov 2025 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350809; cv=none; b=Jz4DJDsFxh3A+zB7Vc/1tDOfvBBSdrGyz0W+qJlKvWeiszYbYQc3vk3DxZymlIGqz3RjUb6fqIdGTs9H4wYyf9T1LIKZEMNlkuu6b90SOK1MTUhQScj5dxlkd14LepUIYlhPx/qxoPRvlg07U0N6a1El2edICYW+VNUxY2aRL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350809; c=relaxed/simple;
	bh=K1/lrENhSmcO8zZyjLiIhv7kiq479ofCN3Yedf8t91g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=b/i+D1zNt5Guas4YZ1Wnmiid5Oy+ouk6H+J0vQ9BLhxCXEA91eYLbngcf94Ht6WF5Leh59eSOVv7bKZ3laLXekNvbbXvwbv8NFTXVf/w8iFfps+50anZWZPB6XF7eWuw10sxCQtYnU6Ucw+sbBUhKrf3jLGzeUtWs9zo/jfY+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAAXpNYAmRpp_40HAQ--.23411S2;
	Mon, 17 Nov 2025 11:39:53 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	t-kristo@ti.com,
	s-anna@ti.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/omap: Fix error handling in omap_iommu_probe_device
Date: Mon, 17 Nov 2025 11:39:43 +0800
Message-Id: <20251117033943.40749-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAAXpNYAmRpp_40HAQ--.23411S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kur4DKF45AFW3Jw1rXrb_yoW5Gw48pF
	98GFWY9rW8Grn7KFZ7Zw1UZFyagr4vv3WYvF13Kws7Krn8tryrtFyxXa40vw1FyrWkCa13
	J3W5tF48uF95Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwV
	AFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3kucU
	UUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

omap_iommu_probe_device() calls of_find_device_by_node() which
increments the reference count of the platform device, but fails to
decrement the reference count in both success and error paths. This
could lead to resource leakage and prevent proper device cleanup when
the IOMMU is unbound or the device is removed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 9d5018deec86 ("iommu/omap: Add support to program multiple iommus")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/iommu/omap-iommu.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 5c6f5943f44b..4df06cb09623 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1637,6 +1637,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	struct omap_iommu *oiommu;
 	struct device_node *np;
 	int num_iommus, i;
+	int ret = 0;
 
 	/*
 	 * Allocate the per-device iommu structure for DT-based devices.
@@ -1663,28 +1664,26 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
 		np = of_parse_phandle(dev->of_node, "iommus", i);
 		if (!np) {
-			kfree(arch_data);
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 
 		pdev = of_find_device_by_node(np);
+		of_node_put(np);
 		if (!pdev) {
-			of_node_put(np);
-			kfree(arch_data);
-			return ERR_PTR(-ENODEV);
+			ret = -ENODEV;
+			goto err_cleanup;
 		}
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
-			of_node_put(np);
-			kfree(arch_data);
-			return ERR_PTR(-EINVAL);
+			put_device(&pdev->dev);
+			ret = -EINVAL;
+			goto err_cleanup;
 		}
 
 		tmp->iommu_dev = oiommu;
 		tmp->dev = &pdev->dev;
-
-		of_node_put(np);
 	}
 
 	dev_iommu_priv_set(dev, arch_data);
@@ -1697,17 +1696,28 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 	oiommu = arch_data->iommu_dev;
 
 	return &oiommu->iommu;
+
+err_cleanup:
+	for (tmp = arch_data; tmp < arch_data + i; tmp++) {
+		if (tmp->dev)
+			put_device(tmp->dev);
+	}
+	kfree(arch_data);
+	return ERR_PTR(ret);
 }
 
 static void omap_iommu_release_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data = dev_iommu_priv_get(dev);
+	struct omap_iommu_arch_data *tmp;
 
 	if (!dev->of_node || !arch_data)
 		return;
 
-	kfree(arch_data);
+	for (tmp = arch_data; tmp->dev; tmp++)
+		put_device(tmp->dev);
 
+	kfree(arch_data);
 }
 
 static int omap_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
-- 
2.17.1


