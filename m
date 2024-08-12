Return-Path: <stable+bounces-66561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333194F024
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362411C20B58
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A176186E50;
	Mon, 12 Aug 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKq8G8ih"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E7184532
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473975; cv=none; b=ONREQQCYNVHEYN1b5UGQeRE3cwp1lNqXm8uQD9K1r9JrD27c8Ev5+mWUffhpEthMPo2RvBsjoN77205KzREiUCjesuuHHbsqMzPtRrmHErewpiKNcjckn63AcNk5LtC0SCxpvLR4YHkHOkXAdhctFKfWz3WmO4+aoMsRvDEE9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473975; c=relaxed/simple;
	bh=TLlPLf4rQpKQnbBbMDWuQ/4e2gea4RrmAVgExkPRzYc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tbJhBZ5CY08YaAORcxLx7ItVNoK++2I2yi4X+Kec8DDosbWMx4kr4YamwuTqFJU/nsB3YY2XxpVPIXc79fg2n5jyMamY1zMpX+8YcIgNXA8aJ8yU7osJ/YYiYzALnelzacP7RA1Npo38iUCbS9F0ks+m/CfGp7/kaZXjYqTZ8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKq8G8ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4FCC32782;
	Mon, 12 Aug 2024 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473975;
	bh=TLlPLf4rQpKQnbBbMDWuQ/4e2gea4RrmAVgExkPRzYc=;
	h=Subject:To:Cc:From:Date:From;
	b=WKq8G8ihT0WmgSL/u9zf179z+7s7uo+ZzosTFnr2IGkEW4dIsLcS2pjkjkgOgNyEG
	 IhpC0lu8xxLEqmsi4aVDrbs4GjGRZGClFHyT93cmOdBd4KXG5LFx0tYxCy60HuvpfS
	 WqT+llq0Xa/R5ryNR0MjATuyRlujtqjmR47HWx+E=
Subject: FAILED: patch "[PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large" failed to apply to 5.15-stable tree
To: alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:46:02 +0200
Message-ID: <2024081202-hastily-panic-ee65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 24e82654e98e96cece5d8b919c522054456eeec6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081202-hastily-panic-ee65@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

24e82654e98e ("drm/amdkfd: don't allow mapping the MMIO HDP page with large pages")
b38c074b2b07 ("drm/amdkfd: CRIU Refactor restore BO function")
67a359d85ec2 ("drm/amdkfd: CRIU remove sync and TLB flush on restore")
22804e03f7a5 ("drm/amdkfd: Fix criu_restore_bo error handling")
d8a25e485857 ("drm/amdkfd: fix loop error handling")
e5af61ffaaef ("drm/amdkfd: CRIU fix a NULL vs IS_ERR() check")
be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
bef153b70c6e ("drm/amdkfd: CRIU implement gpu_id remapping")
40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
42c6c48214b7 ("drm/amdkfd: CRIU checkpoint and restore queue mqds")
2485c12c980a ("drm/amdkfd: CRIU restore sdma id for queues")
8668dfc30d3e ("drm/amdkfd: CRIU restore queue ids")
626f7b3190b4 ("drm/amdkfd: CRIU add queues support")
cd9f79103003 ("drm/amdkfd: CRIU Implement KFD unpause operation")
011bbb03024f ("drm/amdkfd: CRIU Implement KFD resume ioctl")
73fa13b6a511 ("drm/amdkfd: CRIU Implement KFD restore ioctl")
5ccbb057c0a1 ("drm/amdkfd: CRIU Implement KFD checkpoint ioctl")
f185381b6481 ("drm/amdkfd: CRIU Implement KFD process_info ioctl")
3698807094ec ("drm/amdkfd: CRIU Introduce Checkpoint-Restore APIs")
f61c40c0757a ("drm/amdkfd: enable heavy-weight TLB flush on Arcturus")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24e82654e98e96cece5d8b919c522054456eeec6 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Sun, 14 Apr 2024 13:06:39 -0400
Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large
 pages

We don't get the right offset in that case.  The GPU has
an unused 4K area of the register BAR space into which you can
remap registers.  We remap the HDP flush registers into this
space to allow userspace (CPU or GPU) to flush the HDP when it
updates VRAM.  However, on systems with >4K pages, we end up
exposing PAGE_SIZE of MMIO space.

Fixes: d8e408a82704 ("drm/amdkfd: Expose HDP registers to user space")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6b713fb0b818..fdf171ad4a3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1144,7 +1144,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2312,7 +2312,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 			return -EINVAL;
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
 			return -ENOMEM;
 		}
@@ -3354,6 +3354,9 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = dev->adev->rmmio_remap.bus_addr;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |


