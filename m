Return-Path: <stable+bounces-206217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D024D00137
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EB63301E6B0
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C193164B8;
	Wed,  7 Jan 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwmDWPV5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA8623C8A0
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819459; cv=none; b=kaHjo/kWPzj39JCux7vN3WU7p+4ZvviJtAqwLVe0YV/Zs9scFC9MwkZPRLYCHA+U08HPqvZw+HMo/I+FzXdmKgRX//G3a3ziBoa0WLDOgDvrgWWxh47xXmzVBeLoPjaEEU0jMGnrlzgxmEW/iUamVo3PDcCwu6BR7clfLyJwSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819459; c=relaxed/simple;
	bh=CSGcwqvOTPaXU71fi2e5eFyS/0NAMhyqz5X410JKelk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3wfB++67i4zy3LO487YSgRGIYzGMwFuaFAY5ueV0QV+crpkwLoE6yiVP8e0UVyWySzcyYWTbdQ15ABux+FfR4+qHi8dfLWEonCI7UvvPbRrpCQyVYPDimmPaYBJUKbTyTkGt0HOh1NvH0YzRanNXf9OVrhzZK6+jA0pOyN+S18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwmDWPV5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767819458; x=1799355458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CSGcwqvOTPaXU71fi2e5eFyS/0NAMhyqz5X410JKelk=;
  b=CwmDWPV5d/t2gcLfh8CREn6FtxUjqzQJA3qQ6km4tyVl64Le7GuCboSM
   1zMKsyIBPbTt+rOXEpzYrLd7Lss3THCvcaUPAZaMMpsoaHSBXPqhmvEKX
   E5s83Jb9N9X0VXUWhu9fkbs81+vjmf2y01idOCGSDdyGwibpzkCTvgRfi
   EtIxQyCyprUoN3jWX5G15krbH5lEUe50QhDZIkA2FaGkXyOHVkfpypJrv
   aHOwuxjccZHXgKYqOgmp8eGF0g5zKuvTW+dyZO5oymW0vSHMk8Tj8l7Ac
   wJTYwXZ0vSaZy/EUwp84BwpcxpEIgcTx4AL0sIh+c80a7H5WgAgV6goxb
   A==;
X-CSE-ConnectionGUID: 7wUDCPFaT16UZQ0M9rVCpA==
X-CSE-MsgGUID: BWvEcMUlRciGnH0tFrsaTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="79836929"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="79836929"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:57:37 -0800
X-CSE-ConnectionGUID: RUoPGpWOTTGbW7jHosri5Q==
X-CSE-MsgGUID: OdvhppHXQAWV0vEa9CJrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203470140"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 12:57:37 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stuart.summers@intel.com,
	arselan.alvi@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe: Adjust page count tracepoints in shrinker
Date: Wed,  7 Jan 2026 12:57:32 -0800
Message-Id: <20260107205732.2267541-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page accounting can change via the shrinker without calling
xe_ttm_tt_unpopulate(), which normally updates page count tracepoints
through update_global_total_pages. Add a call to
update_global_total_pages when the shrinker successfully shrinks a BO.

v2:
 - Don't adjust global accounting when pinning (Stuart)

Cc: stable@vger.kernel.org
Fixes: ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace points")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8b6474cd3eaf..6ab52fa397e3 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1054,6 +1054,7 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 			       unsigned long *scanned)
 {
 	struct xe_device *xe = ttm_to_xe_device(bo->bdev);
+	struct ttm_tt *tt = bo->ttm;
 	long lret;
 
 	/* Fake move to system, without copying data. */
@@ -1078,8 +1079,10 @@ static long xe_bo_shrink_purge(struct ttm_operation_ctx *ctx,
 			      .writeback = false,
 			      .allow_move = false});
 
-	if (lret > 0)
+	if (lret > 0) {
 		xe_ttm_tt_account_subtract(xe, bo->ttm);
+		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
+	}
 
 	return lret;
 }
@@ -1165,8 +1168,10 @@ long xe_bo_shrink(struct ttm_operation_ctx *ctx, struct ttm_buffer_object *bo,
 	if (needs_rpm)
 		xe_pm_runtime_put(xe);
 
-	if (lret > 0)
+	if (lret > 0) {
 		xe_ttm_tt_account_subtract(xe, tt);
+		update_global_total_pages(bo->bdev, -(long)tt->num_pages);
+	}
 
 out_unref:
 	xe_bo_put(xe_bo);
-- 
2.34.1


