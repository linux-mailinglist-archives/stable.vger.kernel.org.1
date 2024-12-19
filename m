Return-Path: <stable+bounces-105260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE789F7329
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 04:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A3616D062
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 03:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC348633E;
	Thu, 19 Dec 2024 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yCOY5xXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A770824;
	Thu, 19 Dec 2024 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577522; cv=none; b=g22ZEUK8oem0YNaOJeFZKYz5fA0v3+h52EjDVf5jqDOvRJzo7l9665ohJ1T9gUrmyyl17Mw1yzX+Snn7/0/HhMr0Brbg0UKCdfutUJeN6ZLO2zT+iX5Kkue2a1ky1X+DF2/CVRdRFcUDxuVshjWNGZZtpA2nmpypIAe3yswNe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577522; c=relaxed/simple;
	bh=0YpVc5v/T8qweYagCDKDZ2cuia/hhWCx19VaaLnMQsU=;
	h=Date:To:From:Subject:Message-Id; b=A+XupYVr1A4Sn7ruzrlwK+bM6MA/xGfC/XE66/HZp1/tpEEwI+HNMTaBomPbyzt5JLdFPGLyYjyC3hHX0Agw1OPEtISd4ubcxzWUpSjZI+PFRdmixvscg27NGj8WZXzF5LLKODWtkiiG4+FK0X+8ILgKfr7wRTsi6hbjguMLwoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yCOY5xXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FA2C4CECD;
	Thu, 19 Dec 2024 03:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734577520;
	bh=0YpVc5v/T8qweYagCDKDZ2cuia/hhWCx19VaaLnMQsU=;
	h=Date:To:From:Subject:From;
	b=yCOY5xXvzynkm7wKLM2xcc2NIUO6sVtkQYudOSiGdgt+VWuDiZfsITMIvyZSvna7x
	 KE30u+R346GaE8XxrvhQdxbU8k4H7RojDtal5nDeYgqEbeOZF6xhqCgGjJMOwNnRI7
	 CtYfwYynNVFAWXKmzzV0R/mCMIqqJQxmUyYQHZzo=
Date: Wed, 18 Dec 2024 19:05:19 -0800
To: mm-commits@vger.kernel.org,yosryahmed@google.com,stable@vger.kernel.org,shakeel.butt@linux.dev,baolin.wang@linux.alibaba.com,hughd@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-shmem-fix-shmemhugepages-at-swapout.patch removed from -mm tree
Message-Id: <20241219030520.63FA2C4CECD@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: shmem: fix ShmemHugePages at swapout
has been removed from the -mm tree.  Its filename was
     mm-shmem-fix-shmemhugepages-at-swapout.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Hugh Dickins <hughd@google.com>
Subject: mm: shmem: fix ShmemHugePages at swapout
Date: Wed, 4 Dec 2024 22:50:06 -0800 (PST)

/proc/meminfo ShmemHugePages has been showing overlarge amounts (more than
Shmem) after swapping out THPs: we forgot to update NR_SHMEM_THPS.

Add shmem_update_stats(), to avoid repetition, and risk of making that
mistake again: the call from shmem_delete_from_page_cache() is the bugfix;
the call from shmem_replace_folio() is reassuring, but not really a bugfix
(replace corrects misplaced swapin readahead, but huge swapin readahead
would be a mistake).

Link: https://lkml.kernel.org/r/5ba477c8-a569-70b5-923e-09ab221af45b@google.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/mm/shmem.c~mm-shmem-fix-shmemhugepages-at-swapout
+++ a/mm/shmem.c
@@ -787,6 +787,14 @@ static bool shmem_huge_global_enabled(st
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static void shmem_update_stats(struct folio *folio, int nr_pages)
+{
+	if (folio_test_pmd_mappable(folio))
+		__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr_pages);
+	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	__lruvec_stat_mod_folio(folio, NR_SHMEM, nr_pages);
+}
+
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
@@ -821,10 +829,7 @@ static int shmem_add_to_page_cache(struc
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
-		if (folio_test_pmd_mappable(folio))
-			__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
-		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-		__lruvec_stat_mod_folio(folio, NR_SHMEM, nr);
+		shmem_update_stats(folio, nr);
 		mapping->nrpages += nr;
 unlock:
 		xas_unlock_irq(&xas);
@@ -852,8 +857,7 @@ static void shmem_delete_from_page_cache
 	error = shmem_replace_entry(mapping, folio->index, folio, radswap);
 	folio->mapping = NULL;
 	mapping->nrpages -= nr;
-	__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
-	__lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
+	shmem_update_stats(folio, -nr);
 	xa_unlock_irq(&mapping->i_pages);
 	folio_put_refs(folio, nr);
 	BUG_ON(error);
@@ -1969,10 +1973,8 @@ static int shmem_replace_folio(struct fo
 	}
 	if (!error) {
 		mem_cgroup_replace_folio(old, new);
-		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
-		__lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
-		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
-		__lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
+		shmem_update_stats(new, nr_pages);
+		shmem_update_stats(old, -nr_pages);
 	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
_

Patches currently in -mm which might be from hughd@google.com are



