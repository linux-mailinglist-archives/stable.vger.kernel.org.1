Return-Path: <stable+bounces-134950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C06A95B8C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EE03B6E6A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7819D891;
	Tue, 22 Apr 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOwMJw/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE919CCFC;
	Tue, 22 Apr 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288278; cv=none; b=Ehw000sBy1prg0UfBrLFMxpT+JW2IvUbSacIsxXeddXNwIGhvHAHG7DQ37528Q4a2Fp9ZgT1bKgN7rSV5ePWqsQuSEr+YczKK923APPkkOIRZrn+HEGhORSMf02etCn4ytznwHFvcQezpEKLc2e5hpyLJecQk+jis3m8j/R/SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288278; c=relaxed/simple;
	bh=vWqY35KnpFAJ7ZKHNCsglf8lfnRCqooU+WTC/YUBglQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkYqpu6ENnH+2OsWlgZ7e1tXYia0vX0i2P0yz4bVRZFYbTBU7dJGa75YC5gmF1uGkDZNk+u2l4QUYcJq1FTxX1+HQuCOUXJUzfskdJu+Q6PCKcrV3OTcQcYkITp2FhrjJtQKBTeLC8rkMDR9TdM9k2YsUuSKxi3nUM/Tk5ZtZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOwMJw/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA9C4CEE4;
	Tue, 22 Apr 2025 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288278;
	bh=vWqY35KnpFAJ7ZKHNCsglf8lfnRCqooU+WTC/YUBglQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOwMJw/aJE5lCh8ByIWNhYcr8bEBkFtZqOGIb0HjBhGWN+ZSXRP3qL3XPy1rP9v3s
	 MZZOedZU7qc27WP+kDm7p1RK6XlBkUeeHWcwaWkxgrdS5Usv+RaiHeJHmqxX7YwRUf
	 BFXOgtQCDRGrRq3993IyRG2IstfJg90wCyP3DszwNtoQWU0kjLKO/3t2LhwjiiEaaq
	 IiLmo2smwodyeEYgq9wHW6N7VN4P9jaGWgtNDDqYf6Eyzw9ZXx+eUCtmuSADgGqSAt
	 i85+p8FLwiTrt3yC1YAtbAlSxmtRfmNwWYpus38ze8zI5sdSvX1YbqLxPpXtkQwnrG
	 26HAuNw95DhJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	vitaly.prosyak@amd.com,
	srinivasan.shanmugam@amd.com,
	Jesse.zhang@amd.com,
	Jiadong.Zhu@amd.com,
	Tim.Huang@amd.com,
	Prike.Liang@amd.com,
	Hawking.Zhang@amd.com,
	Likun.Gao@amd.com,
	kenneth.feng@amd.com,
	Jack.Xiao@amd.com,
	boyuan.zhang@amd.com,
	kent.russell@amd.com,
	shane.xiao@amd.com,
	xiaogang.chen@amd.com,
	yifan1.zhang@amd.com,
	Frank.Min@amd.com,
	david.belanger@amd.com,
	natalie.vock@gmx.de,
	alex.sierra@amd.com,
	le.ma@amd.com,
	mario.limonciello@amd.com,
	yingli12@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 22/23] drm/amdgpu: Use the right function for hdp flush
Date: Mon, 21 Apr 2025 22:17:02 -0400
Message-Id: <20250422021703.1941244-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit c235a7132258ac30bd43d228222986022d21f5de ]

There are a few prechecks made before HDP flush like a flush is not
required on APU bare metal. Using hdp callback directly bypasses those
checks. Use amdgpu_device_flush_hdp which takes care of prechecks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1d9bff4cf8c53d33ee2ff1b11574e5da739ce61c)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c |  2 +-
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 45ed97038df0c..24d711b0e6346 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5998,7 +5998,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -6076,7 +6076,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
@@ -6153,7 +6153,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -6528,7 +6528,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 84cf5fd297b7f..0357fea8ae1df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2327,7 +2327,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -2371,7 +2371,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -2416,7 +2416,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
@@ -3051,7 +3051,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -3269,7 +3269,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -4487,7 +4487,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b259e217930c7..241619ee10e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2264,7 +2264,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -2408,7 +2408,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		adev->hdp.funcs->flush_hdp(adev, NULL);
+		amdgpu_device_flush_hdp(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -3429,7 +3429,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9784a28921853..c6e7429212827 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,7 +265,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -966,7 +966,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 2797fd84432b2..4e9c23d65b02f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -226,7 +226,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -893,7 +893,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 60acf676000b3..525e435ee22d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -294,7 +294,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 
 	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -862,7 +862,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7a45f3fdc7341..9a212413c6d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2351,7 +2351,7 @@ static int gmc_v9_0_hw_init(void *handle)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	adev->hdp.funcs->flush_hdp(adev, NULL);
+	amdgpu_device_flush_hdp(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 2395f1856962a..e77a467af7ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -532,7 +532,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 51e470e8d67d9..bf00de763acb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -600,7 +600,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 4d33c95a51163..89f6c06946c51 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -488,7 +488,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			adev->hdp.funcs->flush_hdp(adev, NULL);
+			amdgpu_device_flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
-- 
2.39.5


