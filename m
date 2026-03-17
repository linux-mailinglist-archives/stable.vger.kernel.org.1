Return-Path: <stable+bounces-225803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCovN6gruWmVtQEAu9opvQ
	(envelope-from <stable+bounces-225803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:23:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E010C2A7CE7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4823D303638F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31433A257C;
	Tue, 17 Mar 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+a9A/1v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB23387353
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742773; cv=none; b=QzSu9+WMOzP8erzb4Imc1KhHCc1n+D80jlNnSYCW8XfEbHfViK8OOJ4APG6XQwKNXuy+YGn2QbvghigipDmof0J0hJtChiZzk/pQi+0ViWei2kRUB/TdL0Yf7lgePFtqsOSxm2LGvRP8IJXRtRdZjGm05c2+Jr4uvfwGYfSZFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742773; c=relaxed/simple;
	bh=+UYckGZZN6NQTl2c2cTydojNQQNAcGEPsx+c2KwR6Bg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kPOAIFMngwcdHsJvNXsoULYnSBY/73E56KdONxU7dHHoWRl6VYkH+XDbu6Lb1Vg0tKUDt//0K1fWwFBmszizMobwAteZH/J7cnsgyU1+etLcaehP2DQDo7JkvoZZXr2v26LD/wpvDyVC7PvFUfu0rpwlNS+k/D4gJSXibNUQSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+a9A/1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A2C4CEF7;
	Tue, 17 Mar 2026 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773742773;
	bh=+UYckGZZN6NQTl2c2cTydojNQQNAcGEPsx+c2KwR6Bg=;
	h=Subject:To:Cc:From:Date:From;
	b=L+a9A/1vMNF+0hewIbC5FwIRVZSEJwyTV9tmrDbwdj0anC6t966wqIrlkGmfGNZo0
	 pLumgsO4AxzziUuEpaaiQWEzIP8+SZ6n5ITzNkcCs1NyZ4gJOCvf/dk0zmuawt0apI
	 NMNVCrtum7ECl502xTSSgAfpItxlw76psPYy+qYE=
Subject: FAILED: patch "[PATCH] mm: Fix a hmm_range_fault() livelock / starvation problem" failed to apply to 6.18-stable tree
To: thomas.hellstrom@linux.intel.com,akpm@linux-foundation.org,apopple@nvidia.com,dri-devel@lists.freedesktop.org,hch@lst.de,jgg@mellanox.com,jgg@ziepe.ca,jhubbard@nvidia.com,leon@kernel.org,matthew.brost@intel.com,rcampbell@nvidia.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 11:19:27 +0100
Message-ID: <2026031727-elective-spilt-6870@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225803-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E010C2A7CE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b570f37a2ce480be26c665345c5514686a8a0274
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031727-elective-spilt-6870@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b570f37a2ce480be26c665345c5514686a8a0274 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Tue, 10 Feb 2026 12:56:53 +0100
Subject: [PATCH] mm: Fix a hmm_range_fault() livelock / starvation problem
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 26ca00c325d9..d5af2b7f577b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -65,7 +65,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
-void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
+void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
@@ -97,6 +97,14 @@ static inline int set_movable_ops(const struct movable_operations *ops, enum pag
 	return -ENOSYS;
 }
 
+static inline void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
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
index 6cd7974d4ada..406cef06b684 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1379,14 +1379,16 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 #ifdef CONFIG_MIGRATION
 /**
- * migration_entry_wait_on_locked - Wait for a migration entry to be removed
- * @entry: migration swap entry.
+ * softleaf_entry_wait_on_locked - Wait for a migration entry or
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
@@ -1394,7 +1396,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * This follows the same logic as folio_wait_bit_common() so see the comments
  * there.
  */
-void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
+void softleaf_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	__releases(ptl)
 {
 	struct wait_page_queue wait_page;
@@ -1428,6 +1430,9 @@ void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	 * If a migration entry exists for the page the migration path must hold
 	 * a valid reference to the page, and it must take the ptl to remove the
 	 * migration entry. So the page is valid until the ptl is dropped.
+	 * Similarly any path attempting to drop the last reference to a
+	 * device-private page needs to grab the ptl to remove the device-private
+	 * entry.
 	 */
 	spin_unlock(ptl);
 
diff --git a/mm/memory.c b/mm/memory.c
index 07778814b4a8..2f815a34d924 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4763,7 +4763,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				unlock_page(vmf->page);
 				put_page(vmf->page);
 			} else {
-				pte_unmap_unlock(vmf->pte, vmf->ptl);
+				pte_unmap(vmf->pte);
+				softleaf_entry_wait_on_locked(entry, vmf->ptl);
 			}
 		} else if (softleaf_is_hwpoison(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/migrate.c b/mm/migrate.c
index 1bf2cf8c44dd..2c3d489ecf51 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -500,7 +500,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	if (!softleaf_is_migration(entry))
 		goto out;
 
-	migration_entry_wait_on_locked(entry, ptl);
+	softleaf_entry_wait_on_locked(entry, ptl);
 	return;
 out:
 	spin_unlock(ptl);
@@ -532,10 +532,10 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 * If migration entry existed, safe to release vma lock
 		 * here because the pgtable page won't be freed without the
 		 * pgtable lock released.  See comment right above pgtable
-		 * lock release in migration_entry_wait_on_locked().
+		 * lock release in softleaf_entry_wait_on_locked().
 		 */
 		hugetlb_vma_unlock_read(vma);
-		migration_entry_wait_on_locked(entry, ptl);
+		softleaf_entry_wait_on_locked(entry, ptl);
 		return;
 	}
 
@@ -553,7 +553,7 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	ptl = pmd_lock(mm, pmd);
 	if (!pmd_is_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
+	softleaf_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 0a8b31939640..8079676c8f1f 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -176,7 +176,7 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 		}
 
 		if (softleaf_is_migration(entry)) {
-			migration_entry_wait_on_locked(entry, ptl);
+			softleaf_entry_wait_on_locked(entry, ptl);
 			spin_unlock(ptl);
 			return -EAGAIN;
 		}


