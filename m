Return-Path: <stable+bounces-123715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D5A5C6FE
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10580189C029
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BBB846D;
	Tue, 11 Mar 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXwFnChD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D725DCE3;
	Tue, 11 Mar 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706753; cv=none; b=tqYkKDEfbH34+A+oSojzsBt25y0M4RQ5SrAc5uEjW78gbw/4nUwMbfsMbpM4yzWSk/RWU+lGn4QEkGB0kxA7uXu44Q4+3g1RBLabFnbg5gKSkLIiWqnk26J/YBNnyCgjfJQc/KCNMa7TNZHnr7VNEySQB27vzPlw5c8RO9h9JSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706753; c=relaxed/simple;
	bh=jjcw0lhuLcDNdmRQePQ+/sBsmYzUupkXZCWgL5gu93o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qieKmD9lkSSoI/u/L8+P3U5/Mqs9gvKhsIwn4De0/rWTYl2OTp6J2vqZEIJ2aSFFaKfebPPJ+ZvUGfOmcBfeCgxZq4yvdpHaIq7NV2ElTUCYXGumDKbHYq6qYTyqMYAtnKTGqKjJSMtKMFMBajowFgaynKlQKPwWIR/3WBXgmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXwFnChD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1027FC4CEE9;
	Tue, 11 Mar 2025 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706753;
	bh=jjcw0lhuLcDNdmRQePQ+/sBsmYzUupkXZCWgL5gu93o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXwFnChDfeBHMuDmub5O9qNtqSr98qmC0mxf2MeaYUg+U5kqyWvFnqPMYzYrLBbsS
	 Um14uLmkb8tXEFlJjjth0p5UDHv81HOucFHBRK+QuvL38TRXVH+wGuWLF42rJ/S6qT
	 /++Ob9NemhWX69gJ82qRHTruwA9k6bE+DMxYq0QE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 156/462] gpio: pca953x: Improve interrupt support
Date: Tue, 11 Mar 2025 15:57:02 +0100
Message-ID: <20250311145804.509759784@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 3ad1a9e432c8a..64a4128b9a422 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -732,25 +732,6 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
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




