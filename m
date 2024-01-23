Return-Path: <stable+bounces-13501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A194C837C5E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63971C287DA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035546AB;
	Tue, 23 Jan 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ysD157G0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502094A27;
	Tue, 23 Jan 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969593; cv=none; b=N/0vByzhxRW7yy5YprkLKDGvDer0f6iK0SjKTOPWFo7pHqSxNKq/x/zW9GGUDFVTuKyZa1sqO8dbTM+BVLhWZLcXTi0FkGwllEkM9DtmowX+3YXpc2OhFZq6SxpgMXlbpsLh0rBKH5zbMGwTEpOkiwCOlHrIh943meA/iq40lQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969593; c=relaxed/simple;
	bh=zMfPq63/UZdQOJ1LnuKH8WmZ5srnqMCkJVzwZ8wzTQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8mV51dUW+n+o2UPUJO8blBxvsaaYJpu2S0kwBGqAGXbQbkpfvZnqpeV9Rb5hvVddh4RPjSZ1D2XvVm+jVB4eiJHMdOk6L1o/3t/gDZRx2DfTbYXVAwtkQ4EkyxhujgfdIwIQWoK0G3dXVTeD4LIJcfi3uo3/sJBSGySjiy0jGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ysD157G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B7C43390;
	Tue, 23 Jan 2024 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969593;
	bh=zMfPq63/UZdQOJ1LnuKH8WmZ5srnqMCkJVzwZ8wzTQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ysD157G0c+9/7AMJQIr3tiR65aWhE0u9KE2P+FJsV89wb9aMNKSUk2ZkXD3hVRIP9
	 /YiyqhWxUbsGL5JklVSYcy44XnoUFtT/BgW7N/WtwNLIOj4P1AQICThIp4SZF70NjQ
	 WdyTCaTwVXoLJAh+EqPtfCk230szDcJzKxSPixeQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 320/641] clk: renesas: rzg2l: Check reset monitor registers
Date: Mon, 22 Jan 2024 15:53:44 -0800
Message-ID: <20240122235827.893569473@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit da235d2fac212d0add570e755feb1167a830bc99 ]

The hardware manual of both RZ/G2L and RZ/G3S specifies that the reset
monitor registers need to be interrogated when the reset signals are
toggled (chapters "Procedures for Supplying and Stopping Reset Signals"
and "Procedure for Activating Modules").  Without this, there is a
chance that different modules (e.g. Ethernet) are not ready after their
reset signal is toggled, leading to failures (on probe or resume from
deep sleep states).

The same indications are available for RZ/V2M for TYPE-B reset controls.

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Fixes: 8090bea32484 ("clk: renesas: rzg2l: Add support for RZ/V2M reset monitor reg")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 59 ++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3189c3167ba8..3d2daa4ba2a4 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1416,12 +1416,27 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
-	u32 value = BIT(info->resets[id].bit) << 16;
+	u32 mask = BIT(info->resets[id].bit);
+	s8 monbit = info->resets[id].monbit;
+	u32 value = mask << 16;
 
 	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		reg = CLK_MRST_R(reg);
+	} else if (monbit >= 0) {
+		reg = CPG_RST_MON;
+		mask = BIT(monbit);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+		return 0;
+	}
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 value & mask, 10, 200);
 }
 
 static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
@@ -1430,14 +1445,28 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 value = (dis << 16) | dis;
+	u32 mask = BIT(info->resets[id].bit);
+	s8 monbit = info->resets[id].monbit;
+	u32 value = (mask << 16) | mask;
 
 	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
 		CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		reg = CLK_MRST_R(reg);
+	} else if (monbit >= 0) {
+		reg = CPG_RST_MON;
+		mask = BIT(monbit);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+		return 0;
+	}
+
+	return readl_poll_timeout_atomic(priv->base + reg, value,
+					 !(value & mask), 10, 200);
 }
 
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
@@ -1449,9 +1478,6 @@ static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 	if (ret)
 		return ret;
 
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
 	return rzg2l_cpg_deassert(rcdev, id);
 }
 
@@ -1460,18 +1486,21 @@ static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 {
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 bitmask = BIT(info->resets[id].bit);
 	s8 monbit = info->resets[id].monbit;
+	unsigned int reg;
+	u32 bitmask;
 
 	if (info->has_clk_mon_regs) {
-		return !!(readl(priv->base + CLK_MRST_R(reg)) & bitmask);
+		reg = CLK_MRST_R(info->resets[id].off);
+		bitmask = BIT(info->resets[id].bit);
 	} else if (monbit >= 0) {
-		u32 monbitmask = BIT(monbit);
-
-		return !!(readl(priv->base + CPG_RST_MON) & monbitmask);
+		reg = CPG_RST_MON;
+		bitmask = BIT(monbit);
+	} else {
+		return -ENOTSUPP;
 	}
-	return -ENOTSUPP;
+
+	return !!(readl(priv->base + reg) & bitmask);
 }
 
 static const struct reset_control_ops rzg2l_cpg_reset_ops = {
-- 
2.43.0




