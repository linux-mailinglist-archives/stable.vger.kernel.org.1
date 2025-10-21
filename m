Return-Path: <stable+bounces-188541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CBBBF86E0
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DFD19C3DDA
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8460273D66;
	Tue, 21 Oct 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xii6aHaU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7A274652;
	Tue, 21 Oct 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076734; cv=none; b=fUqNJ3RCbCF8+90/BXWt6VQ36jzcnq5cG/TqA72XbwmJnPrZp9mCPKaVRBJi4BjYw51Jz7vrViHbj9w+1GAvWOXX+aG9UAHRtlmnsQ9hGnrcuUtgHd4mZaEKfkfso/ipFNJd3pF/FvoLqqkhjuFO9q5RmRqzPYvsKwPNf2K87UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076734; c=relaxed/simple;
	bh=Mb3hzVQjNGYG+ZCBzv2DShmiJmAW9U1kKJY+dYcx3kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbWu3lDbMsAArDoMthdENMz8LupxWbZKbtAftnzeBgmfcU7ZCeNVsJGBn3WDOE9rld3tAgzB4VHCvASVMzMcB2uEDrgV4O7UYLWasBigbfe4zt/lXZKmMA6d2LWdAeyGO8hJdIjVSC5v5bn9wjl15VP0kd1HmV2QWFzdcdWDFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xii6aHaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E354DC116B1;
	Tue, 21 Oct 2025 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076734;
	bh=Mb3hzVQjNGYG+ZCBzv2DShmiJmAW9U1kKJY+dYcx3kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xii6aHaUf913eBI3/o6BAfjqTZyP1roNaX9A5qrZy7Dqo0cECRX4vLnGg+p6v5lxu
	 xUCDVaLUdq8MrKvPfZSNyORmBPP+WL/vLl0AM3JSKUXayu35tUtgUh6xlitkQkw8kC
	 uPRHpFEY/rNM36FdEUQ/dKIFCOWepzAaUEqh2mn8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 021/136] drm/amdgpu: use atomic functions with memory barriers for vm fault info
Date: Tue, 21 Oct 2025 21:50:09 +0200
Message-ID: <20251021195036.484778431@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <hanguidong02@gmail.com>

commit 6df8e84aa6b5b1812cc2cacd6b3f5ccbb18cda2b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    5 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            |    7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            |    7 +++----
 3 files changed, 8 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2353,10 +2353,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_fr
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
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1055,7 +1055,7 @@ static int gmc_v7_0_sw_init(void *handle
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1287,7 +1287,7 @@ static int gmc_v7_0_process_interrupt(st
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1303,8 +1303,7 @@ static int gmc_v7_0_process_interrupt(st
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1168,7 +1168,7 @@ static int gmc_v8_0_sw_init(void *handle
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1468,7 +1468,7 @@ static int gmc_v8_0_process_interrupt(st
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1484,8 +1484,7 @@ static int gmc_v8_0_process_interrupt(st
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;



