Return-Path: <stable+bounces-105549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46B9FA489
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9131885CD0
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D029156243;
	Sun, 22 Dec 2024 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0hVg0Xt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A12F43
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852468; cv=none; b=Utiomks8gEKw24oKYsSnde9ykZFPPXbPvlvyeDC8+nMk2QuM7SHRe6udRxfTl+KlDh+tK6Z2DWpcBQl7Q2RTU7NKGuXCDK2j8I0yq/bMUz11qL3i7/F613Sl3184raDVXpgA41nsjGzu5EmfcwRlucOiDZtBtoDfwhmo+jOuB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852468; c=relaxed/simple;
	bh=cYcjimPjsH0cEx+j3GSgKfNa9kMq0AhtYBKGhrk5wvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eOCn163xjAeS1UDZYLDFfWd7fpnEPlO/2fQbAoMa4TnLvYAB5o4qAzFRcusSm7/GUoNFGwyH0g2/6qyuuqL/e2tgnLmTckftr66pZrVHNpuLQkXCZzQ3DSM7teDQIuxmFYYmZRenplxYYcZTepR9D/mmnKWjQwqUAqLpB2HDSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0hVg0Xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8C4C4CECD;
	Sun, 22 Dec 2024 07:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734852467;
	bh=cYcjimPjsH0cEx+j3GSgKfNa9kMq0AhtYBKGhrk5wvw=;
	h=Subject:To:Cc:From:Date:From;
	b=p0hVg0XtTd5OHky/FMV2uQnhp+zRvO/V/Et8jTPTwIw/wqJy38Ob8zYyBlB47kG9d
	 z0iSCCFN2RZmOUatE0YsWVEx+uA3BR1b/nfE7LTza18nQ7aa32d0ytA5dxZWAP60PX
	 tXE0jyvJn4T/qwbVRiiu/H6Q8Q5ueDnGp74jR2lo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in" failed to apply to 5.4-stable tree
To: mdaenzer@redhat.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:27:31 +0100
Message-ID: <2024122231-punk-caption-dc11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 85230ee36d88e7a09fb062d43203035659dd10a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122231-punk-caption-dc11@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85230ee36d88e7a09fb062d43203035659dd10a5 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>
Date: Tue, 17 Dec 2024 18:22:56 +0100
Subject: [PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in
 amdgpu_vm_bo_update
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Third time's the charm, I hope?

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 695c2c745e5dff201b75da8a1d237ce403600d04)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ddd7f05e4db9..c9c48b782ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1266,10 +1266,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * next command submission.
 	 */
 	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
-		uint32_t mem_type = bo->tbo.resource->mem_type;
-
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(mem_type)))
+		if (bo->tbo.resource &&
+		    !(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);


