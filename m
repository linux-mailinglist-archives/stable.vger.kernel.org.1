Return-Path: <stable+bounces-110821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CEA1CE1B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 20:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8611887C41
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E6166F06;
	Sun, 26 Jan 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XhIxK4nq"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E211189F43
	for <stable@vger.kernel.org>; Sun, 26 Jan 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737919013; cv=none; b=fyzIJQQj22Ue2FZSKAGvyFp/XJwjalTVumWe5/VMzvmfz4CC0iIEli7MDXvf/HJPnjHHuHTT9Bmmy4YgceijsqRDVYMBRsSFCidIPLM9JNl8Y/5PQtwCbU89RwP/QqGogokT+xd1t+Bsmx5kXBFg3l+1Pgo2M58m2x3Bwz8Cvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737919013; c=relaxed/simple;
	bh=QK2mNIgVfgFqU32KvW7t+F3B7NGbIMX4zcWrWdXkBq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=immVVivFkNcwIthbRa9Yc3cLCL0xc9got+rswcJCLMU0ifC8iBSpAEIn9y3h6Op5uzkJo3DY+BPRGlGTyGEVn//ZkfB8/JbhUbrtNf1fCvC+a6VCwVte92uYQwZxpUnMQGKMpBS3vW0IqRFUfVqkmz6qzo2WZwV6U51jQ1IuIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XhIxK4nq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737919006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PU/avQ9TlPjvpr9AxfIB/9oT6G3IkCBy26F4yeJbMvs=;
	b=XhIxK4nq91yBE8yjZQH7dhUzoVFR82f0YBprwkHjW/QYFmcia4g0P4mqO7cB+xC0PEe1fj
	EA9BWIZsyr7VRZFZfnx5O/yc+4x5t3eCpCkgSnlX/yjJqDgx43vkFqDiRnsoIQkagjg+Ha
	3DC7Bkvbgr8f/DJqx+xMdz4THbApSnY=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Stable List <stable@vger.kernel.org>,
	Dominik Haller <d.haller@phytec.de>
Subject: [PATCH v8 05/13] drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready
Date: Mon, 27 Jan 2025 00:45:43 +0530
Message-Id: <20250126191551.741957-6-aradhya.bhatia@linux.dev>
In-Reply-To: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
References: <20250126191551.741957-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

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
Cc: Stable List <stable@vger.kernel.org>
Tested-by: Dominik Haller <d.haller@phytec.de>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 87921a748cdb..6a77ca36cb9d 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -769,7 +769,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
-	u32 tmp, reg_wakeup, div;
+	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -786,6 +786,19 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
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
-- 
2.34.1


