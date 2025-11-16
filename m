Return-Path: <stable+bounces-194861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FAEC611A8
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5AE435E5D6
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034521A459;
	Sun, 16 Nov 2025 08:16:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330A15E97;
	Sun, 16 Nov 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763280998; cv=none; b=L7zHZVuE13Ti7y8fRpUvMGDVkTbCdfN7HywczRkLbRm8PGnIbhAcrHkk8R3EZmNQfE4x4ZbfLnYG9jPuxkLAlU61DAp9k0g/gqZLTy3SnbJxZyGGuT1XZuhAFgJPCl4QCCG9oWtv3stLNkrvJTQSs2IpJhpVBk/UNgSGid7JyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763280998; c=relaxed/simple;
	bh=0507P64Y1wb0dgKC4xe3LKZImWIlfpqAPpZCmnSOmW4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WJMOx/eOfywPgjXdS4nK86XPMBAaE1euQzBFzg654S1wNAqgGZmEBgt+eNEIY+2oC4l17/kSJDyeOnuCV3BmJCmLBcZqMsPnilSgLc2nexKIXU9w7cB99aNFxJgcsrXELGWimQrhvMQhLdY/1Q4X/95zEU81Ad0phk12ZTGTYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAAXHG1DiBlp1_bvAA--.52935S2;
	Sun, 16 Nov 2025 16:16:12 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: tglx@linutronix.de,
	maz@kernel.org,
	shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip: Fix error handling in qcom_mpm_init
Date: Sun, 16 Nov 2025 16:16:02 +0800
Message-Id: <20251116081602.28926-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAAXHG1DiBlp1_bvAA--.52935S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kZF48KryUtr17ur1xXwb_yoWrAFWUpa
	1fCFWYvrWkJrn2gr92vF1UZwn8Aw17Kay3G3W8Cwna9rnavry5try0qF1Fqa4rCFWvvF15
	J3y3K3W5CFWUuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjhF4tUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

of_find_device_by_node() increments the reference count but it's never
decremented, preventing proper device cleanup. Add put_device()
properly to ensure references released before function return.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/irqchip/irq-qcom-mpm.c | 56 +++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 8d569f7c5a7a..8e5303375261 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -333,14 +333,19 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	int i, irq;
 	int ret;
 
+	if (!pdev)
+		return -ENODEV;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
 
 	ret = of_property_read_u32(np, "qcom,mpm-pin-count", &pin_cnt);
 	if (ret) {
 		dev_err(dev, "failed to read qcom,mpm-pin-count: %d\n", ret);
-		return ret;
+		goto err_put_device;
 	}
 
 	priv->reg_stride = DIV_ROUND_UP(pin_cnt, 32);
@@ -348,19 +353,22 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	ret = of_property_count_u32_elems(np, "qcom,mpm-pin-map");
 	if (ret < 0) {
 		dev_err(dev, "failed to read qcom,mpm-pin-map: %d\n", ret);
-		return ret;
+		goto err_put_device;
 	}
 
 	if (ret % 2) {
 		dev_err(dev, "invalid qcom,mpm-pin-map\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_put_device;
 	}
 
 	priv->map_cnt = ret / 2;
 	priv->maps = devm_kcalloc(dev, priv->map_cnt, sizeof(*priv->maps),
 				  GFP_KERNEL);
-	if (!priv->maps)
-		return -ENOMEM;
+	if (!priv->maps) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
 
 	for (i = 0; i < priv->map_cnt; i++) {
 		u32 pin, hwirq;
@@ -386,19 +394,23 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 		ret = of_address_to_resource(msgram_np, 0, &res);
 		if (ret) {
 			of_node_put(msgram_np);
-			return ret;
+			goto err_put_device;
 		}
 
 		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
 		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
 		of_node_put(msgram_np);
-		if (!priv->base)
-			return -ENOMEM;
+		if (!priv->base) {
+			ret = -ENOMEM;
+			goto err_put_device;
+		}
 	} else {
 		/* Otherwise, fall back to simple MMIO. */
 		priv->base = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(priv->base))
-			return PTR_ERR(priv->base);
+		if (IS_ERR(priv->base)) {
+			ret = PTR_ERR(priv->base);
+			goto err_put_device;
+		}
 	}
 
 	for (i = 0; i < priv->reg_stride; i++) {
@@ -410,21 +422,25 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_put_device;
+	}
 
 	genpd = &priv->genpd;
 	genpd->flags = GENPD_FLAG_IRQ_SAFE;
 	genpd->power_off = mpm_pd_power_off;
 
 	genpd->name = devm_kasprintf(dev, GFP_KERNEL, "%s", dev_name(dev));
-	if (!genpd->name)
-		return -ENOMEM;
+	if (!genpd->name) {
+		ret = -ENOMEM;
+		goto err_put_device;
+	}
 
 	ret = pm_genpd_init(genpd, NULL, false);
 	if (ret) {
 		dev_err(dev, "failed to init genpd: %d\n", ret);
-		return ret;
+		goto err_put_device;
 	}
 
 	ret = of_genpd_add_provider_simple(np, genpd);
@@ -438,7 +454,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	if (IS_ERR(priv->mbox_chan)) {
 		ret = PTR_ERR(priv->mbox_chan);
 		dev_err(dev, "failed to acquire IPC channel: %d\n", ret);
-		return ret;
+		goto remove_genpd;
 	}
 
 	parent_domain = irq_find_host(parent);
@@ -466,6 +482,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 		goto remove_domain;
 	}
 
+	put_device(dev);
 	return 0;
 
 remove_domain:
@@ -474,6 +491,9 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	mbox_free_channel(priv->mbox_chan);
 remove_genpd:
 	pm_genpd_remove(genpd);
+err_put_device:
+	if (pdev)
+		put_device(dev);
 	return ret;
 }
 
-- 
2.17.1


