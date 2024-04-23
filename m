Return-Path: <stable+bounces-40681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC618AE767
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 15:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F831C23529
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F8745E2;
	Tue, 23 Apr 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bwT5OMkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56566134CC2
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877620; cv=none; b=C99HeO7jXMUO/osCdXBVy8uYLHBBCIAQx+sk5rQ71SzO1i+UDm0RuGZDI6M4QlpuAClEbJ3630y8bE7ufkZRnPDW1Z9fi1TbnpGJ/lSgYi5LHspc3TiUfzt0x7atX/hmO0dEvbdrLyN/yPcSdPtbvI66fsNrW5BwvAOiR/HzDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877620; c=relaxed/simple;
	bh=qM6y2BXWXoDYnp0p8CGgKTLSid8A7WE1XQAENIRdUBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p6Lw+q7LMGd8GZba1zFfCs6xzQ1rcJayozV/RCrBbppWJztmONz5Wvt0v9m8wQ7n262r5D77L4G1+ZbPnKyeTVj4vU+tj+AvIjfHWw+Jr6RNatFH/wN5iZ1l87lyD7nIIHTmHHQsbMq+ATMyg28eB59CqnYgT7bBDYpi84vt6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bwT5OMkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2020BC2BD11;
	Tue, 23 Apr 2024 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713877620;
	bh=qM6y2BXWXoDYnp0p8CGgKTLSid8A7WE1XQAENIRdUBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=bwT5OMkJyPra6ZboujaeTdBDh8KkmlE36uJuNe818U0KlyKnPXdnwZ39R08hYAC5/
	 C2hXlunvRaDajDJvzLNf2D9YNPftrPF3mKipCpuNGrkSl9bfv3uW6JMo4JLrDBQ5Dv
	 MyK5SGnB2iShWDD11LE3Fj0Ieo3OqJuTnFG3ZN2A=
Subject: FAILED: patch "[PATCH] drm/amdgpu: validate the parameters of bo mapping operations" failed to apply to 4.19-stable tree
To: xinhui.pan@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com,hexed@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 06:06:50 -0700
Message-ID: <2024042350-oversized-skimpily-1a7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 6fef2d4c00b5b8561ad68dd2b68173f5c6af1e75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042350-oversized-skimpily-1a7e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

6fef2d4c00b5 ("drm/amdgpu: validate the parameters of bo mapping operations more clearly")
9f0bcf49e989 ("amdgpu: validate offset_in_bo of drm_amdgpu_gem_va")
9a89a721b41b ("drm/amdgpu: check alignment on CPU page for bo map")
8b80d74bdb22 ("drm/amdgpu: restrict bo mapping within gpu address limits")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fef2d4c00b5b8561ad68dd2b68173f5c6af1e75 Mon Sep 17 00:00:00 2001
From: xinhui pan <xinhui.pan@amd.com>
Date: Thu, 11 Apr 2024 11:11:38 +0800
Subject: [PATCH] drm/amdgpu: validate the parameters of bo mapping operations
 more clearly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Verify the parameters of
amdgpu_vm_bo_(map/replace_map/clearing_mappings) in one common place.

Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
Cc: stable@vger.kernel.org
Reported-by: Vlad Stolyarov <hexed@google.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4299ce386322..94089069c9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1613,6 +1613,37 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
+/* Validate operation parameters to prevent potential abuse */
+static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
+					  struct amdgpu_bo *bo,
+					  uint64_t saddr,
+					  uint64_t offset,
+					  uint64_t size)
+{
+	uint64_t tmp, lpfn;
+
+	if (saddr & AMDGPU_GPU_PAGE_MASK
+	    || offset & AMDGPU_GPU_PAGE_MASK
+	    || size & AMDGPU_GPU_PAGE_MASK)
+		return -EINVAL;
+
+	if (check_add_overflow(saddr, size, &tmp)
+	    || check_add_overflow(offset, size, &tmp)
+	    || size == 0 /* which also leads to end < begin */)
+		return -EINVAL;
+
+	/* make sure object fit at this offset */
+	if (bo && offset + size > amdgpu_bo_size(bo))
+		return -EINVAL;
+
+	/* Ensure last pfn not exceed max_pfn */
+	lpfn = (saddr + size - 1) >> AMDGPU_GPU_PAGE_SHIFT;
+	if (lpfn >= adev->vm_manager.max_pfn)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_bo_map - map bo inside a vm
  *
@@ -1639,21 +1670,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	uint64_t eaddr;
+	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
@@ -1706,17 +1730,9 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	uint64_t eaddr;
 	int r;
 
-	/* validate the parameters */
-	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK || size & ~PAGE_MASK)
-		return -EINVAL;
-	if (saddr + size <= saddr || offset + size <= offset)
-		return -EINVAL;
-
-	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
-	if ((bo && offset + size > amdgpu_bo_size(bo)) ||
-	    (eaddr >= adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT))
-		return -EINVAL;
+	r = amdgpu_vm_verify_parameters(adev, bo, saddr, offset, size);
+	if (r)
+		return r;
 
 	/* Allocate all the needed memory */
 	mapping = kmalloc(sizeof(*mapping), GFP_KERNEL);
@@ -1730,7 +1746,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	}
 
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
 	mapping->last = eaddr;
@@ -1817,10 +1833,14 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	struct amdgpu_bo_va_mapping *before, *after, *tmp, *next;
 	LIST_HEAD(removed);
 	uint64_t eaddr;
+	int r;
+
+	r = amdgpu_vm_verify_parameters(adev, NULL, saddr, 0, size);
+	if (r)
+		return r;
 
-	eaddr = saddr + size - 1;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
-	eaddr /= AMDGPU_GPU_PAGE_SIZE;
+	eaddr = saddr + (size - 1) / AMDGPU_GPU_PAGE_SIZE;
 
 	/* Allocate all the needed memory */
 	before = kzalloc(sizeof(*before), GFP_KERNEL);


