Return-Path: <stable+bounces-182151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82FBAD509
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895931886665
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09ED302755;
	Tue, 30 Sep 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rpj+z78f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA73043C4;
	Tue, 30 Sep 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244005; cv=none; b=dfhwLIR6O9V9ORFJNQsrz9Zs3zVb/1CIS6KraBdvKiJlsf+qsj26H9wNpTh/MxG/uELaa8gISfoMeRpK6vW17Aj9JJkf2Mm/Kib2TivaFe/wYImNTPbp//kDeT1zhLdG+olhQoBMzdn3HKUdKOlNAnaEXcs23jgPwEAbGAJQWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244005; c=relaxed/simple;
	bh=L7qTR+zOnP9v+UrlTP56tJj4Tt9UuwLC1EJL3tk6LsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMiqxkkzuCvgFnK6hBEevvbNy4YA9DIf4RlGQAoeqXlkDdCDsEtb1cEDoSk3dO4CRj2J1Buh7cLIT9emdlaJ/hn/pEPHEfPh4NIuY2oN5E2FA9wepFMoEUZaelqFeWHJa4QM4nwbEGGxoXzXNbnlsLo/aqV5E3LBaDZ1/D3+Efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rpj+z78f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F2C4CEF0;
	Tue, 30 Sep 2025 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244005;
	bh=L7qTR+zOnP9v+UrlTP56tJj4Tt9UuwLC1EJL3tk6LsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rpj+z78f+gXAikf4/XC2ZF9i22adZBEuSWxppJeCvRMmEkEORomCY93idd8TGyCM4
	 XGC11KQea+flvl/ubC80BfDA33DKZihuNAV75674spfD/39k1Pj7m4Z3+z3/6l9Xmo
	 +545v4wQ+Ey3uyFbRir/Exw5dnkqh+C9/NgdQaPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjiang Tu <tujinjiang@huawei.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 81/81] mm/hugetlb: fix folio is still mapped when deleted
Date: Tue, 30 Sep 2025 16:47:23 +0200
Message-ID: <20250930143823.117383084@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hugetlbfs/inode.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -502,13 +502,13 @@ static void remove_inode_hugepages(struc
 
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
 
@@ -518,8 +518,6 @@ static void remove_inode_hugepages(struc
 					(index + 1) * pages_per_huge_page(h));
 				i_mmap_unlock_write(mapping);
 			}
-
-			lock_page(page);
 			/*
 			 * We must free the huge page and remove from page
 			 * cache (remove_huge_page) BEFORE removing the



