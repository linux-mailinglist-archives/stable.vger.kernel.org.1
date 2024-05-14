Return-Path: <stable+bounces-45096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345B8C5ADC
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39A81C21CA1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054911802CD;
	Tue, 14 May 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xL+12Xxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C621E487;
	Tue, 14 May 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710484; cv=none; b=m8htwsYE3ANKWMBsgatyZp8bwOjSlIeBKcTLXqrnQk7zG8Qs7NypAB+JKVo+ff9OznXfNJkMtTGsQML0//VIrSLxEEXiu2rWIT1f9Df43AAhywLWqVBpjoxlBp5DUxPZL02cqOzs7cGVvtZ3IA7RE09v1jPEH3m6S0KhZ6Kb5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710484; c=relaxed/simple;
	bh=GMUOu4hvb8NdAMYVr5g91uztX05xA/mhP2BKu4fk6Ho=;
	h=Date:To:From:Subject:Message-Id; b=A2MdeJ+aTOh2DiSe4V8Xe2URO3RGSnJjKy1WidmKgJfL9jSzo8MnYxMTRHyKUufzzFBqd0DjU3fJcrCk7A8dLn8bZFbfWaW8pSmEXwQ66/yzfkzsrGmetW2lXvdmFn4zzlo/Xnuxb2V3mFOZsuJMKHFphXq9LhhjVo0jMsghXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xL+12Xxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23475C2BD10;
	Tue, 14 May 2024 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715710484;
	bh=GMUOu4hvb8NdAMYVr5g91uztX05xA/mhP2BKu4fk6Ho=;
	h=Date:To:From:Subject:From;
	b=xL+12XxkCmH6Pbq//w4J2FZidGWU0LXCOVh6ZQiOwwgz8fvHTVEVlWt7FEwOldDd5
	 IxABv1T5tLHuPUbLHViuPmfzO73FPxtdF7R6Hi9bYHRjm7lfiAN84dcsdjk7DIB26R
	 6nniZ/7LbQT5pD0iZvyIb62lritZlAP8XE9PTQ4Y=
Date: Tue, 14 May 2024 11:14:43 -0700
To: mm-commits@vger.kernel.org,xuyu@linux.alibaba.com,stable@vger.kernel.org,shy828301@gmail.com,nao.horiguchi@gmail.com,linmiaohe@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-huge_memory-mark-huge_zero_page-reserved.patch added to mm-hotfixes-unstable branch
Message-Id: <20240514181444.23475C2BD10@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/huge_memory: mark huge_zero_page reserved
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-huge_memory-mark-huge_zero_page-reserved.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-huge_memory-mark-huge_zero_page-reserved.patch

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
Subject: mm/huge_memory: mark huge_zero_page reserved
Date: Sat, 11 May 2024 11:54:35 +0800

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

The root cause is that HWPoison flag will be set for huge_zero_page
without increasing the page refcnt. But then unpoison_memory() will
decrease the page refcnt unexpectly as it appears like a successfully
hwpoisoned page leading to VM_BUG_ON_PAGE(page_ref_count(page) == 0)
when releasing huge_zero_page.

Fix this issue by marking huge_zero_page reserved. So unpoison_memory()
will skip this page. This will make it consistent with ZERO_PAGE case too.

Link: https://lkml.kernel.org/r/20240511035435.1477004-1-linmiaohe@huawei.com
Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge_zero_page")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Xu Yu <xuyu@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/huge_memory.c~mm-huge_memory-mark-huge_zero_page-reserved
+++ a/mm/huge_memory.c
@@ -208,6 +208,7 @@ retry:
 		__free_pages(zero_page, compound_order(zero_page));
 		goto retry;
 	}
+	__SetPageReserved(zero_page);
 	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
 
 	/* We take additional reference here. It will be put back by shrinker */
@@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_pa
 		struct page *zero_page = xchg(&huge_zero_page, NULL);
 		BUG_ON(zero_page == NULL);
 		WRITE_ONCE(huge_zero_pfn, ~0UL);
+		__ClearPageReserved(zero_page);
 		__free_pages(zero_page, compound_order(zero_page));
 		return HPAGE_PMD_NR;
 	}
_

Patches currently in -mm which might be from linmiaohe@huawei.com are

mm-huge_memory-mark-huge_zero_page-reserved.patch


