Return-Path: <stable+bounces-189276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413EC0919F
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B90C1AA5EEE
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1FC2F619F;
	Sat, 25 Oct 2025 14:24:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C02E7BB5;
	Sat, 25 Oct 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761402259; cv=none; b=qGfOfaXAo0pSF2iNa+jFzqoSKxPv0yHy52Dik+Tzqfq6zHz4zGZrDAPgEAcGfW7V0ATLPY3gFbsNgx5YyBZskiU2DMtZXRXqfxC+2+/KTtUBhTy6jOYT6UxkVfMV1luHwrCNmrz/12ee96z2FkBuyAj1RlTb4xNQI6bw2Y2zQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761402259; c=relaxed/simple;
	bh=+bv92ATdBBjbTgiNEpB2pAzl8R6jUHhFTnx/H0dV3d8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Vnqn31J2LgvZ/2lc+LYYn9Xbnz1od1BrkknN27cZtbNYX3VZ1CtIkjdbuueiL3BJk+38Co62Gcz2QJIe0GkjIsy6ls9HMsOEdv+vQAKGnKedoOOuIxVYK6QRoKebXbrAN2Ajx4+i9fpzQunth628qa1bvxjsyiienaS8uNtAlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAA3vWF53fxoIJeYAA--.6133S2;
	Sat, 25 Oct 2025 22:24:01 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: lee@kernel.org,
	suzuki.poulose@arm.com,
	broonie@kernel.org,
	mdf@kernel.org,
	wsa@kernel.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drivers: Fix reference leak in altr_sysmgr_regmap_lookup_by_phandle()
Date: Sat, 25 Oct 2025 22:23:52 +0800
Message-Id: <20251025142352.25475-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAA3vWF53fxoIJeYAA--.6133S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DXF48KrWUZFyrAr43Wrg_yoW8WF4rpr
	WUGa4Ykr9rG3W8Ww409w1UAFWakr48C3yS93yjk3sY93Zaq34fJFyjgayjv3s0yFyUGF4U
	tFsFy348AF4UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYXdjDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

altr_sysmgr_regmap_lookup_by_phandle() utilizes
driver_find_device_by_of_node() which internally calls
driver_find_device() to locate the matching device.
driver_find_device() increments the ref count of the found device by
calling get_device(), but altr_sysmgr_regmap_lookup_by_phandle() fails
to call put_device() to decrement the reference count before
returning. This results in a reference count leak of the device, which
may prevent the device from being properly released and cause a memory
leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: cfba5de9b99f ("drivers: Introduce device lookup variants by of_node")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/mfd/altera-sysmgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index fb5f988e61f3..c6c763fb7bbe 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -98,6 +98,7 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 	struct device *dev;
 	struct altr_sysmgr *sysmgr;
 	struct device_node *sysmgr_np;
+	struct regmap *regmap;
 
 	if (property)
 		sysmgr_np = of_parse_phandle(np, property, 0);
@@ -116,8 +117,10 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-EPROBE_DEFER);
 
 	sysmgr = dev_get_drvdata(dev);
+	regmap = sysmgr->regmap;
+	put_device(dev);
 
-	return sysmgr->regmap;
+	return regmap;
 }
 EXPORT_SYMBOL_GPL(altr_sysmgr_regmap_lookup_by_phandle);
 
-- 
2.17.1


