Return-Path: <stable+bounces-16226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C383F1C2
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1BB208A1
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A502031A;
	Sat, 27 Jan 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IVg1fZ06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3681F946
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397558; cv=none; b=Kr33NilnM5BqVJWIVknlM161I4o1YJGEhXc8VnVniooaB3lTh4oVI8K8OmtkPXtJb38h9VxbyASNVpt772bzYTp4JUFO41vBcbv3B6MN+O2I3j05q42Kuc2XljnmX5q6QnEbiVVf5KEP4Vpv0jXodc2+YqmskJ9xYYQt0O1se7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397558; c=relaxed/simple;
	bh=NeRPsG1VuFmLAYTBXSjfGTl6zWmuIYX8y8978PRMvJY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W8TAWZ9NM7sIrnrGMarM2IUTigX23Gnjor44F6yy/dEJTNjg+KRb12r4E/fCBOSR2lRfH8WKsWwu5F8ZuKX2eeL+6Xyp6/9RM8IIFRVu+f/hg823/cmWiLkfDMTsasAEGROAGmlsWOb7rkdZCLYQ5Uy0D214ot5tkLIIM8/Kc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVg1fZ06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EE0C43390;
	Sat, 27 Jan 2024 23:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397557;
	bh=NeRPsG1VuFmLAYTBXSjfGTl6zWmuIYX8y8978PRMvJY=;
	h=Subject:To:Cc:From:Date:From;
	b=IVg1fZ06glHRTuUrwH55Ji6w6hesUpiAtP4HjuxVDdLGl8oPd33n1MR11dRe8b5Rm
	 Qoa0IaKsS9+t7ruvC4DraQ9WzG+UWA8GUzAlNavaqlkehx3qr2rNIgaWNk76YdaFd4
	 z/osTfhfwCVAVwuJZYIgOWKneucr/9AjcDJL9FA8=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,Feifei.Xu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:19:17 -0800
Message-ID: <2024012716-defendant-backache-713f@gregkh>
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
git cherry-pick -x 3380fcad2c906872110d31ddf7aa1fdea57f9df6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012716-defendant-backache-713f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

3380fcad2c90 ("drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs")
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


