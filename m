Return-Path: <stable+bounces-186127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE0BE39DF
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 517D54E80B9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382653164AE;
	Thu, 16 Oct 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NYrrsoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2233437D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620066; cv=none; b=fy6hmvA+PompC5dNbFeTHjLnuIZqDtmDybUYGmhLnL0YdV5b7W2VBYKDYr5VgxSaGJBYXN0k/L9aXK+8vN2fkMBWiRW80v0nPnCd4fVQrob1nyMmKZNrC396B23wVAVqRMY/4Hz5ZfiJqKlgtuFFAA6MaCmdlle8Y9Ej1e41r80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620066; c=relaxed/simple;
	bh=BczE9q4sHkk/Yd6zTtWVGXTQkAtdsSq7WFIJTKj/3f8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QHHkDdFRUg/k3JpEzgDlbXALBAUinUfXI+M/gKNfBH4RJie/y+jy/I2HrZDxU7wpwo4HjxWw3sKKKFtd9K1IthgPZNnXUcoIXb8uE+fdZvZewewxHhf3dcYirbzLK/+/Fg+35lCLLY+tOqmRacYFh/8fTDs/99aRiTySyV+KPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NYrrsoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30980C4CEF1;
	Thu, 16 Oct 2025 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620065;
	bh=BczE9q4sHkk/Yd6zTtWVGXTQkAtdsSq7WFIJTKj/3f8=;
	h=Subject:To:Cc:From:Date:From;
	b=2NYrrsoZjikpYlOTcTamAaRj3Gc4P7L8UKtiLPvRDYj1CWByw4WPndZWl4r9pakZU
	 Kyszz71R3Lo21GrL7pLTgZFP3Ky9ZP53XiuPUqIKFdTVeUbZJVc5ykqFSrKbHLLivR
	 KT+8q9n5T3/icyYaH4h+K+OaLL5W9kRvVghlVDCs=
Subject: FAILED: patch "[PATCH] phy: cadence: cdns-dphy: Update calibration wait time for" failed to apply to 5.4-stable tree
To: devarsht@ti.com,h-shenoy@ti.com,tomi.valkeinen@ideasonboard.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:07:28 +0200
Message-ID: <2025101628-scribing-handwork-22ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2c27aaee934a1b5229152fe33a14f1fdf50da143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101628-scribing-handwork-22ac@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c27aaee934a1b5229152fe33a14f1fdf50da143 Mon Sep 17 00:00:00 2001
From: Devarsh Thakkar <devarsht@ti.com>
Date: Fri, 4 Jul 2025 18:29:15 +0530
Subject: [PATCH] phy: cadence: cdns-dphy: Update calibration wait time for
 startup state machine

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

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index da8de0a9d086..24a25606996c 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -30,6 +30,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -410,7 +411,8 @@ static int cdns_dphy_power_on(struct phy *phy)
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
 	/* Start TX state machine. */
-	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel((reg & DPHY_CMN_SSM_CAL_WAIT_TIME) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
 	       dphy->regs + DPHY_CMN_SSM);
 
 	ret = cdns_dphy_wait_for_pll_lock(dphy);


