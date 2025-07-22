Return-Path: <stable+bounces-163914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7CB0DC15
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812C47AFDDC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC602EACED;
	Tue, 22 Jul 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0olwD58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED62EACE7;
	Tue, 22 Jul 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192624; cv=none; b=kelAgHzw5jEnb1wTHiQ94n505INhf+OwLA1aKtfXhIGQNDxZ7IlSXxM0r6M1jc8j6gscoGa1ZUv92T61LHTbUQmRLu0libcsp+39wmO9eR4ckLKKRGuT8/Urusv8GRP6m1aGy65x9lZ+rRHYXZnBeazquq4+B2LL2uHUNJn6wbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192624; c=relaxed/simple;
	bh=v6+a11yemqaDyhI9NcdxBFdv1wSBMPO5FubN3uyDC/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSVBKsTKQmYB4w4Y++32alMC1kD14T5zrdF2tbTskiAWjYUvwstWomZr+opGbfyMpXmlxIuEz8e3e/XeymxTnDcEhZ+DNPrG+AJSFfjLq6S9mEo+h94S5c3gKyNqgAEoPXEO7VMNibaPCO0cbQsZ89Hv7qzkRPeXouBCmyYVb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0olwD58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AEDC4CEEB;
	Tue, 22 Jul 2025 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192624;
	bh=v6+a11yemqaDyhI9NcdxBFdv1wSBMPO5FubN3uyDC/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0olwD589+EePrsyK/JB+6qNPc62WXhXalB/9Yqn1nURutTu59cUcReKPSo+D8GZN
	 PF3Wl/qqG75omdlrRC/WFMoqp1sasI1ym0Xa2FoUnC9oXuaGUbAtZIZXEhQv6mmH6Z
	 paX11BWrH7+dslACIZFp6EC6SDNtQGKWd9gXsdI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wayne Chang <waynec@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.12 002/158] phy: tegra: xusb: Decouple CYA_TRK_CODE_UPDATE_ON_IDLE from trk_hw_mode
Date: Tue, 22 Jul 2025 15:43:06 +0200
Message-ID: <20250722134340.697269725@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
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

From: Wayne Chang <waynec@nvidia.com>

commit 24c63c590adca310e0df95c77cf7aa5552bc3fc5 upstream.

The logic that drives the pad calibration values resides in the
controller reset domain and so the calibration values are only being
captured when the controller is out of reset. However, by clearing the
CYA_TRK_CODE_UPDATE_ON_IDLE bit, the calibration values can be set
while the controller is in reset.

The CYA_TRK_CODE_UPDATE_ON_IDLE bit was previously cleared based on the
trk_hw_mode flag, but this dependency is not necessary. Instead,
introduce a new flag, trk_update_on_idle, to independently control this
bit.

Fixes: d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
Cc: stable@vger.kernel.org
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20250519090929.3132456-2-waynec@nvidia.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/tegra/xusb-tegra186.c |   14 ++++++++------
 drivers/phy/tegra/xusb.h          |    1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -648,14 +648,15 @@ static void tegra186_utmi_bias_pad_power
 		udelay(100);
 	}
 
-	if (padctl->soc->trk_hw_mode) {
-		value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-		value |= USB2_TRK_HW_MODE;
+	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+	if (padctl->soc->trk_update_on_idle)
 		value &= ~CYA_TRK_CODE_UPDATE_ON_IDLE;
-		padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
-	} else {
+	if (padctl->soc->trk_hw_mode)
+		value |= USB2_TRK_HW_MODE;
+	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL2);
+
+	if (!padctl->soc->trk_hw_mode)
 		clk_disable_unprepare(priv->usb2_trk_clk);
-	}
 }
 
 static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
@@ -1726,6 +1727,7 @@ const struct tegra_xusb_padctl_soc tegra
 	.supports_gen2 = true,
 	.poll_trk_completed = true,
 	.trk_hw_mode = true,
+	.trk_update_on_idle = true,
 	.supports_lp_cfg_en = true,
 };
 EXPORT_SYMBOL_GPL(tegra234_xusb_padctl_soc);
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -434,6 +434,7 @@ struct tegra_xusb_padctl_soc {
 	bool need_fake_usb3_port;
 	bool poll_trk_completed;
 	bool trk_hw_mode;
+	bool trk_update_on_idle;
 	bool supports_lp_cfg_en;
 };
 



