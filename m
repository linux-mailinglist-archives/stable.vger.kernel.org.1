Return-Path: <stable+bounces-242833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCWyKvkf+GlXqQIAu9opvQ
	(envelope-from <stable+bounces-242833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F038D4B8579
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86FC9300914A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CB221F1F;
	Mon,  4 May 2026 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVFgeO7f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26A8460;
	Mon,  4 May 2026 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777868787; cv=none; b=FzcF1C+GCFj+jJIeyA07cT9hHnasbjDi8Y9bCXZH4Vr9bRmTKwnxFKSXrMXBp0979Dgls+1RO9JecRoixOa1Z/mtR+vOA/VmQ8LPl7w2xWCbtZJwlInaSYstEZOKO400+XP7SLYN43ofGjhCNByc0OjC/WJAzK/v/SsPnb6xTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777868787; c=relaxed/simple;
	bh=zQoMfteVnaQntgARLaVx8wlm8c/AUEr2e+lBsP4Ho+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t8SWPFJnYLJCl87+yY3wy7CsXXT630hzAjEMwqYmaf3xn/UNyRZobkIT7rSfyBRlyRuFcb7vo+EjvKaonk26kp87TKHRROflRaTmJjHuZdM/tWIuVriB4YHuFf1V26rmSXaQCV12FQa5vVJvfeM0COoZtvRGK+RRxqTqiKQRP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVFgeO7f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777868785; x=1809404785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zQoMfteVnaQntgARLaVx8wlm8c/AUEr2e+lBsP4Ho+M=;
  b=mVFgeO7fsbukB63RdrA/+6ov4LF4RVIfpKfPFHmKQs4M9ycbeotcrZSQ
   DWLq+zkl3fpxv90gglkUNuWPphciiA1NuqcrBahYMZtri1K/92SibdtiL
   rqbUEIoxuoMkQu44xX1aIFNt/gSU1Z5l2I7B4bZ3zXSlDURv35zI+QBSl
   Ou62mYBzBPOUMAys3AnBrbksSyjYZ3UHiD7chlt2rhGf423NOe752yH57
   Gx3vPEFFeGBRLxLsVf6MQFGtN19hT9RZYuvlZXcBat3VlevEMpJheey96
   t2TFcYSgSNilxrjBEhxs+Rzszz+9qjQ54pNVTOplgXN9a4/DNnfz4Ooxc
   Q==;
X-CSE-ConnectionGUID: esNtiOulS4e+V2N1RyjDwg==
X-CSE-MsgGUID: fg+fJGheTTOT8p54PqZIXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89310104"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="89310104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 21:26:24 -0700
X-CSE-ConnectionGUID: Y0w/qymWRYSKFzEN1c0S/w==
X-CSE-MsgGUID: ML5LaMruRSyjXh94W4zzfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; 
   d="scan'208";a="235666547"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 21:26:23 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH] drm/ttm/pool: back up at native page order
Date: Sun,  3 May 2026 21:26:19 -0700
Message-Id: <20260504042619.2896273-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F038D4B8579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242833-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

ttm_pool_split_for_swap() splits high-order pool pages into order-0
pages during backup so each 4K page can be released to the system as
soon as it has been written to shmem. While this minimizes the
allocator's working set during reclaim, it actively fragments memory:
every TTM-backed compound page that the shrinker touches is shattered
into order-0 pages, even when the rest of the system would prefer that
the high-order block stay intact. Under sustained kswapd pressure this
is enough to drive other parts of MM into recovery loops from which
they cannot easily escape, because the memory TTM just freed is no
longer contiguous.

Stop splitting on the backup path and back up each compound atomically
at its native order in ttm_pool_backup():

  - For each non-handle slot, read the order from the head page and
    back up all 1<<order subpages to consecutive shmem indices,
    writing the resulting handles into tt->pages[] as we go.
  - On any per-subpage backup failure, drop the handles we just wrote
    for this compound and restore the original page pointers, so the
    compound is left fully intact and may be retried later. shrunken
    is only incremented once the whole compound succeeds.
  - On success, the compound is freed once at its native order. No
    split_page(), no per-4K refcount juggling, no fragmentation
    introduced from this path.
  - Slots that already hold a backup handle from a previous partial
    attempt are skipped. A compound that would extend past a
    fault-injection-truncated num_pages is skipped rather than split.

The restore-side leftover-page branch in ttm_pool_restore_commit() is
left as-is for now: that path can still split a previously-retained
compound, but in practice it is unreachable under realistic workloads
(per profiling we have not been able to trigger it), so it is not
worth complicating the restore state machine to avoid the split there.
If it ever becomes a problem in practice it can be addressed
independently.

ttm_pool_split_for_swap() itself is retained for the restore path's
sole remaining caller. The DMA-mapped pre-backup unmap loop, the
purge path, ttm_pool_free_*, and ttm_pool_unmap_and_free() already
operate at native order and are unchanged.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to shrink pages")
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

A follow-up should attempt writeback to shmem at folio order as well,
but the API for doing so is unclear and may be incomplete.

This patch is related to the pending series [1] and significantly
reduces the likelihood of Xe entering a kswapd loop under fragmentation.
The kswapd → shrinker → Xe shrinker → TTM backup path is still
exercised; however, with this change the backup path no longer worsens
fragmentation, which previously amplified reclaim pressure and
reinforced the kswapd loop.

Nonetheless, the pathological case that [1] aims to address still exists
and requires a proper solution. Even with this patch, a kswapd loop due
to severe fragmentation can still be triggered, although it is now
substantially harder to reproduce.

[1] https://patchwork.freedesktop.org/series/165330/
---
 drivers/gpu/drm/ttm/ttm_pool.c | 71 +++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..5ead0aba4bb7 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1036,12 +1036,11 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 {
 	struct file *backup = tt->backup;
 	struct page *page;
-	unsigned long handle;
 	gfp_t alloc_gfp;
 	gfp_t gfp;
 	int ret = 0;
 	pgoff_t shrunken = 0;
-	pgoff_t i, num_pages;
+	pgoff_t i, num_pages, npages;
 
 	if (WARN_ON(ttm_tt_is_backed_up(tt)))
 		return -EINVAL;
@@ -1097,28 +1096,72 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
 		num_pages = DIV_ROUND_UP(num_pages, 2);
 
-	for (i = 0; i < num_pages; ++i) {
-		s64 shandle;
+	for (i = 0; i < num_pages; i += npages) {
+		unsigned int order;
+		pgoff_t j;
 
+		npages = 1;
 		page = tt->pages[i];
 		if (unlikely(!page))
 			continue;
 
-		ttm_pool_split_for_swap(pool, page);
+		/* Already-handled entry from a previous attempt. */
+		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
+			continue;
 
-		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
-						 gfp, alloc_gfp);
-		if (shandle < 0) {
-			/* We allow partially shrunken tts */
-			ret = shandle;
+		order = ttm_pool_page_order(pool, page);
+		npages = 1UL << order;
+
+		/*
+		 * Back up the compound atomically at its native order. If
+		 * fault injection truncated num_pages mid-compound, skip
+		 * the partial tail rather than splitting.
+		 */
+		if (unlikely(i + npages > num_pages))
 			break;
+
+		for (j = 0; j < npages; ++j) {
+			unsigned long handle;
+			s64 shandle;
+
+			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
+			    should_fail(&backup_fault_inject, 1))
+				shandle = -1;
+			else
+				shandle = ttm_backup_backup_page(backup, page + j,
+								 flags->writeback,
+								 i + j, gfp,
+								 alloc_gfp);
+
+			if (unlikely(shandle < 0)) {
+				pgoff_t k;
+
+				ret = shandle;
+				/*
+				 * Roll back: drop the handles we just wrote
+				 * and restore the original page pointers so
+				 * the compound remains intact and may be
+				 * retried later.
+				 */
+				for (k = 0; k < j; ++k) {
+					handle = ttm_backup_page_ptr_to_handle(tt->pages[i + k]);
+					ttm_backup_drop(backup, handle);
+					tt->pages[i + k] = page + k;
+				}
+
+				goto out;
+			}
+			handle = shandle;
+			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(shandle);
 		}
-		handle = shandle;
-		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
-		__free_pages_gpu_account(page, 0, false);
-		shrunken++;
+
+		/* Compound fully backed up; free at native order. */
+		page->private = 0;
+		__free_pages_gpu_account(page, order, false);
+		shrunken += npages;
 	}
 
+out:
 	return shrunken ? shrunken : ret;
 }
 
-- 
2.34.1


