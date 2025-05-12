Return-Path: <stable+bounces-143152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E8AB32F6
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8613D3B4578
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB825B67D;
	Mon, 12 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAuVLRrD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82662194AD5
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041608; cv=none; b=CRoIQHSFWVbZcqhKLDr53ywLNjbSO1jtfMHZOeEW4BDTh4orU1v2t8ItbYoUDaUuzUW4qhzJZL///eEE/CIdSFRQfSTeWc0MxTi/kHe49cLWnXM2i2zlzIxOR3pL4T4Ti2g6EFUlIrEltWzp/o900doWMHYjVfu89Ozl5UjI2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041608; c=relaxed/simple;
	bh=vAEfc0pDG6qr70WTK3bEt9I1Vy9AAsPQYC0VPLhY/RQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cD7yq9Pm8D/HSobExZub+ABftxwxp1IHdIl2AZzFhY4WXQuuGOgk6q+dxyzOqMZiZQKT7/PkaocXSB6Lsq9YCW4lczP9UnabTZC9OWGA79Dsz7l5X3hzKaxwrcM8DxU6Q+zpMz10/QRlV3TTi7vLHeObp5e0VYBGNPoI31XE+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LAuVLRrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D75C4CEE7;
	Mon, 12 May 2025 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747041608;
	bh=vAEfc0pDG6qr70WTK3bEt9I1Vy9AAsPQYC0VPLhY/RQ=;
	h=Subject:To:Cc:From:Date:From;
	b=LAuVLRrDeDreEsRyX3GF1NvYNv+KHOpI1ln1pFzoVdE0GUIBFkcLoJOVtOTByya4i
	 WI2th0N3H47Zch4jyXX88nhpUDrzYWzmQo8Ka2H4Yhp1XsgH+NjVhGKXyLcX+Fmco2
	 yVmWI6z9tpLX178cXiKON/dAaPzk7ZiBA+Ft9JeM=
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix dereferencing invalid pmd migration entry" failed to apply to 6.1-stable tree
To: gavinguo@igalia.com,akpm@linux-foundation.org,david@redhat.com,gshan@redhat.com,hughd@google.com,linmiaohe@huawei.com,revest@google.com,stable@vger.kernel.org,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:20:03 +0200
Message-ID: <2025051203-thrift-spool-ebc8@gregkh>
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
git cherry-pick -x be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051203-thrift-spool-ebc8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 Mon Sep 17 00:00:00 2001
From: Gavin Guo <gavinguo@igalia.com>
Date: Mon, 21 Apr 2025 19:35:36 +0800
Subject: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration entry

When migrating a THP, concurrent access to the PMD migration entry during
a deferred split scan can lead to an invalid address access, as
illustrated below.  To prevent this invalid access, it is necessary to
check the PMD migration entry and return early.  In this context, there is
no need to use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the
equality of the target folio.  Since the PMD migration entry is locked, it
cannot be served as the target.

Mailing list discussion and explanation from Hugh Dickins: "An anon_vma
lookup points to a location which may contain the folio of interest, but
might instead contain another folio: and weeding out those other folios is
precisely what the "folio != pmd_folio((*pmd)" check (and the "risk of
replacing the wrong folio" comment a few lines above it) is for."

BUG: unable to handle page fault for address: ffffea60001db008
CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
Call Trace:
<TASK>
try_to_migrate_one+0x28c/0x3730
rmap_walk_anon+0x4f6/0x770
unmap_folio+0x196/0x1f0
split_huge_page_to_list_to_order+0x9f6/0x1560
deferred_split_scan+0xac5/0x12a0
shrinker_debugfs_scan_write+0x376/0x470
full_proxy_write+0x15c/0x220
vfs_write+0x2fc/0xcb0
ksys_write+0x146/0x250
do_syscall_64+0x6a/0x120
entry_SYSCALL_64_after_hwframe+0x76/0x7e

The bug is found by syzkaller on an internal kernel, then confirmed on
upstream.

Link: https://lkml.kernel.org/r/20250421113536.3682201-1-gavinguo@igalia.com
Link: https://lore.kernel.org/all/20250414072737.1698513-1-gavinguo@igalia.com/
Link: https://lore.kernel.org/all/20250418085802.2973519-1-gavinguo@igalia.com/
Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Gavin Guo <gavinguo@igalia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Cc: Florent Revest <revest@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..47d76d03ce30 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio)
 {
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
+
 	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
@@ -3085,9 +3087,12 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		if (folio && folio != pmd_folio(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
+		/*
+		 * Do not apply pmd_folio() to a migration entry; and folio lock
+		 * guarantees that it must be of the wrong folio anyway.
+		 */
+		if (folio && (pmd_migration || folio != pmd_folio(*pmd)))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 	}


