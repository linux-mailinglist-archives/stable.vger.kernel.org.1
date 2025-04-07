Return-Path: <stable+bounces-128438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D9A7D1E0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 04:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D74216CD92
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23351212D6A;
	Mon,  7 Apr 2025 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sum2x4QJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D81917FB;
	Mon,  7 Apr 2025 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991285; cv=none; b=d2tUXZ7fJSR6yb+19GHB/nFh8uaW34q8r9xm/zb3JLBGzAdnSHZSOygZ/6F35Q/17MrkFzdWIUMnVCwB6ICjiSLcIxh4cZf07HIp4YBltqnv6DAmnaeXWKUCjFBrkLTd1DoQVb57edzBpeAEii4SJyaGCuNmtVlGR4q9/rqvWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991285; c=relaxed/simple;
	bh=fIUxbyamkEFrpHCz1Gav28IDD7hLkl9qS7115F388qA=;
	h=Date:To:From:Subject:Message-Id; b=NU/rVdA+oYYvVH5i3bnf44KVeLgZHYKQMItLmZz3M8dhS7+4EA3z/iO6KYu95jQJ0sWKD29Cyj6y6kElxMb0uZxmKA9ohTcgCFmn0KgwDxfEhNLeKxA9U6V0PifZWre28m8y/oYLb1T/YAG2E7100OPyMaDY3QDtHmY8tq2qn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sum2x4QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A81C4CEE3;
	Mon,  7 Apr 2025 02:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743991285;
	bh=fIUxbyamkEFrpHCz1Gav28IDD7hLkl9qS7115F388qA=;
	h=Date:To:From:Subject:From;
	b=Sum2x4QJx+R7qKWFCPaRjq4LPtW20N4426hZ6vHrNKVsZvCsMzqa18ID2uisT+ar/
	 a6Gpk+TiuGERZ8B1Q/NvTYUUvNZsXnP2JZmTmc7xOLFWWj4ChM+6qOcJXdJIHXF5Wk
	 K6w2N4urB2k/2pjEbB0nSmKbC/rlaVATt3S/1h/4=
Date: Sun, 06 Apr 2025 19:01:24 -0700
To: mm-commits@vger.kernel.org,wangkefeng.wang@huawei.com,sunnanyong@huawei.com,stable@vger.kernel.org,osalvador@suse.de,nao.horiguchi@gmail.com,david@redhat.com,tujinjiang@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-memory_hotplug-fix-call-folio_test_large-with-tail-page-in-do_migrate_range.patch added to mm-hotfixes-unstable branch
Message-Id: <20250407020125.62A81C4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/memory_hotplug: fix call folio_test_large with tail page in do_migrate_range
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-memory_hotplug-fix-call-folio_test_large-with-tail-page-in-do_migrate_range.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-memory_hotplug-fix-call-folio_test_large-with-tail-page-in-do_migrate_range.patch

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
Subject: mm/memory_hotplug: fix call folio_test_large with tail page in do_migrate_range
Date: Mon, 24 Mar 2025 21:17:50 +0800

We triggered the below BUG:

 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x2 pfn:0x240402
 head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x1ffffe0000000040(head|node=1|zone=3|lastcpupid=0x1ffff)
 page_type: f4(hugetlb)
 page dumped because: VM_BUG_ON_PAGE(page->compound_head & 1)
 ------------[ cut here ]------------
 kernel BUG at ./include/linux/page-flags.h:310!
 Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 7 UID: 0 PID: 166 Comm: sh Not tainted 6.14.0-rc7-dirty #374
 Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : const_folio_flags+0x3c/0x58
 lr : const_folio_flags+0x3c/0x58
 Call trace:
  const_folio_flags+0x3c/0x58 (P)
  do_migrate_range+0x164/0x720
  offline_pages+0x63c/0x6fc
  memory_subsys_offline+0x190/0x1f4
  device_offline+0xc0/0x13c
  state_store+0x90/0xd8
  dev_attr_store+0x18/0x2c
  sysfs_kf_write+0x44/0x54
  kernfs_fop_write_iter+0x120/0x1cc
  vfs_write+0x240/0x378
  ksys_write+0x70/0x108
  __arm64_sys_write+0x1c/0x28
  invoke_syscall+0x48/0x10c
  el0_svc_common.constprop.0+0x40/0xe0

When allocating a hugetlb folio, between the folio is taken from buddy and
prep_compound_page() is called, start_isolate_page_range() and
do_migrate_range() is called.  When do_migrate_range() scans the head page
of the hugetlb folio, the compound_head field isn't set, so scans the tail
page next.  And at this time, the compound_head field of tail page is set,
folio_test_large() is called by tail page, thus triggers VM_BUG_ON().

To fix it, get folio refcount before calling folio_test_large().

Link: https://lkml.kernel.org/r/20250324131750.1551884-1-tujinjiang@huawei.com
Fixes: 8135d8926c08 ("mm: memory_hotplug: memory hotremove supports thp migration")
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory_hotplug.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/mm/memory_hotplug.c~mm-memory_hotplug-fix-call-folio_test_large-with-tail-page-in-do_migrate_range
+++ a/mm/memory_hotplug.c
@@ -1813,21 +1813,15 @@ static void do_migrate_range(unsigned lo
 		page = pfn_to_page(pfn);
 		folio = page_folio(page);
 
-		/*
-		 * No reference or lock is held on the folio, so it might
-		 * be modified concurrently (e.g. split).  As such,
-		 * folio_nr_pages() may read garbage.  This is fine as the outer
-		 * loop will revisit the split folio later.
-		 */
-		if (folio_test_large(folio))
-			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
-
 		if (!folio_try_get(folio))
 			continue;
 
 		if (unlikely(page_folio(page) != folio))
 			goto put_folio;
 
+		if (folio_test_large(folio))
+			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
+
 		if (folio_contain_hwpoisoned_page(folio)) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
_

Patches currently in -mm which might be from tujinjiang@huawei.com are

mm-contig_alloc-fix-alloc_contig_range-when-__gfp_comp-and-order-max_order.patch
mm-memory_hotplug-fix-call-folio_test_large-with-tail-page-in-do_migrate_range.patch


