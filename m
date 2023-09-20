Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07947A7C2B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjITL6q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjITL6q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64068B0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:58:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DDDC433C8;
        Wed, 20 Sep 2023 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211120;
        bh=l/Wl4Se3Vq67bnZu5N2XwPzsBK1S1LImbCZD7hwEaXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jF0JlpR9sr9/1mp3xBg2z+Ohx1P/tfa26dThrwO2IAuM2QTn0LhonNGEhwfJHBTiw
         3NG99ppiycKRDbQb5QIuG8IWYpUJHQWVJ3T8ezXkownAW6i/OdYEsCj0Fd0lLiJ3Qd
         dKksrAQapBYEqn/Ir4zqxvCSx4ZvmzOfrtpT9LuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 6.1 116/139] Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"
Date:   Wed, 20 Sep 2023 13:30:50 +0200
Message-ID: <20230920112839.887603968@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 169ed4ece8373f02f10642eae5240e3d1ef5c038 upstream.

This reverts commit 70e64c4d522b732e31c6475a3be2349de337d321.

Since, we now have an actual fix for this issue, we can get rid of this
workaround as it can cause pin failures if enough VRAM isn't carved out
by the BIOS.

Cc: stable@vger.kernel.org # 6.1+
Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |   26 ----------------------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    5 ++--
 3 files changed, 3 insertions(+), 29 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1266,7 +1266,6 @@ int amdgpu_device_gpu_recover(struct amd
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
-bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
 bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1337,32 +1337,6 @@ bool amdgpu_device_need_post(struct amdg
 }
 
 /*
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
-/*
  * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
  * speed switching. Until we have confirmation from Intel that a specific host
  * supports it, it's safer that we keep it disabled for all.
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1634,8 +1634,9 @@ static int amdgpu_dm_init(struct amdgpu_
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


