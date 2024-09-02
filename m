Return-Path: <stable+bounces-72634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACB967D21
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 02:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F9F281839
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 00:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAEDF42;
	Mon,  2 Sep 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o7LUn1G5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93737C148;
	Mon,  2 Sep 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238773; cv=none; b=SqAEKmEzIYIlCRrWiT9w19kt0Y4QBMUm/hOTwMpr1lWO/OzlVTs462aGpwtRrsYyFbTv9nWNrMdiR8Uvscdl6P8HidM0lBD5cf4wrxuR+a02PgbbOTIRTrvm1ddQHKlS2vBj8Fmin52IYovNyrDZjK5dN8xzdyNIN6zp3D7SyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238773; c=relaxed/simple;
	bh=H4FC0M6inlMqP9F961+mpsWBPdkXQ93BC6/w1NDdXC0=;
	h=Date:To:From:Subject:Message-Id; b=t82hstHXrV/os1Zjld1KluBP033Yrnbaks8uD8UbIvyJBOmlTNQwH13rlUQCpFJ0f4wBFu5Zliceh4HpqPdh3toIoAiL0EO4ux6ix2nc0KwrIVCkNr0YVeIvQ4s0Ax8FWGGQEPvvbkp1eurSCKQmxD04wmkOrhkNNnomiXj9iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o7LUn1G5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2524DC4CEC6;
	Mon,  2 Sep 2024 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725238772;
	bh=H4FC0M6inlMqP9F961+mpsWBPdkXQ93BC6/w1NDdXC0=;
	h=Date:To:From:Subject:From;
	b=o7LUn1G5kmLHpN84Wib81WiKnxvyRczmf3cYY4HJS8bg1xEfiLPRO1EvJVaIRitNx
	 SND2BFf27CDKAHYvIiTQx1sSm5NTnUisoXvYHHa2AcTK9dY1FxjcJcTcOGGCvb1h+j
	 uhr+LsAx7gXST/ofKjnNKIYvSO5rroQZXh4v4EGE=
Date: Sun, 01 Sep 2024 17:59:31 -0700
To: mm-commits@vger.kernel.org,zhengqi.arch@bytedance.com,xemul@virtuozzo.com,stable@vger.kernel.org,hughd@google.com,david@redhat.com,aarcange@redhat.com,jannh@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] userfaultfd-fix-checks-for-huge-pmds.patch removed from -mm tree
Message-Id: <20240902005932.2524DC4CEC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: userfaultfd: fix checks for huge PMDs
has been removed from the -mm tree.  Its filename was
     userfaultfd-fix-checks-for-huge-pmds.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Jann Horn <jannh@google.com>
Subject: userfaultfd: fix checks for huge PMDs
Date: Tue, 13 Aug 2024 22:25:21 +0200

Patch series "userfaultfd: fix races around pmd_trans_huge() check", v2.

The pmd_trans_huge() code in mfill_atomic() is wrong in three different
ways depending on kernel version:

1. The pmd_trans_huge() check is racy and can lead to a BUG_ON() (if you hit
   the right two race windows) - I've tested this in a kernel build with
   some extra mdelay() calls. See the commit message for a description
   of the race scenario.
   On older kernels (before 6.5), I think the same bug can even
   theoretically lead to accessing transhuge page contents as a page table
   if you hit the right 5 narrow race windows (I haven't tested this case).
2. As pointed out by Qi Zheng, pmd_trans_huge() is not sufficient for
   detecting PMDs that don't point to page tables.
   On older kernels (before 6.5), you'd just have to win a single fairly
   wide race to hit this.
   I've tested this on 6.1 stable by racing migration (with a mdelay()
   patched into try_to_migrate()) against UFFDIO_ZEROPAGE - on my x86
   VM, that causes a kernel oops in ptlock_ptr().
3. On newer kernels (>=6.5), for shmem mappings, khugepaged is allowed
   to yank page tables out from under us (though I haven't tested that),
   so I think the BUG_ON() checks in mfill_atomic() are just wrong.

I decided to write two separate fixes for these (one fix for bugs 1+2, one
fix for bug 3), so that the first fix can be backported to kernels
affected by bugs 1+2.


This patch (of 2):

This fixes two issues.

I discovered that the following race can occur:

  mfill_atomic                other thread
  ============                ============
                              <zap PMD>
  pmdp_get_lockless() [reads none pmd]
  <bail if trans_huge>
  <if none:>
                              <pagefault creates transhuge zeropage>
    __pte_alloc [no-op]
                              <zap PMD>
  <bail if pmd_trans_huge(*dst_pmd)>
  BUG_ON(pmd_none(*dst_pmd))

I have experimentally verified this in a kernel with extra mdelay() calls;
the BUG_ON(pmd_none(*dst_pmd)) triggers.

On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
a BUG_ON(), since the page table access helpers are actually designed to
deal with page tables concurrently disappearing; but on older kernels
(<=6.4), I think we could probably theoretically race past the two
BUG_ON() checks and end up treating a hugepage as a page table.

The second issue is that, as Qi Zheng pointed out, there are other types
of huge PMDs that pmd_trans_huge() can't catch: devmap PMDs and swap PMDs
(in particular, migration PMDs).

On <=6.4, this is worse than the first issue: If mfill_atomic() runs on a
PMD that contains a migration entry (which just requires winning a single,
fairly wide race), it will pass the PMD to pte_offset_map_lock(), which
assumes that the PMD points to a page table.

Breakage follows: First, the kernel tries to take the PTE lock (which will
crash or maybe worse if there is no "struct page" for the address bits in
the migration entry PMD - I think at least on X86 there usually is no
corresponding "struct page" thanks to the PTE inversion mitigation, amd64
looks different).

If that didn't crash, the kernel would next try to write a PTE into what
it wrongly thinks is a page table.

As part of fixing these issues, get rid of the check for pmd_trans_huge()
before __pte_alloc() - that's redundant, we're going to have to check for
that after the __pte_alloc() anyway.

Backport note: pmdp_get_lockless() is pmd_read_atomic() in older kernels.

Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com
Link: https://lkml.kernel.org/r/20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com
Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/userfaultfd.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/mm/userfaultfd.c~userfaultfd-fix-checks-for-huge-pmds
+++ a/mm/userfaultfd.c
@@ -787,21 +787,23 @@ retry:
 		}
 
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
-		/*
-		 * If the dst_pmd is mapped as THP don't
-		 * override it and just be strict.
-		 */
-		if (unlikely(pmd_trans_huge(dst_pmdval))) {
-			err = -EEXIST;
-			break;
-		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
 		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
 			err = -ENOMEM;
 			break;
 		}
-		/* If an huge pmd materialized from under us fail */
-		if (unlikely(pmd_trans_huge(*dst_pmd))) {
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		/*
+		 * If the dst_pmd is THP don't override it and just be strict.
+		 * (This includes the case where the PMD used to be THP and
+		 * changed back to none after __pte_alloc().)
+		 */
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
+			     pmd_devmap(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
+		if (unlikely(pmd_bad(dst_pmdval))) {
 			err = -EFAULT;
 			break;
 		}
_

Patches currently in -mm which might be from jannh@google.com are

mm-fix-harmless-type-confusion-in-lock_vma_under_rcu.patch


