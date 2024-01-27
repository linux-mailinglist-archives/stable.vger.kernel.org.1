Return-Path: <stable+bounces-16222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5183F1BE
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C288A1C21A54
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6D200BC;
	Sat, 27 Jan 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ps0jNgBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69478200AC
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397543; cv=none; b=ofPmKUR1D+RJZLOJvoR3n0iwj+wt5OpF2crxtd9huSpmNbKckNnHhCl0wVsoAElBhzPa1FJYjVyIgwwtaqmDxdYvjhDy+qkouM0OOuwntqiAdqodJVZxHG8d5YkcmBoU7egjsiQLRMKzxrsJ0D0gCn6Mh54Ke25nd10fNpwoivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397543; c=relaxed/simple;
	bh=2Q7+OSymkjAyjmi8QeZ1Us6udXuviNFHN2TC2yALfdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EJLy5Gc7kcqloev7hTWgXE7iK1Mj7l6Y4Lo61AMOJYSmAy8rjnMdDNh2gLdwE8P4h3vx8yopbpYc7Z7XUBbnqy/HLBjZsnp1WkPeXnHlAtNoDVoY5DRgpIfCyoLKH8PWaolmsXS7RS7QfzpKcV8wveN8TDnOuFRqWA4I1I6vFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ps0jNgBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064DC433C7;
	Sat, 27 Jan 2024 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397543;
	bh=2Q7+OSymkjAyjmi8QeZ1Us6udXuviNFHN2TC2yALfdI=;
	h=Subject:To:Cc:From:Date:From;
	b=Ps0jNgBHsAk1tr/vGQIZ2pcvjdsTM5Yx+Qs0e2WdSwv9TbYJKcaRnEa9unbxKSYSY
	 gxPh0z2M4oiaVHgCIPlmOQ5aqQLwJ5G6kgqNEUREzC4usSh4oh1RguBcc7UvmWZDPN
	 7adGvAtpL61uMhMFk8gxYDcp/OoE3gLALmnAjOis=
Subject: FAILED: patch "[PATCH] drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs" failed to apply to 6.6-stable tree
To: alexander.deucher@amd.com,Feifei.Xu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:19:01 -0800
Message-ID: <2024012700-scorpion-rift-e354@gregkh>
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
git cherry-pick -x 03ff6d7238b77e5fb2b85dc5fe01d2db9eb893bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012700-scorpion-rift-e354@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

03ff6d7238b7 ("drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs")
91963397c49a ("drm/amdgpu: Enable tunneling on high-priority compute queues")
6cb8e3ee3a08 ("drm/amdgpu: update ib start and size alignment")
7a41ed8b59ba ("drm/amdgpu: add new INFO ioctl query for the last GPU page fault")
2e8ef6a56129 ("drm/amdgpu: add cached GPU fault structure to vm struct")

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


