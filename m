Return-Path: <stable+bounces-140221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041CAAA63B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CE5166855
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351228F942;
	Mon,  5 May 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2hizHr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0F27B512;
	Mon,  5 May 2025 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484418; cv=none; b=um2ngH0LgrjgH1mH+pwgH64rK2SnQW/70OGppo/PIiYkzMchAqJc/GjRXLbJW5vjG1IBBZFLO9WvZjv8RKzaj8Nvp0vGUKKQAmmp+68GH9xl9o9J1AGd9rcWW3H79x56WV3oet9dHJSbkf6MsC7CCa7Dq59MbvoUN1xPCjGgktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484418; c=relaxed/simple;
	bh=AEY/lwKxlfTN5+V+VSlk+xRWGzvVARxsOuxzbKhA3BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRQXwJ2t4hoBah6f72oInCvSSqqOwB2AzH9HYisG9qSBz4xXyRYbg5Eppbdq5xwboziX3DE7wN7KKN8S4uKY+scfLniBpQkDKPn2iB0fQ4HymzQnZHYOGshQtmY0tM8MvaKCHgpKEEQlHVSoar56BTR1qI3vN+UDKPX/s0vVyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2hizHr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A303C4CEE4;
	Mon,  5 May 2025 22:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484417;
	bh=AEY/lwKxlfTN5+V+VSlk+xRWGzvVARxsOuxzbKhA3BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2hizHr+neeREzWPR9vAlInwHCzjlGbKI2JDBJFto0tSAiUVpSoYeIsUVkpnO/p4u
	 Q/kPaAAaWQ3m6Gi0vp/Vg093m3XpSV1tuVKWIjwmh8kgzCpqqpPOHjTOGH4VlUAxPi
	 sg/Xuesj5B8sWySU6atT+qI3dsvfX9w/+eTybv0vl+Zyew9Z8HG8e36+c5VTwo5fx7
	 D/rfQuJ23g2oGRW/ELns8TWK4G6ZWV2N0nD3tA7edFvB2kO27iK7dgXnr+mp9IC5vX
	 hdYv+ZyfZF7ekmTJSy0AvXlQWHwYxSHsb0jOOpJqmh7DecnQrna110lRUOJpNXdRdz
	 iCxa0onvgp0lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	vitaly.prosyak@amd.com,
	Jesse.zhang@amd.com,
	Jiadong.Zhu@amd.com,
	Trigger.Huang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 473/642] drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10
Date: Mon,  5 May 2025 18:11:29 -0400
Message-Id: <20250505221419.2672473-473-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 25961bad9212476983c570438366e1f5e9a9cf21 ]

This commit adds the cleaner shader microcode for GFX10.1.0 GPUs. The
cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs).

Clearing these resources is important for ensuring data isolation
between different workloads running on the GPU. Without the cleaner
shader, residual data from a previous workload could potentially be
accessed by a subsequent workload, leading to data leaks and incorrect
computation results.

The cleaner shader microcode is represented as an array of 32-bit words
(`gfx_10_1_0_cleaner_shader_hex`). This array is the binary
representation of the cleaner shader code, which is written in a
low-level GPU instruction set.

When the cleaner shader feature is enabled, the AMDGPU driver loads this
array into a specific location in the GPU memory. The GPU then reads
this memory location to fetch and execute the cleaner shader
instructions.

The cleaner shader is executed automatically by the GPU at the end of
each workload, before the next workload starts. This ensures that all
GPU resources are in a clean state before the start of each workload.

This addition is part of the cleaner shader feature implementation. The
cleaner shader feature helps resource utilization by cleaning up GPU
resources after they are used. It also enhances security and reliability
by preventing data leaks between workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  14 ++
 .../drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h |  35 +++++
 .../amdgpu/gfx_v10_1_10_cleaner_shader.asm    | 126 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1f32c531f610e..09178d56afbf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4739,6 +4739,20 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 1, 10):
+		adev->gfx.cleaner_shader_ptr = gfx_10_1_10_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_1_10_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 101 &&
+		    adev->gfx.pfp_fw_version  >= 158 &&
+		    adev->gfx.mec_fw_version >= 152) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
index 663c2572d440a..5255378af53c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -21,6 +21,41 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/* Define the cleaner shader gfx_10_1_10 */
+static const u32 gfx_10_1_10_cleaner_shader_hex[] = {
+	0xb0804004, 0xbf8a0000,
+	0xbf068100, 0xbf840023,
+	0xbe8203b8, 0xbefc0380,
+	0x7e008480, 0x7e028480,
+	0x7e048480, 0x7e068480,
+	0x7e088480, 0x7e0a8480,
+	0x7e0c8480, 0x7e0e8480,
+	0xbefc0302, 0x80828802,
+	0xbf84fff5, 0xbe8203ff,
+	0x80000000, 0x87020102,
+	0xbf840012, 0xbefe03c1,
+	0xbeff03c1, 0xd7650001,
+	0x0001007f, 0xd7660001,
+	0x0002027e, 0x16020288,
+	0xbe8203bf, 0xbefc03c1,
+	0xd9382000, 0x00020201,
+	0xd9386040, 0x00040401,
+	0xd70f6a01, 0x000202ff,
+	0x00000400, 0x80828102,
+	0xbf84fff7, 0xbefc03ff,
+	0x00000068, 0xbe803080,
+	0xbe813080, 0xbe823080,
+	0xbe833080, 0x80fc847c,
+	0xbf84fffa, 0xbeea0480,
+	0xbeec0480, 0xbeee0480,
+	0xbef00480, 0xbef20480,
+	0xbef40480, 0xbef60480,
+	0xbef80480, 0xbefa0480,
+	0xbf810000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
+
 /* Define the cleaner shader gfx_10_3_0 */
 static const u32 gfx_10_3_0_cleaner_shader_hex[] = {
 	0xb0804004, 0xbf8a0000,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
new file mode 100644
index 0000000000000..9ba3359253c95
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 256 Dwords cleaner shader.
+
+// GFX10.1 : Clear SGPRs, VGPRs and LDS
+//   Launch 32 waves per CU (16 per SIMD) as a workgroup (threadgroup) to fill every wave slot
+//   Waves are "wave32" and have 64 VGPRs each, which uses all 1024 VGPRs per SIMD
+//   Waves are launched in "CU" mode, and the workgroup shares 64KB of LDS (half of the WGP's LDS)
+//      It takes 2 workgroups to use all of LDS: one on each CU of the WGP
+//   Each wave clears SGPRs 0 - 107
+//   Each wave clears VGPRs 0 - 63
+//   The first wave of the workgroup clears its 64KB of LDS
+//   The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//       before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+
+
+shader main
+  asic(GFX10.1)
+  type(CS)
+  wave_size(32)
+// Note: original source code from SQ team
+
+//
+// Create 32 waves in a threadgroup (CS waves)
+// Each allocates 64 VGPRs
+// The workgroup allocates all of LDS (64kbytes)
+//
+// Takes about 2500 clocks to run.
+//   (theorhetical fastest = 1024clks vgpr + 640lds = 1660 clks)
+//
+  S_BARRIER
+  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_0
+  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s0 == 1)
+
+  s_mov_b32     s2, 0x00000038  // Loop 64/8=8 times  (loop unrolled for performance)
+  s_mov_b32     m0, 0
+  //
+  // CLEAR VGPRs
+  //
+label_0005:
+  v_movreld_b32     v0, 0
+  v_movreld_b32     v1, 0
+  v_movreld_b32     v2, 0
+  v_movreld_b32     v3, 0
+  v_movreld_b32     v4, 0
+  v_movreld_b32     v5, 0
+  v_movreld_b32     v6, 0
+  v_movreld_b32     v7, 0
+  s_mov_b32         m0, s2
+  s_sub_u32     s2, s2, 8
+  s_cbranch_scc0  label_0005
+  //
+  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wave
+  s_and_b32     s2, s2, s0                                  // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_0023                         // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1        // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1          // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f                    // 64 loop iterations
+  s_mov_b32     m0, 0xffffffff
+  // Clear all of LDS space
+  // Each FirstWave of WorkGroup clears 64kbyte block
+
+label_001F:
+  ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
+  ds_write2_b64  v1, v[4:5], v[4:5] offset0:64 offset1:96
+  v_add_co_u32     v1, vcc, 0x00000400, v1
+  s_sub_u32     s2, s2, 1
+  s_cbranch_scc0  label_001F
+
+  //
+  // CLEAR SGPRs
+  //
+label_0023:
+  s_mov_b32     m0, 0x00000068  // Loop 108/4=27 times  (loop unrolled for performance)
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+
+  //clear vcc
+  s_mov_b64 vcc, 0          //clear vcc
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_lo, 0   //clear  flat scratch lo SGPR
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_hi, 0    //clear  flat scratch hi SGPR
+  s_mov_b64 ttmp0, 0        //Clear ttmp0 and ttmp1
+  s_mov_b64 ttmp2, 0        //Clear ttmp2 and ttmp3
+  s_mov_b64 ttmp4, 0        //Clear ttmp4 and ttmp5
+  s_mov_b64 ttmp6, 0        //Clear ttmp6 and ttmp7
+  s_mov_b64 ttmp8, 0        //Clear ttmp8 and ttmp9
+  s_mov_b64 ttmp10, 0       //Clear ttmp10 and ttmp11
+  s_mov_b64 ttmp12, 0       //Clear ttmp12 and ttmp13
+  s_mov_b64 ttmp14, 0       //Clear ttmp14 and ttmp15
+
+ s_endpgm
+
+end
+
+
-- 
2.39.5


