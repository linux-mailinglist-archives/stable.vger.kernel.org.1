Return-Path: <stable+bounces-188382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F7BF7C8F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFC3B51B8
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4082417C6;
	Tue, 21 Oct 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhaIIiwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE431DF99C
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065459; cv=none; b=Y+4aBAhUGhO7Lv8djrUdEz+TJJgdGu5s4D35uTEUxmkHsi6zVxUPrlG7uni9E9nR8wBfhJ3ehNX1TJaSp55Y+0rtwZ+pCkyG/Sz6dmKbajl3b4FuBj8vgpXpvooD2ZeVT1IA1O1Z73+3FNLQ8boeLcMJAu9pU5XXz6Hhs5RHjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065459; c=relaxed/simple;
	bh=TGQDQJS6SN4yhID1bwDNiZiktaYnpJ68WA5dlA7yliE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETvlFR76Hb6GVwVr9qnqt9qfD+YBAe7Z7+u7grdKiET0tzAG/cATSHKA6eNeKnJh5SX22bptMcc+N56SfOCCSQeYx5kh0/4h94i2l+I8LtLGjE47Ayvm9wSRaYpvKmQoESbxrn+XWBrxR5nmU+ZcWlNlw1ABxuWnRmyRgq72pxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhaIIiwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5441C116B1;
	Tue, 21 Oct 2025 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065458;
	bh=TGQDQJS6SN4yhID1bwDNiZiktaYnpJ68WA5dlA7yliE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhaIIiwX+XmkTWVtdD2shd3BD08UskU1wPjJvk+HXqxkxFtbrnZUyx8txiPdLu7Wp
	 CiLvkrZMATjMu/V77f7BHjUwY9qdbPUR3K0f2aiBWo0veOt8EfVOkO8hc2+5OmwQeR
	 Bk7alRmqHoSwP4BrnMy9yn2fT8su43vb/cZSApvgRRKmaB36Ezz8ccRTAD8ENIR5yD
	 lY2j3EQHfGSMyVgBqzsC71hxhbKbP4rHjNKIftk+2X81jd/VvplCsA03PTzNjq52Qj
	 vv4tmEVoWKLSe9pdzcDAC+0wjAEsXFZ7EQ3Igiu2LUgHYnjbbP4pab1y4xWUDTMUsM
	 roeehk63zF7LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Harikrishna Shenoy <h-shenoy@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] phy: cadence: cdns-dphy: Update calibration wait time for startup state machine
Date: Tue, 21 Oct 2025 12:50:53 -0400
Message-ID: <20251021165053.2388405-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021165053.2388405-1-sashal@kernel.org>
References: <2025101626-mossy-unsaid-e0a8@gregkh>
 <20251021165053.2388405-1-sashal@kernel.org>
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
index a5d6d87003423..8d93a830ab8bf 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -30,6 +30,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -421,7 +422,8 @@ static int cdns_dphy_power_on(struct phy *phy)
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
 	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
 	       dphy->regs + DPHY_CMN_SSM);
 
 	ret = cdns_dphy_wait_for_pll_lock(dphy);
-- 
2.51.0


