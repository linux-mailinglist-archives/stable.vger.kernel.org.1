Return-Path: <stable+bounces-133181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72532A91EF5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF4E8A0F3D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D42505BE;
	Thu, 17 Apr 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BY6XVUue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414F2505B0
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898212; cv=none; b=e8KCmMRcaHTL1MzKVjaA0rT0k9kxG+JKhSJ49iOaPNkb/+Z9AJj2rbrtxTkH2geVTUd30wdHtHRX2IpuTy8iyKgZ9pAlJQrebJnueSoAzPh3Pts+iWvmM7xELFSvfXXDWvWLyqJW4Hx/2RuhdZMQ0oMsQjTR+nuiEsGQrG3Jr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898212; c=relaxed/simple;
	bh=Ey/Kg67kNfJuFuD+XLRu+VsJdwgIRchmRLPkH998Cww=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aH86mDoRY8tqp1LsixYi4GVgH/a3iOhmjPjmty4+qnFkEhCWBCdJXS0S2kRegwX8L9kYOTEVkZ8hQk+FwIc3uW3X46XLnOVqRnYJZRFOcdgUEXK1ntPBUWC6TttPyRiN44aOVO+K9mASahwB4pTlJYs2rvKSGMPGmyMLVy04KJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BY6XVUue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D47C4CEE4;
	Thu, 17 Apr 2025 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744898212;
	bh=Ey/Kg67kNfJuFuD+XLRu+VsJdwgIRchmRLPkH998Cww=;
	h=Subject:To:Cc:From:Date:From;
	b=BY6XVUueXz3l4t48CLKS8PnLpn2JA8xTybjYhjz7/q22UxGXmjFMibD7dRFLTpFYi
	 0W3GzmjNlxTk1vF1qPoKXYjLR4Jmau7rVa2ocslvH+oLDd51fCXqLFCXQVakVR0DM2
	 u0gmTRFklLpeeEZpYgd44/5CqCZ7zRPap3CC4re8=
Subject: FAILED: patch "[PATCH] phy: freescale: imx8m-pcie: assert phy reset and perst in" failed to apply to 6.1-stable tree
To: stefan.eichenberger@toradex.com,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:53:39 +0200
Message-ID: <2025041739-buffoon-panorama-8f27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aecb63e88c5e5fb9afb782a1577264c76f179af9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041739-buffoon-panorama-8f27@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aecb63e88c5e5fb9afb782a1577264c76f179af9 Mon Sep 17 00:00:00 2001
From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Date: Wed, 5 Mar 2025 15:43:16 +0100
Subject: [PATCH] phy: freescale: imx8m-pcie: assert phy reset and perst in
 power off

Ensure the PHY reset and perst is asserted during power-off to
guarantee it is in a reset state upon repeated power-on calls. This
resolves an issue where the PHY may not properly initialize during
subsequent power-on cycles. Power-on will deassert the reset at the
appropriate time after tuning the PHY parameters.

During suspend/resume cycles, we observed that the PHY PLL failed to
lock during resume when the CPU temperature increased from 65C to 75C.
The observed errors were:
  phy phy-32f00000.pcie-phy.3: phy poweron failed --> -110
  imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
  imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq+0x0/0x80 returns -110
  imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

This resulted in a complete CPU freeze, which is resolved by ensuring
the PHY is in reset during power-on, thus preventing PHY PLL failures.

Cc: stable@vger.kernel.org
Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250305144355.20364-3-eichest@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 5b505e34ca36..7355d9921b64 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -156,6 +156,16 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	return ret;
 }
 
+static int imx8_pcie_phy_power_off(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(imx8_phy->reset);
+	reset_control_assert(imx8_phy->perst);
+
+	return 0;
+}
+
 static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
@@ -176,6 +186,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
 	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
+	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 


