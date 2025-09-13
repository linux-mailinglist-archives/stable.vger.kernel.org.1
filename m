Return-Path: <stable+bounces-179475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8DB560D5
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21772AA1D52
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A52EC558;
	Sat, 13 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EV2niPSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257023A994
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766493; cv=none; b=gcW2ZywP5klmTEopJLXAsCBeNomZNULJE/aMTjUNO4ciVuMwoYFVBxxL7AgKAkr1kQptCtAoueG34AkNKORloMQD0wThgN/lHct3UxlxH9YWptatVfS6qr0wcbfSN2M3wllJIXYYX1dlvJ2qTlQs97fu5uQyEb5HM65+2JqzPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766493; c=relaxed/simple;
	bh=ahXmHdv+f6v0x62Qw0R5FyKmj+iKbcFTEBGnxXGyZzo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G75Hb1tRqpsUiHkAT1x8NQCAJzFKzhtE+GN2GqZo7az6RUHRHHPXe4I1Uc9MazNaSsmhudCFyHC4wth7JmDFffK5QzuHoSj1RYDUtQZ0C/80K8MnZcNEIX48y9pr2Q8RdkObSA0UH4kgHP+OpaBzOT8JFiAsScKWgEiuNCzsC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EV2niPSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE835C4CEEB;
	Sat, 13 Sep 2025 12:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766493;
	bh=ahXmHdv+f6v0x62Qw0R5FyKmj+iKbcFTEBGnxXGyZzo=;
	h=Subject:To:Cc:From:Date:From;
	b=EV2niPSazYM3epbBaVUB8ging88eYD48iYvZM2NoYdDBJdMWeZWMAMTZwxF//PYny
	 0sXzc18dbs9KcwGaM4y4GzbVIBfA5pjo6c4M/FKJ7kYbdItyKsMglLfarVzZQcxmOC
	 QUhZVIdzOtDbhZ1NykbaRM/0/iWuEXupBPO8Qb0o=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix a memory leak in fence cleanup when unloading" failed to apply to 6.1-stable tree
To: alexander.deucher@amd.com,christian.koenig@amd.com,lincao12@amd.com,vitaly.prosyak@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:27:59 +0200
Message-ID: <2025091359-extruding-tartly-9ee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7838fb5f119191403560eca2e23613380c0e425e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091359-extruding-tartly-9ee4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


