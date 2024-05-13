Return-Path: <stable+bounces-43696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B88C43E5
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15FD287160
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831B9539C;
	Mon, 13 May 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cToHZJzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996957305
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613253; cv=none; b=ZIrdzaEj0CRIbZzBelQeWTu5U/P04veCLMjd6eLsAS0XdTHAH+KFJKEDR1y9ElImB6s85oYW1rsWbpjWnNl5b82PTQ+TMPw7F8WwZsYX0VzvzRbNwr9bHwDmPn2ddloPF/21T+GCMq404QFKukoAfo2VuCfH9NenDcxmL8nrqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613253; c=relaxed/simple;
	bh=gzpST5lyIwUXlQaTD9azWKPjp+oolfFH4iIa9L0/MrE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kPltwr10PN++kYKSpX0aGHPixLFVFiOuR+C//UIqGal/dpINXKyZOs8D2syO12AaNgM08emg1enmOUblaVyoXlIMwJvSkLSqc/S0Rixwkutv8XnHZF1pdbK9SOq9Gp/rJezU+1M1BQnaLyCr/qpRfPDJnLMEurekbrn6JyH2JuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cToHZJzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685F9C113CC;
	Mon, 13 May 2024 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715613252;
	bh=gzpST5lyIwUXlQaTD9azWKPjp+oolfFH4iIa9L0/MrE=;
	h=Subject:To:Cc:From:Date:From;
	b=cToHZJzGz0JisbYcWF2qHCkzpxhv5zxViJGb/EY/1M6aH8DHjAPFn4/BSwRphBsng
	 FSU3jcJZJx0q4NPT+30lYT6bMl4HZOC8KIQfXzHs0dQWv0dpZ9fuUKYeTLcpdAmwkT
	 vOaAsRYdFqZU+3jF7syt8g6+Pj2hsvYFhRg1/NBA=
Subject: FAILED: patch "[PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large" failed to apply to 5.15-stable tree
To: alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:14:09 +0200
Message-ID: <2024051309-blanching-list-a7ab@gregkh>
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
git cherry-pick -x be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051309-blanching-list-a7ab@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


