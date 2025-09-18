Return-Path: <stable+bounces-179408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125BAB55A73
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 01:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BB37BE2F1
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5F28469B;
	Fri, 12 Sep 2025 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HdPbYmdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055D19258E;
	Fri, 12 Sep 2025 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720754; cv=none; b=eWSwM5Jd6IYqoGbioqJmWTAA4J83yV/jwJEfgdeyp1HZ2Aaq26hHtKgm9OPFBf1xvfc2qKAziG8bai+3+roCr+E7hC4N5q1vdgGXXu33J/N7ODXE2f0jBsIuwiLghjs5NkGJQDHDVjSZutSwQbCEOAN7pOX7ni3uEwaoFmYbiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720754; c=relaxed/simple;
	bh=SOVAzC1jMb7cNXpuMxdlDIX2YS5nXeUAkLHtZaFcXVg=;
	h=Date:To:From:Subject:Message-Id; b=p4LYhRBuuhUO+jJ8cDu6MjMgEM3RL05zRoItrT2/SUuLdCL7R81bRN0VItVid1r/M+9uQ5HbwNAZCDgT3dqpYGG4qe5MRjRjSWBvnL5jrtiMXb/Gf9uCuQ5anVi3YqtUBAaXZOSov49Mc21Kvt7TVdno3q65q7ZhsqBJwHPqmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HdPbYmdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657CFC4CEF1;
	Fri, 12 Sep 2025 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757720753;
	bh=SOVAzC1jMb7cNXpuMxdlDIX2YS5nXeUAkLHtZaFcXVg=;
	h=Date:To:From:Subject:From;
	b=HdPbYmdqSZvMukJDvKiS/0t2ialGvtOy2x4UMMFp7ZpHXlimDAlZlYxBp/RI0MRUd
	 gQPB2WIFhH5OEEWG6GM+dsBfem4wTvtgYqNhDWw90jivczelyOG8d202IduT/vX+eO
	 WX/Z4zFmWfC6NT43551I8EPBvX7KbNqh1Vw06o+U=
Date: Fri, 12 Sep 2025 16:45:52 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,wangkefeng.wang@huawei.com,stable@vger.kernel.org,osalvador@suse.de,muchun.song@linux.dev,david@redhat.com,tujinjiang@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-hugetlb-fix-folio-is-still-mapped-when-deleted.patch added to mm-hotfixes-unstable branch
Message-Id: <20250912234553.657CFC4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/hugetlb: fix folio is still mapped when deleted
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-hugetlb-fix-folio-is-still-mapped-when-deleted.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-fix-folio-is-still-mapped-when-deleted.patch

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
From: Jinjiang Tu <tujinjiang@huawei.com>
Subject: mm/hugetlb: fix folio is still mapped when deleted
Date: Fri, 12 Sep 2025 15:41:39 +0800

Migration may be raced with fallocating hole.  remove_inode_single_folio
will unmap the folio if the folio is still mapped.  However, it's called
without folio lock.  If the folio is migrated and the mapped pte has been
converted to migration entry, folio_mapped() returns false, and won't
unmap it.  Due to extra refcount held by remove_inode_single_folio,
migration fails, restores migration entry to normal pte, and the folio is
mapped again.  As a result, we triggered BUG in filemap_unaccount_folio.

The log is as follows:
 BUG: Bad page cache in process hugetlb  pfn:156c00
 page: refcount:515 mapcount:0 mapping:0000000099fef6e1 index:0x0 pfn:0x156c00
 head: order:9 mapcount:1 entire_mapcount:1 nr_pages_mapped:0 pincount:0
 aops:hugetlbfs_aops ino:dcc dentry name(?):"my_hugepage_file"
 flags: 0x17ffffc00000c1(locked|waiters|head|node=0|zone=2|lastcpupid=0x1fffff)
 page_type: f4(hugetlb)
 page dumped because: still mapped when deleted
 CPU: 1 UID: 0 PID: 395 Comm: hugetlb Not tainted 6.17.0-rc5-00044-g7aac71907bde-dirty #484 NONE
 Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4f/0x70
  filemap_unaccount_folio+0xc4/0x1c0
  __filemap_remove_folio+0x38/0x1c0
  filemap_remove_folio+0x41/0xd0
  remove_inode_hugepages+0x142/0x250
  hugetlbfs_fallocate+0x471/0x5a0
  vfs_fallocate+0x149/0x380

Hold folio lock before checking if the folio is mapped to avold race with
migration.

Link: https://lkml.kernel.org/r/20250912074139.3575005-1-tujinjiang@huawei.com
Fixes: 4aae8d1c051e ("mm/hugetlbfs: unmap pages if page fault raced with hole punch")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/hugetlbfs/inode.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/hugetlbfs/inode.c~mm-hugetlb-fix-folio-is-still-mapped-when-deleted
+++ a/fs/hugetlbfs/inode.c
@@ -517,14 +517,16 @@ static bool remove_inode_single_folio(st
 
 	/*
 	 * If folio is mapped, it was faulted in after being
-	 * unmapped in caller.  Unmap (again) while holding
-	 * the fault mutex.  The mutex will prevent faults
-	 * until we finish removing the folio.
+	 * unmapped in caller or hugetlb_vmdelete_list() skips
+	 * unmapping it due to fail to grab lock.  Unmap (again)
+	 * while holding the fault mutex.  The mutex will prevent
+	 * faults until we finish removing the folio.  Hold folio
+	 * lock to guarantee no concurrent migration.
 	 */
+	folio_lock(folio);
 	if (unlikely(folio_mapped(folio)))
 		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
-	folio_lock(folio);
 	/*
 	 * We must remove the folio from page cache before removing
 	 * the region/ reserve map (hugetlb_unreserve_pages).  In
_

Patches currently in -mm which might be from tujinjiang@huawei.com are

mm-hugetlb-fix-folio-is-still-mapped-when-deleted.patch
filemap-optimize-folio-refount-update-in-filemap_map_pages.patch


