Return-Path: <stable+bounces-66562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEC94F025
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318B71F26069
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9F186E3D;
	Mon, 12 Aug 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2G1zBn1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3A184533
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473978; cv=none; b=st+QvrXU8xJ3xlw0cwdnq3GHEYlL3dH7h0NdjP5E5xfzn/0WfALK/PZvEezqAuWn3xH0M4gPSLF4/l7Fz/ztwgUqtBjieOB8ub9DeJo6HJLEMAQrr7pKdAIVHSne/TatZGDawuCz8EkV/U4B0297cpVTg2xRUwlQ6P4Xzx1/NV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473978; c=relaxed/simple;
	bh=eU9UEDouEIiXx86u9YUm6dzPb1x+Z0rY0INgr2sq3mk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i4T70qvKKYvck5YsDfMLxsZp94O/Kdc1lqFIqXJRiIVydwB4UdItUnu30k9Z9UslfSjHySyQrRE+rsVoyR/p+lv3PoCApzOqEiRS9lMZoDuJQoVco8OLh+LKmaInNf34UMdNa3e5x6SCIxzXYd58zzM/1h4SdxjnHuHEXkng9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2G1zBn1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CADC32782;
	Mon, 12 Aug 2024 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473978;
	bh=eU9UEDouEIiXx86u9YUm6dzPb1x+Z0rY0INgr2sq3mk=;
	h=Subject:To:Cc:From:Date:From;
	b=2G1zBn1HTYeBN9qk7eOfQu+t0MxJQsQwYb2vp7VfaXFcWQWIDMtJgJ3fM6yP3ESvc
	 pvADpIEvUvgIN95TQQxtbo/ljRG3c4h4dof+j7MOmDuwCUkhLTU1XUmXwjvnUZhXA3
	 TK6gNG0Mgf6BXv4ty+4zN+gsAPb1n3cSSl4BxnFs=
Subject: FAILED: patch "[PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:46:02 +0200
Message-ID: <2024081201-knoll-credit-f60d@gregkh>
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
git cherry-pick -x 24e82654e98e96cece5d8b919c522054456eeec6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081201-knoll-credit-f60d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

24e82654e98e ("drm/amdkfd: don't allow mapping the MMIO HDP page with large pages")

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


