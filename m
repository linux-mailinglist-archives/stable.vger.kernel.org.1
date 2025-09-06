Return-Path: <stable+bounces-177913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBFB467AF
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287EE3A76F7
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101BA29CE6;
	Sat,  6 Sep 2025 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGQ+huIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D921CD2C
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757120657; cv=none; b=a/mXvaLIVMSRwgN9JFphPS19xyNwOCGzfKd7YMMOPQxQZRKWuqiu/fysaHlTJn9K4FvOWsBnD6IkITh6QjsMU5wKn5oECk994FRFoMdVrsy9lQpukwv7DYroKjcNaaPDKVkd/pqudIL2Qke2NwuZNp+2WGK7Wp2ZkAQNrDrJJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757120657; c=relaxed/simple;
	bh=QDof7UtiCJLH+zmIGEsufnal3iQtP48HcTwC6oD2ox8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDKtShE8LMVgFuLBQSvcw5Hw7pfxIO2uh82zNKZf+kdfmWHpQRmfgqnqCnYgmTZUz+qKI3KgToaFnoDO6qTkdOtuSQ58kytAADohMOBBN9GJ7yeKXmx59w0aHs3Cdiv/YVvwI/o/mttWjk5XrKXaGkaqw0w5tKgJLgAZbnHoag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGQ+huIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0199C4CEF1;
	Sat,  6 Sep 2025 01:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757120657;
	bh=QDof7UtiCJLH+zmIGEsufnal3iQtP48HcTwC6oD2ox8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGQ+huIb80XZutjDvtU8JdNnXIZOGkddNcseuid9Khn9HEfqo6yC7ztF83jV/Kdmu
	 MmyP7oRu68F7ppOSDRy9RWODVNLqe979dl5Cmf5kanUW2+Uj53AHJpBLdpRfpiBuI0
	 OZ2JtnmnepwCwnHSTOk+5TD4eUfZ3DxEPpGNPjHpBGJBhy+xytbzoZfMYH2PTy3udC
	 62PL5wxo+EXAYUmGygRkJRJN1Gl7QYzzFbrWwKWvrrumsAgOAgzjchtx7VTfw2/z5v
	 AMhxfCZFWheSQPdPWlb8q0vFJ6S7jagC2ki/VJzjiFgMIxi1SIrc2e+qVqEybtgjy3
	 0tX+ErOMJQWlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] gpio: pca953x: fix IRQ storm on system wake up
Date: Fri,  5 Sep 2025 21:04:14 -0400
Message-ID: <20250906010414.3620828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051942-diagnoses-sequence-8a2a@gregkh>
References: <2025051942-diagnoses-sequence-8a2a@gregkh>
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
index 45f3836c4f0fa..a8f6ef4006fef 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1145,6 +1145,9 @@ static int pca953x_suspend(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
 	mutex_lock(&chip->i2c_lock);
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
 
@@ -1170,6 +1173,8 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	mutex_lock(&chip->i2c_lock);
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(dev);
-- 
2.50.1


