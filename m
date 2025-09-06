Return-Path: <stable+bounces-177915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5CB467EC
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F72D5C462C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CB8635C;
	Sat,  6 Sep 2025 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB7VF2aq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F21DA3D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121441; cv=none; b=QNTtlhwASmkH61fLv1lf1n5EoBBlgG1o7P1hAVydHM/8HNwJl3e2DGRJ2LyF9I071rQ7rcfqClF2W8OQYv54V8GIzLCnms3e6hgSnzjDZFVtcbKqhRd5WcfAd9lviPZhT6eBb82Lx7bu6ogJRvydW0m5CHFNTaSAi++mk+vMwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121441; c=relaxed/simple;
	bh=vD91PjmgreQYDUsRln6+XLHL57xOMSLTTH8nq13wMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl2ksXMJtaJLg15CY0z8mqUAGVuGopkNfy4CX+VKfBG33AXeVnPryyYhon/JfKw2ujJkXDYOvGtxGle3QHQENSissiy4sPyCK/aNIqruEh6zj5Pqjlo7qWY1rGqnx65VdoZ7GT6MgnCAyQw1PzCXTMWFsp/AXz359YsY3f1Mh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7VF2aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3149BC4CEF1;
	Sat,  6 Sep 2025 01:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757121440;
	bh=vD91PjmgreQYDUsRln6+XLHL57xOMSLTTH8nq13wMC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB7VF2aq4UpDqgmlHjIXzKrtIHltKPSTFkVaNAxsOsC9GY/UzdUfjknJq2qNZz2ks
	 TxrVMSE77qVDSJMTR4agsHmdUazbyWkKSoONijzDCew0XxmhwqgoxeG1f7MsEj5xiK
	 X888zUaJq1zCq2DaturXrGwjbs3cIBRb9NYWT7QhOYRYS5m8OTO6L6xX0kl9st7daU
	 8/ABv5ylQ/h4XkU9A3ZaEi4F9sbTwn6Gs2N8vsgQQfsdn5/A9e4sYBIEx75kGpPI5f
	 nYIC8lqVChThsjZfRZPsF5h/xHNlIJ/4k377P3aU8Qtu31sScHmZ60QocLNIXjLX/y
	 EbtqWuMFU6opA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] gpio: pca953x: fix IRQ storm on system wake up
Date: Fri,  5 Sep 2025 21:17:17 -0400
Message-ID: <20250906011717.3642558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051943-spoon-zodiac-7ae0@gregkh>
References: <2025051943-spoon-zodiac-7ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

[ Upstream commit 3e38f946062b4845961ab86b726651b4457b2af8 ]

If an input changes state during wake-up and is used as an interrupt
source, the IRQ handler reads the volatile input register to clear the
interrupt mask and deassert the IRQ line. However, the IRQ handler is
triggered before access to the register is granted, causing the read
operation to fail.

As a result, the IRQ handler enters a loop, repeatedly printing the
"failed reading register" message, until `pca953x_resume()` is eventually
called, which restores the driver context and enables access to
registers.

Fix by disabling the IRQ line before entering suspend mode, and
re-enabling it after the driver context is restored in `pca953x_resume()`.

An IRQ can be disabled with disable_irq() and still wake the system as
long as the IRQ has wake enabled, so the wake-up functionality is
preserved.

Fixes: b76574300504 ("gpio: pca953x: Restore registers after suspend/resume cycle")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250512095441.31645-1-francesco@dolcini.it
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[ Apply directly to suspend/resume functions ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index c81d73d5e0159..37c209a83ecdb 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1199,6 +1199,9 @@ static int pca953x_suspend(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
 	mutex_lock(&chip->i2c_lock);
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
 
@@ -1224,6 +1227,8 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	mutex_lock(&chip->i2c_lock);
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(dev);
-- 
2.50.1


