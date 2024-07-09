Return-Path: <stable+bounces-58944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822D92C54A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 23:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50EA2828AF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FDB182A58;
	Tue,  9 Jul 2024 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="psS0O6x+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF58153505;
	Tue,  9 Jul 2024 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560299; cv=none; b=lUnymXG8vnLYC5Na4/1PdLWvftZdHZk1tZLvglfcP/diYGNXCV/grUOs9UP5YUs/EwyHOyR27NuQ43k+zYSsnGMTF6BSsaYcmxtJ/0Mff4IURMaESUncuABlP4K+nd8NsfvAtmZFYUBoLp5jLRwb9GkXRLfPF3wTUN9HbUC/SN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560299; c=relaxed/simple;
	bh=PIqq3LEc7NRihJ60b4Nkq//Xt1rREK5EJrbcVX8FAxA=;
	h=Date:To:From:Subject:Message-Id; b=uOLixTpdmtcPn118WVN4HoqjtQVE2kWitd3kKyxghNGh782Xh+2WyAkoMTK9Aj64pbB5vB61htAyeUtZ0jXUd88GnJ/1JDllY2PvBCEkdshJjFsAEhhUALEE9uy1eGMF3E8TAA+KapmAAmn0o7uOnvJDMA0tVAdB7+7FWZffTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=psS0O6x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09C3C3277B;
	Tue,  9 Jul 2024 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720560298;
	bh=PIqq3LEc7NRihJ60b4Nkq//Xt1rREK5EJrbcVX8FAxA=;
	h=Date:To:From:Subject:From;
	b=psS0O6x+xWe09DsDsDCI6MWZZtC/eGRc2Dcqby/H/0YtEO05Lvzb79oRx+lpgkOsT
	 Jwko8IdHmmTagQYvvINsI99Pu8pCxgZxFQxFsnRQ7kbz9MpMsXuMyuC6NjUXXg3Grx
	 Q28YizYF8e40k8eZXcgOwwbJXN6mdhjIm0gUuiPM=
Date: Tue, 09 Jul 2024 14:24:58 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,muchun.song@linux.dev,hughd@google.com,linmiaohe@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-hugetlb-fix-kernel-null-pointer-dereference-when-migrating-hugetlb-folio.patch added to mm-hotfixes-unstable branch
Message-Id: <20240709212458.B09C3C3277B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-hugetlb-fix-kernel-null-pointer-dereference-when-migrating-hugetlb-folio.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-fix-kernel-null-pointer-dereference-when-migrating-hugetlb-folio.patch

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
From: Miaohe Lin <linmiaohe@huawei.com>
Subject: mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio
Date: Tue, 9 Jul 2024 20:04:33 +0800

A kernel crash was observed when migrating hugetlb folio:

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0
Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 3435 Comm: bash Not tainted 6.10.0-rc6-00450-g8578ca01f21f #66
RIP: 0010:__folio_undo_large_rmappable+0x70/0xb0
RSP: 0018:ffffb165c98a7b38 EFLAGS: 00000097
RAX: fffffbbc44528090 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffa30e000a2800 RSI: 0000000000000246 RDI: ffffa3153ffffcc0
RBP: fffffbbc44528000 R08: 0000000000002371 R09: ffffffffbe4e5868
R10: 0000000000000001 R11: 0000000000000001 R12: ffffa3153ffffcc0
R13: fffffbbc44468000 R14: 0000000000000001 R15: 0000000000000001
FS:  00007f5b3a716740(0000) GS:ffffa3151fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000010959a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __folio_migrate_mapping+0x59e/0x950
 __migrate_folio.constprop.0+0x5f/0x120
 move_to_new_folio+0xfd/0x250
 migrate_pages+0x383/0xd70
 soft_offline_page+0x2ab/0x7f0
 soft_offline_page_store+0x52/0x90
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xb9/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b3a514887
RSP: 002b:00007ffe138fce68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f5b3a514887
RDX: 000000000000000c RSI: 0000556ab809ee10 RDI: 0000000000000001
RBP: 0000556ab809ee10 R08: 00007f5b3a5d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007f5b3a61b780 R14: 00007f5b3a617600 R15: 00007f5b3a616a00

It's because hugetlb folio is passed to __folio_undo_large_rmappable()
unexpectedly.  large_rmappable flag is imperceptibly set to hugetlb folio
since commit f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to
use a folio").  Then commit be9581ea8c05 ("mm: fix crashes from deferred
split racing folio migration") makes folio_migrate_mapping() call
folio_undo_large_rmappable() triggering the bug.  Fix this issue by
clearing large_rmappable flag for hugetlb folios.  They don't need that
flag set anyway.

Link: https://lkml.kernel.org/r/20240709120433.4136700-1-linmiaohe@huawei.com
Fixes: f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")
Fixes: be9581ea8c05 ("mm: fix crashes from deferred split racing folio migration")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/mm/hugetlb.c~mm-hugetlb-fix-kernel-null-pointer-dereference-when-migrating-hugetlb-folio
+++ a/mm/hugetlb.c
@@ -2162,6 +2162,9 @@ static struct folio *alloc_buddy_hugetlb
 		nid = numa_mem_id();
 retry:
 	folio = __folio_alloc(gfp_mask, order, nid, nmask);
+	/* Ensure hugetlb folio won't have large_rmappable flag set. */
+	if (folio)
+		folio_clear_large_rmappable(folio);
 
 	if (folio && !folio_ref_freeze(folio, 1)) {
 		folio_put(folio);
_

Patches currently in -mm which might be from linmiaohe@huawei.com are

mm-hugetlb-fix-potential-race-in-__update_and_free_hugetlb_folio.patch
mm-hugetlb-fix-kernel-null-pointer-dereference-when-migrating-hugetlb-folio.patch
mm-memory-failure-remove-obsolete-mf_msg_different_compound.patch


