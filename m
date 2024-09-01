Return-Path: <stable+bounces-72625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C3967B60
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF8D281340
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214D3B79C;
	Sun,  1 Sep 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Le0IP7xT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0921DFD1;
	Sun,  1 Sep 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210544; cv=none; b=UqQQrzkuhm16VqQ7w5ZXM2rFxK/ZCjinnre76xOMOLAB46dG8FgajcT5Qdyrl5+XCNhdztidM9mWd+3frluTWe2c/QRH/dqJ49+mHMNIsGvRr1f74/Gik/ZCOOxVSrjYThz6HjYizpKrgPTRRaxhOzBGAJM/KJm/V7eraIqAUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210544; c=relaxed/simple;
	bh=7jZdEgQ0zHN0PGwSAW9/+wG6PuOHaUhGrzXg7tIU70A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4EvONPBNhaaFwGTmgtcGkjjBIH+eLqzYc35NbMdaDzWuITq66+Ak/tYeSIi8aM5/EDxs3Pwedh8OH2Y2WsQvhT5gT9T4OVsWEVwEiTvXqvaF94nFT7X5CiN2vegYeycB9XNkRG3hc+1ipzQObNQO3Zi1VV1m+CxIzZW911okxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Le0IP7xT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6667AC4CEC3;
	Sun,  1 Sep 2024 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210543;
	bh=7jZdEgQ0zHN0PGwSAW9/+wG6PuOHaUhGrzXg7tIU70A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Le0IP7xTmpBMtypJnIt8CSftRCd3OoKCxlt9HFDbGN+sceSJYLMHFA/83uAdXy6Sg
	 RPQCzxvnM+VncMTWbtMJ+cYJ20u0tDgm8N90Oa1rKFkKuf+fDwRwXya5zPOf6fasUV
	 zyODeAOFStns2nFoqbNM5No7MQtYAI05/GUU9hs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 211/215] phy: zynqmp: Enable reference clock correctly
Date: Sun,  1 Sep 2024 18:18:43 +0200
Message-ID: <20240901160831.327931319@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
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

From: Sean Anderson <sean.anderson@linux.dev>

commit 687d6bccb28238fcfa65f7c1badfdfeac498c428 upstream.

Lanes can use other lanes' reference clocks, as determined by refclk.
Use refclk to determine the clock to enable/disable instead of always
using the lane's own reference clock. This ensures the clock selected in
xpsgtr_configure_pll is the one enabled.

For the other half of the equation, always program REF_CLK_SEL even when
we are selecting the lane's own clock. This ensures that Linux's idea of
the reference clock matches the hardware. We use the "local" clock mux
for this instead of going through the ref clock network.

Fixes: 25d700833513 ("phy: xilinx: phy-zynqmp: dynamic clock support for power-save")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://lore.kernel.org/r/20240628205540.3098010-2-sean.anderson@linux.dev
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/xilinx/phy-zynqmp.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -81,7 +81,8 @@
 
 /* Reference clock selection parameters */
 #define L0_Ln_REF_CLK_SEL(n)		(0x2860 + (n) * 4)
-#define L0_REF_CLK_SEL_MASK		0x8f
+#define L0_REF_CLK_LCL_SEL		BIT(7)
+#define L0_REF_CLK_SEL_MASK		0x9f
 
 /* Calibration digital logic parameters */
 #define L3_TM_CALIB_DIG19		0xec4c
@@ -396,11 +397,12 @@ static void xpsgtr_configure_pll(struct
 		       PLL_FREQ_MASK, ssc->pll_ref_clk);
 
 	/* Enable lane clock sharing, if required */
-	if (gtr_phy->refclk != gtr_phy->lane) {
-		/* Lane3 Ref Clock Selection Register */
+	if (gtr_phy->refclk == gtr_phy->lane)
+		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy->lane),
+			       L0_REF_CLK_SEL_MASK, L0_REF_CLK_LCL_SEL);
+	else
 		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy->lane),
 			       L0_REF_CLK_SEL_MASK, 1 << gtr_phy->refclk);
-	}
 
 	/* SSC step size [7:0] */
 	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_0_LSB,
@@ -620,7 +622,7 @@ static int xpsgtr_phy_init(struct phy *p
 	mutex_lock(&gtr_dev->gtr_mutex);
 
 	/* Configure and enable the clock when peripheral phy_init call */
-	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
+	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->refclk]))
 		goto out;
 
 	/* Skip initialization if not required. */
@@ -672,7 +674,7 @@ static int xpsgtr_phy_exit(struct phy *p
 	gtr_phy->skip_phy_init = false;
 
 	/* Ensure that disable clock only, which configure for lane */
-	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
+	clk_disable_unprepare(gtr_dev->clk[gtr_phy->refclk]);
 
 	return 0;
 }



