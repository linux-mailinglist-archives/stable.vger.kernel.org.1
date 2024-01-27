Return-Path: <stable+bounces-16225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E983F1C1
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76B71F22D3B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A77200BD;
	Sat, 27 Jan 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rr/uwM8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893E1F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397557; cv=none; b=cZkbgE50oXEKZjbbt2t9WHytcY5WgxRhbgLn2NiXKW3O+vI/BCL0YVOIyzx4HJDgrFCvT7kD67Iev6ZneLV1zJ0Y5W/sW8qHlNBmRlglHe6Z0I1cmnXWzB0BxbC8L4bOvGgR5rF5RT3QhVQelVgKGrOkY+pSeuzngOpcMgeLIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397557; c=relaxed/simple;
	bh=ED+Y0rNMN+naXOaIa/sE3MuLrTOpqyQX9GaeHOv7h/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CXEqiEAgUxhu5aAj0GwQzW4YYg9X4yBMwg5/grAPXGOtM8iCcMbg/bGW1erqx/WM4G8qxk8j3diTnx5CjDtMDyR8s/E4u8kZIt0HhHGDtnJoim4Sc79bzZioDOB/YnrSqnRh601GR1ldOKSwoG6iSNuiH+kuvf6l4g+06Zb4l1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rr/uwM8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E329EC433F1;
	Sat, 27 Jan 2024 23:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397557;
	bh=ED+Y0rNMN+naXOaIa/sE3MuLrTOpqyQX9GaeHOv7h/A=;
	h=Subject:To:Cc:From:Date:From;
	b=rr/uwM8aRkaJLc6kPStEPuQ272L3LYpI78ngmgGS/MzZFcRJtphgGXGTXypeYKFLg
	 uflNJkdfgJXEGaCpBDjiBIjG5cMhBWejV7D0YnTU4eWbjB8ya7GUpU509dveF1DRNI
	 KHMQkdvDYumW+yrIjzRhRG6cPaqlvjVGkvKLCYl4=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,Feifei.Xu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:19:16 -0800
Message-ID: <2024012716-tranquil-debtless-e305@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3380fcad2c906872110d31ddf7aa1fdea57f9df6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012716-tranquil-debtless-e305@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

3380fcad2c90 ("drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs")
91963397c49a ("drm/amdgpu: Enable tunneling on high-priority compute queues")
6cb8e3ee3a08 ("drm/amdgpu: update ib start and size alignment")
7a41ed8b59ba ("drm/amdgpu: add new INFO ioctl query for the last GPU page fault")
2e8ef6a56129 ("drm/amdgpu: add cached GPU fault structure to vm struct")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3380fcad2c906872110d31ddf7aa1fdea57f9df6 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Fri, 19 Jan 2024 12:32:59 -0500
Subject: [PATCH] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0. This can lead to hangs in some mixed
graphics and compute workloads. Updated firmware is also
required for AQL.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0ea0866c261f..d9cf9fd03d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3846,7 +3846,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 15277f1d5cf0..d722cbd31783 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -224,6 +224,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);


