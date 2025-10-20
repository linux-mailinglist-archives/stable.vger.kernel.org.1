Return-Path: <stable+bounces-187983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248BBEFDE0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 197224EFCE6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF02EA17D;
	Mon, 20 Oct 2025 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7sW4JVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595192EA17F
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948118; cv=none; b=cRaD76I1nkN3u4qwa+gOV45li/5EvbmhSCDRft3quEdlPygDY59VWmrAGYUf2n4dsIEvACT8K8oKGWzw/OsOcFHgbkGeQH68W7JpdxsFtA9vQONsIhtnFKRxEFzKP68gNfABsVZOdcQdrtPKiDsFNywEtJ5y7Wu32+9mKk6GJ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948118; c=relaxed/simple;
	bh=UiQgCENkrChsloLEXK7o0joSWRoSf2K+SPhoViSTbdo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BeUEKskwMquAU6WXnfjHK6G142uqVrXLglfPrwVz6mnuco1sr9l/ROvgt6UGv8KqSfMCYFDbLqmHrDkyyI1+84jciGkUUFpt4Yb7XhSH8Vge2EVH2ycNHfamyMxBwd6Xz2YChZK7SW1ii9QOFQD6uC2taCZYKZun1vC6GXVHHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7sW4JVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AA5C4CEF9;
	Mon, 20 Oct 2025 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760948117;
	bh=UiQgCENkrChsloLEXK7o0joSWRoSf2K+SPhoViSTbdo=;
	h=Subject:To:Cc:From:Date:From;
	b=M7sW4JVWagMHqYVhNHw55crJvUnhUYUGFxA1Tlvl+KRh9/Vwcn0UVR1QuDv1D3LSM
	 /lS7IbseN15ohDycWqm7vr1YnYCnmkWZpKTXajxphGn0b7ShD8Yc1t0rFfMFXGqZHK
	 F1+0rWMV00BO1PZ9rUoxtg+p52DET8kS60Gh20Qo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: use atomic functions with memory barriers for vm" failed to apply to 5.4-stable tree
To: hanguidong02@gmail.com,alexander.deucher@amd.com,felix.kuehling@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:15:12 +0200
Message-ID: <2025102012-cranberry-chimp-891a@gregkh>
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
git cherry-pick -x 6df8e84aa6b5b1812cc2cacd6b3f5ccbb18cda2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102012-cranberry-chimp-891a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6df8e84aa6b5b1812cc2cacd6b3f5ccbb18cda2b Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 8 Oct 2025 03:43:27 +0000
Subject: [PATCH] drm/amdgpu: use atomic functions with memory barriers for vm
 fault info

The atomic variable vm_fault_info_updated is used to synchronize access to
adev->gmc.vm_fault_info between the interrupt handler and
get_vm_fault_info().

The default atomic functions like atomic_set() and atomic_read() do not
provide memory barriers. This allows for CPU instruction reordering,
meaning the memory accesses to vm_fault_info and the vm_fault_info_updated
flag are not guaranteed to occur in the intended order. This creates a
race condition that can lead to inconsistent or stale data being used.

The previous implementation, which used an explicit mb(), was incomplete
and inefficient. It failed to account for all potential CPU reorderings,
such as the access of vm_fault_info being reordered before the atomic_read
of the flag. This approach is also more verbose and less performant than
using the proper atomic functions with acquire/release semantics.

Fix this by switching to atomic_set_release() and atomic_read_acquire().
These functions provide the necessary acquire and release semantics,
which act as memory barriers to ensure the correct order of operations.
It is also more efficient and idiomatic than using explicit full memory
barriers.

Fixes: b97dfa27ef3a ("drm/amdgpu: save vm fault information for amdkfd")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 83020963dfde..a2ca9acf8c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2329,10 +2329,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 					  struct kfd_vm_fault_info *mem)
 {
-	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
+	if (atomic_read_acquire(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb(); /* make sure read happened */
-		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 93d7ccb7d013..0e5e54d0a9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1068,7 +1068,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1290,7 +1290,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1306,8 +1306,7 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index c5e2a2c41e06..e1509480dfc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1183,7 +1183,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1478,7 +1478,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1494,8 +1494,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;


