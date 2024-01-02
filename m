Return-Path: <stable+bounces-9209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05F821DBC
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1742F1C222A9
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1211189;
	Tue,  2 Jan 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxUmwxfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E4101F2
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C44C433C8;
	Tue,  2 Jan 2024 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205946;
	bh=f/2UBs1nENMSeFVE64x0mtkudNoodeqg8mDWX2ga30U=;
	h=Subject:To:Cc:From:Date:From;
	b=vxUmwxfDYbjMPqqaMPK7SAElFkHJZ3YT+moPSZu9dEFwOQHOV7HGa0CSl/4pTKPrg
	 N7YVdTVPyMSqbRQSG+i4PUhbRCL0YcA/Ile9p358NKGjS903ytK+KUVL1w+E8ISSgP
	 XKsgr9PrAknZf9PUZfMCWr3M+gVtj5o114oGvSMk=
Subject: FAILED: patch "[PATCH] mm/memory-failure: check the mapcount of the precise page" failed to apply to 5.4-stable tree
To: willy@infradead.org,akpm@linux-foundation.org,dan.j.williams@intel.com,n-horiguchi@ah.jp.nec.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:32:14 +0100
Message-ID: <2024010214-creative-deck-d169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c79c5a0a00a9457718056b588f312baadf44e471
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010214-creative-deck-d169@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

c79c5a0a00a9 ("mm/memory-failure: check the mapcount of the precise page")
96f96763de26 ("mm: memory-failure: convert to pr_fmt()")
98931dd95fd4 ("Merge tag 'mm-stable-2022-05-25' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c79c5a0a00a9457718056b588f312baadf44e471 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Mon, 18 Dec 2023 13:58:36 +0000
Subject: [PATCH] mm/memory-failure: check the mapcount of the precise page

A process may map only some of the pages in a folio, and might be missed
if it maps the poisoned page but not the head page.  Or it might be
unnecessarily hit if it maps the head page, but not the poisoned page.

Link: https://lkml.kernel.org/r/20231218135837.3310403-3-willy@infradead.org
Fixes: 7af446a841a2 ("HWPOISON, hugetlb: enable error handling path for hugepage")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6953bda11e6e..82e15baabb48 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1570,7 +1570,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageSwapCache(p)) {
@@ -1621,10 +1621,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		try_to_unmap(folio, ttu);
 	}
 
-	unmap_success = !page_mapped(hpage);
+	unmap_success = !page_mapped(p);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call


