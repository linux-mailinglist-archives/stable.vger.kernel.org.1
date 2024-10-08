Return-Path: <stable+bounces-82337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826C994C5F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AFB25232
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7B1DEFE1;
	Tue,  8 Oct 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5sC3anC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3F1DEFC9;
	Tue,  8 Oct 2024 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391921; cv=none; b=ctMB4tfmuI71UdOidEkm34vvm8LokoMAglXzardC1FktnmZjtu9d+88u9QM2AgaEEcx/bKjHpbh/IjoZJZb2Bneam+1dytHNwy6uKdt6I63kSAvKcx7RKULPcHC7o3Y6ntvAgBrQGkhczzIYIw/bCW0Xxqtxl2b7P8z2ICfDSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391921; c=relaxed/simple;
	bh=6lhtmG6Ae+rd7YXCLgSRtv39cyLsNY0nO01FsbtIZq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9Qqn0j6lB4LF+bexSSbgAN1p1RitdHEVtQ2jdAbyISSs3Ia7H95w4Enxh8lcdTVRzEc4f4ugnpiq6GdLOPLKoJIqG01UOYeIh4qTOynSRt1c7ad4Js6tYAoH9tyxnibKoG4I1n3cuhRoXKbG9Vg2HZl5gN3TWkDH+mCahetdWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5sC3anC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D9BC4CECC;
	Tue,  8 Oct 2024 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391921;
	bh=6lhtmG6Ae+rd7YXCLgSRtv39cyLsNY0nO01FsbtIZq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5sC3anCTiKpdoNmeegkGZcwUc58+20AfAYQ89GE+XeJpKJt81H9RFnitgsOhla0j
	 ByFCSFTXS6ot9cyNgSePx4yXaNb2RrrAgcAOlxLoZZI/Z1t3BhAijIazqTR9W71Lxc
	 auWshKcpN1KAYJYq2V3TK/k+myhQlx5F7dHPv3wk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 262/558] drm/amdgpu/gfx12: properly handle error ints on all pipes
Date: Tue,  8 Oct 2024 14:04:52 +0200
Message-ID: <20241008115712.644222233@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 39879321769cc2d9a690725959ef76af92a38ac1 ]

Need to handle the interrupt enables for all pipes.

v2: fix indexing (Jessie)

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 130 ++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 34b95ca700b23..ac671656069a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1690,26 +1690,68 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	gfx_v12_0_init_compute_vmid(adev);
 }
 
+static u32 gfx_v12_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v12_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE1_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static void gfx_v12_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
-						bool enable)
+					       bool enable)
 {
-	u32 tmp;
+	u32 tmp, cp_int_cntl_reg;
+	int i, j;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0);
-
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
-			    enable ? 1 : 0);
-
-	WREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0, tmp);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+			if (cp_int_cntl_reg) {
+				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
+						    enable ? 1 : 0);
+				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
+			}
+		}
+	}
 }
 
 static int gfx_v12_0_init_csb(struct amdgpu_device *adev)
@@ -4755,15 +4797,42 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
-					      unsigned type,
+					      unsigned int type,
 					      enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-				      PRIV_REG_INT_ENABLE,
-				      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v12_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -4774,15 +4843,28 @@ static int gfx_v12_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
 static int gfx_v12_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
-					       unsigned type,
+					       unsigned int type,
 					       enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_INSTR_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v12_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_INSTR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -4806,8 +4888,8 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 	case 0:
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
 		}
 		break;
-- 
2.43.0




