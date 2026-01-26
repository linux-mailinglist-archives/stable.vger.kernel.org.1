Return-Path: <stable+bounces-211674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ht8Mp28d2l8kgEAu9opvQ
	(envelope-from <stable+bounces-211674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:12:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443958C680
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 899B3301ABAA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1075271468;
	Mon, 26 Jan 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+kLqftn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546A248886
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769454744; cv=none; b=f/dj6ASYil6urxfw5n8fpAMdq724icGD3BsHeBR9O7EeYdzEif6+stR44SaXppzTuffOipvODxRs6ymyL3+TFNIc283EqtCsG3kqGCNxPVjeObycrK1pwapDO2mTVE7zhq2wj2KbPPyP6YRFR4glvAbPMp5i8ZgjC4cR4zCTLF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769454744; c=relaxed/simple;
	bh=pb4fYRuBt3mhkRykC6UWKFk6pcniBHZFYRUmOKoogTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX2dpoLEHFGUjQrnGA0QiU+1ehrXXn7CPqjb06mDJAuPYPqV+1rq2qm/AQYmka92UsyU17awvODZA9Y0Kr28h+D1scwfeBG804GSenvSHX69YcUU0SL6/OCf18rKyNz9Qz5vnMJLuvgDIhuHTw8TUTMv0aAIYhBrVeP8IlXZ1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+kLqftn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E6AC116C6;
	Mon, 26 Jan 2026 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769454744;
	bh=pb4fYRuBt3mhkRykC6UWKFk6pcniBHZFYRUmOKoogTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+kLqftn243vkxB4IeCdTL5D8VSVjuC+AifUBJMmeiQEKFetHhtzJFe4E//xgmuLB
	 MJkK4knNqmv6F14J/JtaldTC0hl3+7UOTmHsuTaMamSMpg+IoVSDWd0A0EbsWlB/90
	 vXa6FPFydXbY4DO99sWh+Zan6im4JHtyE91UcUKzMB5+aJAtFJdQY+kJiLpz7anll5
	 G+Cxoo980+Fhn0h5Ybs92tZyDFlSCIC5t3H+BZma71srCAqP4m3+FOthPGfnwDRTGf
	 ePrBlEmvqPo5z98tK3DheFOVYxi+Eskwlwg9ARW+UQg3KLRY9UwLjLfua1MQjgdFEu
	 iKgspbTxGCMIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "jianyun.gao" <jianyungao89@gmail.com>,
	SeongJae Park <sj@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Chris Li <chrisl@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] mm: fix some typos in mm module
Date: Mon, 26 Jan 2026 14:12:20 -0500
Message-ID: <20260126191221.3643780-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012615-emblaze-unified-1aeb@gregkh>
References: <2026012615-emblaze-unified-1aeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,arm.com,oracle.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211674-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,oracle.com:email]
X-Rspamd-Queue-Id: 443958C680
X-Rspamd-Action: no action

From: "jianyun.gao" <jianyungao89@gmail.com>

[ Upstream commit b6c46600bfb28b4be4e9cff7bad4f2cf357e0fb7 ]

Below are some typos in the code comments:

  intevals ==> intervals
  addesses ==> addresses
  unavaliable ==> unavailable
  facor ==> factor
  droping ==> dropping
  exlusive ==> exclusive
  decription ==> description
  confict ==> conflict
  desriptions ==> descriptions
  otherwize ==> otherwise
  vlaue ==> value
  cheching ==> checking
  exisitng ==> existing
  modifed ==> modified
  differenciate ==> differentiate
  refernece ==> reference
  permissons ==> permissions
  indepdenent ==> independent
  spliting ==> splitting

Just fix it.

Link: https://lkml.kernel.org/r/20250929002608.1633825-1-jianyungao89@gmail.com
Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3937027caecb ("mm/hugetlb: fix two comments related to huge_pmd_unshare()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/sysfs.c     | 2 +-
 mm/gup.c             | 2 +-
 mm/hugetlb.c         | 6 +++---
 mm/hugetlb_vmemmap.c | 6 +++---
 mm/kmsan/core.c      | 2 +-
 mm/ksm.c             | 2 +-
 mm/memory-tiers.c    | 2 +-
 mm/memory.c          | 4 ++--
 mm/secretmem.c       | 2 +-
 mm/slab_common.c     | 2 +-
 mm/slub.c            | 2 +-
 mm/swapfile.c        | 2 +-
 mm/userfaultfd.c     | 2 +-
 mm/vma.c             | 4 ++--
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2caeca5624ce8..dec9f5d0d5123 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1267,7 +1267,7 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS: Update the tuned monitoring
-	 * intevals.
+	 * intervals.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
 	/*
diff --git a/mm/gup.c b/mm/gup.c
index a8ba5112e4d09..d2524fe09338f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2710,7 +2710,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  *
  *  *) ptes can be read atomically by the architecture.
  *
- *  *) valid user addesses are below TASK_MAX_SIZE
+ *  *) valid user addresses are below TASK_MAX_SIZE
  *
  * The last two assumptions can be relaxed by the addition of helper functions.
  *
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0455119716ec0..4e016433e32e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2934,7 +2934,7 @@ typedef enum {
 	 * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
 	 * that currently vma_needs_reservation() has an unwanted side
 	 * effect to either use end() or commit() to complete the
-	 * transaction.	 Hence it needs to differenciate from NEEDED.
+	 * transaction. Hence it needs to differentiate from NEEDED.
 	 */
 	MAP_CHG_ENFORCED = 2,
 } map_chg_state;
@@ -6007,7 +6007,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	/*
 	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
 	 * could defer the flush until now, since by holding i_mmap_rwsem we
-	 * guaranteed that the last refernece would not be dropped. But we must
+	 * guaranteed that the last reference would not be dropped. But we must
 	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
 	 * dropped and the last reference to the shared PMDs page might be
 	 * dropped as well.
@@ -7193,7 +7193,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		} else if (unlikely(is_pte_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
-			 * corrupted, permissons do not apply.  Here
+			 * corrupted, permissions do not apply. Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba0fb1b6a5a8e..96ee2bd16ee15 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 	if (likely(pmd_leaf(*pmd))) {
 		/*
 		 * Higher order allocations from buddy allocator must be able to
-		 * be treated as indepdenent small pages (as they can be freed
+		 * be treated as independent small pages (as they can be freed
 		 * individually).
 		 */
 		if (!PageReserved(head))
@@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		ret = hugetlb_vmemmap_split_folio(h, folio);
 
 		/*
-		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * Splitting the PMD requires allocating a page, thus let's fail
 		 * early once we encounter the first OOM. No point in retrying
 		 * as it can be dynamically done on remap with the memory
 		 * we get back from the vmemmap deduplication.
@@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struct hstate *h,
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
-		 * This can occur in the case that both spliting fails
+		 * This can occur in the case that both splitting fails
 		 * halfway and head page allocation also failed. In this
 		 * case __hugetlb_vmemmap_optimize_folio() would free memory
 		 * allowing more vmemmap remaps to occur.
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 35ceaa8adb41e..90f427b95a213 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -33,7 +33,7 @@ bool kmsan_enabled __read_mostly;
 
 /*
  * Per-CPU KMSAN context to be used in interrupts, where current->kmsan is
- * unavaliable.
+ * unavailable.
  */
 DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index ba97828f32903..4f672f4f21407 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -389,7 +389,7 @@ static unsigned long ewma(unsigned long prev, unsigned long curr)
  * exponentially weighted moving average. The new pages_to_scan value is
  * multiplied with that change factor:
  *
- *      new_pages_to_scan *= change facor
+ *      new_pages_to_scan *= change factor
  *
  * The new_pages_to_scan value is limited by the cpu min and max values. It
  * calculates the cpu percent for the last scan and calculates the new
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0ea5c13f10a23..864811fff4093 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -519,7 +519,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 	 * for each device getting added in the same NUMA node
 	 * with this specific memtype, bump the map count. We
 	 * Only take memtype device reference once, so that
-	 * changing a node memtype can be done by droping the
+	 * changing a node memtype can be done by dropping the
 	 * only reference count taken here.
 	 */
 
diff --git a/mm/memory.c b/mm/memory.c
index b59ae7ce42ebc..61748b762876f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4328,7 +4328,7 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	 * If we want to map a page that's in the swapcache writable, we
 	 * have to detect via the refcount if we're really the exclusive
 	 * user. Try freeing the swapcache to get rid of the swapcache
-	 * reference only in case it's likely that we'll be the exlusive user.
+	 * reference only in case it's likely that we'll be the exclusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
 		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
@@ -5405,7 +5405,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 
 /**
  * set_pte_range - Set a range of PTEs to point to pages in a folio.
- * @vmf: Fault decription.
+ * @vmf: Fault description.
  * @folio: The folio that contains @page.
  * @page: The first page to create a PTE for.
  * @nr: The number of PTEs to create.
diff --git a/mm/secretmem.c b/mm/secretmem.c
index b59350daffe31..9b0f5d9ec6f4b 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -227,7 +227,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	struct file *file;
 	int fd, err;
 
-	/* make sure local flags do not confict with global fcntl.h */
+	/* make sure local flags do not conflict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
 	if (!secretmem_enable || !can_set_direct_map())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 29be54153fa91..87bde1d8916be 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -259,7 +259,7 @@ static struct kmem_cache *create_cache(const char *name,
  * @object_size: The size of objects to be created in this cache.
  * @args: Additional arguments for the cache creation (see
  *        &struct kmem_cache_args).
- * @flags: See the desriptions of individual flags. The common ones are listed
+ * @flags: See the descriptions of individual flags. The common ones are listed
  *         in the description below.
  *
  * Not to be called directly, use the kmem_cache_create() wrapper with the same
diff --git a/mm/slub.c b/mm/slub.c
index 507f346102256..e4c47a6b726ad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2533,7 +2533,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
 		/*
-		 * Restore orig_size, otherwize kmalloc redzone overwritten
+		 * Restore orig_size, otherwise kmalloc redzone overwritten
 		 * would be reported
 		 */
 		set_orig_size(s, x, orig_size);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 82524f8595eda..89746abc47373 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1703,7 +1703,7 @@ static bool swap_entries_put_map_nr(struct swap_info_struct *si,
 
 /*
  * Check if it's the last ref of swap entry in the freeing path.
- * Qualified vlaue includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
+ * Qualified value includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
  */
 static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index af61b95c89e4e..0630f188c847c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1578,7 +1578,7 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
 
 	/*
 	 * For now, we keep it simple and only move between writable VMAs.
-	 * Access flags are equal, therefore cheching only the source is enough.
+	 * Access flags are equal, therefore checking only the source is enough.
 	 */
 	if (!(src_vma->vm_flags & VM_WRITE))
 		return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index abe0da33c8446..9127eaeea93ff 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -109,7 +109,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *tgt = merge_next ? vmg->next : vmg->prev;
-	struct vm_area_struct *src = vmg->middle; /* exisitng merge case. */
+	struct vm_area_struct *src = vmg->middle; /* existing merge case. */
 	struct anon_vma *tgt_anon = tgt->anon_vma;
 	struct anon_vma *src_anon = vmg->anon_vma;
 
@@ -798,7 +798,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * Returns: The merged VMA if merge succeeds, or NULL otherwise.
  *
  * ASSUMPTIONS:
- * - The caller must assign the VMA to be modifed to @vmg->middle.
+ * - The caller must assign the VMA to be modified to @vmg->middle.
  * - The caller must have set @vmg->prev to the previous VMA, if there is one.
  * - The caller must not set @vmg->next, as we determine this.
  * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
-- 
2.51.0


