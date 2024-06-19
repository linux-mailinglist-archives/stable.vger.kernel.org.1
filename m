Return-Path: <stable+bounces-53767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2819D90E613
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6311C21770
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622EF7B3E5;
	Wed, 19 Jun 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pe+1Otrt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2379952
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786393; cv=none; b=QmrXdes+B1KICpKg9dsHk0xo97jnXazkqPTSvzP7cyYhXxHlCeuMAAFneccrL7nIV9Te90Xf6qNZ2V1Iaia0Ddi3Q33FQyMZA0GurtQcGqKzLM6ec5jZyni+eMWm05df7t3N6oyiV5L9dhztn84V9DSOB9RQDUVK1hFWsff2lpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786393; c=relaxed/simple;
	bh=gqQehO2/fBvU3igX1sri7kplk3PFjyXAtBqJ4w04k8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kdavdAsAfdwod2aOAP0ZMlX9IHtbPi3F0eYcf9yqgBzcAwkGP0qelk2JnkNmViTWFzvjl48eSqQT6jMgEsi61YRaPPPgwcl1B/9NFfIffcGwy8yXRw04aan2pnqxt15SwH3I70OzqYE10TuDJE15MVDevg7i/j74SjQ+I581dII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pe+1Otrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A8BC4AF48;
	Wed, 19 Jun 2024 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786393;
	bh=gqQehO2/fBvU3igX1sri7kplk3PFjyXAtBqJ4w04k8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=pe+1OtrtwJh45vtCdCQkr1DAsj+1b1Em2nRneNwUEllIzhEmfpqQorqjg54MLnc4p
	 jsOc4sdRtFjn3MQ52z8Wi6tqOmPtDbQZVAi+eG/iWLDKDZ+9Q4gXGhNZcpoEmhyjv0
	 QPTvOsX9rUGtfkNFGKZvJlEdQoW8JCGLr+1oZUkA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: remove invalid resource->start check v2" failed to apply to 6.9-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com,pierre-eric.pelloux-prayer@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:39:06 +0200
Message-ID: <2024061905-deputy-licking-4147@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x c8962679af3538deaf6d90e90bbdceb0f66b6e98
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061905-deputy-licking-4147@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

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


