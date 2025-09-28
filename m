Return-Path: <stable+bounces-181835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03551BA6999
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C94C1897ABE
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738722370A;
	Sun, 28 Sep 2025 07:04:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87346200C2;
	Sun, 28 Sep 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759043086; cv=none; b=utbDAPAkHIpsMY8BwroWXkU/Ibqj3bvlBkylNO5XPMZR8u2ZECdpE1AYFAOOl3/kxdoDc/m1nb4q+IJRWiP9O7DPI1QORfelEHdhg2k5mwe95zuUx8njXqlbL+agKIJTPidQ1IHEId/KQEjs4vTlyjYJ/sEl/855SHa5PABGg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759043086; c=relaxed/simple;
	bh=wh3jIY7ic2TbFwR0SQf2ct+jaUIfyaJP+Ktg1Y+IC0E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XpII7ylySTN5OgXtBEnkC5Oiw8wpci43Yn0fh2Q6r2IRuLCRguQPNGOd6fQdfhZOCuJxIB89mW9IUZadu19fb11Qvfklqq41IyglA7yEyDtEPrqHclSKSmGoBa2RVuFS/O2B6dlUDYz3HpP0oOpRI+cwAjEc0BsxXpHIf/b2IHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-01 (Coremail) with SMTP id qwCowADXK5713dhohiDrBw--.18611S2;
	Sun, 28 Sep 2025 15:04:25 +0800 (CST)
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
Subject: [PATCH v2] soc: samsung: exynos-pmu: fix reference leak in exynos_get_pmu_regmap_by_phandle()
Date: Sun, 28 Sep 2025 15:04:19 +0800
Message-Id: <20250928070419.39881-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:qwCowADXK5713dhohiDrBw--.18611S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xAr18WF4DCr4kZFy5Jwb_yoW8KF1Upr
	WrJaySkrWkGrWvkrWvqr4jvFW3u34I939Y9a4xC34q93ZYqFySyryUGFy8Zas8Ary8JF15
	tF12yFy8GFyUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoZ2-UUUU
	U
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

Since Exynos-PMU is a core system device that is not unloaded at
runtime, and regmap is created during device probing, releasing the
temporary device reference does not affect the validity of regmap.
From the perspective of code standards and maintainability, reference
count leakage is a genuine code defect that should be fixed. Even if
the leakage does not immediately cause issues in certain scenarios,
known leakage points should not be left unaddressed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the typo of the variable in the patch. Sorry for the typo;
- added more detailed description.
---
 drivers/soc/samsung/exynos-pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index a77288f49d24..b80cc30c1100 100644
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
+	put_device(dev);
+
+	return regmap;
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
 
-- 
2.17.1


