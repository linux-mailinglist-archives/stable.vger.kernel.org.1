Return-Path: <stable+bounces-158131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E47AE5751
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED4D4A782E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DF22370A;
	Mon, 23 Jun 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lxaTO1Oh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3472221543;
	Mon, 23 Jun 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717561; cv=none; b=pF7coyOrCR96rc7yvn3ayvmdcGZdnbpguxwplvUyymkMfcnTsaYCuMBj8cOPc53vfNaqt4kn1jlLmA7l1mtAdm8MPYnlUe7ZUJhxUWNhVbgW8fK+s80WJCOUW30+vqh/ArJUme3Sk9z4VWsagA60jffHSTzZ1pI8ocLrr8w11iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717561; c=relaxed/simple;
	bh=gIl1VuyhxCb2W+WX2JrFWsYDuGfl/MPsDRSCBXvMnyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wf2mR/yrjdij+vCbMoY3SC4jHSBJ1NODliXVofhizHUzV/DaJ22qz+wvDdieIIsOQRvz0i6FTWIWcPl8J94tZ72NWt6HzOkS5ZzLwjjp53VO7+vUMKRo1z2f5lQrE23pSkGqOzFJ0qp21Gyhpp8HqfQHq7TwZCL+BtIkd1NscHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lxaTO1Oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E2C4CEEA;
	Mon, 23 Jun 2025 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717560;
	bh=gIl1VuyhxCb2W+WX2JrFWsYDuGfl/MPsDRSCBXvMnyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxaTO1OhRUIMPgnvGBxQ4YikkT2y8WarVx3mromeSXJVELvU2saaUlzkMY+251e7k
	 yGpNxXrgzru/oo2+Z7L2qT65eXUZnovcbzKx962Eg1gydnTKx36YUWfo7Vz0FK00j3
	 meUs+ekSDSsNUwHz3i693R9Kw6ZIwN2PbBtxN7pA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Thompson <davthompson@nvidia.com>,
	Shravan Kumar Ramani <shravankr@nvidia.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 413/414] gpio: mlxbf3: only get IRQ for device instance 0
Date: Mon, 23 Jun 2025 15:09:10 +0200
Message-ID: <20250623130652.278700061@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Thompson <davthompson@nvidia.com>

[ Upstream commit 10af0273a35ab4513ca1546644b8c853044da134 ]

The gpio-mlxbf3 driver interfaces with two GPIO controllers,
device instance 0 and 1. There is a single IRQ resource shared
between the two controllers, and it is found in the ACPI table for
device instance 0.  The driver should not attempt to get an IRQ
resource when probing device instance 1, otherwise the following
error is logged:
  mlxbf3_gpio MLNXBF33:01: error -ENXIO: IRQ index 0 not found

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Fixes: cd33f216d241 ("gpio: mlxbf3: Add gpio driver support")
Link: https://lore.kernel.org/r/20250613163443.1065217-1-davthompson@nvidia.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mlxbf3.c | 54 ++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
index 10ea71273c891..9875e34bde72a 100644
--- a/drivers/gpio/gpio-mlxbf3.c
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -190,7 +190,9 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	struct mlxbf3_gpio_context *gs;
 	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
+	char *colon_ptr;
 	int ret, irq;
+	long num;
 
 	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
 	if (!gs)
@@ -227,25 +229,39 @@ static int mlxbf3_gpio_probe(struct platform_device *pdev)
 	gc->owner = THIS_MODULE;
 	gc->add_pin_ranges = mlxbf3_gpio_add_pin_ranges;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq >= 0) {
-		girq = &gs->gc.irq;
-		gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
-		girq->default_type = IRQ_TYPE_NONE;
-		/* This will let us handle the parent IRQ in the driver */
-		girq->num_parents = 0;
-		girq->parents = NULL;
-		girq->parent_handler = NULL;
-		girq->handler = handle_bad_irq;
-
-		/*
-		 * Directly request the irq here instead of passing
-		 * a flow-handler because the irq is shared.
-		 */
-		ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
-				       IRQF_SHARED, dev_name(dev), gs);
-		if (ret)
-			return dev_err_probe(dev, ret, "failed to request IRQ");
+	colon_ptr = strchr(dev_name(dev), ':');
+	if (!colon_ptr) {
+		dev_err(dev, "invalid device name format\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtol(++colon_ptr, 16, &num);
+	if (ret) {
+		dev_err(dev, "invalid device instance\n");
+		return ret;
+	}
+
+	if (!num) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq >= 0) {
+			girq = &gs->gc.irq;
+			gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
+			girq->default_type = IRQ_TYPE_NONE;
+			/* This will let us handle the parent IRQ in the driver */
+			girq->num_parents = 0;
+			girq->parents = NULL;
+			girq->parent_handler = NULL;
+			girq->handler = handle_bad_irq;
+
+			/*
+			 * Directly request the irq here instead of passing
+			 * a flow-handler because the irq is shared.
+			 */
+			ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
+					       IRQF_SHARED, dev_name(dev), gs);
+			if (ret)
+				return dev_err_probe(dev, ret, "failed to request IRQ");
+		}
 	}
 
 	platform_set_drvdata(pdev, gs);
-- 
2.39.5




