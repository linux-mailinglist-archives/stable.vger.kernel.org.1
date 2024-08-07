Return-Path: <stable+bounces-65582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141394A9D3
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1582F287B68
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964396F312;
	Wed,  7 Aug 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oM/rK2xm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FEC54F87
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040210; cv=none; b=rKyGS1wD3rd9ZrGAb6DCkM7UnfTAMNhY1jO71j0+ITGU16OenyYHE/6w8iIQUJ59/OWyrLr+8GcRuGfVt6eVWN2b3+Bz0kF+Nd4QxdTbnZxDJcvv1whIo/Do9StKQpPzixmgS+NeE305HQXPec7sOsCau5oNWJYjNHoRrR8cYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040210; c=relaxed/simple;
	bh=mYTzCblYJ9ohGX2sSpwjJ/FZ2kMtDU/vxaXt/yzPmDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jn1smTDYieAa2tG+0bJyGOBfzI5Gm+BMDBrcKK0q8W9hPsjD8OtoNGCcM1utSTHKHOzghleEzVLQp2OHy4kd21UmREpR1lUVqFa9yAnS2eJOxkbmyqDOr1R32n1VoLDl1maD4w8yxIiS6uMAMPE1BBw2WxPq+hwmW9ATvO0IonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oM/rK2xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACDEC4AF11;
	Wed,  7 Aug 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040210;
	bh=mYTzCblYJ9ohGX2sSpwjJ/FZ2kMtDU/vxaXt/yzPmDo=;
	h=Subject:To:Cc:From:Date:From;
	b=oM/rK2xmK9eo3KUgUj+H5caJWJEU0iRN7qQshvZ5q0cIYL/78xl7yLnC3eArBMOmA
	 YlTTqUD6iQo1IHuSs7xJkJW/7bDbBwbSJwj08ETB0ts+vY8W1aqkGM5SkqYIKTqEuR
	 LOc5NVqJIZ5sXu68doAx/zJu6cPPA7pqloyg5XY8=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix locking scope when flushing tlb" failed to apply to 5.10-stable tree
To: Yunxiang.Li@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:16:40 +0200
Message-ID: <2024080740-rocklike-avert-cbfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9c33e5fd4fb63b793d9a92bf35d190630d9bada4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080740-rocklike-avert-cbfd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
08abccc9a7a7 ("drm/amdgpu: further move TLB hw workarounds a layer up")
e2e3788850b9 ("drm/amdgpu: rework lock handling for flush_tlb v2")
3983c9fd2d8b ("drm/amdgpu: drop error return from flush_gpu_tlb_pasid")
041a5743883d ("drm/amdgpu: fix and cleanup gmc_v11_0_flush_gpu_tlb_pasid")
72cc99205c0b ("drm/amdgpu: cleanup gmc_v10_0_flush_gpu_tlb_pasid")
e7b90e99fa8f ("drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb_pasid")
0c525aa40649 ("drm/amdgpu: fix and cleanup gmc_v8_0_flush_gpu_tlb_pasid")
fb4c52db6974 ("drm/amdgpu: fix and cleanup gmc_v7_0_flush_gpu_tlb_pasid")
a70cb2176f7e ("drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb v2")
24a6eb92b7f6 ("drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
6b7d211740da ("drm/amdgpu: Fix refclk reporting for SMU v13.0.6")
1b8e56b99459 ("drm/amdgpu: Restrict bootloader wait to SMUv13.0.6")
983ac45a06ae ("drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH")
822f7808291f ("drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery")
3488c79beafa ("drm/amdgpu: add initial support for UMSCH")
2da1b04a2096 ("drm/amdgpu: add UMSCH 4.0 api definition")
3ee8fb7005ef ("drm/amdgpu: enable VPE for VPE 6.1.0")
9d4346bdbc64 ("drm/amdgpu: add VPE 6.1.0 support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c33e5fd4fb63b793d9a92bf35d190630d9bada4 Mon Sep 17 00:00:00 2001
From: Yunxiang Li <Yunxiang.Li@amd.com>
Date: Thu, 23 May 2024 07:48:19 -0400
Subject: [PATCH] drm/amdgpu: fix locking scope when flushing tlb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Which method is used to flush tlb does not depend on whether a reset is
in progress or not. We should skip flush altogether if the GPU will get
reset. So put both path under reset_domain read lock.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 660599823050..322b8ff67cde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -682,12 +682,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	signed long r;
+	int r;
 	uint32_t seq;
 
-	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
-	    !down_read_trylock(&adev->reset_domain->sem)) {
+	/*
+	 * A GPU reset should flush all TLBs anyway, so no need to do
+	 * this while one is ongoing.
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
 
+	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 								 2, all_hub,
@@ -701,44 +706,41 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
-		return 0;
-	}
+		r = 0;
+	} else {
+		/* 2 dwords flush + 8 dwords fence */
+		ndw = kiq->pmf->invalidate_tlbs_size + 8;
 
-	/* 2 dwords flush + 8 dwords fence */
-	ndw = kiq->pmf->invalidate_tlbs_size + 8;
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		if (adev->gmc.flush_tlb_needs_extra_type_0)
+			ndw += kiq->pmf->invalidate_tlbs_size;
 
-	if (adev->gmc.flush_tlb_needs_extra_type_0)
-		ndw += kiq->pmf->invalidate_tlbs_size;
+		spin_lock(&adev->gfx.kiq[inst].ring_lock);
+		amdgpu_ring_alloc(ring, ndw);
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-	spin_lock(&adev->gfx.kiq[inst].ring_lock);
-	amdgpu_ring_alloc(ring, ndw);
-	if (adev->gmc.flush_tlb_needs_extra_type_2)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
+		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
+			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
 
-	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
-		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
+		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
+		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
+		if (r) {
+			amdgpu_ring_undo(ring);
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 
-	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
-	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
-	if (r) {
-		amdgpu_ring_undo(ring);
+		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		goto error_unlock_reset;
+		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+			dev_err(adev->dev, "timeout waiting for kiq fence\n");
+			r = -ETIME;
+		}
 	}
 
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
-	if (r < 1) {
-		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
-		r = -ETIME;
-		goto error_unlock_reset;
-	}
-	r = 0;
-
 error_unlock_reset:
 	up_read(&adev->reset_domain->sem);
 	return r;


