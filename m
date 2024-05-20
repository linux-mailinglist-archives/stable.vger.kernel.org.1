Return-Path: <stable+bounces-45426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 807BF8C9765
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FE6281189
	for <lists+stable@lfdr.de>; Sun, 19 May 2024 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185B71B4C;
	Sun, 19 May 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wWo2Qz0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF063335C7;
	Sun, 19 May 2024 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716161909; cv=none; b=HejTgoMAO6DpGnPwdQY4zP5QuY7iSkFW9GhKvmtRA/0Ybs/aPQ5e4a3yibO4xZrhdPomHGLqgUYyPLmpVoXWstJcBxz2RdY7GTVvOU+PmVI+QQZ5CTnSirlnLkR6cb0eSHvg2tFNy7FHmpdIMUOFiGUvbOeux8Gl3vdU8KpJtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716161909; c=relaxed/simple;
	bh=pGDiMU3VLjKvOuPmkbe0yr6cavGUkz5eEdtWWP+UlP0=;
	h=Date:To:From:Subject:Message-Id; b=OJlnmyKUm0n/+YFSL9Ui6MjcqDp2WHuVPQyAadkK4m+wrJ/PoeXmBgeKp5UTIU9vmu9NZQEO174P5FmVDzP2GHidecQ5/j4tOJ4Tqafg3sbzmwb9jy80sWHucY10+Zu9J2FYQ2/ogEeduOCk9gUDwxs4yMlkh6oM/+8GbIhYqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wWo2Qz0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A52C32781;
	Sun, 19 May 2024 23:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716161909;
	bh=pGDiMU3VLjKvOuPmkbe0yr6cavGUkz5eEdtWWP+UlP0=;
	h=Date:To:From:Subject:From;
	b=wWo2Qz0Pk8PXW+Ui5hQo3q3AaRHO1Oq2Xa/993017Gn+lKeCz13hoXvopsdwQkfzp
	 s6rUoSEXJq207kRlTdaGxKfcvilF1Qe1nF043lIq2XdhECg2ax4jE57+10M3fjHnyT
	 WZEYAAg3Kj74E6GhHDVdNp9hrinFrqynB3BpqFTA=
Date: Sun, 19 May 2024 16:38:28 -0700
To: mm-commits@vger.kernel.org,xuyu@linux.alibaba.com,stable@vger.kernel.org,shy828301@gmail.com,osalvador@suse.de,nao.horiguchi@gmail.com,david@redhat.com,anshuman.khandual@arm.com,linmiaohe@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-huge_memory-dont-unpoison-huge_zero_folio.patch added to mm-hotfixes-unstable branch
Message-Id: <20240519233829.15A52C32781@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/huge_memory: don't unpoison huge_zero_folio
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-huge_memory-dont-unpoison-huge_zero_folio.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-huge_memory-dont-unpoison-huge_zero_folio.patch

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
Subject: mm/huge_memory: don't unpoison huge_zero_folio
Date: Thu, 16 May 2024 20:26:08 +0800

When I did memory failure tests recently, below panic occurs:

 kernel BUG at include/linux/mm.h:1135!
 invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
 RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
 RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
 RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
 RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
 RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
 R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
 FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0
 Call Trace:
  <TASK>
  do_shrink_slab+0x14f/0x6a0
  shrink_slab+0xca/0x8c0
  shrink_node+0x2d0/0x7d0
  balance_pgdat+0x33a/0x720
  kswapd+0x1f3/0x410
  kthread+0xd5/0x100
  ret_from_fork+0x2f/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in: mce_inject hwpoison_inject
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:shrink_huge_zero_page_scan+0x168/0x1a0
 RSP: 0018:ffff9933c6c57bd0 EFLAGS: 00000246
 RAX: 000000000000003e RBX: 0000000000000000 RCX: ffff88f61fc5c9c8
 RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff88f61fc5c9c0
 RBP: ffffcd7c446b0000 R08: ffffffff9a9405f0 R09: 0000000000005492
 R10: 00000000000030ea R11: ffffffff9a9405f0 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff88e703c4ac00
 FS:  0000000000000000(0000) GS:ffff88f61fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055f4da6e9878 CR3: 0000000c71048000 CR4: 00000000000006f0

The root cause is that HWPoison flag will be set for huge_zero_folio
without increasing the folio refcnt.  But then unpoison_memory() will
decrease the folio refcnt unexpectedly as it appears like a successfully
hwpoisoned folio leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0) when
releasing huge_zero_folio.

Skip unpoisoning huge_zero_folio in unpoison_memory() to fix this issue. 
We're not prepared to unpoison huge_zero_folio yet.

Link: https://lkml.kernel.org/r/20240516122608.22610-1-linmiaohe@huawei.com
Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Xu Yu <xuyu@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory-failure.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/memory-failure.c~mm-huge_memory-dont-unpoison-huge_zero_folio
+++ a/mm/memory-failure.c
@@ -2546,6 +2546,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (is_huge_zero_folio(folio)) {
+		unpoison_pr_info("Unpoison: huge zero page is not supported %#lx\n",
+				 pfn, &unpoison_rs);
+		ret = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
_

Patches currently in -mm which might be from linmiaohe@huawei.com are

mm-huge_memory-dont-unpoison-huge_zero_folio.patch


