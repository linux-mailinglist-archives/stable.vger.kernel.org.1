Return-Path: <stable+bounces-49480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666B8FED6B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329B51C21F7E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5F19DF48;
	Thu,  6 Jun 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jJJx3TT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C819DF4C;
	Thu,  6 Jun 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683486; cv=none; b=krVHlUtrK5vWCC5TS6zaggejz9BWUHYITDwrwaTOGJjxRXTATUtOrYSF2h2QlHbnN3bH/JTDT5Nd5Aekd1D0UfahIrEafyU56L6wFQKdy+yBfEwfl4uF8uNvvHX3Pf+vPPZZwt1NGzJ1wPhlG9xAnBUTgOUqm1tcwqOYFaAMT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683486; c=relaxed/simple;
	bh=JSJA86/8KTOHmwftU69Eqy8pYzP8wCopfrUiGkyJqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmV1hr/wK20PhuM7nc/BMbVKYEg9u+bJt4BhYQ0X0lkJYOztHo6+d9JlG8M+mr2cIFmN9d484PFxvVbtkd4bw089ooBr3x96VUpBANFQYlmTju8t2sHHiWmvbe69Omsn9oXn0244J5w9tjxYIsh4XxJRdxlmxkmpcOBqM9UElGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jJJx3TT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CFCC32782;
	Thu,  6 Jun 2024 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683486;
	bh=JSJA86/8KTOHmwftU69Eqy8pYzP8wCopfrUiGkyJqkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJJx3TT5b8aWg0UQJY29ny3NkVnd1vnB+mLaX+NkgmTq7zPIXMLFPksPsOBh8W9al
	 a5upQBxMGFZ73zYocK2VA5NkxOkk4KIhK1poSx6iOnT9DVwGTDRZxpHD9O5tFlxTzw
	 nKW0tG+p7/BaPRALr2JLzUor3XD6hj/svwYPDMU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 371/473] drm/mediatek: dp: Add support for embedded DisplayPort aux-bus
Date: Thu,  6 Jun 2024 16:05:00 +0200
Message-ID: <20240606131712.161351977@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit caf2ae486742f6a93ca676bbebdfacfd34e4966d ]

For the eDP case we can support using aux-bus on MediaTek DP: this
gives us the possibility to declare our panel as generic "panel-edp"
which will automatically configure the timings and available modes
via the EDID that we read from it.

To do this, move the panel parsing at the end of the probe function
so that the hardware is initialized beforehand and also initialize
the DPTX AUX block and power both on as, when we populate the
aux-bus, the panel driver will trigger an EDID read to perform
panel detection.

Last but not least, since now the AUX transfers can happen in the
separated aux-bus, it was necessary to add an exclusion for the
cable_plugged_in check in `mtk_dp_aux_transfer()` and the easiest
way to do this is to simply ignore checking that when the bridge
type is eDP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230725073234.55892-10-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Stable-dep-of: 8431fff9e0f3 ("drm/mediatek: dp: Fix mtk_dp_aux_transfer return value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/Kconfig  |  1 +
 drivers/gpu/drm/mediatek/mtk_dp.c | 92 ++++++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 369e495d0c3e8..d1eededee9434 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -27,6 +27,7 @@ config DRM_MEDIATEK_DP
 	select PHY_MTK_DP
 	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DP_AUX_BUS
 	help
 	  DRM/KMS Display Port driver for MediaTek SoCs.
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 326a536e677cd..4bea46ae4dbfb 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022 BayLibre
  */
 
+#include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic_helper.h>
@@ -1284,9 +1285,11 @@ static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
 
 static void mtk_dp_initialize_priv_data(struct mtk_dp *mtk_dp)
 {
+	bool plugged_in = (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP);
+
 	mtk_dp->train_info.link_rate = DP_LINK_BW_5_4;
 	mtk_dp->train_info.lane_count = mtk_dp->max_lanes;
-	mtk_dp->train_info.cable_plugged_in = false;
+	mtk_dp->train_info.cable_plugged_in = plugged_in;
 
 	mtk_dp->info.format = DP_PIXELFORMAT_RGB;
 	memset(&mtk_dp->info.vm, 0, sizeof(struct videomode));
@@ -1588,6 +1591,16 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 	u8 val;
 	ssize_t ret;
 
+	/*
+	 * If we're eDP and capabilities were already parsed we can skip
+	 * reading again because eDP panels aren't hotpluggable hence the
+	 * caps and training information won't ever change in a boot life
+	 */
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP &&
+	    mtk_dp->rx_cap[DP_MAX_LINK_RATE] &&
+	    mtk_dp->train_info.sink_ssc)
+		return 0;
+
 	ret = drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
 	if (ret < 0)
 		return ret;
@@ -2037,15 +2050,14 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 				   struct drm_dp_aux_msg *msg)
 {
-	struct mtk_dp *mtk_dp;
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
 	bool is_read;
 	u8 request;
 	size_t accessed_bytes = 0;
 	int ret;
 
-	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
-
-	if (!mtk_dp->train_info.cable_plugged_in) {
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP &&
+	    !mtk_dp->train_info.cable_plugged_in) {
 		ret = -EAGAIN;
 		goto err;
 	}
@@ -2513,6 +2525,28 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
 	return 0;
 }
 
+static int mtk_dp_edp_link_panel(struct drm_dp_aux *mtk_aux)
+{
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
+	struct device *dev = mtk_aux->dev;
+	int ret;
+
+	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+
+	/* Power off the DP and AUX: either detection is done, or no panel present */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+			   DP_PWR_STATE_BANDGAP_TPLL,
+			   DP_PWR_STATE_MASK);
+	mtk_dp_power_disable(mtk_dp);
+
+	if (IS_ERR(mtk_dp->next_bridge)) {
+		ret = PTR_ERR(mtk_dp->next_bridge);
+		mtk_dp->next_bridge = NULL;
+		return ret;
+	}
+	return 0;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2531,21 +2565,14 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, irq_num,
 				     "failed to request dp irq resource\n");
 
-	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
-	if (IS_ERR(mtk_dp->next_bridge) &&
-	    PTR_ERR(mtk_dp->next_bridge) == -ENODEV)
-		mtk_dp->next_bridge = NULL;
-	else if (IS_ERR(mtk_dp->next_bridge))
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->next_bridge),
-				     "Failed to get bridge\n");
-
 	ret = mtk_dp_dt_parse(mtk_dp, pdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to parse dt\n");
 
-	drm_dp_aux_init(&mtk_dp->aux);
 	mtk_dp->aux.name = "aux_mtk_dp";
+	mtk_dp->aux.dev = dev;
 	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
+	drm_dp_aux_init(&mtk_dp->aux);
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
 
@@ -2586,6 +2613,43 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->need_debounce = true;
 	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
+		/*
+		 * Set the data lanes to idle in case the bootloader didn't
+		 * properly close the eDP port to avoid stalls and then
+		 * reinitialize, reset and power on the AUX block.
+		 */
+		mtk_dp_set_idle_pattern(mtk_dp, true);
+		mtk_dp_initialize_aux_settings(mtk_dp);
+		mtk_dp_power_enable(mtk_dp);
+
+		/*
+		 * Power on the AUX to allow reading the EDID from aux-bus:
+		 * please note that it is necessary to call power off in the
+		 * .done_probing() callback (mtk_dp_edp_link_panel), as only
+		 * there we can safely assume that we finished reading EDID.
+		 */
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
+				   DP_PWR_STATE_MASK);
+
+		ret = devm_of_dp_aux_populate_bus(&mtk_dp->aux, mtk_dp_edp_link_panel);
+		if (ret) {
+			/* -ENODEV this means that the panel is not on the aux-bus */
+			if (ret == -ENODEV) {
+				ret = mtk_dp_edp_link_panel(&mtk_dp->aux);
+				if (ret)
+					return ret;
+			} else {
+				mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+						   DP_PWR_STATE_BANDGAP_TPLL,
+						   DP_PWR_STATE_MASK);
+				mtk_dp_power_disable(mtk_dp);
+				return ret;
+			}
+		}
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-- 
2.43.0




