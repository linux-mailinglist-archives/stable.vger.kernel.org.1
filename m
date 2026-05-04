Return-Path: <stable+bounces-243933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EgsO+Ir+Wk86QIAu9opvQ
	(envelope-from <stable+bounces-243933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5D4C4D2C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3DF03028B19
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC03D300E;
	Mon,  4 May 2026 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJv3k0Yr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D953D0926;
	Mon,  4 May 2026 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937359; cv=none; b=hVm0IUYICBjG1ds28oNrdTUwU9YsZ5Qlkqo/NUClxePNve1MnMs88e8PVS1Mn7eM2Li/6vSU96SivVh4k3759Cw1wieJh0Ht9wakpmWpKPVxITOJvxE4NpCcoKiWkV/toPxR+0IquLRi+C9vT/j9ArPn2o3yESm0OwZ44b9GBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937359; c=relaxed/simple;
	bh=D4bRlDJqbmkrqhygiZUwPPCzNuNKuwuOZ58/BaNil04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg4d/lPagDECrmiu2YIEW4Fwe48dHSJnZ3743In7EAGtDN+I8t0J1+wsgxwUOf1gACHH0WhgAiHimLoT1e3c+mojMkeGe/6Wgmzj0IXYxJ6bn2cWRiZHhS0wZ3WXHs5rvm1o3h4LC3Gpgew5JNZJvK+81U63BKroPWi2nkkTvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJv3k0Yr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777937358; x=1809473358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4bRlDJqbmkrqhygiZUwPPCzNuNKuwuOZ58/BaNil04=;
  b=WJv3k0YrSlv882n2sCNltiUG9YcKvEbo6yywYR2wBd1f1phsCnM2DhIQ
   6N7DaNK/OGDlrXc7Xjv4Xtw8FLpPGaDo3mZwLMxI7R55WP76dWlZvJe9y
   OOAdBp7tGknNfKIrqOEDRAhSZvkG2/7E9aZDcpP2GdsK89nzqAJMEw5R2
   R/zvTYAVdfNQMi+FD51WVPEYiSX6AMhlxScOoHw2vKI2b9c/SsQrNIFOK
   Ksc1JQkreSAJt73vMdevVDJqG1ZAYHB4j2nO7ifPareWfDm6dOYgLIR/6
   J7mFYf+A/rYAsFINLo0SDVdnpc+BnftJxFth2qncHhc3o8bKy8318Ff/6
   A==;
X-CSE-ConnectionGUID: VKzo2pHDRkaY+ujVYx7JXw==
X-CSE-MsgGUID: TO54+YowQcqMzZDRKY/EXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89497288"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89497288"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 16:29:15 -0700
X-CSE-ConnectionGUID: XtP0aJglQ72vw15qkR3y/g==
X-CSE-MsgGUID: vtgklWZ6QcagW/7/gVMIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239626117"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 16:29:15 -0700
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
Subject: [PATCH v2 2/2] drm/ttm/pool: back up at native page order
Date: Mon,  4 May 2026 16:29:10 -0700
Message-Id: <20260504232910.3249376-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504232910.3249376-1-matthew.brost@intel.com>
References: <20260504232910.3249376-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75E5D4C4D2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243933-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Stop unconditionally splitting on the backup path and back up each
compound at its native order in ttm_pool_backup():

  - For each non-handle slot, read the order from the head page and
    back up all 1<<order subpages to consecutive shmem indices,
    writing the resulting handles into tt->pages[] as we go.
  - On success, the compound is freed once at its native order. No
    split_page(), no per-4K refcount juggling, no fragmentation
    introduced from this path.
  - Slots that already hold a backup handle from a previous partial
    attempt are skipped. A compound that would extend past a
    fault-injection-truncated num_pages is skipped rather than split.

A per-subpage backup failure cannot be made fully atomic: backing up a
subpage allocates a shmem folio before the source page can be released,
so under true OOM any subpage in a compound (not just the first) may
fail to be backed up with the rest of the source compound still live
and contiguous. To make forward progress in that case, fall back to
splitting the source compound and backing up its remaining subpages
individually:

  - On the first per-subpage failure for a compound (and only if
    order > 0), call ttm_pool_split_for_swap() to split the source
    compound, release the subpages whose contents already live in
    shmem (their handles in tt->pages stay valid), and retry the
    failing subpage at order 0.
  - Subsequent successful subpage backups in the now-split compound
    free their source page individually as soon as the handle is
    written.
  - A second failure after splitting terminates the loop with partial
    progress; the remaining order-0 subpages stay in tt->pages as
    plain page pointers and are cleaned up by the normal
    ttm_pool_drop_backed_up() / ttm_pool_free_range() paths.

This restores the original split-on-OOM fallback behavior while
keeping the common, non-OOM case fragmentation-free. It also
preserves the "partial backup is allowed" contract: shrunken is
incremented per backed-up subpage so the caller still sees forward
progress when a compound only partially succeeds.

The restore-side leftover-page branch in ttm_pool_restore_commit() is
left as-is for now: that path can still split a previously-retained
compound, but in practice it is unreachable under realistic workloads
(per profiling we have not been able to trigger it), so it is not
worth complicating the restore state machine to avoid the split there.
If it ever becomes a problem in practice it can be addressed
independently.

ttm_pool_split_for_swap() itself is retained both for the OOM
fallback above and for the restore path's remaining caller. The
DMA-mapped pre-backup unmap loop, the purge path, ttm_pool_free_*,
and ttm_pool_unmap_and_free() already operate at native order and
are unchanged.

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

v2:
 - Split pages and free immediately if backup fails are higher order
   (Thomas)

[1] https://patchwork.freedesktop.org/series/165330/
---
 drivers/gpu/drm/ttm/ttm_pool.c | 84 ++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 084768d6d9b1..5345297b5ef9 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1039,12 +1039,11 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
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
@@ -1100,28 +1099,85 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	if (IS_ENABLED(CONFIG_FAULT_INJECTION) && should_fail(&backup_fault_inject, 1))
 		num_pages = DIV_ROUND_UP(num_pages, 2);
 
-	for (i = 0; i < num_pages; ++i) {
-		s64 shandle;
+	for (i = 0; i < num_pages; i += npages) {
+		unsigned int order;
+		pgoff_t j;
+		bool folio_has_been_split = false;
 
+		npages = 1;
 		page = tt->pages[i];
 		if (unlikely(!page))
 			continue;
 
-		ttm_pool_split_for_swap(pool, page);
+		/* Already-handled entry from a previous attempt. */
+		if (unlikely(ttm_backup_page_ptr_is_handle(page)))
+			continue;
+
+		order = ttm_pool_page_order(pool, page);
+		npages = 1UL << order;
 
-		shandle = ttm_backup_backup_page(backup, page, flags->writeback, i,
-						 gfp, alloc_gfp);
-		if (shandle < 0) {
-			/* We allow partially shrunken tts */
-			ret = shandle;
+		/*
+		 * Back up the compound atomically at its native order. If
+		 * fault injection truncated num_pages mid-compound, skip
+		 * the partial tail rather than splitting.
+		 */
+		if (unlikely(i + npages > num_pages))
 			break;
+
+		for (j = 0; j < npages; ++j) {
+			s64 shandle;
+
+try_again_after_split:
+			if (IS_ENABLED(CONFIG_FAULT_INJECTION) &&
+			    should_fail(&backup_fault_inject, 1))
+				shandle = -ENOMEM;
+			else
+				shandle = ttm_backup_backup_page(backup, page + j,
+								 flags->writeback,
+								 i + j, gfp,
+								 alloc_gfp);
+
+			if (shandle < 0 && !folio_has_been_split && order) {
+				pgoff_t k;
+
+				/*
+				 * True OOM: could not allocate a shmem folio
+				 * for the next subpage. Fall back to splitting
+				 * the source compound and backing up subpages
+				 * individually. Release the already-backed-up
+				 * subpages whose contents now live in shmem;
+				 * any further failure terminates the loop with
+				 * partial progress (handled by the caller).
+				 */
+				folio_has_been_split = true;
+				ttm_pool_split_for_swap(pool, page);
+
+				for (k = 0; k < j; ++k) {
+					__free_pages_gpu_account(page + k, 0, false);
+					shrunken++;
+				}
+
+				goto try_again_after_split;
+			} else if (shandle < 0) {
+				ret = shandle;
+				goto out;
+			} else if (folio_has_been_split) {
+				__free_pages_gpu_account(page + j, 0, false);
+				shrunken++;
+			}
+
+			tt->pages[i + j] = ttm_backup_handle_to_page_ptr(shandle);
+		}
+
+		if (!folio_has_been_split) {
+			/* Compound fully backed up; free at native order. */
+			page->private = 0;
+			__free_pages_gpu_account(page, order, false);
+			shrunken += npages;
 		}
-		handle = shandle;
-		tt->pages[i] = ttm_backup_handle_to_page_ptr(handle);
-		__free_pages_gpu_account(page, 0, false);
-		shrunken++;
 	}
 
+out:
 	return shrunken ? shrunken : ret;
 }
 
-- 
2.34.1


