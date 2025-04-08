Return-Path: <stable+bounces-131380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D7A80A18
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B0A4E610F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4826FA4F;
	Tue,  8 Apr 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vUzdJZlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722526FA4C;
	Tue,  8 Apr 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116241; cv=none; b=Mr/xUkjrBV0Tc4YIVidHPZ9OU2PeZXye/l/rCxSgelkMfdAfGGP6Bvu0WyyB4eS3HCNYXtiSVv26VcMB05AOWNM9hRvzTdgL6Bq5Fe0R9l1gS2yDxk+BwYQNyvuNN47gvKEwwBzkq1SvEznGsUSuprkbvwx5vp7DkQkEIuoWZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116241; c=relaxed/simple;
	bh=WK6nr6umOm3DdJ9lepMpCC+mjy8GAYt7sEte4OliaDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IezMP17HIXbCygvIsYMNb00LyG/lu5Wh8kc45zt9OSx2Oje+oYc3aXVzD6BuTtMv5YChRMd4jPo5MBWAGa6LDaMCzZOaSHo/pVt+1FXnmCbCYTmLFzrzf8EXFD96FhkOfioKO5RXTPQtUxhjKYp4LMbO/Ov+LmZQbfsv+thEojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vUzdJZlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A14DC4CEE5;
	Tue,  8 Apr 2025 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116241;
	bh=WK6nr6umOm3DdJ9lepMpCC+mjy8GAYt7sEte4OliaDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vUzdJZlPs/8Iwe5XQCo7eQZsDG62nSnpnw4NOwKzS0tHwBOaqqfNRJLkO0Y5rjTAF
	 3bEV3wDWwBSkIBjmXTIsAbCPhgnbBIUagiwcDscOnRQ4ywvivg3vBLYeMw0mHoApbM
	 OaUGo2RjTKaXuBy37LkXs0PLYSoeNDVIa4ubaUQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 067/423] drm/msm/dsi/phy: Program clock inverters in correct register
Date: Tue,  8 Apr 2025 12:46:33 +0200
Message-ID: <20250408104847.307644760@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit baf49072877726616c7f5943a6b45eb86bfeca0a ]

Since SM8250 all downstream sources program clock inverters in
PLL_CLOCK_INVERTERS_1 register and leave the PLL_CLOCK_INVERTERS as
reset value (0x0).  The most recent Hardware Programming Guide for 3 nm,
4 nm, 5 nm and 7 nm PHYs also mention PLL_CLOCK_INVERTERS_1.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/634489/
Link: https://lore.kernel.org/r/20250129115504.40080-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 798168180c1ab..a2c87c84aa05b 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -305,7 +305,7 @@ static void dsi_pll_commit(struct dsi_pll_7nm *pll, struct dsi_pll_config *confi
 	writel(pll->phy->cphy_mode ? 0x00 : 0x10,
 	       base + REG_DSI_7nm_PHY_PLL_CMODE_1);
 	writel(config->pll_clock_inverters,
-	       base + REG_DSI_7nm_PHY_PLL_CLOCK_INVERTERS);
+	       base + REG_DSI_7nm_PHY_PLL_CLOCK_INVERTERS_1);
 }
 
 static int dsi_pll_7nm_vco_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.39.5




