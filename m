Return-Path: <stable+bounces-181827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B5BA6737
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 05:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB94189A655
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8926A1BE;
	Sun, 28 Sep 2025 03:51:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C42CA52;
	Sun, 28 Sep 2025 03:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759031495; cv=none; b=rt5Uds2Gbi316gd0LS5juEJD5V/9c8jFCt8CtKiHHzxNblOYJVKBHQR1E9OJms3ts10ZvQfCAJCYCyLPew5X6mDYmyJoNf+TsHLe/Y7Ja954nOu3hhaLXT5Ve7V5OwGnNC6WXHeLZ+YLFTEWzHPxo/zoagRja35JmoRVrhoH2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759031495; c=relaxed/simple;
	bh=hEGQEz3jQvYvlIlFsxeICi1HfNmKvvp/9pc7i+xhdK4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dmIOUoJSbkja6aqsypoIfunFKCZgPUs1VnAxFXR4s4Oz9xSJdizW+1FP+y00s2JazMdeN7rYykqWRrmcOeBM7hWOB8CFxLUuqFvKQa6J3GRb955r1rhDrL5k5poEmdg17+g0zT+7Evf6BnwVclrnTcstg7eOs24VIYE1BLN3QZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowABntH6usNhous7GBw--.19174S2;
	Sun, 28 Sep 2025 11:51:22 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: krzk@kernel.org,
	alim.akhtar@samsung.com,
	semen.protsenko@linaro.org,
	peter.griffin@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] soc: samsung: exynos-pmu: fix reference leak in exynos_get_pmu_regmap_by_phandle()
Date: Sun, 28 Sep 2025 11:51:08 +0800
Message-Id: <20250928035108.10432-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowABntH6usNhous7GBw--.19174S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xAr18WF4DCr4kZFy5Jwb_yoW8AF47pr
	W8JFWFkrW7GrWUKa10qr4qvFW3u34xC39Y9a4xC3sY93ZYqFySkry8GFy8Zas8Ary8JF13
	tF12ya48GFy8Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwV
	AFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjg4S5UU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In exynos_get_pmu_regmap_by_phandle(), driver_find_device_by_of_node()
utilizes driver_find_device_by_fwnode() which internally calls
driver_find_device() to locate the matching device.
driver_find_device() increments the reference count of the found
device by calling get_device(), but exynos_get_pmu_regmap_by_phandle()
fails to call put_device() to decrement the reference count before
returning. This results in a reference count leak of the device each
time exynos_get_pmu_regmap_by_phandle() is executed, which may prevent
the device from being properly released and cause a memory leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/soc/samsung/exynos-pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index a77288f49d24..ed903a2dd416 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -302,6 +302,7 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
 {
 	struct device_node *pmu_np;
 	struct device *dev;
+	struct regmap *regmap;
 
 	if (propname)
 		pmu_np = of_parse_phandle(np, propname, 0);
@@ -325,7 +326,10 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return syscon_node_to_regmap(pmu_np);
+	regmap = syscon_node_to_regmap(pmu_np);
+	put_device(regmap);
+
+	return regmap;
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
 
-- 
2.17.1


