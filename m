Return-Path: <stable+bounces-134819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F5EA9522A
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D1188EE48
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F526659C;
	Mon, 21 Apr 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="av+y2suU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71923266564
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243848; cv=none; b=nvmSWEKdywr4LkkjwObVTC349tZk6szSBLrQexLuvbEtBGxZgmrCSZR8aadf7YDlMP7nvnuBa4Erf6sITT3Iv341OZVYG0T6WitLEbS21h6rWcgCr+NhTX2hVzn26Z2alJjVGsNhUpf/hbTWYcA8SDV1BsRp2VnJHXK6gC44EoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243848; c=relaxed/simple;
	bh=RSBDJxIzT5QZG4lITucH+2/m6MFi05t4NwGyRrMAFaw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O7QBHtYqGRcm/EkocfJiS+CTQF52CqfFIGbM97euYzCIvXxJfhzvg9L8e0FgQY69aSxCncAn7D8jRf0hL07snbp0zlo/lPdfm7PHhYdDNFCNXZhcoMwP0Udpxr1hBgftIjRbXGpyLToCxHbNfHG1/Tr6m2oq9gvzaRw2+Oc/5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=av+y2suU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4BC4CEE4;
	Mon, 21 Apr 2025 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243848;
	bh=RSBDJxIzT5QZG4lITucH+2/m6MFi05t4NwGyRrMAFaw=;
	h=Subject:To:Cc:From:Date:From;
	b=av+y2suUl1+WjgKFZRwD19NnupGULTxhnbQ2OCqAfLnpcq6prij4K0mv6F6E+2Cng
	 TlnPfbtDNj8GfdbK9Wcm1ctTkDNZYuWqog4JTOt3llB6XI5v9B4HyBSkhm/6YjWY7R
	 IaykuFBmKxMhhua9WQfL9Fp7Rxd+sVeaS+rxnKPU=
Subject: FAILED: patch "[PATCH] mm: fix apply_to_existing_page_range()" failed to apply to 5.15-stable tree
To: kirill.shutemov@linux.intel.com,akpm@linux-foundation.org,david@redhat.com,dja@axtens.net,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:57:15 +0200
Message-ID: <2025042115-penholder-famished-11cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a995199384347261bb3f21b2e171fa7f988bd2f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042115-penholder-famished-11cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a995199384347261bb3f21b2e171fa7f988bd2f8 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 9 Apr 2025 12:40:43 +0300
Subject: [PATCH] mm: fix apply_to_existing_page_range()

In the case of apply_to_existing_page_range(), apply_to_pte_range() is
reached with 'create' set to false.  When !create, the loop over the PTE
page table is broken.

apply_to_pte_range() will only move to the next PTE entry if 'create' is
true or if the current entry is not pte_none().

This means that the user of apply_to_existing_page_range() will not have
'fn' called for any entries after the first pte_none() in the PTE page
table.

Fix the loop logic in apply_to_pte_range().

There are no known runtime issues from this, but the fix is trivial enough
for stable@ even without a known buggy user.

Link: https://lkml.kernel.org/r/20250409094043.1629234-1-kirill.shutemov@linux.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: be1db4753ee6 ("mm/memory.c: add apply_to_existing_page_range() helper")
Cc: Daniel Axtens <dja@axtens.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory.c b/mm/memory.c
index 1a35165622e1..44481fe7c629 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2938,11 +2938,11 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	if (fn) {
 		do {
 			if (create || !pte_none(ptep_get(pte))) {
-				err = fn(pte++, addr, data);
+				err = fn(pte, addr, data);
 				if (err)
 					break;
 			}
-		} while (addr += PAGE_SIZE, addr != end);
+		} while (pte++, addr += PAGE_SIZE, addr != end);
 	}
 	*mask |= PGTBL_PTE_MODIFIED;
 


