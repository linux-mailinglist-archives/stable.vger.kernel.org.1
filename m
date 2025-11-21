Return-Path: <stable+bounces-196561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167AC7B602
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2D2E360A45
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6A1FBCA7;
	Fri, 21 Nov 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/PC9V51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3036D505
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763750725; cv=none; b=j6n9dUG7Xcn9CxjY3GcTLS8+Gmfm6Kv9DwuEg/5GGq+fBTeZ+IkqIyPRZIguZlA2KYJ1gi2P75s7KxBT/SOk9kUwDnkh9cQga07BqIa9ZEOP98V1CmP3LNCmmIooBqQGGiSao+LmJXh3AIzb5kh/ive6WpWO/5Z/4eCr8NB5Fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763750725; c=relaxed/simple;
	bh=l+kfyHV6LdyLx5NsakOVdKcq2b/rDICIhOCfWnFWFNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULoydnhGZvxUpq2W5hEkfgdDhKJd7WlhqD0CkGOanCb06RHSD22l9/v6Gjn7wp/mF6Mmdf9a/a/RY8Mqtx/r74Nk/5kGCvkcLxTdSIPk1McCgOYjYAnDbry1DppzJJ6b/zyvx2mFNdXq47TyiTkP/zuDODt1d06HOMHdRG1mt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/PC9V51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E43C4CEF1;
	Fri, 21 Nov 2025 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763750725;
	bh=l+kfyHV6LdyLx5NsakOVdKcq2b/rDICIhOCfWnFWFNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/PC9V51YSBg9oJxeDxy/WqIYSxESiMQZ9IJ2ep0C59v6E2nJkHfXAlD0cizdlnzI
	 oXjJ+PDNakrIuhtW+BkDqwMVmUQNsXnNpqN/671vwx1PNUP9FS2axfBkSh37htydqX
	 CQViOfHGGdwonep9uoURizQqSp5yFUaE1lI6a9eE2fxsVanrNgEgol9yH3UYt7yloq
	 gZweg3ER7Q5/XKv2bxaF6vHtK80TdeSp8toUp7bhk3aJ2Bl/aJY0uWNecKiVCMGdVO
	 Mj3L9ZAGO5Qqdi8Pk91VuSn0pN8EDsRmBZcShMcVCxqk8+kiS2Nb8O7xReq4tu0Ne5
	 G656o7yzHcWrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] drm/amdgpu/jpeg: Move parse_cs to amdgpu_jpeg.c
Date: Fri, 21 Nov 2025 13:45:21 -0500
Message-ID: <20251121184522.2650460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112053-unifier-drove-b0a8@gregkh>
References: <2025112053-unifier-drove-b0a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

[ Upstream commit 28f75f9bcc7da7da12e5dae2ae8d8629a2b2e42e ]

Rename jpeg_v2_dec_ring_parse_cs to amdgpu_jpeg_dec_parse_cs
and move it to amdgpu_jpeg.c as it is shared among jpeg versions.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: bbe3c115030d ("drm/amdgpu/jpeg: Add parse_cs for JPEG5_0_1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 65 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 58 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  6 ---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 10 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5d5e9ee83a5d6..31506b91ec026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -539,3 +539,68 @@ void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_pri
 			drm_printf(p, "\nInactive Instance:JPEG%d\n", i);
 	}
 }
+
+static inline bool amdgpu_jpeg_reg_valid(u32 reg)
+{
+	if (reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END ||
+	    (reg >= JPEG_ATOMIC_RANGE_START && reg <= JPEG_ATOMIC_RANGE_END))
+		return false;
+	else
+		return true;
+}
+
+/**
+ * amdgpu_jpeg_dec_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+
+int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
+			      struct amdgpu_job *job,
+			      struct amdgpu_ib *ib)
+{
+	u32 i, reg, res, cond, type;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res) /* only support 0 at the moment */
+			return -EINVAL;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (cond != PACKETJ_CONDITION_CHECK0 ||
+			    !amdgpu_jpeg_reg_valid(reg)) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 ||
+			    !amdgpu_jpeg_reg_valid(reg)) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] == CP_PACKETJ_NOP)
+				continue;
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			return -EINVAL;
+		default:
+			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 4f0775e39b543..346ae0ab09d33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -25,11 +25,18 @@
 #define __AMDGPU_JPEG_H__
 
 #include "amdgpu_ras.h"
+#include "amdgpu_cs.h"
 
 #define AMDGPU_MAX_JPEG_INSTANCES	4
 #define AMDGPU_MAX_JPEG_RINGS           10
 #define AMDGPU_MAX_JPEG_RINGS_4_0_3     8
 
+#define JPEG_REG_RANGE_START            0x4000
+#define JPEG_REG_RANGE_END              0x41c2
+#define JPEG_ATOMIC_RANGE_START         0x4120
+#define JPEG_ATOMIC_RANGE_END           0x412A
+
+
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
 #define AMDGPU_JPEG_HARVEST_JPEG1 (1 << 1)
 
@@ -170,5 +177,8 @@ int amdgpu_jpeg_reg_dump_init(struct amdgpu_device *adev,
 			       const struct amdgpu_hwip_reg_entry *reg, u32 count);
 void amdgpu_jpeg_dump_ip_state(struct amdgpu_ip_block *ip_block);
 void amdgpu_jpeg_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
+int amdgpu_jpeg_dec_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 58239c405fda5..27c76bd424cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -23,7 +23,6 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
-#include "amdgpu_cs.h"
 #include "amdgpu_pm.h"
 #include "soc15.h"
 #include "soc15d.h"
@@ -806,7 +805,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -854,58 +853,3 @@ const struct amdgpu_ip_block_version jpeg_v2_0_ip_block = {
 		.rev = 0,
 		.funcs = &jpeg_v2_0_ip_funcs,
 };
-
-/**
- * jpeg_v2_dec_ring_parse_cs - command submission parser
- *
- * @parser: Command submission parser context
- * @job: the job to parse
- * @ib: the IB to parse
- *
- * Parse the command stream, return -EINVAL for invalid packet,
- * 0 otherwise
- */
-int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			      struct amdgpu_job *job,
-			      struct amdgpu_ib *ib)
-{
-	u32 i, reg, res, cond, type;
-	struct amdgpu_device *adev = parser->adev;
-
-	for (i = 0; i < ib->length_dw ; i += 2) {
-		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
-		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
-		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
-		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
-
-		if (res) /* only support 0 at the moment */
-			return -EINVAL;
-
-		switch (type) {
-		case PACKETJ_TYPE0:
-			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START ||
-			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE3:
-			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START ||
-			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-				return -EINVAL;
-			}
-			break;
-		case PACKETJ_TYPE6:
-			if (ib->ptr[i] == CP_PACKETJ_NOP)
-				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
-			return -EINVAL;
-		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 63fadda7a6733..654e43e83e2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -45,9 +45,6 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
-#define JPEG_REG_RANGE_START						0x4000
-#define JPEG_REG_RANGE_END						0x41c2
-
 void jpeg_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
@@ -60,9 +57,6 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
-int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
-			      struct amdgpu_job *job,
-			      struct amdgpu_ib *ib);
 
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3e2c389242dbe..20983f126b490 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -696,7 +696,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -727,7 +727,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_6_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v2_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a44eb2667664b..d1a011c40ba23 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -597,7 +597,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index da3ee69f1a3ba..33db2c1ae6cca 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -762,7 +762,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a78144773fabb..aae7328973d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1177,7 +1177,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 481d1a2dbe5aa..e0fdbacbde096 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -807,7 +807,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index e0a71909252be..1bb09d85eb5b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -683,7 +683,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-	.parse_cs = jpeg_v2_dec_ring_parse_cs,
+	.parse_cs = amdgpu_jpeg_dec_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
-- 
2.51.0


