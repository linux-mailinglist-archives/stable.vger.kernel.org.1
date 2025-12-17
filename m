Return-Path: <stable+bounces-202786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48640CC6D95
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446613076A1C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138934164C;
	Wed, 17 Dec 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pfh/wVpt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE85341042
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964110; cv=none; b=Thg7i8Al517royb+vVkiW7OLBlmcF1vZ+98OHa6jB1pgoUfv2Gkv8sjDoYFPgDclKBRYmAWAyrWSytXelXIXLo6HMILZQpCDhViciV1vciFR4HdL798v82dYOLf1ppMzEAKUwk0PdlQDsRICkbMS7IWo6U13/M6sb3z5w4WV5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964110; c=relaxed/simple;
	bh=cZKzx4/E5g/AiPNRpcZHQSv4imDklkFdnm2n9sk3TRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rg5bGRlhClkMbPwccMeX7JunzzMEa0IgVKdzWaDSfYfhe7Q7jVi9dd8GVO2pVCyjr01KECRpstP//qVCOxJA6cOgb7p1ulhfXtJscyiWj9MRWDL2AdGdaVSA+9uE6LBlR54vhfvQhD3BHgZDQRjWZLDnX8hCZnRoOaIUPlO7amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pfh/wVpt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765964108; x=1797500108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cZKzx4/E5g/AiPNRpcZHQSv4imDklkFdnm2n9sk3TRg=;
  b=Pfh/wVptU2QXZPHABed0UjIsJRJknDWYsKtpAvevGYze/rfH0YJFqMOE
   4eeWtBEnqsCj9Xf+DPRbM3QCvLiIrP2lkHsy5DAW5EjlxSWUtYZ1YqpRz
   +uSrg4S1h6ORAyqwntwExAivf1+skT68sZciDjOuXKnQCYs6BNcvM55ph
   S6kNw+w8eV/NbW1sMIxhh22rn3smRNLL6lXHY/4wLUpYsLO2X4DHPYQiR
   gXzkfMdK9Z2/xfXgs3mrXY5XTj5WpGZQ+S2AHom95zCzO016FDNIp/FgZ
   8DeTtGEKk+na4qClG30XGG/YArYCv53r0W5RyO/ZkgzYbfnetx830COYH
   Q==;
X-CSE-ConnectionGUID: P1Zn5A+bS96b3Vw1idS2PA==
X-CSE-MsgGUID: dlsr5cHZR6mzvovgAvh86A==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="85313595"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="85313595"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 01:35:05 -0800
X-CSE-ConnectionGUID: 0bHy8PbySFq4OtT84BRuiQ==
X-CSE-MsgGUID: qe/Yb2ZnTvyW3ZFo0iowbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="197357035"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.149])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 01:35:03 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Drop preempt-fences when destroying imported dma-bufs.
Date: Wed, 17 Dec 2025 10:34:41 +0100
Message-ID: <20251217093441.5073-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When imported dma-bufs are destroyed, TTM is not fully
individualizing the dma-resv, but it *is* copying the fences that
need to be waited for before declaring idle. So in the case where
the bo->resv != bo->_resv we can still drop the preempt-fences, but
make sure we do that on bo->_resv which contains the fence-pointer
copy.

In the case where the copying fails, bo->_resv will typically not
contain any fences pointers at all, so there will be nothing to
drop. In that case, TTM would have ensured all fences that would
have been copied are signaled, including any remaining preempt
fences.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6280e6a013ff..8b6474cd3eaf 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1526,7 +1526,7 @@ static bool xe_ttm_bo_lock_in_destructor(struct ttm_buffer_object *ttm_bo)
 	 * always succeed here, as long as we hold the lru lock.
 	 */
 	spin_lock(&ttm_bo->bdev->lru_lock);
-	locked = dma_resv_trylock(ttm_bo->base.resv);
+	locked = dma_resv_trylock(&ttm_bo->base._resv);
 	spin_unlock(&ttm_bo->bdev->lru_lock);
 	xe_assert(xe, locked);
 
@@ -1546,13 +1546,6 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	bo = ttm_to_xe_bo(ttm_bo);
 	xe_assert(xe_bo_device(bo), !(bo->created && kref_read(&ttm_bo->base.refcount)));
 
-	/*
-	 * Corner case where TTM fails to allocate memory and this BOs resv
-	 * still points the VMs resv
-	 */
-	if (ttm_bo->base.resv != &ttm_bo->base._resv)
-		return;
-
 	if (!xe_ttm_bo_lock_in_destructor(ttm_bo))
 		return;
 
@@ -1562,14 +1555,14 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	 * TODO: Don't do this for external bos once we scrub them after
 	 * unbind.
 	 */
-	dma_resv_for_each_fence(&cursor, ttm_bo->base.resv,
+	dma_resv_for_each_fence(&cursor, &ttm_bo->base._resv,
 				DMA_RESV_USAGE_BOOKKEEP, fence) {
 		if (xe_fence_is_xe_preempt(fence) &&
 		    !dma_fence_is_signaled(fence)) {
 			if (!replacement)
 				replacement = dma_fence_get_stub();
 
-			dma_resv_replace_fences(ttm_bo->base.resv,
+			dma_resv_replace_fences(&ttm_bo->base._resv,
 						fence->context,
 						replacement,
 						DMA_RESV_USAGE_BOOKKEEP);
@@ -1577,7 +1570,7 @@ static void xe_ttm_bo_release_notify(struct ttm_buffer_object *ttm_bo)
 	}
 	dma_fence_put(replacement);
 
-	dma_resv_unlock(ttm_bo->base.resv);
+	dma_resv_unlock(&ttm_bo->base._resv);
 }
 
 static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
-- 
2.51.1


