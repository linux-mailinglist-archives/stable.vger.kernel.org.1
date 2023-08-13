Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5B77ACA4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjHMVfY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHMVfX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091D10EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB28961580
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31F3C433C8;
        Sun, 13 Aug 2023 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962524;
        bh=OUPn7ctCCTq07YgomPazDfOkSxh3WUQnOrCfV3BR1dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EG3IJf0LphWtO4VOhKTULDqJTlHZXLwgXUpXYPPLTOveeJs9Pd/ay/E+GHaQmmzNl
         SjIr4so76luaPLMdlmtn54KS8D43DJpX6fUdG/dIGB5oagi7xp9rwvtgQNmuNLdVAu
         G0rfdTrJvCtDbuCIv9b3x1FzvZwInZt8AFpQGtlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
        Roman Li <roman.li@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 031/149] drm/amd: Disable S/G for APUs when 64GB or more host memory
Date:   Sun, 13 Aug 2023 23:17:56 +0200
Message-ID: <20230813211719.738464481@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

commit 08fffa74d9772d9538338be3f304006c94dde6f0 upstream.

Users report a white flickering screen on multiple systems that
is tied to having 64GB or more memory.  When S/G is enabled pages
will get pinned to both VRAM carve out and system RAM leading to
this.

Until it can be fixed properly, disable S/G when 64GB of memory or
more is detected.  This will force pages to be pinned into VRAM.
This should fix white screen flickers but if VRAM pressure is
encountered may lead to black screens.  It's a trade-off for now.

Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)")
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G display parameter")
Cc: <stable@vger.kernel.org> # 6.4.y
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   26 ++++++++++++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    5 +---
 3 files changed, 29 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1263,6 +1263,7 @@ int amdgpu_device_gpu_recover(struct amd
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1334,6 +1334,32 @@ bool amdgpu_device_need_post(struct amdg
 }
 
 /*
+ * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
+ * Disable S/G on such systems until we have a proper fix.
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
+ */
+bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
+{
+	switch (amdgpu_sg_display) {
+	case -1:
+		break;
+	case 0:
+		return false;
+	case 1:
+		return true;
+	default:
+		return false;
+	}
+	if ((totalram_pages() << (PAGE_SHIFT - 10)) +
+	    (adev->gmc.real_vram_size / 1024) >= 64000000) {
+		DRM_WARN("Disabling S/G due to >=64GB RAM\n");
+		return false;
+	}
+	return true;
+}
+
+/*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
  * supports it, it's safer that we keep it disabled for all.
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1634,9 +1634,8 @@ static int amdgpu_dm_init(struct amdgpu_
 		}
 		break;
 	}
-	if (init_data.flags.gpu_vm_support &&
-	    (amdgpu_sg_display == 0))
-		init_data.flags.gpu_vm_support = false;
+	if (init_data.flags.gpu_vm_support)
+		init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
 
 	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;


