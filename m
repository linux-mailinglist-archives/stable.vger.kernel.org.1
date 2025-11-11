Return-Path: <stable+bounces-193615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA52C4A6C2
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3144F7227
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A13446C4;
	Tue, 11 Nov 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nt8WoEwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF93446B3;
	Tue, 11 Nov 2025 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823602; cv=none; b=GT/j4jofJAfxlkvQOk8nQ4Q/aRjPlZqPqLK9CDH1DmpeROLuIdUt1P9H/c3h2oASYe/csSTR8CzCgTkP9lI+3X+8FYAFe4W/BhS9HVbLjfscpSG4X5qBOI8GSY3vGXkG+WRonYOHSx2pDNBnzLOrK0P90UCD6vRSLCSLm02HtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823602; c=relaxed/simple;
	bh=B79jNhXSjvQc2nPx9HkEtnmNwPwsXkfRXWnGK8hxOH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLsLqwL8GUBOOYzs4IMrJQ5bKzprlzINrJLLZgOPE0DjMGMkxWJDwz6/oi3a4uIOaTRKZR1kS2qD3YlACgrnu7MqLgQ0Drpc+DsYQSlzV+LW7YzoAa7qFCwJWcZSHoOk2uC+s4ZE07LBXDZE8UqCLN5onxOgaQ6fclZp9PiN40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nt8WoEwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEBBC4CEFB;
	Tue, 11 Nov 2025 01:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823601;
	bh=B79jNhXSjvQc2nPx9HkEtnmNwPwsXkfRXWnGK8hxOH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt8WoEwR8a8Ke6hPK+2u9oL4MuUZCRlQcIKnm8BaG8GqVhQk/Cj/x3+rrMKTwB0Nq
	 u54QYmuIUu6aXH14EXPMs+wZYWiMKmP1KolbFAw3jWC6N8dTfpjl+n0N5+5lBQj2tP
	 kqUHYCrOT/QPi/yRpJx41kDdr2iGHHYAbKtzYgWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 284/565] drm/msm/dsi/phy: Toggle back buffer resync after preparing PLL
Date: Tue, 11 Nov 2025 09:42:20 +0900
Message-ID: <20251111004533.267748481@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
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

[ Upstream commit b63f008f395ca5f6bc89123db97440bdc19981c4 ]

According to Hardware Programming Guide for DSI PHY, the retime buffer
resync should be done after PLL clock users (byte_clk and intf_byte_clk)
are enabled.  Downstream also does it as part of configuring the PLL.

Driver was only turning off the resync FIFO buffer, but never bringing it
on again.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/657823/
Link: https://lore.kernel.org/r/20250610-b4-sm8750-display-v6-6-ee633e3ddbff@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index a2c87c84aa05b..ec5aa8cb37d9a 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -465,6 +465,10 @@ static int dsi_pll_7nm_vco_prepare(struct clk_hw *hw)
 	if (pll_7nm->slave)
 		dsi_pll_enable_global_clk(pll_7nm->slave);
 
+	writel(0x1, pll_7nm->phy->base + REG_DSI_7nm_PHY_CMN_RBUF_CTRL);
+	if (pll_7nm->slave)
+		writel(0x1, pll_7nm->slave->phy->base + REG_DSI_7nm_PHY_CMN_RBUF_CTRL);
+
 error:
 	return rc;
 }
-- 
2.51.0




