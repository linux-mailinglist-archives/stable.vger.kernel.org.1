Return-Path: <stable+bounces-69560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F164956838
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79F41F22D91
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E341607AD;
	Mon, 19 Aug 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3tdnfb/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3415B14C
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062905; cv=none; b=jN5YvSVrTOCmql1wRUSpPKf7ECYUFEwSwDGrrGHpXNwpOhoZXyQRPHJzjms+jc52nTySfcDCISg2uYQaJYCJTMYWY+YKneR6biRO9e2Oe23so3cQm8dTNe0MHfRsLne4FNln0BNMUdTpY06CgEP1JXysgEt2rNVQ0bPYll2wQ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062905; c=relaxed/simple;
	bh=pzx/wQlItqYen/7acGYNO78ZvkW0CF+IUhHvgYLhBNA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7HnaJSfpf+AYLKtZh4axKOdHT4FKLl0jHowTpdgjUbeyQoV+5gnp0dtrz2/k5ALbz42smHXGLLr7c3jUxnU1TvJ7nRznvwQeXm41ayLyqjSz71a5+MILUtiurZveKri1mLk7OZ/HRQbqBsxBB0awW0Vdfz7GAAJSJJp5BigOIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3tdnfb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760BDC32782;
	Mon, 19 Aug 2024 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062904;
	bh=pzx/wQlItqYen/7acGYNO78ZvkW0CF+IUhHvgYLhBNA=;
	h=Subject:To:Cc:From:Date:From;
	b=r3tdnfb/ZEMt8DsaYEZKH2ny0ybEhjv2/QSEFgt9MFPSEGU76BGZMsld/R3dw8OnB
	 XD2KehsWk4s9hayIgTzDaeBMM9UXDfdMiv8sWnClwRIiEkJn2nqhjRYZ1S6GYg/oBR
	 j5lU0wH0VqdSWWsFJLMdQmh4AXJ06bVLLKM7Hhrw=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes: fix mes ring buffer overflow" failed to apply to 6.10-stable tree
To: Jack.Xiao@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:21:42 +0200
Message-ID: <2024081941-flavorful-extrovert-01b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 11752c013f562a1124088a35bd314aa0e9f0e88f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081941-flavorful-extrovert-01b9@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

11752c013f56 ("drm/amdgpu/mes: fix mes ring buffer overflow")
fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")
de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
ade887c63394 ("drm/amdgpu/mes12: Use a separate fence per transaction")
94b51a3d01ed ("drm/amdgpu/mes12: increase mes submission timeout")
b1d852920b31 ("drm/amdgpu/mes12: print MES opcodes rather than numbers")
785f0f9fe742 ("drm/amdgpu: Add mes v12_0 ip block support (v4)")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11752c013f562a1124088a35bd314aa0e9f0e88f Mon Sep 17 00:00:00 2001
From: Jack Xiao <Jack.Xiao@amd.com>
Date: Thu, 18 Jul 2024 16:38:50 +0800
Subject: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow

wait memory room until enough before writing mes packets
to avoid ring buffer overflow.

v2: squash in sched_hw_submission fix

Fixes: de3246254156 ("drm/amdgpu: cleanup MES11 command submission")
Fixes: fffe347e1478 ("drm/amdgpu: cleanup MES12 command submission")
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 34e087e8920e635c62e2ed6a758b0cd27f836d13)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..e6344a6b0a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	 */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		sched_hw_submission = max(sched_hw_submission, 256);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_MES)
+		sched_hw_submission = 8;
 	else if (ring == &adev->sdma.instance[0].page)
 		sched_hw_submission = 256;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index f9343642ae7e..1a5ad5be33bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	const char *op_str, *misc_op_str;
 	unsigned long flags;
 	u64 status_gpu_addr;
-	u32 status_offset;
+	u32 seq, status_offset;
 	u64 *status_ptr;
 	signed long r;
 	int ret;
@@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r)
 		goto error_unlock_free;
 
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
@@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_status_pkt.api_status.api_completion_fence_addr =
 		ring->fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++ring->fence_drv.sync_seq;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
 
 	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
 				   sizeof(mes_status_pkt) / 4);
@@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
 			x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
@@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
 
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
 error_unlock_free:
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0713bc3eb263..249e5a66205c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	const char *op_str, *misc_op_str;
 	unsigned long flags;
 	u64 status_gpu_addr;
-	u32 status_offset;
+	u32 seq, status_offset;
 	u64 *status_ptr;
 	signed long r;
 	int ret;
@@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r)
 		goto error_unlock_free;
 
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
 	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
@@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_status_pkt.api_status.api_completion_fence_addr =
 		ring->fence_drv.gpu_addr;
-	mes_status_pkt.api_status.api_completion_fence_value =
-		++ring->fence_drv.sync_seq;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
 
 	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
 				   sizeof(mes_status_pkt) / 4);
@@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
 			x_pkt->header.opcode);
 
-	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
@@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
 
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
 error_unlock_free:
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 


