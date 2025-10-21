Return-Path: <stable+bounces-188428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D63BF8541
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA87464993
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D61274B2A;
	Tue, 21 Oct 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEs5VE1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB922749DC;
	Tue, 21 Oct 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076373; cv=none; b=b/Zz/1fbccDsC8g1fgGZocN9q1MSaZiNhcVTlss++iF+CbgZYYlUCH+B85CLvHQZ+rJSZdJ9QDKyAmBUjhb4X1AS3ghpsngW2U+Hp9C5Y/m278BxYS+DIBHW4AZ6fv7Vc3jZhZEq9b2b5AtK54RIy0Qe1fqp7K7nPOFO2kTWibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076373; c=relaxed/simple;
	bh=9Le6mwC1x51rDQE26FOZJ18nnfxRJ0YvBsDU61gqYZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUI2Hk9KsXYjrIqaMi5HhKMUaZwoxmeegXMpC06mWDJxuREKXmkmyWuejFbZx1PITG68191VWGYCcztnDl6ESaPevcWlk8Ok1iA6Cs01LFi2+rCSXCzDUTSMBa3wLeiLET0nsJE2S5Kf957Qaj+m7JyS379NgWHCOjcjXOwOnvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEs5VE1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4832BC4CEF5;
	Tue, 21 Oct 2025 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076372;
	bh=9Le6mwC1x51rDQE26FOZJ18nnfxRJ0YvBsDU61gqYZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEs5VE1XbpfsWW6vQzekWYJDxD34fOWrRa+gJTusLsGGPmnJZ3iPaEGODHYF2FK48
	 EQDz6+7qkQTZySHMmK8EQq8gdtIncdLe4XsDbcxiMy7ZIZJWYCCqYpFYIdhsxZMZ39
	 sDXvhcrFcvp8GkET9MlAsolVfi3DzHrxZBciBu9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 015/105] drm/amdgpu: use atomic functions with memory barriers for vm fault info
Date: Tue, 21 Oct 2025 21:50:24 +0200
Message-ID: <20251021195021.853652206@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2285,10 +2285,9 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_fr
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
@@ -1061,7 +1061,7 @@ static int gmc_v7_0_sw_init(void *handle
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1290,7 +1290,7 @@ static int gmc_v7_0_process_interrupt(st
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1306,8 +1306,7 @@ static int gmc_v7_0_process_interrupt(st
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
@@ -1174,7 +1174,7 @@ static int gmc_v8_0_sw_init(void *handle
 					GFP_KERNEL);
 	if (!adev->gmc.vm_fault_info)
 		return -ENOMEM;
-	atomic_set(&adev->gmc.vm_fault_info_updated, 0);
+	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
 }
@@ -1465,7 +1465,7 @@ static int gmc_v8_0_process_interrupt(st
 	vmid = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     VMID);
 	if (amdgpu_amdkfd_is_kfd_vmid(adev, vmid)
-		&& !atomic_read(&adev->gmc.vm_fault_info_updated)) {
+		&& !atomic_read_acquire(&adev->gmc.vm_fault_info_updated)) {
 		struct kfd_vm_fault_info *info = adev->gmc.vm_fault_info;
 		u32 protections = REG_GET_FIELD(status,
 					VM_CONTEXT1_PROTECTION_FAULT_STATUS,
@@ -1481,8 +1481,7 @@ static int gmc_v8_0_process_interrupt(st
 		info->prot_read = protections & 0x8 ? true : false;
 		info->prot_write = protections & 0x10 ? true : false;
 		info->prot_exec = protections & 0x20 ? true : false;
-		mb();
-		atomic_set(&adev->gmc.vm_fault_info_updated, 1);
+		atomic_set_release(&adev->gmc.vm_fault_info_updated, 1);
 	}
 
 	return 0;



