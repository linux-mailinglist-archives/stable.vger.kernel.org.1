Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33670C787
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjEVTag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjEVTaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A589C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DDD628F9
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F67CC433EF;
        Mon, 22 May 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783834;
        bh=Iemrj4gObI7ce+EINspKkfs3V/6eQYXZEm+BfzogVaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQCh8DTYlZ5guKUMO6pB9+Oiq8vLMiVyNX4OP3v7v2m8s4X7h/WIUWOaTFLk9s0/j
         0fiLuetMz8yQCUsziGM77L/R7LQI7jqaKHtXmEujudFSB9QY9LaaP/Xe0EQ6H1213w
         7AtLV1oq3yKuaNicqBxeOIZebCGVOJYFm5+Wce3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 150/292] drm/amdgpu: drop gfx_v11_0_cp_ecc_error_irq_funcs
Date:   Mon, 22 May 2023 20:08:27 +0100
Message-Id: <20230522190409.711614283@linuxfoundation.org>
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

From: Horatio Zhang <Hongkun.Zhang@amd.com>

[ Upstream commit 720b47229a5b24061d1c2e29ddb6043a59178d79 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 3380daf42da8a..b803e785d3aff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -683,9 +683,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
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
-- 
2.39.2



