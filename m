Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F22703560
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbjEOQ6Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243274AbjEOQ6X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4572768E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1F5862A39
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00095C433D2;
        Mon, 15 May 2023 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169899;
        bh=eG/No02p96U9z755qMZ6ksiz0GF+P1LV3U3MupKXbaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfbDp2pQn+l8C6BedJYVIf7wfIIZePKvZctQV/iyQq4+ypIJMm/80sX/0OqTLBg+L
         /AQvBVKHcmF2vY0bBTgZv4nxD7PF4NzHd6JlErQNLilbMpasjTQP2AJMd6nvbbRXXz
         5pAHu4AUPXzCbuMz6OZplSIwmt6wyWaKo0aXca5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 206/246] drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs
Date:   Mon, 15 May 2023 18:26:58 +0200
Message-Id: <20230515161728.785440289@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Horatio Zhang <Hongkun.Zhang@amd.com>

commit 720b47229a5b24061d1c2e29ddb6043a59178d79 upstream.

The gfx.cp_ecc_error_irq is retired in gfx11. In gfx_v11_0_hw_fini still
use amdgpu_irq_put to disable this interrupt, which caused the call trace
in this function.

[  102.873958] Call Trace:
[  102.873959]  <TASK>
[  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu]
[  102.874019]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
[  102.874072]  amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu]
[  102.874122]  amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu]
[  102.874172]  amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu]
[  102.874223]  amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu]
[  102.874321]  amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu]
[  102.874375]  process_one_work+0x21f/0x3f0
[  102.874377]  worker_thread+0x200/0x3e0
[  102.874378]  ? process_one_work+0x3f0/0x3f0
[  102.874379]  kthread+0xfd/0x130
[  102.874380]  ? kthread_complete_and_exit+0x20/0x20
[  102.874381]  ret_from_fork+0x22/0x30

v2:
- Handle umc and gfx ras cases in separated patch
- Retired the gfx_v11_0_cp_ecc_error_irq_funcs in gfx11

v3:
- Improve the subject and code comments
- Add judgment on gfx11 in the function of amdgpu_gfx_ras_late_init

v4:
- Drop the define of CP_ME1_PIPE_INST_ADDR_INTERVAL and
SET_ECC_ME_PIPE_STATE which using in gfx_v11_0_set_cp_ecc_error_state
- Check cp_ecc_error_irq.funcs rather than ip version for a more
sustainable life

v5:
- Simplify judgment conditions

Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |    8 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   46 --------------------------------
 2 files changed, 5 insertions(+), 49 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -686,9 +686,11 @@ int amdgpu_gfx_ras_late_init(struct amdg
 		if (r)
 			return r;
 
-		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
-		if (r)
-			goto late_fini;
+		if (adev->gfx.cp_ecc_error_irq.funcs) {
+			r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
+			if (r)
+				goto late_fini;
+		}
 	} else {
 		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1313,13 +1313,6 @@ static int gfx_v11_0_sw_init(void *handl
 	if (r)
 		return r;
 
-	/* ECC error */
-	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
-				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
-				  &adev->gfx.cp_ecc_error_irq);
-	if (r)
-		return r;
-
 	/* FED error */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
 				  GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
@@ -4442,7 +4435,6 @@ static int gfx_v11_0_hw_fini(void *handl
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
@@ -5882,36 +5874,6 @@ static void gfx_v11_0_set_compute_eop_in
 	}
 }
 
-#define CP_ME1_PIPE_INST_ADDR_INTERVAL  0x1
-#define SET_ECC_ME_PIPE_STATE(reg_addr, state) \
-	do { \
-		uint32_t tmp = RREG32_SOC15_IP(GC, reg_addr); \
-		tmp = REG_SET_FIELD(tmp, CP_ME1_PIPE0_INT_CNTL, CP_ECC_ERROR_INT_ENABLE, state); \
-		WREG32_SOC15_IP(GC, reg_addr, tmp); \
-	} while (0)
-
-static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
-							struct amdgpu_irq_src *source,
-							unsigned type,
-							enum amdgpu_interrupt_state state)
-{
-	uint32_t ecc_irq_state = 0;
-	uint32_t pipe0_int_cntl_addr = 0;
-	int i = 0;
-
-	ecc_irq_state = (state == AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
-
-	pipe0_int_cntl_addr = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
-
-	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0, CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
-
-	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
-		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i * CP_ME1_PIPE_INST_ADDR_INTERVAL,
-					ecc_irq_state);
-
-	return 0;
-}
-
 static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    struct amdgpu_irq_src *src,
 					    unsigned type,
@@ -6329,11 +6291,6 @@ static const struct amdgpu_irq_src_funcs
 	.process = gfx_v11_0_priv_inst_irq,
 };
 
-static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_funcs = {
-	.set = gfx_v11_0_set_cp_ecc_error_state,
-	.process = amdgpu_gfx_cp_ecc_error_irq,
-};
-
 static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs = {
 	.process = gfx_v11_0_rlc_gc_fed_irq,
 };
@@ -6349,9 +6306,6 @@ static void gfx_v11_0_set_irq_funcs(stru
 	adev->gfx.priv_inst_irq.num_types = 1;
 	adev->gfx.priv_inst_irq.funcs = &gfx_v11_0_priv_inst_irq_funcs;
 
-	adev->gfx.cp_ecc_error_irq.num_types = 1; /* CP ECC error */
-	adev->gfx.cp_ecc_error_irq.funcs = &gfx_v11_0_cp_ecc_error_irq_funcs;
-
 	adev->gfx.rlc_gc_fed_irq.num_types = 1; /* 0x80 FED error */
 	adev->gfx.rlc_gc_fed_irq.funcs = &gfx_v11_0_rlc_gc_fed_irq_funcs;
 


