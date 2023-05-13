Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6F70151A
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjEMHm4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 03:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjEMHmz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 03:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A66184
        for <stable@vger.kernel.org>; Sat, 13 May 2023 00:42:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2350C61C1E
        for <stable@vger.kernel.org>; Sat, 13 May 2023 07:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB60FC433EF;
        Sat, 13 May 2023 07:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683963773;
        bh=riqZgnYnI0JHSUsm9xtf567cS6nlh6g9TvoGh0Nh0Zc=;
        h=Subject:To:Cc:From:Date:From;
        b=pagv4gL60vEFLmJUB8KnvHAQC4jVtYmqPUvG6PGFQUF2sm8TKFlLo/b95H3jlhq0F
         n2X0WZ8gvP9De5NBuGFeXKn3ig+AIXMCYpfRThaqa+hyflh33B+F6UmhELCWW+Mvb5
         6dxtyiUOGYuVIbnhHZGWWmTVPMAis0Oqy43+y7nw=
Subject: FAILED: patch "[PATCH] drm/amd/pm: parse pp_handle under appropriate conditions" failed to apply to 5.15-stable tree
To:     guchun.chen@amd.com, alexander.deucher@amd.com,
        mario.limonciello@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 13 May 2023 16:23:15 +0900
Message-ID: <2023051315-stinging-unwell-cc5d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 58d9b9a14b47c2a3da6effcbb01607ad7edc0275
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051315-stinging-unwell-cc5d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

58d9b9a14b47 ("drm/amd/pm: parse pp_handle under appropriate conditions")
ebfc253335af ("drm/amd/pm: do not expose the smu_context structure used internally in power")
d698a2c4859d ("drm/amd/pm: move pp_force_state_enabled member to amdgpu_pm structure")
13f5dbd6e3d9 ("drm/amd/pm: do not expose power implementation details to display")
79c65f3fcbb1 ("drm/amd/pm: do not expose power implementation details to amdgpu_pm.c")
bc143d8b8387 ("drm/amd/pm: do not expose implementation details to other blocks out of power")
4da8b63944a4 ("drm/amdgpu: Send Message to SMU on aldebaran passthrough for sbr handling")
f296a0bcc961 ("drm/amd/pm: skip setting gfx cgpg in the s0ix suspend-resume")
7e31a8585b79 ("drm/amdgpu: move smu_debug_mask to a more proper place")
6ff7fddbd120 ("drm/amdgpu: add support for SMU debug option")
1f5fc7a50955 ("drm/amd/pm: Add debugfs info for STB")
79aae67ef8bb ("drm/amd/pm: Add STB accessors interface")
fdcb279d5b79 ("drm/amdgpu: query umc error info from ecc_table v2")
edd794208555 ("drm/amd/pm: add message smu to get ecc_table v2")
3ebd8bf02380 ("drm/amdgpu: support new mode-1 reset interface (v2)")
6c08e0ef87b8 ("drm/amd/pm: avoid duplicate powergate/ungate setting")
56c5977eae87 ("drm/amdkfd: replace/remove remaining kgd_dev references")
c531a58bb61b ("drm/amdkfd: replace kgd_dev in static gfx v10_3 funcs")
4056b0337746 ("drm/amdkfd: replace kgd_dev in static gfx v10 funcs")
9a17c9b79b4d ("drm/amdkfd: replace kgd_dev in static gfx v9 funcs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58d9b9a14b47c2a3da6effcbb01607ad7edc0275 Mon Sep 17 00:00:00 2001
From: Guchun Chen <guchun.chen@amd.com>
Date: Fri, 5 May 2023 13:20:11 +0800
Subject: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions

amdgpu_dpm_is_overdrive_supported is a common API across all
asics, so we should cast pp_handle into correct structure
under different power frameworks.

v2: using return directly to simplify code
v3: SI asic does not carry od_enabled member in pp_handle, and update Fixes tag

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
Fixes: eb4900aa4c49 ("drm/amdgpu: Fix kernel NULL pointer dereference in dpm functions")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 300e156b924f..86246f69dbe1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1460,15 +1460,21 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
+
+		return (smu->od_enabled || smu->is_apu);
+	} else {
+		struct pp_hwmgr *hwmgr;
 
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+		/* SI asic does not carry od_enabled */
+		if (adev->family == AMDGPU_FAMILY_SI)
+			return false;
 
-	return false;
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,

