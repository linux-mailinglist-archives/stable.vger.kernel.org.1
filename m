Return-Path: <stable+bounces-115265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F69A342BC
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D76C16C854
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410132222A7;
	Thu, 13 Feb 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Equ+Tu1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AB281375;
	Thu, 13 Feb 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457458; cv=none; b=jOL5+B29bWpezsHoq5Kln16/2EKZhCkSmqpIcr6eVitMnr/8wzcsxB5jxhwae//Dw6UzAOVRjKA1He93K9AZMMyefvGhVzfTvrCBJxikaNOjVzzOs4b9mFlyTrUv+x7qhtnZTa/rogbggyUWF1uKWd4H+rnFct1yj6++uFQZ798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457458; c=relaxed/simple;
	bh=AOOIMGNIG/63zKFORWW2P3W72caIzItAYzRgjjvLHug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpck+p+mOP9XcDlBrCTW+5S7glzVZKuyi8lSAj+IgysTE4CFfc1R3EkcAaKfr6h/uJf3plNzqlENITfPDBH75juLsCVVB3yCmpyUpJNRfGM1x0bCmSdJaxoI0IkTXu3NjhE+Fx4T1Y17JEprdSYa8EzYebzGl3FRfiyYRYUoE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Equ+Tu1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4DAC4CED1;
	Thu, 13 Feb 2025 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457457;
	bh=AOOIMGNIG/63zKFORWW2P3W72caIzItAYzRgjjvLHug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Equ+Tu1KGysn+xnVgJLsXrDSMtBbOvKe/FZgdyFeJ/RCZ2P45RWhjQO+ozaaX9kyg
	 dowettOuLWQnyq21WZRa5uptCjlbDAOHa5A7Nyi2mS/C71/ksYucmIjNbsfIrM+wFk
	 +tELA/JvVV0sBIf0Hscny9cJgIh18Tpq0LJubJpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 116/422] gpio: pca953x: Improve interrupt support
Date: Thu, 13 Feb 2025 15:24:25 +0100
Message-ID: <20250213142441.029052215@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

[ Upstream commit d6179f6c6204f9932aed3a7a2100b4a295dfed9d ]

The GPIO drivers with latch interrupt support (typically types starting
with PCAL) have interrupt status registers to determine which particular
inputs have caused an interrupt. Unfortunately there is no atomic
operation to read these registers and clear the interrupt. Clearing the
interrupt is done by reading the input registers.

The code was reading the interrupt status registers, and then reading
the input registers. If an input changed between these two events it was
lost.

The solution in this patch is to revert to the non-latch version of
code, i.e. remembering the previous input status, and looking for the
changes. This system results in no more I2C transfers, so is no slower.
The latch property of the device still means interrupts will still be
noticed if the input changes back to its initial state.

Fixes: 44896beae605 ("gpio: pca953x: add PCAL9535 interrupt support for Galileo Gen2")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240606033102.2271916-1-mark.tomlinson@alliedtelesis.co.nz
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index e49802f26e07f..d764a3af63467 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -841,25 +841,6 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 	DECLARE_BITMAP(trigger, MAX_LINE);
 	int ret;
 
-	if (chip->driver_data & PCA_PCAL) {
-		/* Read the current interrupt status from the device */
-		ret = pca953x_read_regs(chip, PCAL953X_INT_STAT, trigger);
-		if (ret)
-			return false;
-
-		/* Check latched inputs and clear interrupt status */
-		ret = pca953x_read_regs(chip, chip->regs->input, cur_stat);
-		if (ret)
-			return false;
-
-		/* Apply filter for rising/falling edge selection */
-		bitmap_replace(new_stat, chip->irq_trig_fall, chip->irq_trig_raise, cur_stat, gc->ngpio);
-
-		bitmap_and(pending, new_stat, trigger, gc->ngpio);
-
-		return !bitmap_empty(pending, gc->ngpio);
-	}
-
 	ret = pca953x_read_regs(chip, chip->regs->input, cur_stat);
 	if (ret)
 		return false;
-- 
2.39.5




