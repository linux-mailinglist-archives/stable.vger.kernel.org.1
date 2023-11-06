Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB97E2526
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKFN2j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjKFN2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F62D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:28:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D4C433C8;
        Mon,  6 Nov 2023 13:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277316;
        bh=wqxSfyh63YXJVdqrA4SSbpMFNkcnlLC0ma+K5LRkd74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeOKQw1OAcnogrCg74/J0MBjA5+H7bkYyye09AaF3XZ7R3DNTwfT/UL3YqyVGaZ5O
         o1rsqP+7uE1Sa2l9lM+u6HbGkoS53BPpPYHi6SjbzwP5zdNSrfarhA5H9wyAIbud5s
         PSQv1qiVSU+E8VTneRPLX8xv2HE8ILI3InfDVZPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 111/128] drm/amd: Move helper for dynamic speed switch check out of smu13
Date:   Mon,  6 Nov 2023 14:04:31 +0100
Message-ID: <20231106130314.217615523@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 188623076d0f1a500583d392b6187056bf7cc71a upstream.

This helper is used for checking if the connected host supports
the feature, it can be moved into generic code to be used by other
smu implementations as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1285,6 +1285,7 @@ int amdgpu_device_gpu_recover(struct amd
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1319,6 +1319,25 @@ bool amdgpu_device_need_post(struct amdg
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


