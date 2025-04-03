Return-Path: <stable+bounces-127984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE57A7ADD7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6901885000
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821325E478;
	Thu,  3 Apr 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6dYHZ8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1488A25E471;
	Thu,  3 Apr 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707676; cv=none; b=Bt4fnPIdi7p0rAI59GLJ86FkIUhe77ZkqQiEeefrDD4WXxZpBg5oNLYJD7u9sF9cvEI3HZvDHh+vO0ufI2oquNgJr3R4Q2u7MxacqZ4zC29GxE2UiQLYEyRlV5HegBmwPK/U4b7RVQ8ilv2bqOT40xLObzcO1IeX+zn6fg/vvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707676; c=relaxed/simple;
	bh=bYDF03y7wMr/7fpD3lfeArDZi4hx1ONU08HD9qmFx7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnLxxKi5ch8vJYi/rYJTIGv4XYSOAa7Pem+U8JZB0RGD4BWFuqAye6IXwWKw3hw9aFcG/iITbJJGWJZB6A2qe97mOwpckkit7Y9RqMxBcaeCQthAcQW/G0/us/cljaH+E4dk6MzD/Z2/Svb9qJ9FiFH9V/2BovqbdeMimXHC39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6dYHZ8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BDCC4CEEA;
	Thu,  3 Apr 2025 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707676;
	bh=bYDF03y7wMr/7fpD3lfeArDZi4hx1ONU08HD9qmFx7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6dYHZ8baKwt9agcsfPdxoS0PlwkqzkhwDqKdrMjwLofJrw0gFKrf2o3JFy8esuDc
	 qT4/D9lONS6Sj8vmFnoDnJ2EYFfXOIFZjVwSNBO7+o1D1/1MaCCMFaELaPal+eand+
	 0TflB2O8czW2ZPxKSr8CsnnWp447abL1PJjDPvEm5VWq5vlyChSSL0JFPTguSZ/zVp
	 10GBX9qKKC0V7aHwDCyZgizgAncPKbv0UbLsr/ljhjdmKhgPsOHqk+xqyZsJLKdzty
	 +Z2jSxpAovNYqWcdujVsSlenp4QaCKzw95OjY61mD33IQtH6G0irRWcboi7RHqE25V
	 hkUz/tQ6qnuuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 29/44] drm/rockchip: stop passing non struct drm_device to drm_err() and friends
Date: Thu,  3 Apr 2025 15:12:58 -0400
Message-Id: <20250403191313.2679091-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit abeef1f9eaf9301cc98a6841dab5f72de5c95360 ]

The expectation is that the struct drm_device based logging helpers get
passed an actual struct drm_device pointer rather than some random
struct pointer where you can dereference the ->dev member.

Convert drm_err(hdmi, ...) to dev_err(hdmi->dev, ...). This matches
current usage, but drops "[drm] *ERROR*" prefix from logging.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/f42da4c9943a2f2a9de4272b7849e72236d4c3f9.1737644530.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c    | 16 ++++++++--------
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index e7a6669c46b07..f737e7d46e667 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -203,7 +203,7 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(hdmi->regmap)) {
-		drm_err(hdmi, "Unable to get rockchip,grf\n");
+		dev_err(hdmi->dev, "Unable to get rockchip,grf\n");
 		return PTR_ERR(hdmi->regmap);
 	}
 
@@ -214,7 +214,7 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 	if (IS_ERR(hdmi->ref_clk)) {
 		ret = PTR_ERR(hdmi->ref_clk);
 		if (ret != -EPROBE_DEFER)
-			drm_err(hdmi, "failed to get reference clock\n");
+			dev_err(hdmi->dev, "failed to get reference clock\n");
 		return ret;
 	}
 
@@ -222,7 +222,7 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 	if (IS_ERR(hdmi->grf_clk)) {
 		ret = PTR_ERR(hdmi->grf_clk);
 		if (ret != -EPROBE_DEFER)
-			drm_err(hdmi, "failed to get grf clock\n");
+			dev_err(hdmi->dev, "failed to get grf clock\n");
 		return ret;
 	}
 
@@ -302,16 +302,16 @@ static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 
 	ret = clk_prepare_enable(hdmi->grf_clk);
 	if (ret < 0) {
-		drm_err(hdmi, "failed to enable grfclk %d\n", ret);
+		dev_err(hdmi->dev, "failed to enable grfclk %d\n", ret);
 		return;
 	}
 
 	ret = regmap_write(hdmi->regmap, hdmi->chip_data->lcdsel_grf_reg, val);
 	if (ret != 0)
-		drm_err(hdmi, "Could not write to GRF: %d\n", ret);
+		dev_err(hdmi->dev, "Could not write to GRF: %d\n", ret);
 
 	clk_disable_unprepare(hdmi->grf_clk);
-	drm_dbg(hdmi, "vop %s output to hdmi\n", ret ? "LIT" : "BIG");
+	dev_dbg(hdmi->dev, "vop %s output to hdmi\n", ret ? "LIT" : "BIG");
 }
 
 static int
@@ -574,7 +574,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	ret = rockchip_hdmi_parse_dt(hdmi);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-			drm_err(hdmi, "Unable to parse OF data\n");
+			dev_err(hdmi->dev, "Unable to parse OF data\n");
 		return ret;
 	}
 
@@ -582,7 +582,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (IS_ERR(hdmi->phy)) {
 		ret = PTR_ERR(hdmi->phy);
 		if (ret != -EPROBE_DEFER)
-			drm_err(hdmi, "failed to get phy\n");
+			dev_err(hdmi->dev, "failed to get phy\n");
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index cebd72bf1ef25..6bbc84c5d716d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -170,7 +170,7 @@ static void dw_hdmi_qp_rk3588_hpd_work(struct work_struct *work)
 	if (drm) {
 		changed = drm_helper_hpd_irq_event(drm);
 		if (changed)
-			drm_dbg(hdmi, "connector status changed\n");
+			dev_dbg(hdmi->dev, "connector status changed\n");
 	}
 }
 
@@ -287,7 +287,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		}
 	}
 	if (hdmi->port_id < 0) {
-		drm_err(hdmi, "Failed to match HDMI port ID\n");
+		dev_err(hdmi->dev, "Failed to match HDMI port ID\n");
 		return hdmi->port_id;
 	}
 
@@ -311,20 +311,20 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 						       "rockchip,grf");
 	if (IS_ERR(hdmi->regmap)) {
-		drm_err(hdmi, "Unable to get rockchip,grf\n");
+		dev_err(hdmi->dev, "Unable to get rockchip,grf\n");
 		return PTR_ERR(hdmi->regmap);
 	}
 
 	hdmi->vo_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 							  "rockchip,vo-grf");
 	if (IS_ERR(hdmi->vo_regmap)) {
-		drm_err(hdmi, "Unable to get rockchip,vo-grf\n");
+		dev_err(hdmi->dev, "Unable to get rockchip,vo-grf\n");
 		return PTR_ERR(hdmi->vo_regmap);
 	}
 
 	ret = devm_clk_bulk_get_all_enabled(hdmi->dev, &clks);
 	if (ret < 0) {
-		drm_err(hdmi, "Failed to get clocks: %d\n", ret);
+		dev_err(hdmi->dev, "Failed to get clocks: %d\n", ret);
 		return ret;
 	}
 
@@ -332,7 +332,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(hdmi->enable_gpio)) {
 		ret = PTR_ERR(hdmi->enable_gpio);
-		drm_err(hdmi, "Failed to request enable GPIO: %d\n", ret);
+		dev_err(hdmi->dev, "Failed to request enable GPIO: %d\n", ret);
 		return ret;
 	}
 
@@ -340,7 +340,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (IS_ERR(hdmi->phy)) {
 		ret = PTR_ERR(hdmi->phy);
 		if (ret != -EPROBE_DEFER)
-			drm_err(hdmi, "failed to get phy: %d\n", ret);
+			dev_err(hdmi->dev, "failed to get phy: %d\n", ret);
 		return ret;
 	}
 
@@ -403,7 +403,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	connector = drm_bridge_connector_init(drm, encoder);
 	if (IS_ERR(connector)) {
 		ret = PTR_ERR(connector);
-		drm_err(hdmi, "failed to init bridge connector: %d\n", ret);
+		dev_err(hdmi->dev, "failed to init bridge connector: %d\n", ret);
 		return ret;
 	}
 
-- 
2.39.5


