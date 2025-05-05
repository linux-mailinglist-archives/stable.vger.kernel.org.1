Return-Path: <stable+bounces-140002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD7AAA393
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C1464627
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78E8279787;
	Mon,  5 May 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeHhwzxy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48E2F54BB;
	Mon,  5 May 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483885; cv=none; b=T/GOWMvuLsQVLdpElJAqCHurErQpQ1Adzov3K4qwUmWYQPAmlxqo4dI+38Z1ueTpx6AqmfWNGkdemwxdEq4M80qQnNvvC1+8O2IoPFFC+aLa5nCmB0Mjo5U2UMTqfX7afY6ohWOd0GTscunwoqVcl1jA1fSpIxRSgz7xfxCZgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483885; c=relaxed/simple;
	bh=+vxbdT+/BNS6IrzyO5ffCrwNOh6iSORldFKjxs8lFTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDGxx9IomKHA4bsZGV8a5gUDFBBeQgKbZKKy1eQaqJMUHZ64BOoHXRm5WWdLT4r9KE3x7i05RZ5rAjtoIepqFVetaXaE5Vupnl9T/UyK3rN9LlvW2R06tAix9NbpTySuQgwEvJhKEzb03H3wNnmPh+uAg3lc9Laew/CJmyyGSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeHhwzxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6E6C4CEE4;
	Mon,  5 May 2025 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483885;
	bh=+vxbdT+/BNS6IrzyO5ffCrwNOh6iSORldFKjxs8lFTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeHhwzxyx5veIW4yzlup7PL8cODmLieyYDQtrbCivUvLQhMKMcBQip6d0XOKM1016
	 rMTd9T60rK9UE2mr8BsNP5FtEcbpKnlPE+1UmElVwpnTT/aBzHzzYFBOqpM7CSnLSp
	 bR/KYpzASyFg8kAxuhVj7sD6n9F0Zb2nFLSfNj3g1fyfBZUhgQ2ZFWSUgW0raZbAAN
	 0q8TnhxUEn79Jh7FSnhua7reHfSTFVYwZtrFFUkAlwaj8U8RJM6eddC+bp35oBqaBE
	 GvnZ3QhLgfc/Zdn+o3kV0Dx+b2OW7uRIFifFICvxFXpPQi4iGaDnPsIsvnnYmxsMXN
	 JA2plmrVD37dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	xiang.liu@amd.com,
	Jane.Jian@amd.com,
	kevinyang.wang@amd.com,
	sonny.jiang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 255/642] drm/amdgpu: Add offset normalization in VCN v5.0.1
Date: Mon,  5 May 2025 18:07:51 -0400
Message-Id: <20250505221419.2672473-255-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 0b9647d40ef82837d5025de6daad64db775ea1c5 ]

VCN v5.0.1 also will need register offset normalization. Reuse the logic
from VCN v4.0.3. Also, avoid HDP flush similar to VCN v4.0.3

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 20 +++++++++++---------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ecdc027f82203..e6cf21ed8afb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -31,6 +31,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
 #include "mmsch_v4_0_3.h"
 
 #include "vcn/vcn_4_0_3_offset.h"
@@ -1461,8 +1462,8 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 				    regUVD_RB_WPTR);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-				uint32_t val, uint32_t mask)
+void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				       uint32_t val, uint32_t mask)
 {
 	/* Use normalized offsets when required */
 	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
@@ -1474,7 +1475,8 @@ static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t
 	amdgpu_ring_write(ring, val);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+				   uint32_t val)
 {
 	/* Use normalized offsets when required */
 	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
@@ -1485,8 +1487,8 @@ static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg
 	amdgpu_ring_write(ring, val);
 }
 
-static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
-				unsigned int vmid, uint64_t pd_addr)
+void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				       unsigned int vmid, uint64_t pd_addr)
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 
@@ -1498,7 +1500,7 @@ static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					lower_32_bits(pd_addr), 0xffffffff);
 }
 
-static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
 	 * This is a workaround to avoid any HDP flush through VCN ring.
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
index 0b046114373ae..03572a1d0c9cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.h
@@ -26,4 +26,13 @@
 
 extern const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block;
 
+void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				       uint32_t val, uint32_t mask);
+
+void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+				   uint32_t val);
+void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				       unsigned int vmid, uint64_t pd_addr);
+void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring);
+
 #endif /* __VCN_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index cdbc10d7c9fb7..f893a84282832 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -29,6 +29,7 @@
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
@@ -905,16 +906,17 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
-	.emit_frame_size =
-		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
-		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
-		1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_frame_size = SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+			   SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+			   4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+			   5 +
+			   5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+			   1, /* vcn_v2_0_enc_ring_insert_end */
 	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
 	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
 	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
-	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_vcn_enc_ring_test_ring,
 	.test_ib = amdgpu_vcn_unified_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
@@ -922,8 +924,8 @@ static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
-	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
-- 
2.39.5


