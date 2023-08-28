Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403A78AA6B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjH1KWM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjH1KVk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF35CC1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043936152F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B58C433C8;
        Mon, 28 Aug 2023 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218082;
        bh=fFNOs4G8FmF4sNbCj3sTi0f9GfbMXwMd0Y9XtolMwWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOX29iuBtdIIroKPCq7S+nyTCv+2D7RAXxsoNR3yUV0TZaw52QxVFVuDkFKJjpCLA
         0v/ELPtnFtC24ekhCetIp+VdjvVm+g/S+0GENoUthjdBgpPEwFhA9jZP2DNdYA49vG
         Vp23S7vGLy5yNiNKpk7zjvl8l08JkHtNkUQWNDis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Jianshui Yu <Jianshui.yu@intel.com>
Subject: [PATCH 6.4 071/129] drm/i915/dgfx: Enable d3cold at s2idle
Date:   Mon, 28 Aug 2023 12:12:30 +0200
Message-ID: <20230828101159.703405053@linuxfoundation.org>
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

From: Anshuman Gupta <anshuman.gupta@intel.com>

commit 2872144aec04baa7e43ecd2a60f7f0be3aa843fd upstream.

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
Tested-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Jianshui Yu <Jianshui.yu@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230816125216.1722002-1-anshuman.gupta@intel.com
(cherry picked from commit 2643e6d1f2a5e51877be24042d53cf956589be10)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_driver.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -433,7 +433,6 @@ static int i915_pcode_init(struct drm_i9
 static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 	int ret;
 
 	if (i915_inject_probe_failure(dev_priv))
@@ -547,15 +546,6 @@ static int i915_driver_hw_probe(struct d
 
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
@@ -581,7 +571,6 @@ err_perf:
 static void i915_driver_hw_remove(struct drm_i915_private *dev_priv)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
-	struct pci_dev *root_pdev;
 
 	i915_perf_fini(dev_priv);
 
@@ -589,10 +578,6 @@ static void i915_driver_hw_remove(struct
 
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
-
-	root_pdev = pcie_find_root_port(pdev);
-	if (root_pdev)
-		pci_d3cold_enable(root_pdev);
 }
 
 /**
@@ -1499,6 +1484,8 @@ static int intel_runtime_suspend(struct
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1550,6 +1537,15 @@ static int intel_runtime_suspend(struct
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
@@ -1588,6 +1584,8 @@ static int intel_runtime_resume(struct d
 {
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	struct intel_runtime_pm *rpm = &dev_priv->runtime_pm;
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	struct pci_dev *root_pdev;
 	struct intel_gt *gt;
 	int ret, i;
 
@@ -1601,6 +1599,11 @@ static int intel_runtime_resume(struct d
 
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


