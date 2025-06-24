Return-Path: <stable+bounces-157830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A948AE55EF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9CB4A3BBA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D195226CF1;
	Mon, 23 Jun 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rNP4D/nh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B6225792;
	Mon, 23 Jun 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716823; cv=none; b=gNRCKktsTNdfCzm3FQTyrLkRN0o8n/3SF4QoX7xn7+Wl6Lpf01uAP9YpWwsl9K4Xn1eohKYcAnTFZs1BZz3R91241ZsSIaJR2ayAFBxso6tgbDk2KIxIr12TVdKCNxcrYMVXfSKavNGP9GasOPyBOYO9+NYnPxrAcPD2Nima9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716823; c=relaxed/simple;
	bh=BXFlUVRfdiHRljYf7OJQqYGDi3gdvI/guikXhF4WCpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX/oYGbhen57td2DsX2oVV8I9N/wzaN3nPM6M9pGIvJrNHwrL1iRSX0T8pCnrsJMkRXpUxzRQmqOTwysGO8XsyH+4NWgolHgmoxTMHySQ0wVwvfWcHnDF2iue4L+AMXuEUMao5TeM+NBYJ7592Q/hsQhMTADfdGbCfBBEksYtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rNP4D/nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE530C4CEEA;
	Mon, 23 Jun 2025 22:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716823;
	bh=BXFlUVRfdiHRljYf7OJQqYGDi3gdvI/guikXhF4WCpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNP4D/nhc1ii844xulhkUh19lNltNRlYSSg8eZG++cec6yEKwLGk0oTbuZlj23+hY
	 VoScqVEHuGQ8w5jK//S6TvtjSc+vVV35dGg7eQldl76lm9FI9qulCPUS+7NEWHPsMH
	 ltJtrB//EDJ57IlGysCad06+Ax+K6W155zgufp+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Jann Horn <jannh@google.com>,
	David Hildenbrand <david@redhat.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgormanmgorman@suse.de>
Subject: [PATCH 6.12 315/414] mm: close theoretical race where stale TLB entries could linger
Date: Mon, 23 Jun 2025 15:07:32 +0200
Message-ID: <20250623130649.874029402@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Roberts <ryan.roberts@arm.com>

commit 383c4613c67c26e90e8eebb72e3083457d02033f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/madvise.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -495,6 +495,7 @@ restart:
 					pte_offset_map_lock(mm, pmd, addr, &ptl);
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;
@@ -728,6 +729,7 @@ static int madvise_free_pte_range(pmd_t
 				start_pte = pte;
 				if (!start_pte)
 					break;
+				flush_tlb_batched_pending(mm);
 				arch_enter_lazy_mmu_mode();
 				if (!err)
 					nr = 0;



