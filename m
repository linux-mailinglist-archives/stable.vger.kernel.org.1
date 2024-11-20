Return-Path: <stable+bounces-94400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1A9D3D16
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E99FB28EF6
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A231C3F0B;
	Wed, 20 Nov 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrfXi9vn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A331C32FF;
	Wed, 20 Nov 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111594; cv=none; b=JYQPJ4yTFf9vKpcn6tM8ITl2sPmcj9QW6ZyUlcS6a3/E5jhRcU+WISWsdthL1//8QwMoUkBpm311UQZapHFVklkuAW0BHP4rmnqeLgJrRsKGPKmxhNAOgVXsPmGDlJey7kMr/ARGNngrcoWq58S3VkzDUEsUNYUOpkog7zatXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111594; c=relaxed/simple;
	bh=snK4haJGbbF0ladFXJRDOWEkiDsVD/apKtbr/fWv7JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpH3oXAfSJInipfPTN22Gj0ayiCxPJujmR3nzGz8rvU4wHGQ2fvhbCLGuqbEQmucD9kN88i+2Lt05vCoLSZRIxqxdA8M3fjdzMQThK9+HSuLuXbj3/aYuVbBu9MzYC7vDpUqIuvSjUxBnjwH4z6Z6xyijBUCnIhm1Beif11h0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrfXi9vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D97C4CECD;
	Wed, 20 Nov 2024 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111594;
	bh=snK4haJGbbF0ladFXJRDOWEkiDsVD/apKtbr/fWv7JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrfXi9vnePm6UyBYnED+lnoz9J0bquH4uedjObYscR6tSFvYpFJ494Tj40d4V8DNL
	 1XxtJ5x1pRq+awrBpIgnSwwQ7X9pIgiqnJjd1b6lqng3Jbk7RGCCx6afZnXODe2ebp
	 xqbKH/mT+JNqW2RaxI8OJPhY/a3A8rVCmDPZ85+mtzRuNAAWYP4yzC3Xpbu5NoVa6L
	 ZhKVCScHpMZcJQg8g01D6kmNIjBsILWaQ2b1njPujXzpZSY2Sbrvn06qQoqd+IsbyV
	 pLiEY6TNOApyjNdy7eR1yLyBsYGa51crbhzMKwa2X7nQTYbttcg+Fvrm0XJysHOBAX
	 rP5JWbD24H16A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 09/10] drm/xe: Restore system memory GGTT mappings
Date: Wed, 20 Nov 2024 09:05:34 -0500
Message-ID: <20241120140556.1768511-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit dd886a63d6e2ce5c16e662c07547c067ad7d91f5 ]

GGTT mappings reside on the device and this state is lost during suspend
/ d3cold thus this state must be restored resume regardless if the BO is
in system memory or VRAM.

v2:
 - Unnecessary parentheses around bo->placements[0] (Checkpatch)

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241031182257.2949579-1-matthew.brost@intel.com
(cherry picked from commit a19d1db9a3fa89fabd7c83544b84f393ee9b851f)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c       | 14 +++++++++++---
 drivers/gpu/drm/xe/xe_bo_evict.c |  1 -
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index e147ef1d0578f..c096e5c06f726 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -869,8 +869,8 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
 	if (WARN_ON(!xe_bo_is_pinned(bo)))
 		return -EINVAL;
 
-	if (WARN_ON(!xe_bo_is_vram(bo)))
-		return -EINVAL;
+	if (!xe_bo_is_vram(bo))
+		return 0;
 
 	ret = ttm_bo_mem_space(&bo->ttm, &placement, &new_mem, &ctx);
 	if (ret)
@@ -920,6 +920,7 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 		.interruptible = false,
 	};
 	struct ttm_resource *new_mem;
+	struct ttm_place *place = &bo->placements[0];
 	int ret;
 
 	xe_bo_assert_held(bo);
@@ -933,6 +934,9 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
 		return -EINVAL;
 
+	if (!mem_type_is_vram(place->mem_type))
+		return 0;
+
 	ret = ttm_bo_mem_space(&bo->ttm, &bo->placement, &new_mem, &ctx);
 	if (ret)
 		return ret;
@@ -1740,7 +1744,10 @@ int xe_bo_pin(struct xe_bo *bo)
 			place->fpfn = (xe_bo_addr(bo, 0, PAGE_SIZE) -
 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
+		}
 
+		if (mem_type_is_vram(place->mem_type) ||
+		    bo->flags & XE_BO_FLAG_GGTT) {
 			spin_lock(&xe->pinned.lock);
 			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
 			spin_unlock(&xe->pinned.lock);
@@ -1801,7 +1808,8 @@ void xe_bo_unpin(struct xe_bo *bo)
 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
 		struct ttm_place *place = &(bo->placements[0]);
 
-		if (mem_type_is_vram(place->mem_type)) {
+		if (mem_type_is_vram(place->mem_type) ||
+		    bo->flags & XE_BO_FLAG_GGTT) {
 			spin_lock(&xe->pinned.lock);
 			xe_assert(xe, !list_empty(&bo->pinned_link));
 			list_del_init(&bo->pinned_link);
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 541b49007d738..32043e1e5a863 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -159,7 +159,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
 		 * should setup the iosys map.
 		 */
 		xe_assert(xe, !iosys_map_is_null(&bo->vmap));
-		xe_assert(xe, xe_bo_is_vram(bo));
 
 		xe_bo_put(bo);
 
-- 
2.43.0


