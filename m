Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D961701504
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEMHjt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMHjs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BF35B5
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9003761A39
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21752C433D2;
        Sat, 13 May 2023 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963586;
        bh=HV6apRy0+L+iBl4+Zeq94o0GpNF/3icKXZ4BDtH2BbQ=;
        h=Subject:To:Cc:From:Date:From;
        b=YMIzPbJ9NXDZcxRfslXgvk9d/JiV2jzHxq0/Cd/8rOnTKN3BK76g7vF8TssWLEx1m
         ib94lSgRG1bOwzXWBSp22SyXEthnCc8XIZz4grrMDfCHJtMEVYU/VIkngnURBrol0N
         zhjXMn+BjJjcf9xoqJMMSjljIUQJ1Uqy+VQ2prNU=
Subject: FAILED: patch "[PATCH] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken" failed to apply to 6.3-stable tree
To:     gpiccoli@igalia.com, James.Zhu@amd.com, alexander.deucher@amd.com,
        leo.liu@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:20:38 +0900
Message-ID: <2023051338-handshake-extrude-e64c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1aff0a5d71d23be6658f893c88c6a9791202bcb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051338-handshake-extrude-e64c@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

1aff0a5d71d2 ("drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken BIOSes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aff0a5d71d23be6658f893c88c6a9791202bcb1 Mon Sep 17 00:00:00 2001
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Date: Sun, 12 Mar 2023 13:51:00 -0300
Subject: [PATCH] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh broken
 BIOSes

The VCN firmware loading path enables the indirect SRAM mode if it's
advertised as supported. We might have some cases of FW issues that
prevents this mode to working properly though, ending-up in a failed
probe. An example below, observed in the Steam Deck:

[...]
[drm] failed to load ucode VCN0_RAM(0x3A)
[drm] psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF0000)
amdgpu 0000:04:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
[drm:amdgpu_device_init.cold [amdgpu]] *ERROR* hw_init of IP block <vcn_v3_0> failed -110
amdgpu 0000:04:00.0: amdgpu: amdgpu_device_ip_init failed
amdgpu 0000:04:00.0: amdgpu: Fatal error during GPU init
[...]

Disabling the VCN block circumvents this, but it's a very invasive
workaround that turns off the entire feature. So, let's add a quirk
on VCN loading that checks for known problematic BIOSes on Vangogh,
so we can proactively disable the indirect SRAM mode and allow the
HW proper probe and VCN IP block to work fine.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2385
Fixes: 82132ecc5432 ("drm/amdgpu: enable Vangogh VCN indirect sram mode")
Cc: stable@vger.kernel.org
Cc: James Zhu <James.Zhu@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 0b1980ac4098..e63fcc58e8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -26,6 +26,7 @@
 
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/debugfs.h>
 #include <drm/drm_drv.h>
@@ -114,6 +115,24 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 		adev->vcn.indirect_sram = true;
 
+	/*
+	 * Some Steam Deck's BIOS versions are incompatible with the
+	 * indirect SRAM mode, leading to amdgpu being unable to get
+	 * properly probed (and even potentially crashing the kernel).
+	 * Hence, check for these versions here - notice this is
+	 * restricted to Vangogh (Deck's APU).
+	 */
+	if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 0, 2)) {
+		const char *bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
+
+		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
+		     !strncmp("F7A0114", bios_ver, 7))) {
+			adev->vcn.indirect_sram = false;
+			dev_info(adev->dev,
+				"Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
+		}
+	}
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 

