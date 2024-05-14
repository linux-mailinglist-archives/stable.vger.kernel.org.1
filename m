Return-Path: <stable+bounces-44393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692E8C52A2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA01F21A43
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66561140360;
	Tue, 14 May 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcJFa/Zx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244784F1E5;
	Tue, 14 May 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686024; cv=none; b=shZ+ptJTaS0U2PwLBHoMW3TIexq5fhx2TCXooX/F0tM8mq+654utw3rJ/yOocKROoVla4aAwwU8YVXsSzxmfURmuK27IJoi84iELxJNTZ5vLmxcnxzyPcL3uf/cOeutyQWrDtg1UnvJzOuzPr6ThDHvXaTl2v0h5XrvuC4+b4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686024; c=relaxed/simple;
	bh=ZQEZvUgPye293LovBmjwtC/Lbgpw2RmjZL5iP06OAsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EerhzfFzV+ywyLOiyDV6hmH5rQHXj6v+yzLAbLFZ23CugKpenDEV9rWdv0fVHcEjaMjJJte7tefwuce2kcq2oQPCzUOzSlojQQaBRexPdkad50R/GSvnfR/aRJfKcDu96ZEDzxA/JYg1EnD97PD1+68+h2ZPIp8NFdsD/W/lvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcJFa/Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A78C2BD10;
	Tue, 14 May 2024 11:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686024;
	bh=ZQEZvUgPye293LovBmjwtC/Lbgpw2RmjZL5iP06OAsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcJFa/ZxligJsMe9P1cNijYaBA9mKT8SDeQBVC+rufOXSl9TYmNEcZqh7FVw9Jspr
	 QG89EhZmAAB6hwRr+roXmPjmEW94mh704Ia/GqgTogLAuENooXrGe/bPeIgAqPqD8j
	 fOGD1owbLANNAiNHlY0ujApymRnVBbkt6K4SjDnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 268/301] drm/amdkfd: dont allow mapping the MMIO HDP page with large pages
Date: Tue, 14 May 2024 12:18:59 +0200
Message-ID: <20240514101042.382050175@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Alex Deucher <alexander.deucher@amd.com>

commit be4a2a81b6b90d1a47eaeaace4cc8e2cb57b96c7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1138,7 +1138,7 @@ static int kfd_ioctl_alloc_memory_of_gpu
 			goto err_unlock;
 		}
 		offset = dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2307,7 +2307,7 @@ static int criu_restore_memory_of_gpu(st
 			return -EINVAL;
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
 			return -ENOMEM;
 		}
@@ -3348,6 +3348,9 @@ static int kfd_mmio_mmap(struct kfd_node
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = dev->adev->rmmio_remap.bus_addr;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |



