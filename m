Return-Path: <stable+bounces-134030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADFA9293D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DFF8A707F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB77264A7C;
	Thu, 17 Apr 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwPtTIfH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C226463B;
	Thu, 17 Apr 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914882; cv=none; b=AqIeC90CD4a6tJT242zPsTAW8fqR5k9/GCWzdTCBnhqzhNsAtO8HFsKeoK9AL782hZf2A6ahaEA2KleyYeksWVfb353FGxw7lIbIzOemamwhMDh7h7dsFNh4IO5RAiTRkUBDslQOpCnSg2Idy+TDBP17Ufqd7PBOkFUYUo9OCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914882; c=relaxed/simple;
	bh=4QyU9zoDVpl3rZUf1LgaiMyJTIV5t3pQwO7zJY1XiPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVynn+lUPLhmYWcodvTiLpkmIztxCI8KpxAyWeqBcuRStSXwuPBnpqo7F1SwTuOEvi1O9eljbTEnY65SDRs+UHtydUqitDpg1YtDma72gtXLomWM7iUq8ZKHpYmIssl2QpodoKyncU1J1/72S4dHK5+pPxyllpjM7ILnR4kPHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwPtTIfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2691C4CEE4;
	Thu, 17 Apr 2025 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914882;
	bh=4QyU9zoDVpl3rZUf1LgaiMyJTIV5t3pQwO7zJY1XiPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwPtTIfHkMoMD5+I6CR3pBiV8B9JqmFNmb38EYNTaPNqNzSw1eVjqnk5T0Yk/fWEn
	 mpnvAtRO6UbYYTVNWcz4vUo/45rsiQFGXYXGhEAYbrnoM56H7vNBgSW52vzd2L2StO
	 iLZgbhdwhFZWjGXsES3WEw3Z6UmAOGym1wMALzVs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guixin Liu <kanie@linux.alibaba.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 6.13 361/414] gpio: tegra186: fix resource handling in ACPI probe path
Date: Thu, 17 Apr 2025 19:51:59 +0200
Message-ID: <20250417175125.981802721@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guixin Liu <kanie@linux.alibaba.com>

commit 8323f3a69de6f6e96bf22f32dd8e2920766050c2 upstream.

When the Tegra186 GPIO controller is probed through ACPI matching,
the driver emits two error messages during probing:
  "tegra186-gpio NVDA0508:00: invalid resource (null)"
  "tegra186-gpio NVDA0508:00: invalid resource (null)"

Fix this by getting resource first and then do the ioremap.

Fixes: 2606e7c9f5fc ("gpio: tegra186: Add ACPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250327032349.78809-1-kanie@linux.alibaba.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-tegra186.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -823,6 +823,7 @@ static int tegra186_gpio_probe(struct pl
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
+	struct resource *res;
 	char **names;
 	int err;
 
@@ -842,19 +843,19 @@ static int tegra186_gpio_probe(struct pl
 	gpio->num_banks++;
 
 	/* get register apertures */
-	gpio->secure = devm_platform_ioremap_resource_byname(pdev, "security");
-	if (IS_ERR(gpio->secure)) {
-		gpio->secure = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(gpio->secure))
-			return PTR_ERR(gpio->secure);
-	}
-
-	gpio->base = devm_platform_ioremap_resource_byname(pdev, "gpio");
-	if (IS_ERR(gpio->base)) {
-		gpio->base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(gpio->base))
-			return PTR_ERR(gpio->base);
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "security");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpio->secure = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->secure))
+		return PTR_ERR(gpio->secure);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
 
 	err = platform_irq_count(pdev);
 	if (err < 0)



