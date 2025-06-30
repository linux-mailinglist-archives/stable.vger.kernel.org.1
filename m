Return-Path: <stable+bounces-158946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2028AEDD55
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A07718892D4
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62492701D1;
	Mon, 30 Jun 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J7p9syeu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8E26FA60
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287489; cv=none; b=cvw1Pu9QOEllzTe8CY11iS8N82OgcWaLpAlDWohnmKr/lVVG4NgM3CduRfrVSqRf877LpeOQdTS01XpupQrka97r+hKuQr3S3qwnCm1xwC9jU6dLudoG9vOo2eHbU4cjcihaPToSG0RKb1zMfJ3GqwdueI0Cd+XPce9xOhkP2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287489; c=relaxed/simple;
	bh=QZw9kSA8wwLIK9zqv7VioVQaGJEUPHuZPDZO8RRpNsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sc4cFgGhPhloA8MBm8k7q6vNwbjo27no1wBKIra2Rvj+kamdI51zJMSie7nOfqHDSoGzxQbbCKtPUikOUrpMFkdk4HFQEe/u5+el63d0YnOp+G0ChGon06GqvkfmtjCe2vDRkPRdS9Wp4t6Fe0OqilA1H9PaKUC1Aaib6Tn+b/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J7p9syeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6909BC4CEE3;
	Mon, 30 Jun 2025 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751287488;
	bh=QZw9kSA8wwLIK9zqv7VioVQaGJEUPHuZPDZO8RRpNsA=;
	h=Subject:To:Cc:From:Date:From;
	b=J7p9syeusfHiDwf8KtpbVqe8Jy6xaChZKP8RDEglnqACFdoMzLu+WIk1EfiVCddT/
	 9eH7Q2Hurtm4MenRSi82AXKN8myi19EACPuTQckx0DbHIwwIJv5aADM6ex1GeEpQvU
	 OgwpXD33Nhvx+miQjRdCJAI80DCSJBMkXgRYIwGc=
Subject: FAILED: patch "[PATCH] drm/amdgpu/mes: add missing locking in helper functions" failed to apply to 6.15-stable tree
To: alexander.deucher@amd.com,michael.chen@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 14:44:45 +0200
Message-ID: <2025063045-shrubs-unmanaged-5146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 40f970ba7a4ab77be2ffe6d50a70416c8876496a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063045-shrubs-unmanaged-5146@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40f970ba7a4ab77be2ffe6d50a70416c8876496a Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 19 May 2025 15:46:25 -0400
Subject: [PATCH] drm/amdgpu/mes: add missing locking in helper functions

We need to take the MES lock.

Reviewed-by: Michael Chen <michael.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2febb63ab232..fe772c380120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -300,7 +300,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to map legacy queue\n");
 
@@ -323,7 +325,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_addr = gpu_addr;
 	queue_input.trail_fence_data = seq;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
@@ -353,7 +357,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
 		queue_input.legacy_gfx = true;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reset legacy queue\n");
 
@@ -383,7 +389,9 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
 	else
@@ -411,7 +419,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to write reg (0x%x)\n", reg);
 
@@ -438,7 +448,9 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
@@ -463,7 +475,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
@@ -694,7 +708,9 @@ static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		dev_err(adev->dev, "failed to change_config.\n");
 


