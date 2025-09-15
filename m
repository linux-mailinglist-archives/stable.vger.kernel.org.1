Return-Path: <stable+bounces-179594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A07B56E2B
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 04:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7594A179808
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1036121C16E;
	Mon, 15 Sep 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBZ6/mTK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AD1E98EF
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902406; cv=none; b=Euu2cBYv/HBgWFhaLlVGhSmyQwgf7jOFa+bUryUaXTXSA/0XiYxVa6+50jvdMdoqKdL6o/2VqOQf8JIvDYlhCDiWh23Ti+PWMUZ9xDjhgRQFh5t5bSFHf47+SDSpwpBcVR12wFT9YiCNy7Ff5ArOt757YWDafgYN0/dPh5esPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902406; c=relaxed/simple;
	bh=4UOS1pwU3PLDSzVo08zk+GTuE+eK7gGjzDTOsChGNdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9LAw+W+jXpc/CVe0hwpB/iq4+wi/buVYHgfD+5MglOqNXh+7VPVRXZO9nhNXTGCvuRU2uZ3RInX+6qMW1Iu+Z9nGWILP8cV2YMeKT9oS1Hh7w8D1HEG/Du5pnQPPkKu4WV5kezd7DgnWwYbJDmqff7aLhPTxs9+eODCt9kF5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBZ6/mTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AE3C4CEF0;
	Mon, 15 Sep 2025 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757902405;
	bh=4UOS1pwU3PLDSzVo08zk+GTuE+eK7gGjzDTOsChGNdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBZ6/mTKeDZSF/J7InudZiy5FIsgNIPaoUkvJNJF3yuHGmIS5rbE1zBqluNc2IOMv
	 i8ntBp5XGpPwCTlN/fklcfdAZNqlAHXK+XrozePgMppYgfYrM1phOQRqlmsF3aQgCN
	 R4QhVnuz4EIRqfSjAvcHYRzHzA8bWqZd9oQGhBnoww65CEo9fmm5o3oSTsYou0EkSe
	 hmMe0vLJpjj9m0Ub2TMWtOXjIVL8DX8tO8qA54vlTvVOXaXItqHzWmTef4utgLCJe3
	 Vs4iavLTXP2TltgGnNVDX9K3WdEFXfIAmaeDkK5bj64M25xcyHmC/zf3RbzaZtvIVg
	 SBOcNkf3CiaVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Lin.Cao" <lincao12@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: fix a memory leak in fence cleanup when unloading
Date: Sun, 14 Sep 2025 22:13:22 -0400
Message-ID: <20250915021322.368723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091359-silencer-spoken-a07b@gregkh>
References: <2025091359-silencer-spoken-a07b@gregkh>
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
[ Adapt to conditional check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 10da6e550d768..bc86a44550908 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -400,9 +400,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	if (!ring->is_mes_queue)
-		ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.51.0


