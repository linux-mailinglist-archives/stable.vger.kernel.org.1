Return-Path: <stable+bounces-134817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA1A95228
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A99D188FD5F
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0729266B4A;
	Mon, 21 Apr 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsAmX21x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203A266591
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243837; cv=none; b=V+T5E4h2KpcCHuUtJsYqsCuqHC6hvzX0IxIKwrz3xPN796kBFWEmLsNBuYZmyCxv6DNt5tak1pXlTCSrzcSoonatmbDObCVctWwpE0qpByMqAgv9DPffnTNtC/ARxat/j+CMivxE7wy2UHJRiGy2/Ew/IFuDXqQBFbnwHYRvX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243837; c=relaxed/simple;
	bh=XznL+BV7O+Pp1Lbd+gPy/QaiuENKAR7klXnYziYCPBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qzLWkrZzMunDN8wX2SVmNglhB8aAZQZpaVBCxcEbOhUFk6M+S1WmCvPaajRFYHhSwjOZYUIv9Mr0zouTcBD0AeLXsDa70q3Q9O01VQ3h4bat/Ja1Ww5e2odocKefwU02/xUo1FyiVNftdawguBuPdoBKt72QtKC2aqyKE4sa60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsAmX21x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA97C4CEE4;
	Mon, 21 Apr 2025 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243837;
	bh=XznL+BV7O+Pp1Lbd+gPy/QaiuENKAR7klXnYziYCPBg=;
	h=Subject:To:Cc:From:Date:From;
	b=HsAmX21xcnrABp2QoftMer7CSqEMLJAlt6WE6XZcMLiN+F+B9Getwa6FOfKmyq4TF
	 YKF8/o6qx51xUSrHQQnXz12KTS2gjpSZLOKjIYe7HjW4uL1knOjRNUPxFyrXNfgS51
	 PcY88g2WSDRPiL6nRXIspuzWdaVnjnLIDCWnfLzc=
Subject: FAILED: patch "[PATCH] mm: fix apply_to_existing_page_range()" failed to apply to 6.1-stable tree
To: kirill.shutemov@linux.intel.com,akpm@linux-foundation.org,david@redhat.com,dja@axtens.net,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:57:14 +0200
Message-ID: <2025042114-author-badness-6b2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a995199384347261bb3f21b2e171fa7f988bd2f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042114-author-badness-6b2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


