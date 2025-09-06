Return-Path: <stable+bounces-177914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A5B467DA
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C691CC1DF4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB618FC92;
	Sat,  6 Sep 2025 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHqeM+o9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D8145B16
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121035; cv=none; b=nnKw+62Ra4Cm7C/MxPJJbO8/YRaxFR69di6FNzXcn9SGIvET8XDocSHmi7I4HFr7N+0nQwG0oO6gsq9rtLLQW1Mz5/BJ5ndER9DXuw9NfsGHXeBoM6tU+Y7yZ7bgnq66VX9ZvbHmg+tg8StiIBBtRqnC8EclTZGhXr2ABOgdLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121035; c=relaxed/simple;
	bh=kj/ac/K/A1upJLq10ouu023GSUL+CK9YN8rP3kyoqGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsMZIkOsqY4owdjVwoxfCGngZzyoiZgBhpZIOXXb8glFrq6Q2WN1bONgdjdPfzko3VnV7JJFOlFpAsCwxgW+fcMTSl+OuDnA8VTSYfU/DSoE/N6avFIBEQC1jT9K9gDMsruzkfPb7zPXRSgpVBRpDz5lbIU7ojSWkwe3JW2SeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHqeM+o9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E1C4CEF1;
	Sat,  6 Sep 2025 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757121035;
	bh=kj/ac/K/A1upJLq10ouu023GSUL+CK9YN8rP3kyoqGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHqeM+o9q2znMaNpCPYxWAVySf+4CgvClEd2KQy30+gv9CiHqCx/aqLQ2T9gE93tR
	 EkUiK7QWll5jAYx5gnoEGDdquPyHWAF4Tz8BvXsi0g/IgUJ+0OB4MS7pMLXlbkmoio
	 ZJLnz5xfcISFpVTxclvDOf4z3ZLwpHUgrW1CNJNf4eKBJ4s0OYDggBUNXGogpCBkh8
	 cbMII6inrwofMMi/41HTV2kvool+YbhBqUelddJphH4/M/7WhzCj8S+guqq8LD6xRN
	 mmDpJ5n8odsGxRMeQX1F9AIbsG5hRu4+HPvJLjdcQ/tsvFZR4MJwl1eAjRnUfTqecp
	 1WfwF8t/xZTAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gpio: pca953x: fix IRQ storm on system wake up
Date: Fri,  5 Sep 2025 21:10:32 -0400
Message-ID: <20250906011032.3638685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051943-yearly-fidelity-4578@gregkh>
References: <2025051943-yearly-fidelity-4578@gregkh>
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
index 64a4128b9a422..117f5a00ee703 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1144,6 +1144,9 @@ static int pca953x_suspend(struct device *dev)
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
 	mutex_lock(&chip->i2c_lock);
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, true);
 	mutex_unlock(&chip->i2c_lock);
 
@@ -1169,6 +1172,8 @@ static int pca953x_resume(struct device *dev)
 	}
 
 	mutex_lock(&chip->i2c_lock);
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
 	regcache_cache_only(chip->regmap, false);
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(dev);
-- 
2.50.1


