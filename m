Return-Path: <stable+bounces-77289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192D985B78
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC73286B32
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA00198838;
	Wed, 25 Sep 2024 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc3DUeMl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC315C158;
	Wed, 25 Sep 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264999; cv=none; b=ZGBLYbAvJc9JskG+48haVFGRHT/HttIk04q4BdVVXpCEdk/d2p502+TIYrBUSpC4VQqgcGgwVx0es5NAbVydS2YLeMWB7zKVxnHtlpoJHzyvL2CtnjTzJqMX9gU7Eb/XclMLP2XaWEit3XL3rW9gCCBdF816uP7sBSuEJNdLmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264999; c=relaxed/simple;
	bh=lPibLbkagehAdvgsooMIpVd2FK62BwRWgTYpAj12wDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK9B3ivVU35tA6/nWXQgiRPxmv2+jD9Z3AM7uRFzD6nFu+pk6sow29uncdP+ndoYc56bVb8hCAOigw+AO3DDoPGPusuUnyP09l9JNY2zTDMKnYazjmeFUEaeNIXPwfxfPmamcqJIQvlG98Oov+OH7dBiQbtjgDMBM1WM+hXnx6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc3DUeMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC39C4CECD;
	Wed, 25 Sep 2024 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264998;
	bh=lPibLbkagehAdvgsooMIpVd2FK62BwRWgTYpAj12wDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc3DUeMloL0DMeEbmKjxgsLqbhdzQoJNsyvvxXqMhcPqHkIh/OYvpLm9d4JhpcvSk
	 ul5Zg4wLQArC3pgT/GSKsNAUPv5ogzMk6/6+0ZOtSouF1aYiPhlQjsN1OXpPZSKcEh
	 5a1eBj1B3EntGAgW3yOpdYElUUuPZRU9u064tUGtZXrJEraQxdlSbXmzOHZorbFAE4
	 u9K/UquuRMHTJQJ0tBiWUNL2/ijripCSlsYxL3rkuZ4ElQwDgGbKpgazaHttDZ2akq
	 an6VhrW9p2Rzrd/6W2UVetWSLoINHh7tD76jTWe/D+r0l5EJP7wBlINZLYplBBLpGX
	 WvZ91Bf5/Yw8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	liupeng01@kylinos.cn,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	victorchengchi.lu@amd.com,
	tao.zhou1@amd.com,
	Jane.Jian@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 191/244] drm/amdgpu/gfx9: properly handle error ints on all pipes
Date: Wed, 25 Sep 2024 07:26:52 -0400
Message-ID: <20240925113641.1297102-191-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 48695573d2feaf42812c1ad54e01caff0d1c2d71 ]

Need to handle the interrupt enables for all pipes.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 44 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 50 +++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fc4153a87f947..7d517c94c3efb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2638,7 +2638,7 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	if(adev->gfx.num_gfx_rings)
+	if (adev->gfx.num_gfx_rings)
 		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
@@ -5933,17 +5933,59 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 	}
 }
 
+static u32 gfx_v9_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int me, int pipe)
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
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_REG_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v9_0_get_cpc_int_cntl(adev, i + 1, j);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 20ea6cb01edfd..d95f9a84f97b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2886,21 +2886,63 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 	}
 }
 
+static u32 gfx_v9_4_3_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int xcc_id, int me, int pipe)
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
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
-	int i, num_xcc;
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < num_xcc; i++)
+		for (i = 0; i < num_xcc; i++) {
 			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
-				PRIV_REG_INT_ENABLE,
-				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					      PRIV_REG_INT_ENABLE,
+					      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+			for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					/* MECs start at 1 */
+					mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+					if (mec_int_cntl_reg) {
+						mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+						mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+									     PRIV_REG_INT_ENABLE,
+									     state == AMDGPU_IRQ_STATE_ENABLE ?
+									     1 : 0);
+						WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+					}
+				}
+			}
+		}
 		break;
 	default:
 		break;
-- 
2.43.0


