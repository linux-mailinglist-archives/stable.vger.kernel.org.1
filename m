Return-Path: <stable+bounces-133115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9256CA91DFF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8451C3AC0DB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673F223320;
	Thu, 17 Apr 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bae2F2lc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B3145B24
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896464; cv=none; b=h5BT5+pTkngaZDSalWQoRytnjQRw5lfL3JjRQBMtkIzDLDhhcSOumAzgGD2bwNEdzcHmtV4mFoYR51VtthCHQ8uTzIagKeSRc0Ax/LzBDNg6KvQV6pk9WmGtTP/0Si5n+wglQwy2CuBXWSBRu6imG83bxAbcbUW8RV+q0RCXgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896464; c=relaxed/simple;
	bh=SBZawIzj4JAEiREm8vqstvxpaIB9FlXUcNIVVlmGIkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H2QZhvpLkta404T2IAVqOt+TGMaFYmLAhk2nlP5Yi1ahLgD5z8xZDVygyURTUSG4snAE4mRlXh05wU/pu5jl34FMyDapf67lc4Se65enJQjMUDOFIlulGaE2w6i6QAW/0KVhH8xCftZ+ob34eQslvW3oXH42zuJMK3SeJxEztjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bae2F2lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43025C4CEEA;
	Thu, 17 Apr 2025 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896463;
	bh=SBZawIzj4JAEiREm8vqstvxpaIB9FlXUcNIVVlmGIkY=;
	h=Subject:To:Cc:From:Date:From;
	b=Bae2F2lcBFezCsiCHHV4wCQzv8tPHuD18DVmZd1tEP6V9CIfsGCkFL6Y47XRJZwss
	 /aFOusPFvzvnfNlKSCUN2V6I7Dslj2BcvTgGjEpXMgTp0WzEDiMo8q7j9Z7IQCYz6C
	 j0rZ5039SmG3qWp1f89b6IZmP+22TLm8sTaGppiU=
Subject: FAILED: patch "[PATCH] gpio: tegra186: fix resource handling in ACPI probe path" failed to apply to 5.15-stable tree
To: kanie@linux.alibaba.com,bartosz.golaszewski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:24:51 +0200
Message-ID: <2025041751-faculty-suffix-09fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8323f3a69de6f6e96bf22f32dd8e2920766050c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041751-faculty-suffix-09fc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8323f3a69de6f6e96bf22f32dd8e2920766050c2 Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Thu, 27 Mar 2025 11:23:49 +0800
Subject: [PATCH] gpio: tegra186: fix resource handling in ACPI probe path

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

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 6895b65c86af..d27bfac6c9f5 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -823,6 +823,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
+	struct resource *res;
 	char **names;
 	int err;
 
@@ -842,19 +843,19 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->num_banks++;
 
 	/* get register apertures */
-	gpio->secure = devm_platform_ioremap_resource_byname(pdev, "security");
-	if (IS_ERR(gpio->secure)) {
-		gpio->secure = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(gpio->secure))
-			return PTR_ERR(gpio->secure);
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "security");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gpio->secure = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->secure))
+		return PTR_ERR(gpio->secure);
 
-	gpio->base = devm_platform_ioremap_resource_byname(pdev, "gpio");
-	if (IS_ERR(gpio->base)) {
-		gpio->base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(gpio->base))
-			return PTR_ERR(gpio->base);
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gpio->base))
+		return PTR_ERR(gpio->base);
 
 	err = platform_irq_count(pdev);
 	if (err < 0)


