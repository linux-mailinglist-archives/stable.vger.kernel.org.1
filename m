Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787FA75BFDF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjGUHgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGUHgk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF930EC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA147612AF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFB1C433C9;
        Fri, 21 Jul 2023 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924967;
        bh=GqXk68DYI2wvIe5vsyP/8cku45AaXG8MgMvF65IaCI4=;
        h=Subject:To:Cc:From:Date:From;
        b=NDW1IDjWp0oNSCucbDMLSd7bgSrsNYOnup3hRNvb+m9hHCrE1qdMUSZr9lXywFxen
         IX2J6v88vNPF5K8Qcykz8oFF/8CbMkDpHRWNlEhXtyYhS7lFvSTtXyXN9wRlKcxQ+b
         q0Ifzt9ux/aDtoEgoPiGKDe1OFOBZhPYZL0uosdA=
Subject: FAILED: patch "[PATCH] drm/amd: Move helper for dynamic speed switch check out of" failed to apply to 6.4-stable tree
To:     mario.limonciello@amd.com, alexander.deucher@amd.com,
        evan.quan@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:35:56 +0200
Message-ID: <2023072156-winking-doornail-c9cc@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x 188623076d0f1a500583d392b6187056bf7cc71a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072156-winking-doornail-c9cc@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 188623076d0f1a500583d392b6187056bf7cc71a Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 7 Jul 2023 21:26:08 -0500
Subject: [PATCH] drm/amd: Move helper for dynamic speed switch check out of
 smu13

This helper is used for checking if the connected host supports
the feature, it can be moved into generic code to be used by other
smu implementations as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2f9c14aca73c..a3b86b86dc47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1296,6 +1296,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a92c6189b4b6..a2cdde0ca0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1458,6 +1458,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+bool amdgpu_device_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index cf7e729020ab..9b62b45ebb7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2425,25 +2425,6 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-/*
- * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
- * speed switching. Until we have confirmation from Intel that a specific host
- * supports it, it's safer that we keep it disabled for all.
- *
- * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
- */
-static bool smu_v13_0_is_pcie_dynamic_switching_supported(void)
-{
-#if IS_ENABLED(CONFIG_X86)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	if (c->x86_vendor == X86_VENDOR_INTEL)
-		return false;
-#endif
-	return true;
-}
-
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint32_t pcie_gen_cap,
 				     uint32_t pcie_width_cap)
@@ -2455,7 +2436,7 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
-	if (!smu_v13_0_is_pcie_dynamic_switching_supported()) {
+	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
 

