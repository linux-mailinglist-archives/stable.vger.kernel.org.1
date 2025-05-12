Return-Path: <stable+bounces-143423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023EAB3FDD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA37B16F0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56699297106;
	Mon, 12 May 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIGxrp7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359C2566DD;
	Mon, 12 May 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071910; cv=none; b=TMtSaJXFhpcmDXof/ZQT5IOMhOdaVu1kKMOL7Gid+TNTNjDt5Dg5ryUZpREHNoT6cqpmkuTScr0YXjQanErHaGxfcwGXYahk/GBToskxa1gHDwIJLBsqXfzwru9OM6Mo4Zmn6YpQukBMHqVB31gwd3yQHkCcCYbWSbH025NBxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071910; c=relaxed/simple;
	bh=kZBCh7z7YAKUDe1PdYHRur0B1USANsphHBWdmatTOck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj1Jrcv+wfQTFuM1fhIeNSqzo3PGCRLzSbuYhXCO3nQ5ZlownoW7xBmAsU3CCJ8ldi9mIDy57xI0RPLVWZn2HGcQPpiDgpMOvfWCIoE957kyu1c650Q0qUGEr6SC9K3Ub9Nr3+LvNdTUG8sX5+9M/A78W70MTyUp4LRFOoDsZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIGxrp7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D53C4CEE7;
	Mon, 12 May 2025 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071909;
	bh=kZBCh7z7YAKUDe1PdYHRur0B1USANsphHBWdmatTOck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIGxrp7VL+wRRhi9l00/MmqWZuEtxNvRrFdhaaWWbwFLhouOUG977+W2ZWDunSXcG
	 v1JfUN4wNRvB2n7QWZoFE0KR5vgRxOGSYElttuj608+vXVOs2ZhgYeieIhQ43nEiTg
	 flM6eawapPjXhpZc4dQdoWXup/vI7CmyYTH9E4yU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14 074/197] mm: fix folio_pte_batch() on XEN PV
Date: Mon, 12 May 2025 19:38:44 +0200
Message-ID: <20250512172047.391479001@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Vaněk <arkamar@atlas.cz>

commit 7b08b74f3d99f6b801250683c751d391128799ec upstream.

On XEN PV, folio_pte_batch() can incorrectly batch beyond the end of a
folio due to a corner case in pte_advance_pfn().  Specifically, when the
PFN following the folio maps to an invalidated MFN,

	expected_pte = pte_advance_pfn(expected_pte, nr);

produces a pte_none().  If the actual next PTE in memory is also
pte_none(), the pte_same() succeeds,

	if (!pte_same(pte, expected_pte))
		break;

the loop is not broken, and batching continues into unrelated memory.

For example, with a 4-page folio, the PTE layout might look like this:

[   53.465673] [ T2552] folio_pte_batch: printing PTE values at addr=0x7f1ac9dc5000
[   53.465674] [ T2552]   PTE[453] = 000000010085c125
[   53.465679] [ T2552]   PTE[454] = 000000010085d125
[   53.465682] [ T2552]   PTE[455] = 000000010085e125
[   53.465684] [ T2552]   PTE[456] = 000000010085f125
[   53.465686] [ T2552]   PTE[457] = 0000000000000000 <-- not present
[   53.465689] [ T2552]   PTE[458] = 0000000101da7125

pte_advance_pfn(PTE[456]) returns a pte_none() due to invalid PFN->MFN
mapping.  The next actual PTE (PTE[457]) is also pte_none(), so the loop
continues and includes PTE[457] in the batch, resulting in 5 batched
entries for a 4-page folio.  This triggers the following warning:

[   53.465751] [ T2552] page: refcount:85 mapcount:20 mapping:ffff88813ff4f6a8 index:0x110 pfn:0x10085c
[   53.465754] [ T2552] head: order:2 mapcount:80 entire_mapcount:0 nr_pages_mapped:4 pincount:0
[   53.465756] [ T2552] memcg:ffff888003573000
[   53.465758] [ T2552] aops:0xffffffff8226fd20 ino:82467c dentry name(?):"libc.so.6"
[   53.465761] [ T2552] flags: 0x2000000000416c(referenced|uptodate|lru|active|private|head|node=0|zone=2)
[   53.465764] [ T2552] raw: 002000000000416c ffffea0004021f08 ffffea0004021908 ffff88813ff4f6a8
[   53.465767] [ T2552] raw: 0000000000000110 ffff888133d8bd40 0000005500000013 ffff888003573000
[   53.465768] [ T2552] head: 002000000000416c ffffea0004021f08 ffffea0004021908 ffff88813ff4f6a8
[   53.465770] [ T2552] head: 0000000000000110 ffff888133d8bd40 0000005500000013 ffff888003573000
[   53.465772] [ T2552] head: 0020000000000202 ffffea0004021701 000000040000004f 00000000ffffffff
[   53.465774] [ T2552] head: 0000000300000003 8000000300000002 0000000000000013 0000000000000004
[   53.465775] [ T2552] page dumped because: VM_WARN_ON_FOLIO((_Generic((page + nr_pages - 1), const struct page *: (const struct folio *)_compound_head(page + nr_pages - 1), struct page *: (struct folio *)_compound_head(page + nr_pages - 1))) != folio)

Original code works as expected everywhere, except on XEN PV, where
pte_advance_pfn() can yield a pte_none() after balloon inflation due to
MFNs invalidation.  In XEN, pte_advance_pfn() ends up calling
__pte()->xen_make_pte()->pte_pfn_to_mfn(), which returns pte_none() when
mfn == INVALID_P2M_ENTRY.

The pte_pfn_to_mfn() documents that nastiness:

	If there's no mfn for the pfn, then just create an
	empty non-present pte.  Unfortunately this loses
	information about the original pfn, so
	pte_mfn_to_pfn is asymmetric.

While such hacks should certainly be removed, we can do better in
folio_pte_batch() and simply check ahead of time how many PTEs we can
possibly batch in our folio.

This way, we can not only fix the issue but cleanup the code: removing the
pte_pfn() check inside the loop body and avoiding end_ptr comparison +
arithmetic.

Link: https://lkml.kernel.org/r/20250502215019.822-2-arkamar@atlas.cz
Fixes: f8d937761d65 ("mm/memory: optimize fork() with PTE-mapped THP")
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/internal.h |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

--- a/mm/internal.h
+++ b/mm/internal.h
@@ -205,11 +205,9 @@ static inline int folio_pte_batch(struct
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable, bool *any_young, bool *any_dirty)
 {
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
-	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
 	bool writable, young, dirty;
-	int nr;
+	int nr, cur_nr;
 
 	if (any_writable)
 		*any_writable = false;
@@ -222,11 +220,15 @@ static inline int folio_pte_batch(struct
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
 	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
 
+	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
+	max_nr = min_t(unsigned long, max_nr,
+		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
+
 	nr = pte_batch_hint(start_ptep, pte);
 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
 	ptep = start_ptep + nr;
 
-	while (ptep < end_ptep) {
+	while (nr < max_nr) {
 		pte = ptep_get(ptep);
 		if (any_writable)
 			writable = !!pte_write(pte);
@@ -239,14 +241,6 @@ static inline int folio_pte_batch(struct
 		if (!pte_same(pte, expected_pte))
 			break;
 
-		/*
-		 * Stop immediately once we reached the end of the folio. In
-		 * corner cases the next PFN might fall into a different
-		 * folio.
-		 */
-		if (pte_pfn(pte) >= folio_end_pfn)
-			break;
-
 		if (any_writable)
 			*any_writable |= writable;
 		if (any_young)
@@ -254,12 +248,13 @@ static inline int folio_pte_batch(struct
 		if (any_dirty)
 			*any_dirty |= dirty;
 
-		nr = pte_batch_hint(ptep, pte);
-		expected_pte = pte_advance_pfn(expected_pte, nr);
-		ptep += nr;
+		cur_nr = pte_batch_hint(ptep, pte);
+		expected_pte = pte_advance_pfn(expected_pte, cur_nr);
+		ptep += cur_nr;
+		nr += cur_nr;
 	}
 
-	return min(ptep - start_ptep, max_nr);
+	return min(nr, max_nr);
 }
 
 /**



