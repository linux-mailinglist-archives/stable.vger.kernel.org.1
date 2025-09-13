Return-Path: <stable+bounces-179473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D6B560D3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD43174EA2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D172D63E2;
	Sat, 13 Sep 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+HDSGXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942823A994
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766482; cv=none; b=C56Jg8Mg3yMQeF6Xf0hUva1bRUkp2cfqYAAQ3NaL1AjuCIgL7wZTOSKM/25aylvu5LQjV/2PZsk2YE08GzcioA0jsDFlIgv8nbG9NREQeRLdQJofWfVp4dT+I9avvh3XVRTNa1bNAP+3OUs7k7NzqklQ30q2rliLw7Y4qSabJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766482; c=relaxed/simple;
	bh=jMUShK8ve9G2fJAEWpGBHR6+KSv9jOcLgmrhfkxTKN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Su6D9fA+ErLJUBKpSzUgNzY7JuDHgBZBFKCJEo94b1Ew5T4lWnBeQQNspDcsBMth1r7au0yzKrgztefVtG5ynit5GnwFeMaLnyoh+kLSqTN/BACDqxP1AuGe1xfxiuewUgKkGE29dyHldB4A/2xuVhvJ0ZXj6RSVbin6ceEJqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+HDSGXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2069C4CEEB;
	Sat, 13 Sep 2025 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766482;
	bh=jMUShK8ve9G2fJAEWpGBHR6+KSv9jOcLgmrhfkxTKN0=;
	h=Subject:To:Cc:From:Date:From;
	b=A+HDSGXMjL+QSz0UHsGdgPouz+YA4VNYJ7gVwPlBuzFUVW3/rWxsdtFkXrEZf8M2v
	 MVrhbmFqPIidfPxRddp7McwsD9NUJwocryWsL2M1NTtV/m5QO+U7Q++KJVNjp+Kng9
	 t8ybqYwzLfS154rdSQgjE/SA/Jis+C0tgT0jKOnY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix a memory leak in fence cleanup when unloading" failed to apply to 6.12-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com,lincao12@amd.com,vitaly.prosyak@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:27:59 +0200
Message-ID: <2025091359-silencer-spoken-a07b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7838fb5f119191403560eca2e23613380c0e425e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091359-silencer-spoken-a07b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


