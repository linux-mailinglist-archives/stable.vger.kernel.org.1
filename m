Return-Path: <stable+bounces-100387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2D9EAD28
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E047A188D18D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F22153E8;
	Tue, 10 Dec 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XnGWdQlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC223DEB1
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824028; cv=none; b=cMwfhuZQTjtcdkWLCWBJNtg/XdKipAAEW5LrswrQDt5wyC2LnW0O/Q0LTtYjUaVduX05Z1JscDPvQvVgHANULhtns9g+NbAwoC6ag3zjMR9nt5Mp+85RVy2C4ZRTSJCJxmuKDfng6irRy/SIumhAyp3BZBMpfyKKe3Kf2AbWRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824028; c=relaxed/simple;
	bh=H/FcjiBQjNTCmfFOUEZPb5nrLOnLPpoAxSgeVV5GK7M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HlEASM0REUXOQtTuvHbE2OkXzBDM4JF79sqcxC8XjEN1ZWm2331q1NqBmfOQsm5SQ48mhJKoRysIOM5It+ZNgtFOsSXojNh92RcBNEkM8cUpI0zL+521wS3/OhiRFc0/BSjeaSzhoqX9zcRRCn5srlh78TYKQapbfugemNFj0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XnGWdQlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AFAC4CEE0;
	Tue, 10 Dec 2024 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733824028;
	bh=H/FcjiBQjNTCmfFOUEZPb5nrLOnLPpoAxSgeVV5GK7M=;
	h=Subject:To:Cc:From:Date:From;
	b=XnGWdQlC4xhUiMvodnv1DzlUVG8VyainXxybWY3vlUTrNrcD326SiiBhbHSHSRhPV
	 JbdmKS8moqekiEM5qSkMgz9lcTcB61NStDJKW43Fsi3M+Q7xmXUaUc6OXcioQe4hzZ
	 k8zg444AEGmcExPvOMS/uEczqw/ONe/ciiC+HkT0=
Subject: FAILED: patch "[PATCH] drm/amdgpu: rework resume handling for display (v2)" failed to apply to 6.12-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:46:32 +0100
Message-ID: <2024121032-evasive-monotone-82e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 73dae652dcac776296890da215ee7dec357a1032
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121032-evasive-monotone-82e7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73dae652dcac776296890da215ee7dec357a1032 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 25 Nov 2024 13:59:09 -0500
Subject: [PATCH] drm/amdgpu: rework resume handling for display (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split resume into a 3rd step to handle displays when DCC is
enabled on DCN 4.0.1.  Move display after the buffer funcs
have been re-enabled so that the GPU will do the move and
properly set the DCC metadata for DCN.

v2: fix fence irq resume ordering

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.11.x

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 913eb4f08ee6..96316111300a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3762,7 +3762,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * First resume function for hardware IPs.  The list of all the hardware
+ * Second resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3780,6 +3780,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
@@ -3790,6 +3791,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Third resume function for hardware IPs.  The list of all the hardware
+ * IPs that make up the asic is walked and the resume callbacks are run for
+ * all DCE.  resume puts the hardware into a functional state after a suspend
+ * and updates the software state as necessary.  This function is also used
+ * for restoring the GPU after a GPU reset.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3819,6 +3850,13 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
+	if (r)
+		return r;
+
+	amdgpu_fence_driver_hw_init(adev);
+
+	r = amdgpu_device_ip_resume_phase3(adev);
+
 	return r;
 }
 
@@ -4899,7 +4937,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		goto exit;
 	}
-	amdgpu_fence_driver_hw_init(adev);
 
 	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
@@ -5484,6 +5521,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
 					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 
+				r = amdgpu_device_ip_resume_phase3(tmp_adev);
+				if (r)
+					goto out;
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 


