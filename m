Return-Path: <stable+bounces-155138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879FAE1E30
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45923AD5AC
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D892BDC31;
	Fri, 20 Jun 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DgBQ3qkP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77728DF36
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432288; cv=none; b=M0oYKTbPeCrKcjEFglrrmVyX2tLLf4/IMTaHxIn4q9ACe6FqKMc504jlB2mSIe/UAwQLq8tcz3GdswbQBYpSzqMguUuiwODwrVqumYJUK7qAvyWRT05LNYMpZGWjR/n1/wbbZ4tCsxBBIOLDDEwWenASGwVkbc9qR4RPf/n8MLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432288; c=relaxed/simple;
	bh=bIWMCgFc4uRf7vZrsC09qwjneKL6Qk0m0lrxQ29ba5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jW6RxT2qkJO3V/I/2BXnHZ6JudL1GGzW2uRxprGui6EUdrsjS8GpuC++MCaLdcKN/q7njAOWV51EcnZFcQ4FzqFLQnwOuE7Tf3/u1ikZTUsWqNt5QkE/OlpAzOIcBDutd+uRm7nZubduKaJTd0knVuYFm4S4Y2CNJqxtuueOzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DgBQ3qkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62986C4CEE3;
	Fri, 20 Jun 2025 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432288;
	bh=bIWMCgFc4uRf7vZrsC09qwjneKL6Qk0m0lrxQ29ba5U=;
	h=Subject:To:Cc:From:Date:From;
	b=DgBQ3qkP2MPjORq1RVEt8X1AZRLEA+JrKcx//crCfDe94Jisn4/gcoIux3wKm3LDC
	 THl6brzcCR89JnN1psXMy+PKKp2ocOkjlJGdasSRjHD59JeFwZ8042HWSPIlbdpXpG
	 4TBwY7uptxksx88coTnv6mtcNh94ScrzS+Av0fMI=
Subject: FAILED: patch "[PATCH] mm: close theoretical race where stale TLB entries could" failed to apply to 6.6-stable tree
To: ryan.roberts@arm.com,akpm@linux-foundation.org,david@redhat.com,jannh@google.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,mgorman@suse.de,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:11:25 +0200
Message-ID: <2025062025-boogieman-flyable-ee70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 383c4613c67c26e90e8eebb72e3083457d02033f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062025-boogieman-flyable-ee70@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 383c4613c67c26e90e8eebb72e3083457d02033f Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Fri, 6 Jun 2025 10:28:07 +0100
Subject: [PATCH] mm: close theoretical race where stale TLB entries could
 linger

Commit 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with a
parallel reclaim leaving stale TLB entries") described a theoretical race
as such:


"""
Nadav Amit identified a theoretical race between page reclaim and mprotect
due to TLB flushes being batched outside of the PTL being held.

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
also exists for operations that can leave an old TLB entry behind such as
munmap, mremap and madvise.
"""

The solution was to introduce flush_tlb_batched_pending() and call it
under the PTL from mprotect/madvise/munmap/mremap to complete any pending
tlb flushes.

However, while madvise_free_pte_range() and
madvise_cold_or_pageout_pte_range() were both retro-fitted to call
flush_tlb_batched_pending() immediately after initially acquiring the PTL,
they both temporarily release the PTL to split a large folio if they
stumble upon one.  In this case, where re-acquiring the PTL
flush_tlb_batched_pending() must be called again, but it previously was
not.  Let's fix that.

There are 2 Fixes: tags here: the first is the commit that fixed
madvise_free_pte_range().  The second is the commit that added
madvise_cold_or_pageout_pte_range(), which looks like it copy/pasted the
faulty pattern from madvise_free_pte_range().

This is a theoretical bug discovered during code review.

Link: https://lkml.kernel.org/r/20250606092809.4194056-1-ryan.roberts@arm.com
Fixes: 3ea277194daa ("mm, mprotect: flush TLB if potentially racing with a parallel reclaim leaving stale TLB entries")
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mel Gorman <mgorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

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


