Return-Path: <stable+bounces-188387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC5BF7D13
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AE319C12E9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464B2F6175;
	Tue, 21 Oct 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0HXXTkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0334847A
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066259; cv=none; b=MNjwe33oFuAz7Dbh7pycKTCkWR9NrJHkpt3JAayr3JHuMVYtPUFo9fDSvDn8svaabrUnZYRXC8FswzlBoTXtzrAz3SiOpzqKHffI4Ml31xzAXYe1jyGRnVMZVsIvMIU7NtTu3xIpZn6LwlGupoB427tspwPygLY2M4a4khPXr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066259; c=relaxed/simple;
	bh=Ag9UuOnPjxABMD79fIKinrDOZteqmsK1QrAPwBqbzuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nObjYNu/4rm4ek4xqZ/CrCzFKdvD+P636OFUpGcR/iJ5bvcVd10XYQmKzl2+Kf8o2Z5tED0cT3zzacQ62dY1jq5MkRiHT9OzhYT7YyQrJRMWPEk1hDohGv9eexByohrPSiUVhDdCirk27ushH2+ckl7Id3AvWbhw/3n4i2lz4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0HXXTkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F96C4CEF5;
	Tue, 21 Oct 2025 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066258;
	bh=Ag9UuOnPjxABMD79fIKinrDOZteqmsK1QrAPwBqbzuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0HXXTkc7RLiQB5hhJXQCJmxNUm4MCDhni3dDajRmqkLuFG29uHRJYSkbTkGU1Yqn
	 59LVYERN+HMZR2SgV7ONqOfUt4knzNbJMV4SKZfCDw+hLYg/3rDabHpO5V71CwoZJG
	 7gPjvxn68rnQ11X+ZAFrnEd+9gkzQYCvO2MYHLu2hOKDq3uZQDz1TQGT+1z4NSW1dA
	 uEQorztyMr98MBtAmEkrk+zIIZoiCBRuUhY5zqPbHHgH3uGpuNiFScQ2nPIWlePhm7
	 mRLbzwe9dadj7MU/e0ZbGoI2jrGYh3cRKsRTuUtNgZ7LJ9COpsOT2EfBT+pXIlTcpn
	 Kpo2rlLRhxyDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Harikrishna Shenoy <h-shenoy@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] phy: cadence: cdns-dphy: Update calibration wait time for startup state machine
Date: Tue, 21 Oct 2025 13:04:14 -0400
Message-ID: <20251021170414.2402792-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021170414.2402792-1-sashal@kernel.org>
References: <2025101626-squeamish-relock-6780@gregkh>
 <20251021170414.2402792-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Devarsh Thakkar <devarsht@ti.com>

[ Upstream commit 2c27aaee934a1b5229152fe33a14f1fdf50da143 ]

Do read-modify-write so that we re-use the characterized reset value as
specified in TRM [1] to program calibration wait time which defines number
of cycles to wait for after startup state machine is in bandgap enable
state.

This fixes PLL lock timeout error faced while using RPi DSI Panel on TI's
AM62L and J721E SoC since earlier calibration wait time was getting
overwritten to zero value thus failing the PLL to lockup and causing
timeout.

[1] AM62P TRM (Section 14.8.6.3.2.1.1 DPHY_TX_DPHYTX_CMN0_CMN_DIG_TBIT2):
Link: https://www.ti.com/lit/pdf/spruj83

Cc: stable@vger.kernel.org
Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Tested-by: Harikrishna Shenoy <h-shenoy@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://lore.kernel.org/r/20250704125915.1224738-3-devarsht@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/cdns-dphy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 3d62553a630d6..d65a7aeefe792 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -31,6 +31,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -422,7 +423,8 @@ static int cdns_dphy_power_on(struct phy *phy)
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
 	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
 	       dphy->regs + DPHY_CMN_SSM);
 
 	ret = cdns_dphy_wait_for_pll_lock(dphy);
-- 
2.51.0


