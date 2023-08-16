Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263E77E1FC
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbjHPMxR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 08:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbjHPMwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 08:52:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63764C7
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190365; x=1723726365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ObEwQsWGpgBBmbzOSpq9YycH8gkRe1PSz42+FE0Qd8c=;
  b=BnI4r6x4PZg7oc5sfpvvVfz2J4rj1P6aSCPV+cW4rdhp5edRxOQBRBq1
   NtFqizzReozxuTjY3Jr8ZZV5Tt42NNuz/dh1Z7yI9AAyQWkcaeHX//WK9
   uwbfTxPfZAJKKhPBamozmvAxa40mCZS4KMizXc0HJoL6qdtfF4b8tE0qb
   Kgvh3Wrlfr2EJTc1E/BUfitWakBfK7S9cGeWrPC714eFgmorLgPS0TOFy
   TpN6b9itRyW4Z/m8xYKQUsm6i29IzATfkDsqpXmXUAtsmSlNm1cYpyxBz
   UVy/ahzMEcrhpMX6A+Jl2PBwI2C3sONZfMXlvifB01fAPedjcG3DvP4dI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357498195"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="357498195"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877778720"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:52:46 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     badal.nilawar@intel.com, riana.tauro@intel.com,
        rodrigo.vivi@intel.com, jianshui.yu@intel.com,
        lidong.wang@intel.com, Anshuman Gupta <anshuman.gupta@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dgfx: Enable d3cold at s2idle
Date:   Wed, 16 Aug 2023 18:22:16 +0530
Message-Id: <20230816125216.1722002-1-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

System wide suspend already has support for lmem save/restore during
suspend therefore enabling d3cold for s2idle and keepng it disable for
runtime PM.(Refer below commit for d3cold runtime PM disable justification)
'commit 66eb93e71a7a ("drm/i915/dgfx: Keep PCI autosuspend control
'on' by default on all dGPU")'

It will reduce the DG2 Card power consumption to ~0 Watt
for s2idle power KPI.

v2:
- Added "Cc: stable@vger.kernel.org".

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8755
Cc: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 33 ++++++++++++++++--------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index b870c0df081a..ec4d26b3c17c 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -443,7 +443,6 @@ static int i915_pcode_init(struct drm_i915_private *i915)
 static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 	int ret;
 
 	if (i915_inject_probe_failure(dev_priv))
@@ -557,15 +556,6 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 
 	intel_bw_init_hw(dev_priv);
 
-	/*
-	 * FIXME: Temporary hammer to avoid freezing the machine on our DGFX
-	 * This should be totally removed when we handle the pci states properly
-	 * on runtime PM and on s2idle cases.
-	 */
-	root_pdev = pcie_find_root_port(pdev);
-	if (root_pdev)
-		pci_d3cold_disable(root_pdev);
-
 	return 0;
 
 err_opregion:
@@ -591,7 +581,6 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 
 	i915_perf_fini(dev_priv);
 
@@ -599,10 +588,6 @@ static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
-
-	root_pdev = pcie_find_root_port(pdev);
-	if (root_pdev)
-		pci_d3cold_enable(root_pdev);
 }
 
 /**
@@ -1519,6 +1504,8 @@ static int intel_runtime_suspend(struct device *kdev)
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1570,6 +1557,15 @@ static int intel_runtime_suspend(struct device *kdev)
 		drm_err(&dev_priv->drm,
 			"Unclaimed access detected prior to suspending\n");
 
+	/*
+	 * FIXME: Temporary hammer to avoid freezing the machine on our DGFX
+	 * This should be totally removed when we handle the pci states properly
+	 * on runtime PM.
+	 */
+	root_pdev = pcie_find_root_port(pdev);
+	if (root_pdev)
+		pci_d3cold_disable(root_pdev);
+
 	rpm->suspended = true;
 
 	/*
@@ -1608,6 +1604,8 @@ static int intel_runtime_resume(struct device *kdev)
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1621,6 +1619,11 @@ static int intel_runtime_resume(struct device *kdev)
 
 	intel_opregion_notify_adapter(dev_priv, PCI_D0);
 	rpm->suspended = false;
+
+	root_pdev = pcie_find_root_port(pdev);
+	if (root_pdev)
+		pci_d3cold_enable(root_pdev);
+
 	if (intel_uncore_unclaimed_mmio(&dev_priv->uncore))
 		drm_dbg(&dev_priv->drm,
 			"Unclaimed access during suspend, bios?\n");
-- 
2.25.1

