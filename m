Return-Path: <stable+bounces-179597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE536B56E61
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 04:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B6D3BBBEB
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 02:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E291DF742;
	Mon, 15 Sep 2025 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N49hcrD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868F2DC790
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904233; cv=none; b=UGgZx5HqLR5CFtdxLvRfdI+HbvSxPjr5mUeYEeJV7o/pigdz+JRQDMXbAOPhZ3PqhlZl295f5P/CUpOSboLW5M25rDupkibEX+hBjV6GpumBZnmublIs1l7qsu+m2ZnXxQTozePpTGvBHAOGkCa1f0x82YCyRnjO/jvvuF6MoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904233; c=relaxed/simple;
	bh=bGXtah8C34lfzo/tLyWSyergxYsu3wpC9cQd8bb6NPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F98T77vkmBXK/QqkY17a/sng6vdwyyfPE7NImFWuPnPoK45bKUSHYQ64aZQmamHrFoALdpMWb3LQTFrpD0wOJmPxgBrKf1gSoez6YGEwe7TTBvZ3N8KSUXeyBvdMZ7QPclXGPb/M9pIOOr0ZQXNBTj66YMnyNYDuP63NE4BHT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N49hcrD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A71DC4CEF0;
	Mon, 15 Sep 2025 02:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757904232;
	bh=bGXtah8C34lfzo/tLyWSyergxYsu3wpC9cQd8bb6NPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N49hcrD1W+DbF08/8vWcJHm5RcwnK5IVpqkGfL0JdvD2opZPINC5f2l7i/ofaNjyi
	 LTHh/IVWvRPIFoPONeuoEdMrBTZHs9S45SSpaFJNpxdNfxbkUZrnT5hAx0wgRR4VAt
	 6SccjkLJD3O+agS2UOWambL8R8RpXkcAUbSs2Ufg1ed1H0teKwk9UoTlEEOXhG3Z/t
	 G4NmHr5Ezc8eYU4AC9Ijk2ZoUeyGvmPBK4202s6XqI9xhAFZHS4CQ+o66WRIIqXXb2
	 XRdnry98NIRBP8vTeJMKrh77APJCC8+mj+bd69MDvd0Evvev1F8oQD8bvEg6pXBXJb
	 41HKt75KXBFjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Lin.Cao" <lincao12@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: fix a memory leak in fence cleanup when unloading
Date: Sun, 14 Sep 2025 22:43:50 -0400
Message-ID: <20250915024350.396085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091300-showing-concept-4f3d@gregkh>
References: <2025091300-showing-concept-4f3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 7838fb5f119191403560eca2e23613380c0e425e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index de05b7f864f2c..ab10addf130c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -302,8 +302,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.51.0


