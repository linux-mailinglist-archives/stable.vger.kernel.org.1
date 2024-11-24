Return-Path: <stable+bounces-95119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EB9D7467
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D8EBE6295
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF81DFE30;
	Sun, 24 Nov 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tICWTlLM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2C1DFE25;
	Sun, 24 Nov 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456067; cv=none; b=WtWc7/kuX/fZb67Hu73xjGtGvWCLSBpR3T67kAfolaq58pMIEcUxp6BPQxDh24f9WjHUmZjK1S8RvmMPqCFNfY9lRgVQ23eKbZOJBFrFLxFRYcuodY63PSX0SsqTFrZHDsLaSPJaBxymNb+LayZcWwFtFGNYGX0nR64ADYYwqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456067; c=relaxed/simple;
	bh=SQ4C4hrbqGoQpJQVxZd8jkK60k0aXxT/93qJjofxkos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KksVu3hA+lKo4lNeYPEVmgBs5v6qiuHTU4HNkGa8g6UgkrkReXDA+nqK8J8ubWzkECV/iWVd3pja/0Q4UzUWn+WopKw2Fmtr3vYooLu1RCamzsIacP3E8e45PgErnVzTRmzUJU10oSVQZj2ATCopqSEOD/miz3uTvlExBXbSK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tICWTlLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D3AC4CED1;
	Sun, 24 Nov 2024 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456066;
	bh=SQ4C4hrbqGoQpJQVxZd8jkK60k0aXxT/93qJjofxkos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tICWTlLMAnHgqdqNC5HshSJmYBa+D3UsgvW7qcNGXLU1bC/25dLMcCFAgr+lIR8bW
	 H86SwZz1M7c+xr6xtLAaoOWq2IbzXiVpl2e7IzJeJH5mz6FghQxc+tb1wcupnoihGR
	 An0lnW9CCym8uIJaQ52XUAElGsRayfBQLcQ6xw6JtswmN5rqewl9wGygxVsYIpSqUc
	 5LiqDnFd9wpGEQqF07x78GaW/gcNnOkKTO9F1goo2l21W7RxK95ckZ1CrP73llUBoV
	 Ai9+EjbhGRQQc4RSZGYVZLEMoIm15XF+1nl9dVvNhnzTpq21YCX8wWfp0gYM5+9NUv
	 OrKZTxV8s1hXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manikandan Muralidharan <manikandan.m@microchip.com>,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 29/61] drm/panel: simple: Add Microchip AC69T88A LVDS Display panel
Date: Sun, 24 Nov 2024 08:45:04 -0500
Message-ID: <20241124134637.3346391-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Manikandan Muralidharan <manikandan.m@microchip.com>

[ Upstream commit 40da1463cd6879f542238b36c1148f517927c595 ]

Add support for Microchip AC69T88A 5 inch TFT LCD 800x480
Display module with LVDS interface.The panel uses the Sitronix
ST7262 800x480 Display driver

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240919091548.430285-2-manikandan.m@microchip.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 11ade6bac592f..37fe54c34b141 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4087,6 +4087,31 @@ static const struct panel_desc yes_optoelectronics_ytc700tlag_05_201c = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode mchp_ac69t88a_mode = {
+	.clock = 25000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 88,
+	.hsync_end = 800 + 88 + 5,
+	.htotal = 800 + 88 + 5 + 40,
+	.vdisplay = 480,
+	.vsync_start = 480 + 23,
+	.vsync_end = 480 + 23 + 5,
+	.vtotal = 480 + 23 + 5 + 1,
+};
+
+static const struct panel_desc mchp_ac69t88a = {
+	.modes = &mchp_ac69t88a_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode arm_rtsm_mode[] = {
 	{
 		.clock = 65000,
@@ -4522,6 +4547,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "yes-optoelectronics,ytc700tlag-05-201c",
 		.data = &yes_optoelectronics_ytc700tlag_05_201c,
+	}, {
+		.compatible = "microchip,ac69t88a",
+		.data = &mchp_ac69t88a,
 	}, {
 		/* Must be the last entry */
 		.compatible = "panel-dpi",
-- 
2.43.0


