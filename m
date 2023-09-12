Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF779B5CA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358150AbjIKWHx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbjIKPSr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE38FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A931C433C7;
        Mon, 11 Sep 2023 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445522;
        bh=QysvTCLdelS+oIe8onAEe2gatpb9BrdisuSt7gnTZd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lG8m0Ll30POjL3oDrYO2nDCjP4kQawQl8yRJW1X51pASQ9goErIV+91qUdEd0K02P
         H2Fw1s0y8/FuJjsMaBdP5396eOum5q6fuXANho6wcr6zgU+mzBGa7KA+0Sjhp0ToHN
         ecAx98+BNB1+uwVEr6SgCC/iUBePA3wlfMBo0844=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 360/600] clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
Date:   Mon, 11 Sep 2023 15:46:33 +0200
Message-ID: <20230911134644.305535372@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 4dd432d985ef258e3bc436e568fba4b987b59171 ]

Reconfiguring the clock divider to the exact same value is observed
on an i.MX8MN to often cause a longer than usual clock pause, probably
because the divider restarts counting whenever the register is rewritten.

This issue doesn't show up normally, because the clock framework will
take care to not call set_rate when the clock rate is the same.
However, when we reconfigure an upstream clock, the common code will
call set_rate with the newly calculated rate on all children, e.g.:

  - sai5 is running normally and divides Audio PLL out by 16.
  - Audio PLL rate is increased by 32Hz (glitch-free kdiv change)
  - rates for children are recalculated and rates are set recursively
  - imx8m_clk_composite_divider_set_rate(sai5) is called with
    32/16 = 2Hz more
  - imx8m_clk_composite_divider_set_rate computes same divider as before
  - divider register is written, so it restarts counting from zero and
    MCLK is briefly paused, so instead of e.g. 40ns, MCLK is low for 120ns.

Some external clock consumers can be upset by such unexpected clock pauses,
so let's make sure we only rewrite the divider value when the value to be
written is actually different.

Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/20230807082201.2332746-1-a.fatoum@pengutronix.de
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-composite-8m.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index cbf0d7955a00a..3e9a092e136c1 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	int prediv_value;
 	int div_value;
 	int ret;
-	u32 val;
+	u32 orig, val;
 
 	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
 						&prediv_value, &div_value);
@@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 
 	spin_lock_irqsave(divider->lock, flags);
 
-	val = readl(divider->reg);
-	val &= ~((clk_div_mask(divider->width) << divider->shift) |
-			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+	orig = readl(divider->reg);
+	val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
+		       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
 
 	val |= (u32)(prediv_value  - 1) << divider->shift;
 	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
-	writel(val, divider->reg);
+
+	if (val != orig)
+		writel(val, divider->reg);
 
 	spin_unlock_irqrestore(divider->lock, flags);
 
-- 
2.40.1



