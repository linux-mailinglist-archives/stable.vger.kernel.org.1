Return-Path: <stable+bounces-97536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05A9E245D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F159287B13
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1E1F8925;
	Tue,  3 Dec 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ynq0TTwE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C541DFE2A;
	Tue,  3 Dec 2024 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240850; cv=none; b=VeXPok8U3ui6GFcxu0PYiv/ZUhDG3iW2rKJFIwllbX/VmH1/1fEX+bWbDyer8rFT1qZB11LjwUQvQgftC45wDJhUzW8tem0bVrP4yhu9FTyUnioVheLqNpBK3DQKAXIXTFUGbORdrNWkv/pqEzN7o6OexyjAFRDiG3d2jKc8vfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240850; c=relaxed/simple;
	bh=aHHojbyfYwN43/nDFAJPSU8lmJg/aLDrpA4O2tx41yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gykNwyrn+RsPwkL4kk8i5xn8erxgYr0aWZ/13iChpX/2p93qb2ioS5Rx3Ra5xW+VlX4qMG3tTFSt9jmJmPmXwVIU5nWxq7OnlaqEkojwTHBOjkLZZ6VcGm0mWdeYm/zaIdetHIJH6nzZBkKX1qxDpr6odNUMFGt+5i//5KbzqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ynq0TTwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4850BC4CECF;
	Tue,  3 Dec 2024 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240850;
	bh=aHHojbyfYwN43/nDFAJPSU8lmJg/aLDrpA4O2tx41yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ynq0TTwEoK2O+FcS+I5uY1nG6t1xIs7F0S6guLBCl3VDlNTXWB7jkGFBX/oSEjrbg
	 wOvB1koy3kJcnTbjC4AhD4fXitnFTCGb1BQkgNZ710CMO5ifGlt49kmcUH77aPgZv0
	 8CJB2wZeJMzFtNmAR90lZbJGepAGGsTFRSf2SFHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 254/826] drm: fsl-dcu: enable PIXCLK on LS1021A
Date: Tue,  3 Dec 2024 15:39:41 +0100
Message-ID: <20241203144753.675324219@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

[ Upstream commit ffcde9e44d3e18fde3d18bfff8d9318935413bfd ]

The PIXCLK needs to be enabled in SCFG before accessing certain DCU
registers, or the access will hang. For simplicity, the PIXCLK is enabled
unconditionally, resulting in increased power consumption.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Fixes: 109eee2f2a18 ("drm/layerscape: Add Freescale DCU DRM driver")
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240926055552.1632448-2-alexander.stein@ew.tq-group.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 15 +++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
index 5ca71ef873259..c9ee98693b48a 100644
--- a/drivers/gpu/drm/fsl-dcu/Kconfig
+++ b/drivers/gpu/drm/fsl-dcu/Kconfig
@@ -8,6 +8,7 @@ config DRM_FSL_DCU
 	select DRM_PANEL
 	select REGMAP_MMIO
 	select VIDEOMODE_HELPERS
+	select MFD_SYSCON if SOC_LS1021A
 	help
 	  Choose this option if you have an Freescale DCU chipset.
 	  If M is selected the module will be called fsl-dcu-drm.
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index ab6c0c6cd0e2e..c4c3d41ee5309 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -100,6 +100,7 @@ static void fsl_dcu_irq_uninstall(struct drm_device *dev)
 static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 {
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
+	struct regmap *scfg;
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
@@ -108,6 +109,20 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 		return ret;
 	}
 
+	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
+	if (PTR_ERR(scfg) != -ENODEV) {
+		/*
+		 * For simplicity, enable the PIXCLK unconditionally,
+		 * resulting in increased power consumption. Disabling
+		 * the clock in PM or on unload could be implemented as
+		 * a future improvement.
+		 */
+		ret = regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
+					 SCFG_PIXCLKCR_PXCEN);
+		if (ret < 0)
+			return dev_err_probe(dev->dev, ret, "failed to enable pixclk\n");
+	}
+
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
 		dev_err(dev->dev, "failed to initialize vblank\n");
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
index e2049a0e8a92a..566396013c04a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
@@ -160,6 +160,9 @@
 #define FSL_DCU_ARGB4444		12
 #define FSL_DCU_YUV422			14
 
+#define SCFG_PIXCLKCR			0x28
+#define SCFG_PIXCLKCR_PXCEN		BIT(31)
+
 #define VF610_LAYER_REG_NUM		9
 #define LS1021A_LAYER_REG_NUM		10
 
-- 
2.43.0




