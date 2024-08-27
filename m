Return-Path: <stable+bounces-70605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E63960F0D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BFB1F22224
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A61C6894;
	Tue, 27 Aug 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s2kWHUX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E81BA294;
	Tue, 27 Aug 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770464; cv=none; b=aAKeqr3hgz64j3IFSgY01BiulWakEyhvO1q5+PXFG543970Ag7kTpksVq5sklsJQfaT+Juq3gXDMoVANjxIA/4C/dFbjv4UjCGdX63tjxuJaRRkHdr9nPPsJRu3UjzmJcnajDBzthFB0VRCXk9oTun0LFyVLdCA9tdddSNQCANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770464; c=relaxed/simple;
	bh=A6FJZ9tLiF26sT1trpOQnOC/1ulo/RJcVWteqCNsO6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgsKAU2KYuoprP7+bOdXOqYmY7efV36C/vEJVBYg6+LGVgRvlXJxbvWzfwtvrgeVVA2wiGiMMdCdtoxnMpLbgJPYsfC5fRhkr4b6E/Nn8S6Ypi/EWbwGKx4F1qyBYsCJ39WoX0mkFrxL94gH9dyyr/eTg3KBNxWhDDxViUOzHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s2kWHUX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DDDC4E673;
	Tue, 27 Aug 2024 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770464;
	bh=A6FJZ9tLiF26sT1trpOQnOC/1ulo/RJcVWteqCNsO6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2kWHUX2xuoTaOPVABQo/3VozOw4V6gAPAv0fithBEgXBbeaOWZZYhASCVM/GpmZf
	 6bkNSdcxPaD0X7/lHBncNKklwfy53Oe0aA21vjmVdSxS/MpCtDFTbGYPztA82REQMc
	 uKlU4QgDo7XuQsxQ+ikdz/sim3OIaO0uSV3YTBe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 237/341] drm/amd/amdgpu: command submission parser for JPEG
Date: Tue, 27 Aug 2024 16:37:48 +0200
Message-ID: <20240827143852.427046638@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David (Ming Qiang) Wu <David.Wu3@amd.com>

[ Upstream commit 470516c2925493594a690bc4d05b1f4471d9f996 ]

Add JPEG IB command parser to ensure registers
in the command are within the JPEG IP block.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a7f670d5d8e77b092404ca8a35bb0f8f89ed3117)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 61 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4294f5e7bff9a..61668a784315f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1057,6 +1057,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 			r = amdgpu_ring_parse_cs(ring, p, job, ib);
 			if (r)
 				return r;
+
+			if (ib->sa_bo)
+				ib->gpu_addr =  amdgpu_sa_bo_gpu_addr(ib->sa_bo);
 		} else {
 			ib->ptr = (uint32_t *)kptr;
 			r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index e8dad396fa102..78aaaee492e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
@@ -769,7 +770,11 @@ static void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
 
 	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
@@ -1052,6 +1057,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
+	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1216,3 +1222,56 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.ras = &jpeg_v4_0_3_ras;
 }
+
+/**
+ * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+			     struct amdgpu_job *job,
+			     struct amdgpu_ib *ib)
+{
+	uint32_t i, reg, res, cond, type;
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
+			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
+				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				return -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE3:
+			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
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
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 22483dc663518..9598eda9d7156 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,6 +46,12 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
+int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 2357ff39323f0..e74e1983da53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -76,6 +76,12 @@
 			 ((cond & 0xF) << 24) |				\
 			 ((type & 0xF) << 28))
 
+#define CP_PACKETJ_NOP		0x60000000
+#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
+#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
+#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
+#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
+
 /* Packet 3 types */
 #define	PACKET3_NOP					0x10
 #define	PACKET3_SET_BASE				0x11
-- 
2.43.0




