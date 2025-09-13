Return-Path: <stable+bounces-179476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C37B560D6
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C261C2531A
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692B2D63E2;
	Sat, 13 Sep 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDx1RvVF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546272798F5
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766496; cv=none; b=JNx03XtZj7a9STXGXWtL/av0DyMIJjtGs0gtigCDZE13iMbFCXgVBZRP+LW8gU63d5EK3xnoOW5j+oUyqwT3WY1qg2TSWtiadNyTiqkOYs7zcnDlb1mHEbCTizjx5q/yHb2Fz40s35KQV9FKu9mzSy9B050iz8zjeCywwCT0wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766496; c=relaxed/simple;
	bh=F+LUXZQIfEdOozZjufi7+B8C5WmabbpM6AZ6vzQWr9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q9rLKpMvfngPbyuJgYrA/gI8O2aTAhKDqktlZFWzICtNSAOpMPdywoR30fywnqJfuaX97rYo/pKviYrHy1xi41B+vnXgmEpaji574W+UKfEl8F1UCmrLoXnuUkGE75E+Jbl4esAu1PLSk+JJQ1Ja1uadErI9V1oLi84bCfisAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDx1RvVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF39C4CEEB;
	Sat, 13 Sep 2025 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766496;
	bh=F+LUXZQIfEdOozZjufi7+B8C5WmabbpM6AZ6vzQWr9k=;
	h=Subject:To:Cc:From:Date:From;
	b=xDx1RvVFaA6Q46pHNUuezh4NskcQYOgM0I4B7UjquWUyS45A38FvCRfgbusY3YntG
	 +jm/3/YL8935CS3BwtLjsT539B003cq06oyzrtUfcm1na3VD+1kqUsg0MO/40ZBrnX
	 QtlfUgyzrENIXqoWxKKBHDSRtssjNewvWQ0+IGOY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix a memory leak in fence cleanup when unloading" failed to apply to 5.15-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com,lincao12@amd.com,vitaly.prosyak@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:28:00 +0200
Message-ID: <2025091300-showing-concept-4f3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7838fb5f119191403560eca2e23613380c0e425e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091300-showing-concept-4f3d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7838fb5f119191403560eca2e23613380c0e425e Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 4 Sep 2025 12:35:05 -0400
Subject: [PATCH] drm/amdgpu: fix a memory leak in fence cleanup when unloading
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b61badd20b44 ("drm/amdgpu: fix usage slab after free")
reordered when amdgpu_fence_driver_sw_fini() was called after
that patch, amdgpu_fence_driver_sw_fini() effectively became
a no-op as the sched entities we never freed because the
ring pointers were already set to NULL.  Remove the NULL
setting.

Reported-by: Lin.Cao <lincao12@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: b61badd20b44 ("drm/amdgpu: fix usage slab after free")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a525fa37aac36c4591cc8b07ae8957862415fbd5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..486c3646710c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -421,8 +421,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	ring->adev->rings[ring->idx] = NULL;
 }
 
 /**


