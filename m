Return-Path: <stable+bounces-93734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E09D0611
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDC41F21B3E
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81731DBB31;
	Sun, 17 Nov 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYFOum/y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8A84A3E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731877743; cv=none; b=h+sNjHNmZDqe9u4RO1YJlP9yRfjXio1XXPv/V+sbcmJjKhXPZ4JzRZWYcKmlgbf5FFTNfVv/5Vimt0c+l6/tlfD1jY/uoWLgQj623ur03nJKA6cgaVe/S4QasCTTAvcb9iI6G7Bq21d3Po8dE2vjBheZp8uGXr+pD2d1hVKI+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731877743; c=relaxed/simple;
	bh=iPQUq34SMcKVpzlCEDtSKX3lznVXU759w2H6/8eeNZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rL2G497o8WnI288xWe3PCOMJLHqUVXtgsEyseo8gYqBGJYqGMPJCQyJvZ+R+HsxrgBT/nn++M+MeKFpBpohW0gH2bLCNTN0ikWGf4xxUTZ22T6kdt1WFc4CctXlT/iYyPM3vuizdOkU4tprFif9tpkGYd/jcmHZfvgdPnGUr/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYFOum/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E73C4CECD;
	Sun, 17 Nov 2024 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731877743;
	bh=iPQUq34SMcKVpzlCEDtSKX3lznVXU759w2H6/8eeNZU=;
	h=Subject:To:Cc:From:Date:From;
	b=xYFOum/ysPMrjkUbv9B4oiieB/ekVgy0rNgK2rTWPRPzczgyFFUu+v54kLRI+fy0z
	 llHMBcoRWDgLBqCtIhNn1AKB+k9jxghmTvzzh1pNIcf1mixDNl8QUmbCtdRUJaCyG+
	 XG9MXjI+U/KBs2CUbRXYEw1qTTmYzExFYXK1T1Mg=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()" failed to apply to 6.6-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 22:08:38 +0100
Message-ID: <2024111738-jalapeno-unknown-3db3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0e5ac88fb918297a7484b67f2b484d43bed3fbbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111738-jalapeno-unknown-3db3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e5ac88fb918297a7484b67f2b484d43bed3fbbe Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Thu, 31 Oct 2024 10:04:17 +0100
Subject: [PATCH] drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The coherency flags can only be determined when the BO is locked and that
in turn is only guaranteed when the mapping is validated.

Fix the check, move the resource check into the function and add an assert
that the BO is locked.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: d1a372af1c3d ("drm/amdgpu: Set MTYPE in PTE based on BO flags")
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1b4ca8546f5b5c482717bedb8e031227b1541539)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c76ac0dfe572..7a45f3fdc734 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1124,8 +1124,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool is_vram = bo->tbo.resource &&
+		bo->tbo.resource->mem_type == TTM_PL_VRAM;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				     AMDGPU_GEM_CREATE_EXT_COHERENT);
 	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
@@ -1133,6 +1135,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool snoop = false;
 	bool is_local;
 
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
@@ -1251,9 +1255,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->tbo.resource)
-		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
-					     mapping, flags);
+	if ((*flags & AMDGPU_PTE_VALID) && bo)
+		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,


