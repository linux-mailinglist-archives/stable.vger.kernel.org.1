Return-Path: <stable+bounces-140506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E1AAA972
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0951188926C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087F27E1BC;
	Mon,  5 May 2025 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBK/GiJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56C2777FD;
	Mon,  5 May 2025 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485008; cv=none; b=iADIgfiha+ozAj2vGLhf51fp/KfFhO8jDW25ZibSrFNdAp+ADntnhncwGYm6i09jrOvX3FynUWel7yZqsFOZNP6KyjayyZFzgcm17tPuHnK4MQAUwNfVcHJBmQYxJfrn2sYg7yfhNQl5Ye5OlJeG2MRpm3eJDdhvoKlH221RGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485008; c=relaxed/simple;
	bh=6UGNE9vNQ2U0ZSBt3Uj0ajyLGZ/nnFCOEwgbf+opl6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TE62StFjDie3ROho1313kZbM7R6py59XYofS4DQywWZDZWct9QbptoeNozx9zSqsv/YGVIYExeZX3679KWX+29nQu5xyoLx39dQH8xwQHPxlkR7WimMFgh2zd7ZpJITvyiw4W/oqI0QyYSztn/ah1vgBZVyOoNcJ9dVhrN6EY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBK/GiJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2DBC4CEE4;
	Mon,  5 May 2025 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485008;
	bh=6UGNE9vNQ2U0ZSBt3Uj0ajyLGZ/nnFCOEwgbf+opl6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBK/GiJIvK/TPMgwd10C+13fvT9HolLQDbZW0rxQ7Jykj5AKryCnSyXlDBj9Pz/zx
	 nRtq+VR/lqPiagpb6p2mfzzZd1WqBxDLNwO0mdKma9Su8HVho/u9DU1dPyirBwivO4
	 b9TcUuRg9yl6NAd25bHKDZc6RMc3CU8kKKBhKZvfAwiivzehJ/taqrPHqiJd7SoNCn
	 UcN7IkRsfT1RYWy+fZmnk8oBhsEEUuStJYBGR7tlyed1n3oz5aZSOE2+ejgIegrPel
	 /MKQ8iIjynTt9zJsYMAmgwphyQv3kWQeLQm5npwnvhiWLG4vjVvGd1Q4iA/yhIt7S6
	 tlFdH5PURzCvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Mukul Joshi <mukul.joshi@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	vitaly.prosyak@amd.com,
	srinivasan.shanmugam@amd.com,
	tim.huang@amd.com,
	Jesse.zhang@amd.com,
	Prike.Liang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 121/486] drm/amdgpu/gfx11: don't read registers in mqd init
Date: Mon,  5 May 2025 18:33:17 -0400
Message-Id: <20250505223922.2682012-121-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit e27b36ea6ba5f29e91fcfb375ea29503708fcf43 ]

Just use the default values.  There's not need to
get the value from hardware and it could cause problems
if we do that at runtime and gfxoff is active.

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 47 ++++++++++++++++++--------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0357fea8ae1df..1f06b22dbe7c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -63,6 +63,23 @@
 #define regPC_CONFIG_CNTL_1		0x194d
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
+#define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
+#define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
+#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
+#define regCP_GFX_HQD_QUANTUM_DEFAULT                                             0x00000a01
+#define regCP_GFX_HQD_CNTL_DEFAULT                                                0x00a00000
+#define regCP_RB_DOORBELL_CONTROL_DEFAULT                                         0x00000000
+#define regCP_GFX_HQD_RPTR_DEFAULT                                                0x00000000
+
+#define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000006
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_MQD_CONTROL_DEFAULT                                                 0x00000100
+#define regCP_HQD_PQ_CONTROL_DEFAULT                                              0x00308509
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_HQD_PQ_RPTR_DEFAULT                                                 0x00000000
+#define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be05501
+#define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00300000
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
@@ -3896,7 +3913,7 @@ static void gfx_v11_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
 	if (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		priority = 1;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, priority);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 }
@@ -3918,14 +3935,14 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set up mqd control */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
+	tmp = regCP_GFX_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
 	mqd->cp_gfx_mqd_control = tmp;
 
 	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+	tmp = regCP_GFX_HQD_VMID_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
 	mqd->cp_gfx_hqd_vmid = 0;
 
@@ -3933,7 +3950,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	gfx_v11_0_gfx_mqd_set_priority(adev, mqd, prop);
 
 	/* set up time quantum */
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
+	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
 	mqd->cp_gfx_hqd_quantum = tmp;
 
@@ -3955,7 +3972,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 
 	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
 	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
-	tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
+	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
 #ifdef __BIG_ENDIAN
@@ -3964,7 +3981,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_gfx_hqd_cntl = tmp;
 
 	/* set up cp_doorbell_control */
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+	tmp = regCP_RB_DOORBELL_CONTROL_DEFAULT;
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
 				    DOORBELL_OFFSET, prop->doorbell_index);
@@ -3976,7 +3993,7 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_rb_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
+	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
 
 	/* active the queue */
 	mqd->cp_gfx_hqd_active = 1;
@@ -4062,14 +4079,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
 
 	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL);
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
 			(order_base_2(GFX11_MEC_HPD_SIZE / 4) - 1));
 
 	mqd->cp_hqd_eop_control = tmp;
 
 	/* enable doorbell? */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 
 	if (prop->use_doorbell) {
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
@@ -4098,7 +4115,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
 
 	/* set MQD vmid to 0 */
-	tmp = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	tmp = regCP_MQD_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
 	mqd->cp_mqd_control = tmp;
 
@@ -4108,7 +4125,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
 
 	/* set up the HQD, this is similar to CP_RB0_CNTL */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL);
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
@@ -4134,7 +4151,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	tmp = 0;
 	/* enable the doorbell if requested */
 	if (prop->use_doorbell) {
-		tmp = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				DOORBELL_OFFSET, prop->doorbell_index);
 
@@ -4149,17 +4166,17 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	mqd->cp_hqd_pq_doorbell_control = tmp;
 
 	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
-	mqd->cp_hqd_pq_rptr = RREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR);
+	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
 
 	/* set the vmid for the queue */
 	mqd->cp_hqd_vmid = 0;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE);
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x55);
 	mqd->cp_hqd_persistent_state = tmp;
 
 	/* set MIN_IB_AVAIL_SIZE */
-	tmp = RREG32_SOC15(GC, 0, regCP_HQD_IB_CONTROL);
+	tmp = regCP_HQD_IB_CONTROL_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);
 	mqd->cp_hqd_ib_control = tmp;
 
-- 
2.39.5


