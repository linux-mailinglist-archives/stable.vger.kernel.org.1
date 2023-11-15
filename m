Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5787ECFB5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjKOTuQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjKOTuQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174512C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6647DC433C8;
        Wed, 15 Nov 2023 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077812;
        bh=VZCS0V9aPrf2liMVOlm5LGZd0gcoFXo7MRa7dHFW4Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Je6Wmgw0leW5kPL73BhxVLtfiQ8RNUIZcIef/gWZEhAUkZcyT8dCJsS2abP3RlQu4
         yL9CVGtkQDiHuOro1Qqsli6k778Y1fT0kEkCO7ok1FlpNXhXBTYdrp+tDpMwbrtuXo
         mhAl/OsMLn8yi+3AD9pcZ1FeUuN7LrSrU+TgXayU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 534/603] drm/amdgpu/gfx10,11: use memcpy_to/fromio for MQDs
Date:   Wed, 15 Nov 2023 14:17:59 -0500
Message-ID: <20231115191648.830136643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit b3c942bb6c32a8ddc1d52ee6bc24b8cf732dddf4 ]

Since they were moved to VRAM, we need to use the IO
variants of memcpy.

Fixes: 1cfb4d612127 ("drm/amdgpu: put MQDs in VRAM")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9032d7a24d7cd..306252cd67fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6457,11 +6457,11 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
@@ -6735,7 +6735,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -6758,7 +6758,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -6779,11 +6779,11 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 762d7a19f1be1..43d066bc5245b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3684,11 +3684,11 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
 		*ring->wptr_cpu_addr = 0;
@@ -3977,7 +3977,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -4000,7 +4000,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.kiq[0].mqd_backup)
-			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -4021,11 +4021,11 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 		mutex_unlock(&adev->srbm_mutex);
 
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
 		/* restore MQD to a clean status */
 		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset ring buffer */
 		ring->wptr = 0;
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
-- 
2.42.0



