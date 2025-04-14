Return-Path: <stable+bounces-132454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3FA8820B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1643A89AB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511A2749DC;
	Mon, 14 Apr 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kwmv+d3d"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A618B0F
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637170; cv=none; b=Mvd04aXzuKcxw2sOsaQyUFuUxcUUgCFUe+QdK1GtkJ9isvuxji+aQoH/Wz/M3lv17fTIR8d0sshzFxfeL1/nreQ20gSg+y9v0I67EGwQmMSG6HRfMOG91n/cQg2a54VX8utO9BbyFLPaLZaDbMzTEcgGF60MKyUse/2/++M9bK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637170; c=relaxed/simple;
	bh=PKJ4Roznl3Yg2FWFUh3nz+SZkHXf4hT8t2CQq8HDJu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k3R6ZrS/YP3YHDO2AKPH+9bMl7YxrESGHDh94vtJE2UC4kGPuzj4LHVsUXY61K1QkobO1t3xz7gOg+5Zm5tc9OWyLTALY5IgkvEYJM+JZLFshzc48myh5fVmzJavzaspIRVaKhBhRBJx6D6l7OaX/9kk58lI4b4uEEsBSbF3TYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kwmv+d3d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744637168; x=1776173168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PKJ4Roznl3Yg2FWFUh3nz+SZkHXf4hT8t2CQq8HDJu0=;
  b=Kwmv+d3dEeUWPPrToNRbL1v/9lcXALnBigrcjPTwcdYTMfop8ogRXYhl
   DiTgXA/RUQlCGecSx7DLxIfmFTFYrVIQ5jJS8hE/UmIpyJlTkZj2Iosyz
   fS9vCoRkxvafMy+ALHBYqhamjC6IaQIET4QaItRycrqTQZP0MB+4e/V81
   yYnbAwcOd4gkvXOZOhBBZgD3dnKZQG4VO8nIjGgJUVVzlBt05MDe86ifg
   tWmQiLw0pXA2C0Y2eDZ6gB5Q85z/RIKXUTX4uhyKPlW8i0L7CnbxvQ5V2
   9JZsXlaf1W4HtGcmLSzMxx783HZoDgOA9ADBPninJMINX5bbo7crS4arI
   w==;
X-CSE-ConnectionGUID: QhY9ul6MTG6Dhfq+HNzmpA==
X-CSE-MsgGUID: tUklHGrvSFK5Fi+UBTN1lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45987897"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45987897"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:26:08 -0700
X-CSE-ConnectionGUID: 9GqZHTiWRkWZ4YmIK1iPkg==
X-CSE-MsgGUID: 6PazK+wXR7ySdV2awzdjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160775103"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:26:06 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/userptr: fix notifier vs folio deadlock
Date: Mon, 14 Apr 2025 14:25:40 +0100
Message-ID: <20250414132539.26654-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

User is reporting what smells like notifier vs folio deadlock, where
migrate_pages_batch() on core kernel side is holding folio lock(s) and
then interacting with the mappings of it, however those mappings are
tied to some userptr, which means calling into the notifier callback and
grabbing the notifier lock. With perfect timing it looks possible that
the pages we pulled from the hmm fault can get sniped by
migrate_pages_batch() at the same time that we are holding the notifier
lock to mark the pages as accessed/dirty, but at this point we also want
to grab the folio locks(s) to mark them as dirty, but if they are
contended from notifier/migrate_pages_batch side then we deadlock since
folio lock won't be dropped until we drop the notifier lock.

Fortunately the mark_page_accessed/dirty is not really needed in the
first place it seems and should have already been done by hmm fault, so
just remove it.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4765
Fixes: 0a98219bcc96 ("drm/xe/hmm: Don't dereference struct page pointers without notifier lock")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
---
 drivers/gpu/drm/xe/xe_hmm.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index c3cc0fa105e8..57b71956ddf4 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -19,29 +19,6 @@ static u64 xe_npages_in_range(unsigned long start, unsigned long end)
 	return (end - start) >> PAGE_SHIFT;
 }
 
-/**
- * xe_mark_range_accessed() - mark a range is accessed, so core mm
- * have such information for memory eviction or write back to
- * hard disk
- * @range: the range to mark
- * @write: if write to this range, we mark pages in this range
- * as dirty
- */
-static void xe_mark_range_accessed(struct hmm_range *range, bool write)
-{
-	struct page *page;
-	u64 i, npages;
-
-	npages = xe_npages_in_range(range->start, range->end);
-	for (i = 0; i < npages; i++) {
-		page = hmm_pfn_to_page(range->hmm_pfns[i]);
-		if (write)
-			set_page_dirty_lock(page);
-
-		mark_page_accessed(page);
-	}
-}
-
 static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
 		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
 {
@@ -331,7 +308,6 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 	if (ret)
 		goto out_unlock;
 
-	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
 	xe_hmm_userptr_set_mapped(uvma);
 	userptr->notifier_seq = hmm_range.notifier_seq;
-- 
2.49.0


