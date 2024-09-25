Return-Path: <stable+bounces-77501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A03985DD9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440322896C2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78413205708;
	Wed, 25 Sep 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPWfHMe9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACD2056E8;
	Wed, 25 Sep 2024 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266052; cv=none; b=qyj8xMSwDsf6de735m5cIZFBEnebq/+Au2Dt52l2E2UoHLjpjOTCk04/erz+Qn9DsgV611lr5Xl9f6Rbb6NETcB+0EZ+MkaORzhb2GA5sq7hqhYWpCxAxsV/JST89TCOQjg9tK+x6ZvDjatdk+KBTGc9rfQz9oV53oXZPqweulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266052; c=relaxed/simple;
	bh=LZFArz61I3bOyAfe/aCGyh4ciDiv1aeLyIAFGHdeI7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwaUTQ+v/ZN3qnZ0X6mBe6PSAtI2pfUw3r2nVGHaftAzVaExkQSNglWQmqm9pjNLQ4S6sovYg9jITTz8/MKqo0Y3viv9G0TDXWYNMK437mWnjjZxNo935/tD/QbRTrV+7+djmK639dPYxvinuLUCz5bh73R+C9Zv2tZzWlbmg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPWfHMe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87059C4CEC7;
	Wed, 25 Sep 2024 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266052;
	bh=LZFArz61I3bOyAfe/aCGyh4ciDiv1aeLyIAFGHdeI7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPWfHMe9EI0Qk5z/kXNP9LQ8+D28A3fd2gKx9aseeiUQeTXwhVf3VodfvmSh4yNN8
	 qgcLQwHK+/l6/HVHfhZADi2kG4iZWcmrK+bu18dZZ37LW75NTXHpZFt4yM2E02tiWz
	 nkxpGX7mjW9zCxgDnPW7lINDLG7Flf/nSiIK6LPQHLML9pO+xMdsAPnKN8HbZ4Q5x2
	 g219rbNUNdQyMoLZDOXt5sGlHQSwH9eJ25bw4GWOpCCG/NEBX0GId46tF0P6jGkD9D
	 EV4no7wQUUq/ESJNMjvwkG84oAW19gUuBZy3uAlgK4kXdPLFTgN3IIjWABChbiFNJM
	 iV7Nu9jD6r8Pg==
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
	Harish.Kasiviswanathan@amd.com,
	Jane.Jian@amd.com,
	tao.zhou1@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 156/197] drm/amdgpu/gfx9: properly handle error ints on all pipes
Date: Wed, 25 Sep 2024 07:52:55 -0400
Message-ID: <20240925115823.1303019-156-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 0594eab666a9b..b278453cad6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2477,7 +2477,7 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	if(adev->gfx.num_gfx_rings)
+	if (adev->gfx.num_gfx_rings)
 		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
@@ -5772,17 +5772,59 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
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
index f5b9f443cfdd7..2564a003526ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2824,21 +2824,63 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
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


