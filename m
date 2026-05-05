Return-Path: <stable+bounces-243950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLa/F7lg+WnW8AIAu9opvQ
	(envelope-from <stable+bounces-243950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:15:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05C4C61C8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 05:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0DB301DC12
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 03:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48453A6B97;
	Tue,  5 May 2026 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5uYN3Fd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A83A169F;
	Tue,  5 May 2026 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777950899; cv=none; b=qjyI1rrokCttatM65TB/oFPMDUUzwaVEq/+HyfiljTYnTSQTT/zX+FXX0UC7lDlfaAAGx/2dtN9coH5rMOBT5J3my7iCOVYGu+myIo0slfP5HWut6l91QqoELEKkftB0YVZDIKx+3S2JbAPikS94aNSgdmpNyip9gYJjSeo+rIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777950899; c=relaxed/simple;
	bh=fNhmiWxmGiirEt62bhncS7FDl+A8WLBmJYsxZetHEsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3OARUG1msGMreo+rJoFJwcXd3ncARSyQab00nZiMTz1bx2bfpOSur86lsqIFr//A/CpNY80JU2w5ODIDSLGinPY/9A6gIpIyt/+30wGRLgWCnmIybzaqeRx8ZPcNC1RLivOqacBG9neoUGVvEKGqgiGAmvehiuh9Jt2ZksKU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5uYN3Fd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777950896; x=1809486896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNhmiWxmGiirEt62bhncS7FDl+A8WLBmJYsxZetHEsY=;
  b=M5uYN3Fd22bN5J6LUI5+Ud+SdiopSBWcytIG/i/MkJJt3ShjOpCAvR+d
   Vsef2gq8XF7f7hl4c2udrx1weWZIwVN3ljgTC5/36J/YEW35SgcDyVTsN
   CDyNk1V8hsJWzyDttoMIwmTYhqVDTSvs8XpaCrU22V80jEYYH7o4xBcjV
   hq7W1YR+FvIkcoStiQkUMZB4Juk7gTIMxINPDCybLidvOzNfNGi2G0bmw
   o+MsdmmGlfdnc+E6D193lLaX1y+fSXP2qt7WUwL47KjBfV2ax1cq/77mp
   x0p/Qp6XAPCEc4b2yIxmd3ylw5H8DFj8odpQnLRBOCjDJHTT6uBLV86qL
   Q==;
X-CSE-ConnectionGUID: I4XH+uX8Saeg3my1AU8JNQ==
X-CSE-MsgGUID: epidVb9HTrmFhdeuadm6Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78837549"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78837549"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:14:55 -0700
X-CSE-ConnectionGUID: gcyaQt1bTMeUg6FWBFTgrQ==
X-CSE-MsgGUID: 5cepSeuaQOmefx/A6MaDhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="235939037"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 20:14:56 -0700
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
Subject: [PATCH v3 2/2] drm/ttm/pool: back up at native page order
Date: Mon,  4 May 2026 20:14:50 -0700
Message-Id: <20260505031450.3262489-3-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505031450.3262489-1-matthew.brost@intel.com>
References: <20260505031450.3262489-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC05C4C61C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243950-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.brost@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]

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
v3:
 - Skip handles in purge path (sashiko)

[1] https://patchwork.freedesktop.org/series/165330/
---
 drivers/gpu/drm/ttm/ttm_pool.c | 87 ++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 53d1e36f0b48..45b80b13aea4 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1045,12 +1045,11 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
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
@@ -1070,7 +1069,8 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 			unsigned int order;
 
 			page = tt->pages[i];
-			if (unlikely(!page)) {
+			if (unlikely(!page ||
+				     ttm_backup_page_ptr_is_handle(page))) {
 				num_pages = 1;
 				continue;
 			}
@@ -1106,28 +1106,85 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
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


