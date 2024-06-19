Return-Path: <stable+bounces-53766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638A90E611
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D41C21697
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690FC7CF1A;
	Wed, 19 Jun 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TuQ0ikBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38479DD4
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786390; cv=none; b=FbMgaFTOUKr4fKFiNFN29ZX1lF+AGT8z3oUgyxwlNMkEO2p249ThR7i/QCKdmTRkysWRlAmHcKx7LX7D/wSgGRetdy0qCemgOIgMUMGcdbcJAU/JbaMx3rMKUDESEL/nXCEwrLV5IH0oD9S4yKMZiR3p11hTh4Fv0LfCOXkaIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786390; c=relaxed/simple;
	bh=dnEbSjTKJusTGm6zwMHY7mCNezWvvcy0R6fLCMygMto=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UIPc1x9IYArTnpwjhZOoPaJHN6+6uYk5ZHqe5mEsY3gaffubDQCJfaBx9ek8Rs0qg89CEmDS/Ylp5fpkLBJXOnvyjxmpUX9/P9OfBen3Jtcs6pn0WrjPyHvgvzzZoIclmnv3Zx9xB6HqwCWeSTGCTMsrAw9W9Sgwb3mLYaKkU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TuQ0ikBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B34C4AF1A;
	Wed, 19 Jun 2024 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786390;
	bh=dnEbSjTKJusTGm6zwMHY7mCNezWvvcy0R6fLCMygMto=;
	h=Subject:To:Cc:From:Date:From;
	b=TuQ0ikBU9iOWEe9yK5B0Hx9JjXMY1sgQnFH1ifnJ4ZcRPN7UNpS/TE9iqc16hj1hM
	 /b0YVjK8HGz4cEDj2nJlzicKlV48K+Ge9nv5FJCdjQjLUIP1JCasF0DsdLIlTDVt/F
	 J+4raT39ZoOrz5EBWjU8P21eCDGYM8Fmn8uwFLgU=
Subject: FAILED: patch "[PATCH] drm/amdgpu: remove invalid resource->start check v2" failed to apply to 6.6-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com,pierre-eric.pelloux-prayer@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:39:06 +0200
Message-ID: <2024061906-monsoon-appliance-6c9e@gregkh>
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
git cherry-pick -x c8962679af3538deaf6d90e90bbdceb0f66b6e98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061906-monsoon-appliance-6c9e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c8962679af35 ("drm/amdgpu: remove invalid resource->start check v2")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c8962679af3538deaf6d90e90bbdceb0f66b6e98 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Fri, 15 Mar 2024 13:07:53 +0100
Subject: [PATCH] drm/amdgpu: remove invalid resource->start check v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The majority of those where removed in the commit aed01a68047b
("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")

But this one was missed because it's working on the resource and not the
BO. Since we also no longer use a fake start address for visible BOs
this will now trigger invalid mapping errors.

v2: also remove the unused variable

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
CC: stable@vger.kernel.org
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fc418e670fda..6417cb76ccd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -557,7 +557,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 				     struct ttm_resource *mem)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	size_t bus_size = (size_t)mem->size;
 
 	switch (mem->mem_type) {
 	case TTM_PL_SYSTEM:
@@ -568,9 +567,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		break;
 	case TTM_PL_VRAM:
 		mem->bus.offset = mem->start << PAGE_SHIFT;
-		/* check if it's visible */
-		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
-			return -EINVAL;
 
 		if (adev->mman.aper_base_kaddr &&
 		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)


