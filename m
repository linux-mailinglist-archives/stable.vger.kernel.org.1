Return-Path: <stable+bounces-181909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27127BA947E
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC3A169197
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289D2FF677;
	Mon, 29 Sep 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xuRp9CvR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE682D592C
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151142; cv=none; b=KAATMjb/SA98ahGSg9+C11wYmKHT2rGH1nWgyzpfcDsBVcTlMhzHqalGxFuU6eQLnk3o5Y3cjNzMnwAnEosuxySkpTBXGK9kw66BumuNsHViqB+L7zaq/23nKMUDmq26r2+gZYVFOwC+bnqow5HJTgMhlqtIOYXBMfBf5Kc3Dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151142; c=relaxed/simple;
	bh=1QVldoierM/DjtqLwoMSk6gFMG0cHRcZr8qwQbaebN4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VpTvFWQ2d2ZjsiIlwhulvq55azBtAu3CuhVYseIpvdtc35fOLX1sEUQRH3nEM1dMfCQQjX9ThcDa3VWxHGQztAfTD9vAPP65k9Fsg45cUs1E7qDPGrRF7PimVSXE2ApCMRE6OEbp6hq37W7MEtcnaIFYrYwSuw4/5HVcdZYJzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xuRp9CvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F5C4CEF4;
	Mon, 29 Sep 2025 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759151142;
	bh=1QVldoierM/DjtqLwoMSk6gFMG0cHRcZr8qwQbaebN4=;
	h=Subject:To:Cc:From:Date:From;
	b=xuRp9CvRNlCWsjMgtoALK8qYpZrnsynkDrWpVB30lawa4IpoKLJZn+bm7GGrf77Hk
	 7NQIliTkEzvlUv0/Ya9LheM3bf0KLzUnWuMfmz2pRIe7B/rK7S14npHE9XQ6Pjng1w
	 0qyx3hUvZS5pMDBXvnEJeRC3aErVtqzqYYbo/Uxo=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix folio is still mapped when deleted" failed to apply to 5.10-stable tree
To: tujinjiang@huawei.com,akpm@linux-foundation.org,david@redhat.com,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org,wangkefeng.wang@huawei.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:05:31 +0200
Message-ID: <2025092931-vastness-jawed-6945@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7b7387650dcf2881fd8bb55bcf3c8bd6c9542dd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092931-vastness-jawed-6945@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b7387650dcf2881fd8bb55bcf3c8bd6c9542dd7 Mon Sep 17 00:00:00 2001
From: Jinjiang Tu <tujinjiang@huawei.com>
Date: Fri, 12 Sep 2025 15:41:39 +0800
Subject: [PATCH] mm/hugetlb: fix folio is still mapped when deleted

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

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 09d4baef29cf..be4be99304bc 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -517,14 +517,16 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
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


