Return-Path: <stable+bounces-69555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4B956832
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C0E1C21169
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC215E5CC;
	Mon, 19 Aug 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NH5zUaJC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C92208E
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062887; cv=none; b=eHGflEN+Oz1lrfVfpvp5y1Iy/VXdhf276YI4tUEXsK3geTcpHjZq27T+LyzezRTKTc+ciQc0DIYCQKwWKfY5/xg5o9Kj5Z56YarLdNu1zyRK1vDO4yRvn0HAbqH0oV3THIh2kg0lrcxI0w5CmTzRvXNo7eoHCT8YpQRZbkeWYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062887; c=relaxed/simple;
	bh=7UYtyS1lcfTibFQWu9IRicVTMqGAYOUtHY/DtYMMq1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pCngAYImT18Xv0MNbmEeKyNcvvo+3jKFbAExks5UHwNZZ3J0VaoAxTUUi/Q3zItz4okVgAvdttRRUsCK212czgGNbysGYrgIQu5gNlljLnXflY9rvCGbTIaHAuOLALb/PRRej1nmu/d/6ik9CTrFsTIKJTrI5IAbxJnKM1EYIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NH5zUaJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E033CC32782;
	Mon, 19 Aug 2024 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062887;
	bh=7UYtyS1lcfTibFQWu9IRicVTMqGAYOUtHY/DtYMMq1k=;
	h=Subject:To:Cc:From:Date:From;
	b=NH5zUaJCE1daTd2QDU6gKCiVgGyFDOjIFX1Hq/9uOC8DtCvWVR89aJFmHDJZwQrQK
	 PEgzskrqXfrWN6gdfzOrl8eCPF/ZAUZJ6k5npu4ezvP9a8oBi3fd0ykDBSh4SYhWax
	 OAYGe605Ac0SLFr5UDTeiK3ZpLT35IWWNTa4CQhk=
Subject: FAILED: patch "[PATCH] drm/amd/amdgpu: command submission parser for JPEG" failed to apply to 6.1-stable tree
To: David.Wu3@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:21:21 +0200
Message-ID: <2024081921-corroding-scrabble-432d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 470516c2925493594a690bc4d05b1f4471d9f996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081921-corroding-scrabble-432d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

470516c29254 ("drm/amd/amdgpu: command submission parser for JPEG")
e6c6bd6253e7 ("drm/amdgpu/jpeg4: properly set atomics vmid field")
dfad65c65728 ("drm/amdgpu: Add JPEG5 support")
8f98a715da8e ("drm/amdgpu/jpeg: add jpeg support for VCN4_0_5")
35d54e21e002 ("drm/amdgpu: Initialize jpeg v4_0_3 ras function")
570df4bca618 ("drm/amdgpu: Add reset_ras_error_count for jpeg v4_0_3")
41e491d8b606 ("drm/amdgpu: Add query_ras_error_count for jpeg v4_0_3")
e684e654eba9 ("drm/amdgpu/jpeg: add jpeg support for VCN4_0_3")
bf35dbc13585 ("drm/amdgpu/jpeg: enable jpeg v4_0 for sriov")
86e8255f941e ("drm/amdgpu: add JPEG 4.0 RAS poison consumption handling")
533174580133 ("drm/amdgpu: add RAS error query for JPEG 4.0")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 470516c2925493594a690bc4d05b1f4471d9f996 Mon Sep 17 00:00:00 2001
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Date: Thu, 8 Aug 2024 12:19:50 -0400
Subject: [PATCH] drm/amd/amdgpu: command submission parser for JPEG

Add JPEG IB command parser to ensure registers
in the command are within the JPEG IP block.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a7f670d5d8e77b092404ca8a35bb0f8f89ed3117)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9aa952f258cf..6dfdff58bffd 100644
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
index f4662920c653..6ae5a784e187 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v4_0_3.h"
@@ -782,7 +783,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
 
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
@@ -1084,6 +1089,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
+	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
@@ -1248,3 +1254,56 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
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
index 747a3e5f6856..71c54b294e15 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -46,6 +46,9 @@
 
 #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
 
+#define JPEG_REG_RANGE_START						0x4000
+#define JPEG_REG_RANGE_END						0x41c2
+
 extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
 
 void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
@@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 					uint32_t val, uint32_t mask);
-
+int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				  struct amdgpu_job *job,
+				  struct amdgpu_ib *ib);
 #endif /* __JPEG_V4_0_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index d694a276498a..f4daff90c770 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
+	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index 2357ff39323f..e74e1983da53 100644
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


