Return-Path: <stable+bounces-186121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF45BE39BE
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F44B358882
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1D3314AA;
	Thu, 16 Oct 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WpOMD0GD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8D32D458
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620047; cv=none; b=mSmEgEy6KSsAZ4mCTbJs5IHytjz8O3D+IuM7ySMxL6lOGWVGVjISvntagt7nsP0BKtO8SAHuMeH/zV8Dv6a5kUcMHRAQDkHrttIFEXtJ0ZGFtdkEVTYa/vj1BthDMi00HJnPNIiblYF50byerrf45yQy/A6UHWHZGCZ3lNqLfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620047; c=relaxed/simple;
	bh=EBl5vr+MoxCwr53fZkChCCLoBy1P1z7OHFL9xulEw44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zj18xHLea53Tk0fvQLCJ3b4oiR4yCsa5UWsN+R6W3j41VQP/jMdu2bioe+EBTSMaD0QgvN8OAnB7+T1qeitfvZSe2vsYygWlNkjBKeQHuyiyi/MUVi3WLmLcjRlNpfxnE532i/A4N1mX9ZYklYF5N4ND7foD5IUTkOxchrBbGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WpOMD0GD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3BBC4CEF1;
	Thu, 16 Oct 2025 13:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760620047;
	bh=EBl5vr+MoxCwr53fZkChCCLoBy1P1z7OHFL9xulEw44=;
	h=Subject:To:Cc:From:Date:From;
	b=WpOMD0GDXqMbogikRxkcDahXBZ7VoIbp5N5k0BcKllNMRPq8cEbLo20x9Z8V6N8fR
	 zlE1RY9cz+4hjhOgz/HxfDEY95KzXOrlQYPtBFH4oHbFbESZXFaG5Rq+O7UXvpMTGd
	 jiQQ+cIoR1FGBPZnhSKeVFQ7NKfNs5hBFMwQG7Fs=
Subject: FAILED: patch "[PATCH] phy: cadence: cdns-dphy: Update calibration wait time for" failed to apply to 6.17-stable tree
To: devarsht@ti.com,h-shenoy@ti.com,tomi.valkeinen@ideasonboard.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:07:25 +0200
Message-ID: <2025101625-laborer-imaging-a408@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 2c27aaee934a1b5229152fe33a14f1fdf50da143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101625-laborer-imaging-a408@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

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


