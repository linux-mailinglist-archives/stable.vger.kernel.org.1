Return-Path: <stable+bounces-179596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00293B56E53
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 04:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04AB3B9ECB
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5B19067C;
	Mon, 15 Sep 2025 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9zODm5X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA747211F
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903490; cv=none; b=cI5oBWPx7wjE1tqmQEVP6uHbBEp39LaJjytwI+5ev5xMoWTYpF7/C1yKB7aZ/KoLMbnDBFKw9MkSBffwRC8dxSG1IEVJThuyieI69Rs0d3w53YFOT0YDQkqPObzqJj5KCNembtlHBrDWKWFyU4aF/pyv8ySlxiwu/6qvqIV9QWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903490; c=relaxed/simple;
	bh=TpRG/iSZSHfz7lztaevH/Uc6ttsg+FzGjpoyKdUIadQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjhTLwQTbWQblNLqld+iasm7vpw9BgXxGSqFO6mSR+jl2UENj5X57xCBVh9nGiIfS422hUI6Kp1iLb9AGV1/gNoOTFUTGUJ4WsbaDn86OhUZBxXs3s8SsDVSpm2U7jr4HxMHTIQyvJwzYaZfjW/AwBLG0hQTRIMGqwnOLCs8w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9zODm5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9323DC4CEF0;
	Mon, 15 Sep 2025 02:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757903490;
	bh=TpRG/iSZSHfz7lztaevH/Uc6ttsg+FzGjpoyKdUIadQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9zODm5XI0AdzvDn2vyTUDyKhy+O6H8lhpXVEWz87aRxVRe60U4qmv/e96UBMEqiH
	 ityPcDMg4ol4mZcnqai18tN2S1ziyekLXbFWhcN7fBBNop/wumz5cn9keDGITmCaJn
	 6UrnFqADAGI8A+XnFP/IXli/jYf422WCyd5yyUcmL6//yPahxsyjZpF9MK9OcexQvq
	 8DYWjk1Vdtn0OQooTZ7/BDkrsFo1PgBy8UnZiUHFuWAo2HQXDarVjFuyHkNqBCdyCF
	 tUUXAQyFrG+OQ2VmD3IyCKfyVOmmmAazH8AmYn1cb8Lxgmyum0eNkYGkpUQ/VWhrCl
	 TT1eORAjaUnSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Lin.Cao" <lincao12@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: fix a memory leak in fence cleanup when unloading
Date: Sun, 14 Sep 2025 22:31:27 -0400
Message-ID: <20250915023127.376435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091359-extruding-tartly-9ee4@gregkh>
References: <2025091359-extruding-tartly-9ee4@gregkh>
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
index cb73d06e1d38d..e1ba061987833 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -368,9 +368,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
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


