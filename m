Return-Path: <stable+bounces-181995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3FBAA7D6
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C4C7A2628
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058123BD13;
	Mon, 29 Sep 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uux/o8Ke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE41F1932
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175066; cv=none; b=W+rVAK6ZVpPaGGKtosuo7D5533+DQn4eVviSI2iSAjCHivhrxzZXY1JK9BE62cbjoBMTywNADURrmJnujGvyMSeQHuuc9iHafR9Q9nxnYfKEH1xEAkQCfw6SZ0VELEDqFpRvg8L7/jJx8QVMM1Y7si5CiXx43i2tdJEcGRbEuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175066; c=relaxed/simple;
	bh=HGSZjt83jpoxmc5fgQytKL6qI0qDlhDN5SsCtKioAPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwgsF0UAWH8kdriObitR6JHord31T+6IdbVdALePWcQgD8E5fKPw43INX0PxABHE6oRSLLCEHuyajhAqDoPzfBvAi+CIGYye7U3snm0Zqu5/BVR7XCk7SZI0DZeX5IqsQHr+SYJo0EnjCD419VPJn0jAbdQdTaqoVa1J6TRI2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uux/o8Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45823C4CEF4;
	Mon, 29 Sep 2025 19:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759175066;
	bh=HGSZjt83jpoxmc5fgQytKL6qI0qDlhDN5SsCtKioAPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uux/o8KeJBN/PokXOgyQMIPCIzwI+M9V+KKxSkUzSjVrfQ+BOEPqq0431BVaPSfxD
	 GufrZOPSEFJM9HVs2epv9GKP1xVfKLxmolkk7am2pBK3MemPeZ8niZ4OSHPaPlO8Io
	 5nj2xtTXtDiAg6JlAUWFQPGyy03fLOciwbbYowFAouGERmdcKdVBVfZplxJey6RKBS
	 ZFfc7xryX03komyjsKaXyagerfLHvlQli5hoOA6cBVdqXEx4uTcSvjfjJHzeQZcQLp
	 Ujb8m6KLds4/1g4G2AB8cSYAtPy/IrQOBhy6pRT9hTSBz7bBwK4IpBu6mkSiGdJDEZ
	 p32cRUMhXSLbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jinjiang Tu <tujinjiang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/hugetlb: fix folio is still mapped when deleted
Date: Mon, 29 Sep 2025 15:44:23 -0400
Message-ID: <20250929194423.334354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092930-header-irritable-c8ed@gregkh>
References: <2025092930-header-irritable-c8ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjiang Tu <tujinjiang@huawei.com>

[ Upstream commit 7b7387650dcf2881fd8bb55bcf3c8bd6c9542dd7 ]

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
[ folio -> page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c8a5d94561ff2..3105376741865 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -519,13 +519,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			/*
 			 * If page is mapped, it was faulted in after being
-			 * unmapped in caller.  Unmap (again) now after taking
-			 * the fault mutex.  The mutex will prevent faults
-			 * until we finish removing the page.
-			 *
-			 * This race can only happen in the hole punch case.
-			 * Getting here in a truncate operation is a bug.
+			 * unmapped in caller or hugetlb_vmdelete_list() skips
+			 * unmapping it due to fail to grab lock.  Unmap (again)
+			 * while holding the fault mutex.  The mutex will prevent
+			 * faults until we finish removing the page.  Hold page
+			 * lock to guarantee no concurrent migration.
 			 */
+			lock_page(page);
 			if (unlikely(page_mapped(page))) {
 				BUG_ON(truncate_op);
 
@@ -537,8 +537,6 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
 			}
-
-			lock_page(page);
 			/*
 			 * We must free the huge page and remove from page
 			 * cache (remove_huge_page) BEFORE removing the
-- 
2.51.0


