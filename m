Return-Path: <stable+bounces-158929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F20AEDAE0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C7189AC56
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CD25D1E9;
	Mon, 30 Jun 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRV6cw36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595825CC42
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282783; cv=none; b=Ai+r+pWHL99lpNV6hIpt7+nJhJe9XpRZrJhKxUgjpigHzdlgcMwJMdxV+8bNwOcUE0w5ESQjs/5j5jrqtMdRQlfJddMu4Jg43YyOAOPif5zZW0E2eao+d7L/H6clsah57RyHb1Uns/t+rywWunckikWBF+8t8bOn8G3Of+/Wbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282783; c=relaxed/simple;
	bh=cTW4HH4uwgoO+eudP12g3brEYJPOxFq7Opp93NptvUw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IrQ5CmGxXf63Axwqh0mKFgmYDnD6Hsgd+LZEZyEZ80j1AoIrxtGriMlXjjpDYr/VHUlf67w/yFFn4MVVOg2LX/Wx9C7eY395Xb5Ab4Yvm+syUxHsFl1ov6fAn3RkjozQrlmjn7jU0ddtVhE4kgmg/BL4PfwXE5bGZj9NXxD+6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRV6cw36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA13C4CEE3;
	Mon, 30 Jun 2025 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751282782;
	bh=cTW4HH4uwgoO+eudP12g3brEYJPOxFq7Opp93NptvUw=;
	h=Subject:To:Cc:From:Date:From;
	b=IRV6cw36OGera0lZ8ouPT/ifeeXkYhNkho0H/+x5n1b1fz/WtyLJsvnDPGqjcf07d
	 XrkGDHsTJy4oFexIIVGMQXIKImF2BZahmmGH3x4cx8KGmvEw1E8ppvLCAcCLsUuOGi
	 +jLGr9vtuJLoURGsTW0+cSJrTOedFbajZfxfgJn4=
Subject: FAILED: patch "[PATCH] drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready" failed to apply to 5.4-stable tree
To: a-bhatia1@ti.com,aradhya.bhatia@linux.dev,d.haller@phytec.de,dmitry.baryshkov@oss.qualcomm.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 13:26:19 +0200
Message-ID: <2025063019-deceiving-cubicle-a65e@gregkh>
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
git cherry-pick -x 47c03e6660e96cbba0239125b1d4a9db3c724b1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063019-deceiving-cubicle-a65e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47c03e6660e96cbba0239125b1d4a9db3c724b1d Mon Sep 17 00:00:00 2001
From: Aradhya Bhatia <a-bhatia1@ti.com>
Date: Sat, 29 Mar 2025 17:09:16 +0530
Subject: [PATCH] drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Once the DSI Link and DSI Phy are initialized, the code needs to wait
for Clk and Data Lanes to be ready, before continuing configuration.
This is in accordance with the DSI Start-up procedure, found in the
Technical Reference Manual of Texas Instrument's J721E SoC[0] which
houses this DSI TX controller.

If the previous bridge (or crtc/encoder) are configured pre-maturely,
the input signal FIFO gets corrupt. This introduces a color-shift on the
display.

Allow the driver to wait for the clk and data lanes to get ready during
DSI enable.

[0]: See section 12.6.5.7.3 "Start-up Procedure" in J721E SoC TRM
     TRM Link: http://www.ti.com/lit/pdf/spruil1

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Cc: stable@vger.kernel.org
Tested-by: Dominik Haller <d.haller@phytec.de>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Link: https://lore.kernel.org/r/20250329113925.68204-6-aradhya.bhatia@linux.dev
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 741d676b8266..93c3d5f1651d 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -776,7 +776,7 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector *connector;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
-	u32 tmp, reg_wakeup, div;
+	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -796,6 +796,19 @@ static void cdns_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 	cdns_dsi_hs_init(dsi);
 	cdns_dsi_init_link(dsi);
 
+	/*
+	 * Now that the DSI Link and DSI Phy are initialized,
+	 * wait for the CLK and Data Lanes to be ready.
+	 */
+	tmp = CLK_LANE_RDY;
+	for (int i = 0; i < nlanes; i++)
+		tmp |= DATA_LANE_RDY(i);
+
+	if (readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
+			       (tmp == (status & tmp)), 100, 500000))
+		dev_err(dsi->base.dev,
+			"Timed Out: DSI-DPhy Clock and Data Lanes not ready.\n");
+
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
 	writel(HFP_LEN(dsi_cfg.hfp) | HACT_LEN(dsi_cfg.hact),


