Return-Path: <stable+bounces-101987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F39EEF85
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5646929789E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387202309BD;
	Thu, 12 Dec 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRtyNLCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAC223C7A;
	Thu, 12 Dec 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019535; cv=none; b=gc26hqhd6vZlSZ/zv6hShxbJr5wj8P3mwYazNiCq3/wfW9NyanvKepb4PWXLsw301kul2m4pB2UL8HaZU0ySXMbYLkwaszxa9d5FnnC9kMdNMs3GvABEIhY0FGQtL9CeBI709KzEMhsGjK2hVc5V27+7OwbiZ4nmR+LH2KBv2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019535; c=relaxed/simple;
	bh=gJO9AoFccjozS059vjWqt1qPAMqMOsBu/9xo4GhGMKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbs0LctNugIuLK6Ewo2lzSTO/P13CyvH+LRFF7CAf0Nh1NCXlSIrI+MEZpNLpRyUPKwZcdK0pf+bw0WUnwEvh0wWxYl4V/T/o5UVOvpzCBr2Ivp4eID03cntuatvImj2Ysi90YvvKD4uH30r2j/aVzpwikDEVgW3dU1udJEn/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRtyNLCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D265C4CECE;
	Thu, 12 Dec 2024 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019534;
	bh=gJO9AoFccjozS059vjWqt1qPAMqMOsBu/9xo4GhGMKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRtyNLCEDaSNGJnvfOHw4XM13LknBhFxwlmnxDZBI1p5WJZOHO4c4v8e/Iw0EckLz
	 NoSqzc2OdQ0eEcNLTAO/YNCJYUPG/eiMXIM6glSzXK7E93g+rgvWuRxpEiYj3dijAy
	 aba3S7oN9gC//Zl/yexGbGJKgRgbOb7ybvuH54hQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 233/772] clk: imx: fracn-gppll: fix pll power up
Date: Thu, 12 Dec 2024 15:52:58 +0100
Message-ID: <20241212144359.537978927@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit ff4279618f0aec350b0fb41b2b35841324fbd96e ]

To i.MX93 which features dual Cortex-A55 cores and DSU, when using
writel_relaxed to write value to PLL registers, the value might be
buffered. To make sure the value has been written into the hardware,
using readl to read back the register could achieve the goal.

current PLL power up flow can be simplified as below:
  1. writel_relaxed to set the PLL POWERUP bit;
  2. readl_poll_timeout to check the PLL lock bit:
     a). timeout = ktime_add_us(ktime_get(), timeout_us);
     b). readl the pll the lock reg;
     c). check if the pll lock bit ready
     d). check if timeout

But in some corner cases, both the write in step 1 and read in
step 2 will be blocked by other bus transaction in the SoC for a
long time, saying the value into real hardware is just before step b).
That means the timeout counting has begins for quite sometime since
step a), but value still not written into real hardware until bus
released just at a point before step b).

Then there maybe chances that the pll lock bit is not ready
when readl done but the timeout happens. readl_poll_timeout will
err return due to timeout. To avoid such unexpected failure,
read back the reg to make sure the write has been done in HW
reg.

So use readl after writel_relaxed to fix the issue.

Since we are here, to avoid udelay to run before writel_relaxed, use
readl before udelay.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Co-developed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20241027-imx-clk-v1-v3-3-89152574d1d7@nxp.com
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index 281fc62ecd3d5..5f2296bb67a65 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -250,9 +250,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
 		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
 	writel_relaxed(pll_div, pll->base + PLL_DIV);
+	readl(pll->base + PLL_DIV);
 	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
 		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
 		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+		readl(pll->base + PLL_NUMERATOR);
 	}
 
 	/* Wait for 5us according to fracn mode pll doc */
@@ -261,6 +263,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	/* Enable Powerup */
 	tmp |= POWERUP_MASK;
 	writel_relaxed(tmp, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	/* Wait Lock */
 	ret = clk_fracn_gppll_wait_lock(pll);
@@ -298,6 +301,7 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
 
 	val |= POWERUP_MASK;
 	writel_relaxed(val, pll->base + PLL_CTRL);
+	readl(pll->base + PLL_CTRL);
 
 	ret = clk_fracn_gppll_wait_lock(pll);
 	if (ret)
-- 
2.43.0




