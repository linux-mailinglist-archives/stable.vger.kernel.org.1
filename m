Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2F726F7A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjFGU6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjFGU6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932202704
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5939664897
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F4AC4339E;
        Wed,  7 Jun 2023 20:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171497;
        bh=DDiRZT+lhoJRCrykjUTKJl+KRdSdzaSx/4CHCnBxGV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjwPa4ZwdA00ytHhNulFtzSv69QDqzx3c0kljgE2aSUeu6C4UC/F5ihfh1fv5mDK+
         kysnhaeqKF91eiiiQ6QXn9nOX3an6KTZ12LW9L8krD+mryqcRC/IoRdL0OkZLsa9lw
         Nh+jQqCeIRDq1o55ARi5RMVt1/+TH2xDunjeRB1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chong Li <chongli2@amd.com>,
        JingWen.Chen2@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 040/159] drm/amdgpu: release gpu full access after "amdgpu_device_ip_late_init"
Date:   Wed,  7 Jun 2023 22:15:43 +0200
Message-ID: <20230607200904.986224114@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Chong Li <chongli2@amd.com>

[ Upstream commit 38eecbe086a4e52f54b2bbda8feba65d44addbef ]

[WHY]
 Function "amdgpu_irq_update()" called by "amdgpu_device_ip_late_init()" is an atomic context.
 We shouldn't access registers through KIQ since "msleep()" may be called in "amdgpu_kiq_rreg()".

[HOW]
 Move function "amdgpu_virt_release_full_gpu()" after function "amdgpu_device_ip_late_init()",
 to ensure that registers be accessed through RLCG instead of KIQ.

Call Trace:
  <TASK>
  show_stack+0x52/0x69
  dump_stack_lvl+0x49/0x6d
  dump_stack+0x10/0x18
  __schedule_bug.cold+0x4f/0x6b
  __schedule+0x473/0x5d0
  ? __wake_up_klogd.part.0+0x40/0x70
  ? vprintk_emit+0xbe/0x1f0
  schedule+0x68/0x110
  schedule_timeout+0x87/0x160
  ? timer_migration_handler+0xa0/0xa0
  msleep+0x2d/0x50
  amdgpu_kiq_rreg+0x18d/0x1f0 [amdgpu]
  amdgpu_device_rreg.part.0+0x59/0xd0 [amdgpu]
  amdgpu_device_rreg+0x3a/0x50 [amdgpu]
  amdgpu_sriov_rreg+0x3c/0xb0 [amdgpu]
  gfx_v10_0_set_gfx_eop_interrupt_state.constprop.0+0x16c/0x190 [amdgpu]
  gfx_v10_0_set_eop_interrupt_state+0xa5/0xb0 [amdgpu]
  amdgpu_irq_update+0x53/0x80 [amdgpu]
  amdgpu_irq_get+0x7c/0xb0 [amdgpu]
  amdgpu_fence_driver_hw_init+0x58/0x90 [amdgpu]
  amdgpu_device_init.cold+0x16b7/0x2022 [amdgpu]

Signed-off-by: Chong Li <chongli2@amd.com>
Reviewed-by: JingWen.Chen2@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b0d9c47cc3813..9da85ef711e88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2509,8 +2509,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_release_full_gpu(adev, true);
 
 	return r;
 }
@@ -3755,18 +3753,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
-		/* failed in exclusive mode due to timeout */
-		if (amdgpu_sriov_vf(adev) &&
-		    !amdgpu_sriov_runtime(adev) &&
-		    amdgpu_virt_mmio_blocked(adev) &&
-		    !amdgpu_virt_wait_reset(adev)) {
-			dev_err(adev->dev, "VF exclusive mode timeout\n");
-			/* Don't send request since VF is inactive. */
-			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
-			adev->virt.ops = NULL;
-			r = -EAGAIN;
-			goto release_ras_con;
-		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
 		goto release_ras_con;
@@ -3845,8 +3831,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_virt_release_full_gpu(adev, true);
 		flush_delayed_work(&adev->delayed_init_work);
+	}
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
@@ -3881,6 +3869,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_release_full_gpu(adev, true);
+
+	/* failed in exclusive mode due to timeout */
+	if (amdgpu_sriov_vf(adev) &&
+		!amdgpu_sriov_runtime(adev) &&
+		amdgpu_virt_mmio_blocked(adev) &&
+		!amdgpu_virt_wait_reset(adev)) {
+		dev_err(adev->dev, "VF exclusive mode timeout\n");
+		/* Don't send request since VF is inactive. */
+		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
+		adev->virt.ops = NULL;
+		r = -EAGAIN;
+	}
 	amdgpu_release_ras_context(adev);
 
 failed:
-- 
2.39.2



