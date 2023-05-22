Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E970C6FD
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjEVTYn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjEVTYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BB1CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9656287A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BADC433D2;
        Mon, 22 May 2023 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783479;
        bh=HjV7t6wRaGmPsGpISVlSU6zwaJWXLyMNRroorwprgT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upozaEPHGMQkUF6wV+mc/yA5xc5/AfHEzXuzdOpL59Sc7Q+hIzGkM88+YEVkBS1OO
         X75+TTjzQqkMal1qXDXezoWZYcwtdxZAGynjdLiypQxWsH0Aes5kJJRRvRD+J5Mec8
         UZLoiXO7AryMnyazW/XuLt9Uuf2KjEjH8gT3jFMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/292] drm/i915: Expand force_probe to block probe of devices as well.
Date:   Mon, 22 May 2023 20:06:26 +0100
Message-Id: <20230522190406.621982636@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 157821fb3e9aaa07cf408686b08d117bf27b7de1 ]

There are new cases where we want to block i915 probe, such
as when experimenting or developing the new Xe driver.

But also, with the new hybrid cards, users or developers might
want to use i915 only on integrated and fully block the probe
of the i915 for the discrete. Or vice versa.

There are even older development and validation reasons,
like when you use some distro where the modprobe.blacklist is
not present.

But in any case, let's introduce a more granular control, but without
introducing yet another parameter, but using the existent force_probe
one.

Just by adding a ! in the begin of the id in the force_probe, like
in this case where we would block the probe for Alder Lake:

$ insmod i915.ko force_probe='!46a6'

v2: Take care of '*' and  '!*' cases as pointed out by
    Gustavo and Jani.

Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230103194701.1492984-1-rodrigo.vivi@intel.com
Stable-dep-of: 79c901c93562 ("drm/i915: taint kernel when force probing unsupported devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/Kconfig       | 15 +++++++++++---
 drivers/gpu/drm/i915/i915_params.c |  2 +-
 drivers/gpu/drm/i915/i915_pci.c    | 33 +++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 3a6e176d77aa5..e04715fa5bc4c 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -54,24 +54,33 @@ config DRM_I915
 	  If "M" is selected, the module will be called i915.
 
 config DRM_I915_FORCE_PROBE
-	string "Force probe driver for selected new Intel hardware"
+	string "Force probe i915 for selected Intel hardware IDs"
 	depends on DRM_I915
 	help
 	  This is the default value for the i915.force_probe module
 	  parameter. Using the module parameter overrides this option.
 
-	  Force probe the driver for new Intel graphics devices that are
+	  Force probe the i915 for Intel graphics devices that are
 	  recognized but not properly supported by this kernel version. It is
 	  recommended to upgrade to a kernel version with proper support as soon
 	  as it is available.
 
+	  It can also be used to block the probe of recognized and fully
+	  supported devices.
+
 	  Use "" to disable force probe. If in doubt, use this.
 
-	  Use "<pci-id>[,<pci-id>,...]" to force probe the driver for listed
+	  Use "<pci-id>[,<pci-id>,...]" to force probe the i915 for listed
 	  devices. For example, "4500" or "4500,4571".
 
 	  Use "*" to force probe the driver for all known devices.
 
+	  Use "!" right before the ID to block the probe of the device. For
+	  example, "4500,!4571" forces the probe of 4500 and blocks the probe of
+	  4571.
+
+	  Use "!*" to block the probe of the driver for all known devices.
+
 config DRM_I915_CAPTURE_ERROR
 	bool "Enable capturing GPU state following a hang"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index d1e4d528cb174..5b24dd50fb6a4 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -122,7 +122,7 @@ i915_param_named_unsafe(enable_psr2_sel_fetch, bool, 0400,
 	"Default: 0");
 
 i915_param_named_unsafe(force_probe, charp, 0400,
-	"Force probe the driver for specified devices. "
+	"Force probe options for specified supported devices. "
 	"See CONFIG_DRM_I915_FORCE_PROBE for details.");
 
 i915_param_named_unsafe(disable_power_well, int, 0400,
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index a2efc0b9d50c8..1fa4a5813683f 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -1252,7 +1252,7 @@ static void i915_pci_remove(struct pci_dev *pdev)
 }
 
 /* is device_id present in comma separated list of ids */
-static bool force_probe(u16 device_id, const char *devices)
+static bool device_id_in_list(u16 device_id, const char *devices, bool negative)
 {
 	char *s, *p, *tok;
 	bool ret;
@@ -1261,7 +1261,9 @@ static bool force_probe(u16 device_id, const char *devices)
 		return false;
 
 	/* match everything */
-	if (strcmp(devices, "*") == 0)
+	if (negative && strcmp(devices, "!*") == 0)
+		return true;
+	if (!negative && strcmp(devices, "*") == 0)
 		return true;
 
 	s = kstrdup(devices, GFP_KERNEL);
@@ -1271,6 +1273,12 @@ static bool force_probe(u16 device_id, const char *devices)
 	for (p = s, ret = false; (tok = strsep(&p, ",")) != NULL; ) {
 		u16 val;
 
+		if (negative && tok[0] == '!')
+			tok++;
+		else if ((negative && tok[0] != '!') ||
+			 (!negative && tok[0] == '!'))
+			continue;
+
 		if (kstrtou16(tok, 16, &val) == 0 && val == device_id) {
 			ret = true;
 			break;
@@ -1282,6 +1290,16 @@ static bool force_probe(u16 device_id, const char *devices)
 	return ret;
 }
 
+static bool id_forced(u16 device_id)
+{
+	return device_id_in_list(device_id, i915_modparams.force_probe, false);
+}
+
+static bool id_blocked(u16 device_id)
+{
+	return device_id_in_list(device_id, i915_modparams.force_probe, true);
+}
+
 bool i915_pci_resource_valid(struct pci_dev *pdev, int bar)
 {
 	if (!pci_resource_flags(pdev, bar))
@@ -1309,10 +1327,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		(struct intel_device_info *) ent->driver_data;
 	int err;
 
-	if (intel_info->require_force_probe &&
-	    !force_probe(pdev->device, i915_modparams.force_probe)) {
+	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
 		dev_info(&pdev->dev,
-			 "Your graphics device %04x is not properly supported by the driver in this\n"
+			 "Your graphics device %04x is not properly supported by i915 in this\n"
 			 "kernel version. To force driver probe anyway, use i915.force_probe=%04x\n"
 			 "module parameter or CONFIG_DRM_I915_FORCE_PROBE=%04x configuration option,\n"
 			 "or (recommended) check for kernel updates.\n",
@@ -1320,6 +1337,12 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENODEV;
 	}
 
+	if (id_blocked(pdev->device)) {
+		dev_info(&pdev->dev, "I915 probe blocked for Device ID %04x.\n",
+			 pdev->device);
+		return -ENODEV;
+	}
+
 	/* Only bind to function 0 of the device. Early generations
 	 * used function 1 as a placeholder for multi-head. This causes
 	 * us confusion instead, especially on the systems where both
-- 
2.39.2



