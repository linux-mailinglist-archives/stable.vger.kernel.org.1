Return-Path: <stable+bounces-62689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94D940D5E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1931C24111
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06564194C92;
	Tue, 30 Jul 2024 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4A7lVR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC399194C8B
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331515; cv=none; b=hTjZKhMO94S7buZNoX7zFqKX4fJl9vGdwWgBCaFm4gsBMCpKnqjIysfz37NbvO3famKF3BQ9RY6X2QpyZ8Uslc5eyJOWoxZhoe6YNJJqYmd8Q4nEoJCWwJIPcVDekEBl8mKnopCB+Dwyh8Uqu52RQMedAECeg09BqzfjBUsp/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331515; c=relaxed/simple;
	bh=7cnrAXR67Uh1qxmgdkuhoD6P/Yzsn5Je0NoiC64p6fM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T8lOvKGWXKHqmeG5aly5cf81b3DPJ4nkd9oEG1R/khUO5jC21Mw1CFci21dPoauibSvbzeajpBBbgStZzyCubdKIJq+BHaXfi/UMO3S77qlZwJuTg9yStBuzL+i4r75aaUPJMsaQg4+zS67R2dGNsOrGb/8YXIfrx3mWqg81ND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4A7lVR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEA4C4AF0C;
	Tue, 30 Jul 2024 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331515;
	bh=7cnrAXR67Uh1qxmgdkuhoD6P/Yzsn5Je0NoiC64p6fM=;
	h=Subject:To:Cc:From:Date:From;
	b=o4A7lVR7wG8y34CGTiBiAXG3qaIdpxN0JEwlVMB2Cr0VhKqcUC8h1FYN0FiT7PFpO
	 ytw7hQgSPv5Xdc+UNexc9o3EtPkDgqNoiDDXQPvDGkDbG+enkbBZ9g7iExBuMTjW5D
	 rxEBN/AIfRasjjZeNVYDojh2fyDN6Htvxf6ah5o8=
Subject: FAILED: patch "[PATCH] mm: shmem: rename mTHP shmem counters" failed to apply to 5.4-stable tree
To: ryan.roberts@arm.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,corbet@lwn.net,da.gomez@samsung.com,david@redhat.com,hughd@google.com,ioworker0@gmail.com,stable@vger.kernel.org,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:24:47 +0200
Message-ID: <2024073046-feminine-relapsing-3d49@gregkh>
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
git cherry-pick -x 63d9866ab01ffd0d0835d5564107283a4afc0a38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073046-feminine-relapsing-3d49@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

63d9866ab01f ("mm: shmem: rename mTHP shmem counters")
f216c845f3c7 ("mm: add per-order mTHP split counters")
66f44583f9b6 ("mm: shmem: add mTHP counters for anonymous shmem")
e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
3d95bc21cea5 ("mm: shmem: add THP validation for PMD-mapped THP related statistics")
6f775463d002 ("mm: shmem: use folio_alloc_mpol() in shmem_alloc_folio()")
0d648dd5c899 ("mm: drop the 'anon_' prefix for swap-out mTHP counters")
42248b9d34ea ("mm: add docs for per-order mTHP counters and transhuge_page ABI")
d0f048ac39f6 ("mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters")
ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters")
5ed890ce5147 ("mm: vmscan: avoid split during shrink_folio_list()")
835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable() for THP split statistics")
085ff35e7636 ("mm: memory: move mem_cgroup_charge() into alloc_anon_folio()")
19eaf44954df ("mm: thp: support allocation of anonymous multi-size THP")
3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
ddc1a5cbc05d ("mempolicy: alloc_pages_mpol() for NUMA policy without vma")
23e4883248f0 ("mm: add page_rmappable_folio() wrapper")
c36f6e6dff4d ("mempolicy trivia: slightly more consistent naming")
7f1ee4e20708 ("mempolicy trivia: delete those ancient pr_debug()s")
1cb5d11a370f ("mempolicy: fix migrate_pages(2) syscall return nr_failed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63d9866ab01ffd0d0835d5564107283a4afc0a38 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 10 Jul 2024 10:55:01 +0100
Subject: [PATCH] mm: shmem: rename mTHP shmem counters

The legacy PMD-sized THP counters at /proc/vmstat include thp_file_alloc,
thp_file_fallback and thp_file_fallback_charge, which rather confusingly
refer to shmem THP and do not include any other types of file pages.  This
is inconsistent since in most other places in the kernel, THP counters are
explicitly separated for anon, shmem and file flavours.  However, we are
stuck with it since it constitutes a user ABI.

Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for anonymous
shmem") added equivalent mTHP stats for shmem, keeping the same "file_"
prefix in the names.  But in future, we may want to add extra stats to
cover actual file pages, at which point, it would all become very
confusing.

So let's take the opportunity to rename these new counters "shmem_" before
the change makes it upstream and the ABI becomes immutable.  While we are
at it, let's improve the documentation for the legacy counters to make it
clear that they count shmem pages only.

Link: https://lkml.kernel.org/r/20240710095503.3193901-1-ryan.roberts@arm.com
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index fe237825b95c..058485daf186 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -412,20 +412,23 @@ thp_collapse_alloc_failed
 	the allocation.
 
 thp_file_alloc
-	is incremented every time a file huge page is successfully
-	allocated.
+	is incremented every time a shmem huge page is successfully
+	allocated (Note that despite being named after "file", the counter
+	measures only shmem).
 
 thp_file_fallback
-	is incremented if a file huge page is attempted to be allocated
-	but fails and instead falls back to using small pages.
+	is incremented if a shmem huge page is attempted to be allocated
+	but fails and instead falls back to using small pages. (Note that
+	despite being named after "file", the counter measures only shmem).
 
 thp_file_fallback_charge
-	is incremented if a file huge page cannot be charged and instead
+	is incremented if a shmem huge page cannot be charged and instead
 	falls back to using small pages even though the allocation was
-	successful.
+	successful. (Note that despite being named after "file", the
+	counter measures only shmem).
 
 thp_file_mapped
-	is incremented every time a file huge page is mapped into
+	is incremented every time a file or shmem huge page is mapped into
 	user address space.
 
 thp_split_page
@@ -496,16 +499,16 @@ swpout_fallback
 	Usually because failed to allocate some continuous swap space
 	for the huge page.
 
-file_alloc
-	is incremented every time a file huge page is successfully
+shmem_alloc
+	is incremented every time a shmem huge page is successfully
 	allocated.
 
-file_fallback
-	is incremented if a file huge page is attempted to be allocated
+shmem_fallback
+	is incremented if a shmem huge page is attempted to be allocated
 	but fails and instead falls back to using small pages.
 
-file_fallback_charge
-	is incremented if a file huge page cannot be charged and instead
+shmem_fallback_charge
+	is incremented if a shmem huge page cannot be charged and instead
 	falls back to using small pages even though the allocation was
 	successful.
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index acb6ac24a07e..cff002be83eb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -269,9 +269,9 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
-	MTHP_STAT_FILE_ALLOC,
-	MTHP_STAT_FILE_FALLBACK,
-	MTHP_STAT_FILE_FALLBACK_CHARGE,
+	MTHP_STAT_SHMEM_ALLOC,
+	MTHP_STAT_SHMEM_FALLBACK,
+	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9ec64aa2be94..f9696c94e211 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
-DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
-DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
-DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
+DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
@@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] = {
 	&anon_fault_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
-	&file_alloc_attr.attr,
-	&file_fallback_attr.attr,
-	&file_fallback_charge_attr.attr,
+	&shmem_alloc_attr.attr,
+	&shmem_fallback_attr.attr,
+	&shmem_fallback_charge_attr.attr,
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
diff --git a/mm/shmem.c b/mm/shmem.c
index 921d59c3d669..f24dfbd387ba 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
 #endif
 			order = next_order(&suitable_orders, order);
 		}
@@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 				count_vm_event(THP_FILE_FALLBACK_CHARGE);
 			}
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 #endif
 		}
 		goto unlock;
@@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_FILE_ALLOC);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
 #endif
 			goto alloced;
 		}


