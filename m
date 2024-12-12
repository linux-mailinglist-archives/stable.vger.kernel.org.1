Return-Path: <stable+bounces-102786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16869EF38B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB62287715
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25F22FDF9;
	Thu, 12 Dec 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yfl2exch"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA8229678;
	Thu, 12 Dec 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022486; cv=none; b=bcB6LmA68rbligC1kbfzZlCM66Mbr5Sy3BYeJr6EmCgff/QJLGzYZAW+486VC48Xjy7pOM8t2FwjdF4fcO92T549rMD0naZzAMq3jDXCCwKCw4uZDZk6usf/LAMNS4Jzn5f96SfDVKHNBSUPUGfZhZt/GXcKqn2O277xxmJy1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022486; c=relaxed/simple;
	bh=HYL4k71H/uB4nCfWpaHF52uWKXzai8MWho4+4ptZvbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Myti2ttFLTqCKrzztY0lcVhIkF6E9t85VKJNWyt0D7IftvZGj+dmBlPSYxzs/NUfoRHZeP2mJlSG6RZr3I9aorawUkx8JA97AZ3exoonVX1Glyt+KB56AusedqPnxFVcIu9qD4x4ab31UWnazV/VhhRqU2QmbHYL1ZtcUBtrqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yfl2exch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AB2C4CED0;
	Thu, 12 Dec 2024 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022486;
	bh=HYL4k71H/uB4nCfWpaHF52uWKXzai8MWho4+4ptZvbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yfl2exchBjLq4BGFRsQX4VF0udAkLy7ZStYuj5ut3DVaQWqmdM3FUFO46w7SX8hos
	 j4IKV+MpM93ksTTgQE78HbCdcPsROGdilTA9UOUurfQRfoKt6KJ+Z+MSNtRfL6AjXc
	 ASJ5xMXFgZ0oY6skrvL2PgqUv2C2NyvMiaXgOMzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 223/565] clk: imx: lpcg-scu: SW workaround for errata (e10858)
Date: Thu, 12 Dec 2024 15:56:58 +0100
Message-ID: <20241212144320.304677003@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 5ee063fac85656bea9cfe3570af147ba1701ba18 ]

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock. See https://www.nxp.com.cn/docs/en/errata/IMX8_1N94W.pdf

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20241027-imx-clk-v1-v3-1-89152574d1d7@nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-lpcg-scu.c | 37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index dd5abd09f3e20..620afdf8dc03e 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,10 +6,12 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 
 #include "clk-scu.h"
 
@@ -41,6 +43,29 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
+{
+	writel(val, reg);
+
+	if (rate >= 24 * HZ_PER_MHZ || rate == 0) {
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -57,7 +82,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -74,7 +100,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
@@ -145,13 +171,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 {
 	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
 
-	/*
-	 * FIXME: Sometimes writes don't work unless the CPU issues
-	 * them twice
-	 */
-
-	writel(clk->state, clk->reg);
 	writel(clk->state, clk->reg);
+	lpcg_e10858_writel(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
 
 	return 0;
-- 
2.43.0




