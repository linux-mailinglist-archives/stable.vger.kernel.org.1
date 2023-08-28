Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAF78AA81
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjH1KWy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjH1KWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23B132
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA59063930
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96AEC433C7;
        Mon, 28 Aug 2023 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218132;
        bh=VPLr7kcRVPJrGYnvixuj/KQsvgf8tS+FRP8cwANGeDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAtH3AWxxNx7ZIOQtJaQ6c3hbq5GSmHLdTtMDKYc1TbiZ0l6n+WDZbsv50BAM+cDF
         UoygGkkPTiq5gVFqlxNnDmh76XzbGywvYSB5rzRMO47SwNmLFoCpZy0KA/HG7S4uMK
         R2N+2Kx+UHVcC6ZNcF1JNemg7LQho8iRmV8KHN04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matt Roper <matthew.d.roper@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 6.4 077/129] drm/i915/display: Handle GMD_ID identification in display code
Date:   Mon, 28 Aug 2023 12:12:36 +0200
Message-ID: <20230828101159.896417386@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Roper <matthew.d.roper@intel.com>

commit 12e6f6dc78e4f4a418648fb1a9c0cd2ae9b3430b upstream.

For platforms with GMD_ID support (i.e., everything MTL and beyond),
identification of the display IP present should be based on the contents
of the GMD_ID register rather than a PCI devid match.

Note that since GMD_ID readout requires access to the PCI BAR, a slight
change to the driver init sequence is needed --- pci_enable_device() is
now called before i915_driver_create().

v2:
 - Fix use of uninitialized i915 pointer in error path if
   pci_enable_device() fails before the i915 device is created.  (lkp)
 - Use drm_device parameter to intel_display_device_probe.  This goes
   against i915 conventions, but since the primary goal here is to make
   it easy to call this function from other drivers (like Xe) and since
   we don't need anything from the i915 structure, this seems like an
   exception where drm_device is a more natural fit.
v3:
 - Go back do drm_i915_private for intel_display_device_probe.  (Jani)
 - Move forward decl to top of header.  (Jani)

Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230523195609.73627-6-matthew.d.roper@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_display_device.c |   65 ++++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_display_device.h |    5 +
 drivers/gpu/drm/i915/i915_driver.c                  |   17 +++--
 drivers/gpu/drm/i915/intel_device_info.c            |   13 ++--
 4 files changed, 84 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -5,7 +5,10 @@
 
 #include <drm/i915_pciids.h>
 #include <drm/drm_color_mgmt.h>
+#include <linux/pci.h>
 
+#include "i915_drv.h"
+#include "i915_reg.h"
 #include "intel_display_device.h"
 #include "intel_display_power.h"
 #include "intel_display_reg_defs.h"
@@ -710,19 +713,73 @@ static const struct {
 	INTEL_RPLP_IDS(&xe_lpd_display),
 	INTEL_DG2_IDS(&xe_hpd_display),
 
-	/* FIXME: Replace this with a GMD_ID lookup */
-	INTEL_MTL_IDS(&xe_lpdp_display),
+	/*
+	 * Do not add any GMD_ID-based platforms to this list.  They will
+	 * be probed automatically based on the IP version reported by
+	 * the hardware.
+	 */
 };
 
+static const struct {
+	u16 ver;
+	u16 rel;
+	const struct intel_display_device_info *display;
+} gmdid_display_map[] = {
+	{ 14,  0, &xe_lpdp_display },
+};
+
+static const struct intel_display_device_info *
+probe_gmdid_display(struct drm_i915_private *i915, u16 *ver, u16 *rel, u16 *step)
+{
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
+	void __iomem *addr;
+	u32 val;
+	int i;
+
+	addr = pci_iomap_range(pdev, 0, i915_mmio_reg_offset(GMD_ID_DISPLAY), sizeof(u32));
+	if (!addr) {
+		drm_err(&i915->drm, "Cannot map MMIO BAR to read display GMD_ID\n");
+		return &no_display;
+	}
+
+	val = ioread32(addr);
+	pci_iounmap(pdev, addr);
+
+	if (val == 0)
+		/* Platform doesn't have display */
+		return &no_display;
+
+	*ver = REG_FIELD_GET(GMD_ID_ARCH_MASK, val);
+	*rel = REG_FIELD_GET(GMD_ID_RELEASE_MASK, val);
+	*step = REG_FIELD_GET(GMD_ID_STEP, val);
+
+	for (i = 0; i < ARRAY_SIZE(gmdid_display_map); i++)
+		if (*ver == gmdid_display_map[i].ver &&
+		    *rel == gmdid_display_map[i].rel)
+			return gmdid_display_map[i].display;
+
+	drm_err(&i915->drm, "Unrecognized display IP version %d.%02d; disabling display.\n",
+		*ver, *rel);
+	return &no_display;
+}
+
 const struct intel_display_device_info *
-intel_display_device_probe(u16 pci_devid)
+intel_display_device_probe(struct drm_i915_private *i915, bool has_gmdid,
+			   u16 *gmdid_ver, u16 *gmdid_rel, u16 *gmdid_step)
 {
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	int i;
 
+	if (has_gmdid)
+		return probe_gmdid_display(i915, gmdid_ver, gmdid_rel, gmdid_step);
+
 	for (i = 0; i < ARRAY_SIZE(intel_display_ids); i++) {
-		if (intel_display_ids[i].devid == pci_devid)
+		if (intel_display_ids[i].devid == pdev->device)
 			return intel_display_ids[i].info;
 	}
 
+	drm_dbg(&i915->drm, "No display ID found for device ID %04x; disabling display.\n",
+		pdev->device);
+
 	return &no_display;
 }
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -10,6 +10,8 @@
 
 #include "display/intel_display_limits.h"
 
+struct drm_i915_private;
+
 #define DEV_INFO_DISPLAY_FOR_EACH_FLAG(func) \
 	/* Keep in alphabetical order */ \
 	func(cursor_needs_physical); \
@@ -81,6 +83,7 @@ struct intel_display_device_info {
 };
 
 const struct intel_display_device_info *
-intel_display_device_probe(u16 pci_devid);
+intel_display_device_probe(struct drm_i915_private *i915, bool has_gmdid,
+			   u16 *ver, u16 *rel, u16 *step);
 
 #endif
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -739,13 +739,17 @@ int i915_driver_probe(struct pci_dev *pd
 	struct drm_i915_private *i915;
 	int ret;
 
-	i915 = i915_driver_create(pdev, ent);
-	if (IS_ERR(i915))
-		return PTR_ERR(i915);
-
 	ret = pci_enable_device(pdev);
-	if (ret)
-		goto out_fini;
+	if (ret) {
+		pr_err("Failed to enable graphics device: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	i915 = i915_driver_create(pdev, ent);
+	if (IS_ERR(i915)) {
+		ret = PTR_ERR(i915);
+		goto out_pci_disable;
+	}
 
 	ret = i915_driver_early_probe(i915);
 	if (ret < 0)
@@ -828,7 +832,6 @@ out_runtime_pm_put:
 	i915_driver_late_release(i915);
 out_pci_disable:
 	pci_disable_device(pdev);
-out_fini:
 	i915_probe_error(i915, "Device initialization failed (%d)\n", ret);
 	return ret;
 }
--- a/drivers/gpu/drm/i915/intel_device_info.c
+++ b/drivers/gpu/drm/i915/intel_device_info.c
@@ -345,7 +345,6 @@ static void ip_ver_read(struct drm_i915_
 static void intel_ipver_early_init(struct drm_i915_private *i915)
 {
 	struct intel_runtime_info *runtime = RUNTIME_INFO(i915);
-	struct intel_display_runtime_info *display_runtime = DISPLAY_RUNTIME_INFO(i915);
 
 	if (!HAS_GMD_ID(i915)) {
 		drm_WARN_ON(&i915->drm, RUNTIME_INFO(i915)->graphics.ip.ver > 12);
@@ -366,8 +365,6 @@ static void intel_ipver_early_init(struc
 		RUNTIME_INFO(i915)->graphics.ip.ver = 12;
 		RUNTIME_INFO(i915)->graphics.ip.rel = 70;
 	}
-	ip_ver_read(i915, i915_mmio_reg_offset(GMD_ID_DISPLAY),
-		    (struct intel_ip_version *)&display_runtime->ip);
 	ip_ver_read(i915, i915_mmio_reg_offset(GMD_ID_MEDIA),
 		    &runtime->media.ip);
 }
@@ -574,6 +571,7 @@ void intel_device_info_driver_create(str
 {
 	struct intel_device_info *info;
 	struct intel_runtime_info *runtime;
+	u16 ver, rel, step;
 
 	/* Setup the write-once "constant" device info */
 	info = mkwrite_device_info(i915);
@@ -584,11 +582,18 @@ void intel_device_info_driver_create(str
 	memcpy(runtime, &INTEL_INFO(i915)->__runtime, sizeof(*runtime));
 
 	/* Probe display support */
-	info->display = intel_display_device_probe(device_id);
+	info->display = intel_display_device_probe(i915, info->has_gmd_id,
+						   &ver, &rel, &step);
 	memcpy(DISPLAY_RUNTIME_INFO(i915),
 	       &DISPLAY_INFO(i915)->__runtime_defaults,
 	       sizeof(*DISPLAY_RUNTIME_INFO(i915)));
 
+	if (info->has_gmd_id) {
+		DISPLAY_RUNTIME_INFO(i915)->ip.ver = ver;
+		DISPLAY_RUNTIME_INFO(i915)->ip.rel = rel;
+		DISPLAY_RUNTIME_INFO(i915)->ip.step = step;
+	}
+
 	runtime->device_id = device_id;
 }
 


