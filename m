Return-Path: <stable+bounces-60506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138D9346E9
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 05:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E633E1F2204C
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D33987D;
	Thu, 18 Jul 2024 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XLA4iIVW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B93A1DB;
	Thu, 18 Jul 2024 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274511; cv=none; b=uTsrVpOnYNUvcvxKkTLeHDp3PXeObKcpiFUfqdtr+0XdWTl1I1SIhhIcsovgk6tfanEIoJqlvFVOEDnfivay8ReUoiVuvWudb8HJrPpa9SNU1l0//s4GLNnhqefl2Jr/EnvubJ3ADWDs6Y7j2UHQh2VbnSHnYqjcyO7vcO5lx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274511; c=relaxed/simple;
	bh=32pVP5w9krcYFGCyfCYUi+ShHtAn/PfiPAEn9Jk1CVQ=;
	h=Date:To:From:Subject:Message-Id; b=HWe5Y9az5oq57wTtvqbiZZbmeQ1elgz5wp5GxEXAkdR4aMDMoc7gQe8p0UKEJBXBkJyTcFoymBhEK3R15j7qjjxzvXPThuT7fBeGfJ5052J6qDiFov6oQEqLx2Op7bVPn/O94R+Hncu67W310b0DeQkLcm8j9imbejVFrXA6epA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XLA4iIVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A41C116B1;
	Thu, 18 Jul 2024 03:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721274510;
	bh=32pVP5w9krcYFGCyfCYUi+ShHtAn/PfiPAEn9Jk1CVQ=;
	h=Date:To:From:Subject:From;
	b=XLA4iIVWqEuhGOLk8GWUmElWh2C4psFLBP/r1MZPaJV9hFt89bPJYC2KWIJAIG73r
	 pFtK4CRP5blRWbKYBzWWwSHOxNXyhZpyZXuQeVbmkatVFPRxJJrQv9P7vLHl2LG6W5
	 N1Mn7VJ+lclVzjs6+pgdouEYH4Z9R7elAm8Js8g4=
Date: Wed, 17 Jul 2024 20:48:29 -0700
To: mm-commits@vger.kernel.org,vbabka@suse.cz,stable@vger.kernel.org,souravpanda@google.com,pasha.tatashin@soleen.com,lkp@intel.com,kent.overstreet@linux.dev,keescook@chromium.org,hch@infradead.org,surenb@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + alloc_tag-outline-and-export-free_reserved_page.patch added to mm-hotfixes-unstable branch
Message-Id: <20240718034830.79A41C116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: alloc_tag: outline and export free_reserved_page()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     alloc_tag-outline-and-export-free_reserved_page.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/alloc_tag-outline-and-export-free_reserved_page.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Suren Baghdasaryan <surenb@google.com>
Subject: alloc_tag: outline and export free_reserved_page()
Date: Wed, 17 Jul 2024 14:28:44 -0700

Outline and export free_reserved_page() because modules use it and it in
turn uses page_ext_{get|put} which should not be exported.  The same
result could be obtained by outlining {get|put}_page_tag_ref() but that
would have higher performance impact as these functions are used in more
performance critical paths.

Link: https://lkml.kernel.org/r/20240717212844.2749975-1-surenb@google.com
Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>
Cc: <stable@vger.kernel.org>	[6.10]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mm.h |   16 +---------------
 mm/page_alloc.c    |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

--- a/include/linux/mm.h~alloc_tag-outline-and-export-free_reserved_page
+++ a/include/linux/mm.h
@@ -3177,21 +3177,7 @@ extern void reserve_bootmem_region(phys_
 				   phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
-static inline void free_reserved_page(struct page *page)
-{
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	adjust_managed_page_count(page, 1);
-}
+void free_reserved_page(struct page *page);
 #define free_highmem_page(page) free_reserved_page(page)
 
 static inline void mark_page_reserved(struct page *page)
--- a/mm/page_alloc.c~alloc_tag-outline-and-export-free_reserved_page
+++ a/mm/page_alloc.c
@@ -5805,6 +5805,23 @@ unsigned long free_reserved_area(void *s
 	return pages;
 }
 
+void free_reserved_page(struct page *page)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+	ClearPageReserved(page);
+	init_page_count(page);
+	__free_page(page);
+	adjust_managed_page_count(page, 1);
+}
+EXPORT_SYMBOL(free_reserved_page);
+
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;
_

Patches currently in -mm which might be from surenb@google.com are

alloc_tag-outline-and-export-free_reserved_page.patch


