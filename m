Return-Path: <stable+bounces-268676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1DKRMA6ZPWrQ4ggAu9opvQ
	(envelope-from <stable+bounces-268676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:09:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 369146C8AC9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=L0d6gc63;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268676-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268676-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D24A8303A666
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA01372ECB;
	Thu, 25 Jun 2026 21:09:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A430BF52;
	Thu, 25 Jun 2026 21:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421769; cv=none; b=WIZS3qjNDFjDZRraNX0lMz3iJTvgtgmrKXZ6cu/xfJu7YeAu0g8UxdTevjkXZJenlRhH0IqjHsW6COAzM/m9HTO26By5Mb7kvw91W9Ae8b/at/lGdIPZpZqLNPppsoxP421DRyhyMYcMv9RTxnY80Jk91rBLfVhWnWfkbTEgjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421769; c=relaxed/simple;
	bh=x8lPMB9iFw3HKoEEo1iPkq9HS6NrGQdWyMDzsDYckdk=;
	h=Date:To:From:Subject:Message-Id; b=IMhOuwrwS2iwIGR52Qo5u/WbEYsDaa87DAIWgvDLhBPYjMLVf0m8ZgzShReewz9NQcq1HJyCXZmJottQTrGN3v8bOV5KzcSHpkEqUnv5J32oh9QkvUlhErtILmCHE3vTnGlLguURYwJrLzyrlvakL+Ul16jVOZifq8i3j8yk8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L0d6gc63; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AC41F000E9;
	Thu, 25 Jun 2026 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782421767;
	bh=a3En7h51SVTLY397zWxNCnhXgLxn2XCd8R1dGxgkZOc=;
	h=Date:To:From:Subject;
	b=L0d6gc63BYoVm/LAmI8BbVlbx+PMhyztbAPQLyTUkfXfXh+faa+6rd1DEKVlvX751
	 ENQ4FaC4HQwlvPRIykJvV64vmaDuEOB0rgApuI47mdMAySNF6c/z7YlLb/u+6Gr2uQ
	 kYzfaWQWHdQS92rsN5rjB0s0iRuRiwRXblriEs1Q=
Date: Thu, 25 Jun 2026 14:09:27 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,stable@vger.kernel.org,ryan.roberts@arm.com,riel@surriel.com,ljs@kernel.org,liam@infradead.org,kas@kernel.org,jannh@google.com,harry@kernel.org,david@kernel.org,anshuman.khandual@arm.com,dev.jain@arm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-rmap-use-huge_ptep_get-in-try_to_unmap_one.patch removed from -mm tree
Message-Id: <20260625210927.B8AC41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:stable@vger.kernel.org,m:ryan.roberts@arm.com,m:riel@surriel.com,m:ljs@kernel.org,m:liam@infradead.org,m:kas@kernel.org,m:jannh@google.com,m:harry@kernel.org,m:david@kernel.org,m:anshuman.khandual@arm.com,m:dev.jain@arm.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,arm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 369146C8AC9


The quilt patch titled
     Subject: mm/rmap: use huge_ptep_get() in try_to_unmap_one()
has been removed from the -mm tree.  Its filename was
     mm-rmap-use-huge_ptep_get-in-try_to_unmap_one.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Dev Jain <dev.jain@arm.com>
Subject: mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Date: Thu, 25 Jun 2026 04:28:51 +0000

try_to_unmap_one() handles hugetlb folios when memory failure needs to
replace a poisoned hugetlb mapping with a hwpoison entry.  In that case
page_vma_mapped_walk() returns the hugetlb entry in pvmw.pte, but the code
reads it with ptep_get() before decoding the PFN.

That is wrong on architectures where hugetlb entries are not encoded as
regular PTEs.  On s390, for example, a raw huge RSTE must be converted by
huge_ptep_get() before helpers such as pte_pfn() can inspect it.  A raw
decode can select the wrong subpage, so try_to_unmap_one() can install a
hwpoison entry for the wrong PFN.

The userspace-visible result is that a later access to the poisoned
hugetlb subpage can miss the expected SIGBUS.  With DEBUG_VM, the wrong
subpage can also trip the PageHWPoison check.

Use huge_ptep_get() for hugetlb mappings before decoding the PFN.

Before c7ab0d2fdc84, the bug existed in the form of a plain dereference:
we would check the head page pfn of the hugetlb with pte_pfn(*pte), and
bail out on mismatch.  This would mean that the hwpoisoned entry will not
get installed.

Link: https://lore.kernel.org/20260625042853.2752898-1-dev.jain@arm.com
Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/rmap.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/mm/rmap.c~mm-rmap-use-huge_ptep_get-in-try_to_unmap_one
+++ a/mm/rmap.c
@@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct foli
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		/*
-		 * Handle PFN swap PTEs, such as device-exclusive ones, that
-		 * actually map pages.
-		 */
-		pteval = ptep_get(pvmw.pte);
+		address = pvmw.address;
+		if (folio_test_hugetlb(folio)) {
+			pteval = huge_ptep_get(mm, address, pvmw.pte);
+		} else {
+			/*
+			 * Handle PFN swap PTEs, such as device-exclusive ones,
+			 * that actually map pages.
+			 */
+			pteval = ptep_get(pvmw.pte);
+		}
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
@@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct foli
 		}
 
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
-		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
 
_

Patches currently in -mm which might be from dev.jain@arm.com are

mm-swap-rename-subpage-page-in-folio_dup_swap-folio_put_swap.patch
mm-mprotect-drop-sub-from-batching-context.patch


