Return-Path: <stable+bounces-43698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07E8C43E7
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AEE286467
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7576139;
	Mon, 13 May 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mSz5o8Hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BB5CA1
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613264; cv=none; b=DLrs+Oyf6NDD+fJHEiutgYWDE8B+PnQR6m5n48VPV4VjVnaGr+xidtDxn8Hp+A5iu4qTMhdTr1mOPhPj/Aty3cCdRBosbg5JztWH43b7VLai76r25+Yx794J66FjadXt6tKSWkZXvY0zsam+YpvYZ59tlmy+b2eGkkfDgLfvjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613264; c=relaxed/simple;
	bh=gyBga+cWOf8EBJOIBfwE6xJINDIScSag8JIGwmYOjHY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DrRMALZ+1JqwTPKqTT1zICn6eTKXBr2TdJtBxVdYVzEzixCmQTpVZEGgTC7lV7gfhsU3IXuE77rRkNQ1dqsnaZXC8+CpEkj/Yfv9cNuyGLy7sIdzPPihC/9uS+o2miu8/bYik5/EThqXfYZZOYK2c7dK7kR3WJSIeGordCQ0bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mSz5o8Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03991C32781;
	Mon, 13 May 2024 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613264;
	bh=gyBga+cWOf8EBJOIBfwE6xJINDIScSag8JIGwmYOjHY=;
	h=Subject:To:Cc:From:Date:From;
	b=mSz5o8HdHsTEY8Wbsdf1yQzeuUJUzZGOkiZhqK3w4UrSOjHDD9gPE4/X7EgtXklhU
	 JSSAdCNYvPXFsQ1/B/Fsj14dnkSXsOvVzQ24DsFzn30KKWKHOEAgPYm9zlfCoAzN8B
	 EFiSISXF6oJlBbn1BuGsd2qfaA4ViYvAD4HKRz7s=
Subject: FAILED: patch "[PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large" failed to apply to 5.4-stable tree
To: alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:14:11 +0200
Message-ID: <2024051310-outcast-feisty-83a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051310-outcast-feisty-83a7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

be4a2a81b6b9 ("drm/amdkfd: don't allow mapping the MMIO HDP page with large pages")
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

From be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7 Mon Sep 17 00:00:00 2001
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
index 55aa74cbc532..1e6cc0bfc432 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1139,7 +1139,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2307,7 +2307,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 			return -EINVAL;
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
 			return -ENOMEM;
 		}
@@ -3349,6 +3349,9 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = dev->adev->rmmio_remap.bus_addr;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |


