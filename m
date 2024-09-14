Return-Path: <stable+bounces-76129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B072C978ED6
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CAB24124
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D9126BFC;
	Sat, 14 Sep 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDEA0BD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D45644E
	for <stable@vger.kernel.org>; Sat, 14 Sep 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726298619; cv=none; b=BG+Pq7MJZpYBmM1lPdH+xMoIADMrphbDnZZHkhRQqECyaqQtcvv5d/zhOpuRobvEPuOY8xjxxRpFapyuL9xlwKaloPotw6I0bdbXVssN37iP8Bcn+p7jBrE5+FGerqMt2S+CiEWzbGyUly24ZkxY9zaFowiK1xn/FuTOn5i4A/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726298619; c=relaxed/simple;
	bh=wTFlHcG8AvS7ayoc4bKpM8NRAbHO3u6gXkcNlSodIwU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=naFQB0LvJRcXVmBDQmeoDVu8XVebUNlutjPoUIf7k5N/xHvv4goTwrBEC0s4MLjT0GHreddV0d0A6kfkIPONsKYNF/3kumaubv6+X2nKyuNFm0FNXOc4t2BRaUD93tnWbPdKS1Nr7YNctvKjipQnqDAwRz6IzQoqP+BIXImNOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDEA0BD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FEC4CEC0;
	Sat, 14 Sep 2024 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726298618;
	bh=wTFlHcG8AvS7ayoc4bKpM8NRAbHO3u6gXkcNlSodIwU=;
	h=Subject:To:Cc:From:Date:From;
	b=EDEA0BD5cYHrWsL1f3N8ZxnFrr3S85TDAC0yDqXKuKcfcZMpBKvRygMV6GB+Vxct1
	 iho9BVJw+g3+muVnxwbXgb0dw9cmm/JeGTzOpKCNSkvhwdsl0BDLjgHKxMv8cWqZQQ
	 wxugUwMBqfTOx6gq/6Mh+Lgn9b3niyLifOXby578=
Subject: FAILED: patch "[PATCH] drm/amd/amdgpu: apply command submission parser for JPEG v1" failed to apply to 5.10-stable tree
To: David.Wu3@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 14 Sep 2024 09:23:28 +0200
Message-ID: <2024091428-stagnant-sesame-feb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8409fb50ce48d66cf9dc5391f03f05c56c430605
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091428-stagnant-sesame-feb3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8409fb50ce48 ("drm/amd/amdgpu: apply command submission parser for JPEG v1")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8409fb50ce48d66cf9dc5391f03f05c56c430605 Mon Sep 17 00:00:00 2001
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Date: Thu, 5 Sep 2024 16:57:28 -0400
Subject: [PATCH] drm/amd/amdgpu: apply command submission parser for JPEG v1

Similar to jpeg_v2_dec_ring_parse_cs() but it has different
register ranges and a few other registers access.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3d5adbdf1d01708777f2eda375227cbf7a98b9fe)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 71f43a5c7f72..6e0e88076224 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -23,6 +23,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "vcn_v1_0.h"
@@ -34,6 +35,9 @@
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring);
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib);
 
 static void jpeg_v1_0_decode_ring_patch_wreg(struct amdgpu_ring *ring, uint32_t *ptr, uint32_t reg_offset, uint32_t val)
 {
@@ -300,7 +304,10 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID), 0, 0, PACKETJ_TYPE0));
-	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	if (ring->funcs->parse_cs)
+		amdgpu_ring_write(ring, 0);
+	else
+		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0, 0, PACKETJ_TYPE0));
@@ -554,6 +561,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 	.get_rptr = jpeg_v1_0_decode_ring_get_rptr,
 	.get_wptr = jpeg_v1_0_decode_ring_get_wptr,
 	.set_wptr = jpeg_v1_0_decode_ring_set_wptr,
+	.parse_cs = jpeg_v1_dec_ring_parse_cs,
 	.emit_frame_size =
 		6 + 6 + /* hdp invalidate / flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
@@ -611,3 +619,69 @@ static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 
 	vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
 }
+
+/**
+ * jpeg_v1_dec_ring_parse_cs - command submission parser
+ *
+ * @parser: Command submission parser context
+ * @job: the job to parse
+ * @ib: the IB to parse
+ *
+ * Parse the command stream, return -EINVAL for invalid packet,
+ * 0 otherwise
+ */
+static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
+				     struct amdgpu_job *job,
+				     struct amdgpu_ib *ib)
+{
+	u32 i, reg, res, cond, type;
+	int ret = 0;
+	struct amdgpu_device *adev = parser->adev;
+
+	for (i = 0; i < ib->length_dw ; i += 2) {
+		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
+		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
+		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
+		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
+
+		if (res || cond != PACKETJ_CONDITION_CHECK0) /* only allow 0 for now */
+			return -EINVAL;
+
+		if (reg >= JPEG_V1_REG_RANGE_START && reg <= JPEG_V1_REG_RANGE_END)
+			continue;
+
+		switch (type) {
+		case PACKETJ_TYPE0:
+			if (reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH &&
+			    reg != JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW &&
+			    reg != JPEG_V1_REG_CTX_INDEX &&
+			    reg != JPEG_V1_REG_CTX_DATA) {
+				ret = -EINVAL;
+			}
+			break;
+		case PACKETJ_TYPE1:
+			if (reg != JPEG_V1_REG_CTX_DATA)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE3:
+			if (reg != JPEG_V1_REG_SOFT_RESET)
+				ret = -EINVAL;
+			break;
+		case PACKETJ_TYPE6:
+			if (ib->ptr[i] != CP_PACKETJ_NOP)
+				ret = -EINVAL;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		if (ret) {
+			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
index bbf33a6a3972..9654d22e0376 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h
@@ -29,4 +29,15 @@ int jpeg_v1_0_sw_init(void *handle);
 void jpeg_v1_0_sw_fini(void *handle);
 void jpeg_v1_0_start(struct amdgpu_device *adev, int mode);
 
+#define JPEG_V1_REG_RANGE_START	0x8000
+#define JPEG_V1_REG_RANGE_END	0x803f
+
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_HIGH	0x8238
+#define JPEG_V1_LMI_JPEG_WRITE_64BIT_BAR_LOW	0x8239
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_HIGH	0x825a
+#define JPEG_V1_LMI_JPEG_READ_64BIT_BAR_LOW	0x825b
+#define JPEG_V1_REG_CTX_INDEX			0x8328
+#define JPEG_V1_REG_CTX_DATA			0x8329
+#define JPEG_V1_REG_SOFT_RESET			0x83a0
+
 #endif /*__JPEG_V1_0_H__*/


