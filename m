Return-Path: <stable+bounces-16223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79283F1BF
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E41F22D7E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC5200AD;
	Sat, 27 Jan 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G43tavgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417B1F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397546; cv=none; b=gxruGadjO3fZWsHAVF41nhXN0+qcpZu78dRTeiv3jJZ/BZRHCxLGWTcWbJT2xMsGTSZRdv1O7AOPgRVVv2g2OHkpkU2L4/WvMLX+YFHrPh0BGDf2NTPs9NsJvC4UX4W88BZ57wjH7PvuJJW6T4Ny6ypiow92+PLQUbHtoPXGjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397546; c=relaxed/simple;
	bh=Rs2qhcdr/lz5+ejim2P5N3nwMFUWbeqv1UVDw6AUa/U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hcv0wLrpy1gPdio7Mdf+DcV4qTlSrh4K+7YkweAT42GstULNmKnhBl7QnIqBZ+7GQITQ6AB75f2DRPEFGvYir/vOpfQlyVfuKKCvocBOUIpyS7DSXXNvHZ0b0XP04we9lFZZcsqg5eTHX0iK9EBkj1Qm4ALLPm5nEMvduZVr4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G43tavgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CDCC433F1;
	Sat, 27 Jan 2024 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397546;
	bh=Rs2qhcdr/lz5+ejim2P5N3nwMFUWbeqv1UVDw6AUa/U=;
	h=Subject:To:Cc:From:Date:From;
	b=G43tavgW4XB4Jzh4kDW90LeFHUebM1RFCE20oQuYE25mDRzeStNSEVGR2gnv1dgyP
	 bQk9zlUBrnSZPjGR6CJku2ISqMb/8Uo+krnH9DjDLgcwX2aW43S4bddiX0Hqq9gOLN
	 fkQ+9l0/OKY6eF8nkwdB8LqczuD2fOo3Q7oNgdbI=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,Feifei.Xu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:19:05 -0800
Message-ID: <2024012704-bunkmate-pacifier-7cb5@gregkh>
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
git cherry-pick -x 03ff6d7238b77e5fb2b85dc5fe01d2db9eb893bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012704-bunkmate-pacifier-7cb5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

03ff6d7238b7 ("drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs")
91963397c49a ("drm/amdgpu: Enable tunneling on high-priority compute queues")
6cb8e3ee3a08 ("drm/amdgpu: update ib start and size alignment")
7a41ed8b59ba ("drm/amdgpu: add new INFO ioctl query for the last GPU page fault")
2e8ef6a56129 ("drm/amdgpu: add cached GPU fault structure to vm struct")
934deb64fdf2 ("drm/amdgpu: Add memory partition id to amdgpu_vm")
be3800f57c3b ("drm/amdgpu: find partition ID when open device")
2c1c7ba457d4 ("drm/amdgpu: support partition drm devices")
4bdca2057933 ("drm/amdgpu: Add utility functions for xcp")
75d1692393cb ("drm/amdgpu: Add initial version of XCP routines")
ea2d2f8ececd ("drm/amdgpu: detect current GPU memory partition mode")
3d2ea552b229 ("drm/amdgpu: implement smuio v13_0_3 callbacks")
8078f1c610fd ("drm/amdgpu: Change num_xcd to xcc_mask")
36be0181eab5 ("drm/amdgpu: program GRBM_MCM_ADDR for non-AID0 GRBM")
5de6bd6a13f1 ("drm/amdgpu: set mmhub bitmask for multiple AIDs")
ed42f2cc3b56 ("drm/amdgpu: correct the vmhub reference for each XCD in gfxhub init")
74c5b85da754 ("drm/amdkfd: Add spatial partitioning support in KFD")
8dc1db3172ae ("drm/amdkfd: Introduce kfd_node struct (v5)")
e6a02e2cc7fe ("drm/amdgpu: Add some XCC programming")
bfb44eacb0e2 ("drm/amdkfd: Set F8_MODE for gc_v9_4_3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03ff6d7238b77e5fb2b85dc5fe01d2db9eb893bd Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Fri, 19 Jan 2024 12:23:55 -0500
Subject: [PATCH] drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0.  This can lead to hangs in some mixed
graphics and compute workloads.  Updated firmware is also
required for AQL.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d63cab294883..ecb622b7f970 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6589,7 +6589,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 8b7fed913526..22cbfa1bdadd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -170,6 +170,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);


