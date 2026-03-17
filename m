Return-Path: <stable+bounces-225850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ld2H5g9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 291982A90FB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 796423028B24
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D0396B79;
	Tue, 17 Mar 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWM93Z7F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E334F486
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747602; cv=none; b=Gy3qOKcRm+8DhnPSdylbYNgNhUZYAhU7Xct4tNjkhlGCCZuv+XfbbWXgu70c7V95x/YNemaMQn11oidF12vqwrnXnKnJzx8sbyt4r6j5G/ApQkN5cigww0fOm7f9ZFFTZHS9CEE9YCU5okcPpF4mfHcOaRlALii6y0P05nEj1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747602; c=relaxed/simple;
	bh=SRgtFoQIanVkXzBuwaf/6kB/9aC7bCosZ4GDzrkN5kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PssL6jpB+7RjN9Qizu+qjy965I0gv2CMIBS9186on8QYg7FjwgqVA3U/76zgUwEYIz0bedKtXTEctXBr91ydD6g9x8pYXF0zxI9oGVYT/pqgIGonV+w0ZCeOO7mj+JuS85eajUd3oR2ccszqO9Ec3d/B7HHPR+hTSgusXD5rBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWM93Z7F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773747600; x=1805283600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SRgtFoQIanVkXzBuwaf/6kB/9aC7bCosZ4GDzrkN5kQ=;
  b=JWM93Z7FfXGNDuH2csdK+kBHvkoueZMmSgJyBTwNBZUMQSNt7fL3i8Iv
   slgpVTHm1U3+7yhWqylOI3z4+zK+Ui6Pqel4/hMU3DPU0KLARI3yWhWAX
   XKZj5z4D6jbV5dENFaQMtIGUW/NYs2ZLk7eo5h6HokBzSuEUW/UB4qzJ1
   K1nUl4T+QgwrNrNOiX9nY3ox2wJ2F2sSJpvRfbVXf6859cE+MMPS26yQe
   IQf8fmun5pwX4IH8Mishw9OyK5Tp4vEH597LWCrYSGpUO9dD6N7OXAkag
   Wc8QPLWZIbysrA8rFELpv80a5k2ztTlRsmRYZLgNYXZUSRmtgSVVlaOjV
   g==;
X-CSE-ConnectionGUID: vjRoCRmIQdytb/rN71Lo4A==
X-CSE-MsgGUID: 2JPjt41aSmukTulPm9PppQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74893924"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74893924"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:39:59 -0700
X-CSE-ConnectionGUID: xPRzCKTrSqOQHh5rh5AZ8w==
X-CSE-MsgGUID: egKHkaI0QjGYmbobZe8KqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226930061"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO fedora) ([10.245.245.163])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:39:56 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.18.y] mm: Fix a hmm_range_fault() livelock / starvation problem
Date: Tue, 17 Mar 2026 12:39:30 +0100
Message-ID: <20260317113930.193553-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026031727-elective-spilt-6870@gregkh>
References: <2026031727-elective-spilt-6870@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-225850-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 291982A90FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If hmm_range_fault() fails a folio_trylock() in do_swap_page,
trying to acquire the lock of a device-private folio for migration,
to ram, the function will spin until it succeeds grabbing the lock.

However, if the process holding the lock is depending on a work
item to be completed, which is scheduled on the same CPU as the
spinning hmm_range_fault(), that work item might be starved and
we end up in a livelock / starvation situation which is never
resolved.

This can happen, for example if the process holding the
device-private folio lock is stuck in
   migrate_device_unmap()->lru_add_drain_all()
sinc lru_add_drain_all() requires a short work-item
to be run on all online cpus to complete.

A prerequisite for this to happen is:
a) Both zone device and system memory folios are considered in
   migrate_device_unmap(), so that there is a reason to call
   lru_add_drain_all() for a system memory folio while a
   folio lock is held on a zone device folio.
b) The zone device folio has an initial mapcount > 1 which causes
   at least one migration PTE entry insertion to be deferred to
   try_to_migrate(), which can happen after the call to
   lru_add_drain_all().
c) No or voluntary only preemption.

This all seems pretty unlikely to happen, but indeed is hit by
the "xe_exec_system_allocator" igt test.

Resolve this by waiting for the folio to be unlocked if the
folio_trylock() fails in do_swap_page().

Rename migration_entry_wait_on_locked() to
softleaf_entry_wait_unlock() and update its documentation to
indicate the new use-case.

Future code improvements might consider moving
the lru_add_drain_all() call in migrate_device_unmap() to be
called *after* all pages have migration entries inserted.
That would eliminate also b) above.

v2:
- Instead of a cond_resched() in hmm_range_fault(),
  eliminate the problem by waiting for the folio to be unlocked
  in do_swap_page() (Alistair Popple, Andrew Morton)
v3:
- Add a stub migration_entry_wait_on_locked() for the
  !CONFIG_MIGRATION case. (Kernel Test Robot)
v4:
- Rename migrate_entry_wait_on_locked() to
  softleaf_entry_wait_on_locked() and update docs (Alistair Popple)
v5:
- Add a WARN_ON_ONCE() for the !CONFIG_MIGRATION
  version of softleaf_entry_wait_on_locked().
- Modify wording around function names in the commit message
  (Andrew Morton)

Suggested-by: Alistair Popple <apopple@nvidia.com>
Fixes: 1afaeb8293c9 ("mm/migrate: Trylock device page in do_swap_page")
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org
Cc: <dri-devel@lists.freedesktop.org>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Reviewed-by: John Hubbard <jhubbard@nvidia.com> #v3
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Link: https://patch.msgid.link/20260210115653.92413-1-thomas.hellstrom@linux.intel.com
(cherry picked from commit a69d1ab971a624c6f112cea61536569d579c3215)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit b570f37a2ce480be26c665345c5514686a8a0274)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/migrate.h |  8 ++++++++
 mm/filemap.c            | 13 +++++++++----
 mm/memory.c             |  3 ++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1f0ac122c3bf..8061efd89041 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -97,6 +97,14 @@ static inline int set_movable_ops(const struct movable_operations *ops, enum pag
 	return -ENOSYS;
 }
 
+static inline void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+	__releases(ptl)
+{
+	WARN_ON_ONCE(1);
+
+	spin_unlock(ptl);
+}
+
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/filemap.c b/mm/filemap.c
index 024b71da5224..8a7f4ce69aff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1386,14 +1386,16 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 #ifdef CONFIG_MIGRATION
 /**
- * migration_entry_wait_on_locked - Wait for a migration entry to be removed
- * @entry: migration swap entry.
+ * migration_entry_wait_on_locked - Wait for a migration entry or
+ * device_private entry to be removed.
+ * @entry: migration or device_private swap entry.
  * @ptl: already locked ptl. This function will drop the lock.
  *
- * Wait for a migration entry referencing the given page to be removed. This is
+ * Wait for a migration entry referencing the given page, or device_private
+ * entry referencing a dvice_private page to be unlocked. This is
  * equivalent to folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE) except
  * this can be called without taking a reference on the page. Instead this
- * should be called while holding the ptl for the migration entry referencing
+ * should be called while holding the ptl for @entry referencing
  * the page.
  *
  * Returns after unlocking the ptl.
@@ -1435,6 +1437,9 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 	 * If a migration entry exists for the page the migration path must hold
 	 * a valid reference to the page, and it must take the ptl to remove the
 	 * migration entry. So the page is valid until the ptl is dropped.
+	 * Similarly any path attempting to drop the last reference to a
+	 * device-private page needs to grab the ptl to remove the device-private
+	 * entry.
 	 */
 	spin_unlock(ptl);
 
diff --git a/mm/memory.c b/mm/memory.c
index 61748b762876..e43f0a4702c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4642,7 +4642,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				unlock_page(vmf->page);
 				put_page(vmf->page);
 			} else {
-				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				pte_unmap(vmf->pte);
+				migration_entry_wait_on_locked(entry, vmf->ptl);
 			}
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
-- 
2.53.0


