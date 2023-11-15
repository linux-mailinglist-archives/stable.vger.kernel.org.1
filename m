Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B17ECAE4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjKOTAD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjKOTAC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:00:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70967C7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 10:59:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9060C433C7;
        Wed, 15 Nov 2023 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700074799;
        bh=cP74eDRtg0eqwVrST4F4chz0IRGlblfKC1j4JIqiVNY=;
        h=Subject:To:Cc:From:Date:From;
        b=MlOoP4LmljelqYLlsLMgJR/YeSBWF0STG+7J/3PQPX9sEPGJ8k33anCUfgRbrnvfC
         aixPQISotlBA8O/Ke5xPDnfAvq32yQZELMee6Yoew5GQdy0QvG5X1l0IXvUIJQXIKv
         9RcXt1CyluEMa/OeICxlLYqR1IxcZUJZHnh+8vTU=
Subject: FAILED: patch "[PATCH] Revert "drm/amd: Disable S/G for APUs when 64GB or more host" failed to apply to 6.5-stable tree
To:     hamza.mahfooz@amd.com, alexander.deucher@amd.com,
        harry.wentland@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 15 Nov 2023 13:59:55 -0500
Message-ID: <2023111555-tingling-prideful-0e1f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 601c63ad8e551b2282e94f0a81779e9ae5c8100e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023111555-tingling-prideful-0e1f@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

601c63ad8e55 ("Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 601c63ad8e551b2282e94f0a81779e9ae5c8100e Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Fri, 8 Sep 2023 10:36:44 -0400
Subject: [PATCH] Revert "drm/amd: Disable S/G for APUs when 64GB or more host
 memory"

This reverts commit 70e64c4d522b732e31c6475a3be2349de337d321.

Since, we now have an actual fix for this issue, we can get rid of this
workaround as it can cause pin failures if enough VRAM isn't carved out
by the BIOS.

Cc: stable@vger.kernel.org # 6.1+
Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7ee49033d9da..dff0e80c5aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1315,7 +1315,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
-bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f32e8d4f3d3..3d540b0cf0e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1358,32 +1358,6 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
-/*
- * On APUs with >= 64GB white flickering has been observed w/ SG enabled.
- * Disable S/G on such systems until we have a proper fix.
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
- * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
- */
-bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
-{
-	switch (amdgpu_sg_display) {
-	case -1:
-		break;
-	case 0:
-		return false;
-	case 1:
-		return true;
-	default:
-		return false;
-	}
-	if ((totalram_pages() << (PAGE_SHIFT - 10)) +
-	    (adev->gmc.real_vram_size / 1024) >= 64000000) {
-		DRM_WARN("Disabling S/G due to >=64GB RAM\n");
-		return false;
-	}
-	return true;
-}
-
 /*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bde6b7037ba6..fc87d0565cb2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1654,8 +1654,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		break;
 	}
-	if (init_data.flags.gpu_vm_support)
-		init_data.flags.gpu_vm_support = amdgpu_sg_display_supported(adev);
+	if (init_data.flags.gpu_vm_support &&
+	    (amdgpu_sg_display == 0))
+		init_data.flags.gpu_vm_support = false;
 
 	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;

