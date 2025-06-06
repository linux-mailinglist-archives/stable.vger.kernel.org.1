Return-Path: <stable+bounces-151604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D094ACFF47
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEFD16EB9D
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 09:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33AE2857F9;
	Fri,  6 Jun 2025 09:28:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9027468;
	Fri,  6 Jun 2025 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202104; cv=none; b=E5k16oC0W6wsxApSg3J830DG3QLRj81iOAMTII/6PO4qcWgLFFWO8rONLYJ7hDuJLzytFp/YM2nIxbJKYWpOON0Qts19G1Zo7yJaVzSv15G9xlpSx722b2XpFhuIrks5Jqm8JrbwexQ1q94412I38MwJSBCRWdvrrmmH1cGjrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202104; c=relaxed/simple;
	bh=XHWGZ7c7xcEbWzJJedFfGFBEzPbGnbtlcjdCVfCQva0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYyze+nlvwYkAkXWyh6vAx7ZUc9dMbc06J3PvKcHtiT9dIR3ThrLmV3mTe5S1JUmR+avbp4ePw80/5Q6U11Sox4Mhz57rzEwrNQAr2j03o4JYSpp9EW21eexDJy4Fj6pt1XrKWex7vT3Sos7IPqFhMShgdwOE2C3hOd3mx4yMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525361655;
	Fri,  6 Jun 2025 02:28:04 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4AEE3F59E;
	Fri,  6 Jun 2025 02:28:20 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Mel Gorman <mgorman@suse.de>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] mm: Close theoretical race where stale TLB entries could linger
Date: Fri,  6 Jun 2025 10:28:07 +0100
Message-ID: <20250606092809.4194056-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with
a parallel reclaim leaving stale TLB entries") described a theoretical
race as such:

"""
Nadav Amit identified a theoritical race between page reclaim and
mprotect due to TLB flushes being batched outside of the PTL being held.

He described the race as follows:

	CPU0                            CPU1
	----                            ----
					user accesses memory using RW PTE
					[PTE now cached in TLB]
	try_to_unmap_one()
	==> ptep_get_and_clear()
	==> set_tlb_ubc_flush_pending()
					mprotect(addr, PROT_READ)
					==> change_pte_range()
					==> [ PTE non-present - no flush ]

					user writes using cached RW PTE
	...

	try_to_unmap_flush()

The same type of race exists for reads when protecting for PROT_NONE and
also exists for operations that can leave an old TLB entry behind such
as munmap, mremap and madvise.
"""

The solution was to introduce flush_tlb_batched_pending() and call it
under the PTL from mprotect/madvise/munmap/mremap to complete any
pending tlb flushes.

However, while madvise_free_pte_range() and
madvise_cold_or_pageout_pte_range() were both retro-fitted to call
flush_tlb_batched_pending() immediately after initially acquiring the
PTL, they both temporarily release the PTL to split a large folio if
they stumble upon one. In this case, where re-acquiring the PTL
flush_tlb_batched_pending() must be called again, but it previously was
not. Let's fix that.

There are 2 Fixes: tags here: the first is the commit that fixed
madvise_free_pte_range(). The second is the commit that added
madvise_cold_or_pageout_pte_range(), which looks like it copy/pasted the
faulty pattern from madvise_free_pte_range().

This is a theoretical bug discovered during code review.

Cc: stable@vger.kernel.org
Fixes: 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with a parallel reclaim leaving stale TLB entries")
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Applies on today's mm-unstable (3f676fe5c7a0). All mm selftests continue to
pass.

Thanks,
Ryan

 mm/madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5f7a66a1617e..1d44a35ae85c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -508,6 +508,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 					pte_offset_map_lock(mm, pmd, addr, &ptl);
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;
@@ -741,6 +742,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 				start_pte = pte;
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;
--
2.43.0


