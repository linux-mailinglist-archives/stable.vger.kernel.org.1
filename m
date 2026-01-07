Return-Path: <stable+bounces-206065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE8CFB734
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2B7301FF78
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352D17B425;
	Wed,  7 Jan 2026 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LocUwEuX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DA15CD7E
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745324; cv=none; b=dl9k9CUzJcyf0Uw6O/tdEQSIxWHEhOYHMr6MF/jnjxdB1QydWDJoJb5QRdN+xXdPtDdTg0A8A9iAxjAOmS2gBs/ScBe9mJGbQJs9cTLuKBNRZxoaEvGRKaoaFk2k/VPfeyhG+mqA9sWxRMAeRP7zOZotSbj1M4T4sDu96ejlk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745324; c=relaxed/simple;
	bh=2sOWIa0qSYW/W6fnwloOu0tp3mpkaPLNLIrk5BmtuAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvRp5XXRfxRF1jv/OyKgqv97tJ1xtl5ehrtor+8OYhB18AXOvTC927xHq/K8ubNCly5Uahd+RZDPiwitf/UYBMYLr489ujjT3AokPwZTxZ4ZqcbswcTyrDUaaaiD1EDR/DM+AEyVMX7CBj6/xXzyXxWuT84MdQaZi9bBC4oEHxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LocUwEuX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767745323; x=1799281323;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2sOWIa0qSYW/W6fnwloOu0tp3mpkaPLNLIrk5BmtuAk=;
  b=LocUwEuXTbPT8NmCzPoSPvRjzqomWc4jLwEbBhZaR78dfi+Lk/G6HSN1
   yZL3sMafLNkGu7rbS+uzc/0yOlA95S7iEXP0Rwef/gR8UzEToP6MPgBOD
   RzvhJ9dSi3PHvzMQ7efsXc+Ex13r/dS9HlvlyePXTXgkMyTiQwMIrPkEq
   J+CXlwDTD5w4RqQfGc9JR3kPNQ7LnxOwQXfyWbZZ7HMlg2MOO3D4KiWRW
   lNMEyyGZqfzLfyt6ZW03AXmFO+S6LdNDJUs9AVGWvIDwmzmW7kjwZg0Nj
   PoplwknPEqE5Ue9IOfwrJOc/JRVcV+eetEO6nUSaqn3Lw4LiGZALvDjBf
   w==;
X-CSE-ConnectionGUID: Pj8jVs8DQ8i9Q/rcUhBVig==
X-CSE-MsgGUID: D/Je3LDoTK+lH4sSzb+OQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="94582140"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="94582140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:22:02 -0800
X-CSE-ConnectionGUID: 9jdUOszTTB6NiBGgh0Y8lA==
X-CSE-MsgGUID: yR0VIK1MSe253n4kpjTwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="233486969"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:22:03 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: arselan.alvi@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Tie page count tracepoints to TTM accounting functions
Date: Tue,  6 Jan 2026 16:21:54 -0800
Message-Id: <20260107002154.1934332-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page accounting can change via the shrinker without calling
xe_ttm_tt_unpopulate(), but those paths already update accounting
through the xe_ttm_tt_account_*() helpers.

Move the page count tracepoints into xe_ttm_tt_account_add() and
xe_ttm_tt_account_subtract() so accounting updates are recorded
consistently, regardless of whether pages are populated, unpopulated,
or reclaimed via the shrinker.

This avoids missing page count updates and keeps global accounting
balanced across all TT lifecycle paths.

Cc: stable@vger.kernel.org
Fixes: ce3d39fae3d3 ("drm/xe/bo: add GPU memory trace points")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8b6474cd3eaf..33afaee38f48 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -432,6 +432,9 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
 	return xe_tt->sg;
 }
 
+static void update_global_total_pages(struct ttm_device *ttm_dev,
+				      long num_pages);
+
 /*
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
@@ -440,6 +443,7 @@ static void xe_ttm_tt_account_add(struct xe_device *xe, struct ttm_tt *tt)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
+	update_global_total_pages(&xe->ttm, tt->num_pages);
 	if (xe_tt->purgeable)
 		xe_shrinker_mod_pages(xe->mem.shrinker, 0, tt->num_pages);
 	else
@@ -450,6 +454,7 @@ static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt)
 {
 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
 
+	update_global_total_pages(&xe->ttm, -(long)tt->num_pages);
 	if (xe_tt->purgeable)
 		xe_shrinker_mod_pages(xe->mem.shrinker, 0, -(long)tt->num_pages);
 	else
@@ -575,7 +580,6 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
 
 	xe_tt->purgeable = false;
 	xe_ttm_tt_account_add(ttm_to_xe_device(ttm_dev), tt);
-	update_global_total_pages(ttm_dev, tt->num_pages);
 
 	return 0;
 }
@@ -592,7 +596,6 @@ static void xe_ttm_tt_unpopulate(struct ttm_device *ttm_dev, struct ttm_tt *tt)
 
 	ttm_pool_free(&ttm_dev->pool, tt);
 	xe_ttm_tt_account_subtract(xe, tt);
-	update_global_total_pages(ttm_dev, -(long)tt->num_pages);
 }
 
 static void xe_ttm_tt_destroy(struct ttm_device *ttm_dev, struct ttm_tt *tt)
-- 
2.34.1


