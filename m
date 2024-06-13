Return-Path: <stable+bounces-50454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4C90661A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9682845C7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8C13CABB;
	Thu, 13 Jun 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxMAlE2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E713A3F4
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265780; cv=none; b=IRyBkFeVSbArOQ50asDIEi/1zmnJ0AgziEVVoGLfRxRJpZeqHvBshjxIGWYteEmotkXEx44Mg0KVL00YJQfDkFig1W5hcyPuG1//qWyETvCG1BW0d3kmx0YlAAdTnQbAMgHWsU+hOpu+JKQeeOC0rQDuBH/exWVtpPP12rFg4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265780; c=relaxed/simple;
	bh=DSBgDqOCquXFSgnDxbF/JvLHEIgw/NJbMuFpUCnl5t4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NIvMljpN07PI8R6USQqfVItBanDuStOnJUmAM7+ahLfUaJzG6J/jF0n1ycHJvm2o/JCTdFhgGhaSNDgHNPe0Yk8OREXj9tR5ifjqOCkyUtWyTCTaBQqUaoV7sj9OmiVbbA/A2EOTqVnG4S6rBPg3aoyEBOc4ySFFoOuGNIH0WPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxMAlE2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CFC4AF1A;
	Thu, 13 Jun 2024 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265779;
	bh=DSBgDqOCquXFSgnDxbF/JvLHEIgw/NJbMuFpUCnl5t4=;
	h=Subject:To:Cc:From:Date:From;
	b=VxMAlE2gPBhP8lV4nAdxn2gYgSw1s5qBF37jYwGe9/zsodWFelf5CsrIX6O1HPols
	 xxo5HFfTIfLk/abxIc+dx4GeXrowwSNbN2IgUmq5PE34L/o67Qr8Y6PDxKpM9syyRs
	 tkxbBQw5N+fergYgH52rKPGsi+2jtmNuBYNxm6qg=
Subject: FAILED: patch "[PATCH] mm/huge_memory: don't unpoison huge_zero_folio" failed to apply to 6.9-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,anshuman.khandual@arm.com,david@redhat.com,nao.horiguchi@gmail.com,osalvador@suse.de,shy828301@gmail.com,stable@vger.kernel.org,xuyu@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 10:02:57 +0200
Message-ID: <2024061356-victory-clothes-c151@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x fe6f86f4b40855a130a19aa589f9ba7f650423f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061356-victory-clothes-c151@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

fe6f86f4b408 ("mm/huge_memory: don't unpoison huge_zero_folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe6f86f4b40855a130a19aa589f9ba7f650423f4 Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Thu, 16 May 2024 20:26:08 +0800
Subject: [PATCH] mm/huge_memory: don't unpoison huge_zero_folio

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

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16ada4fb02b7..a9fe9eda593f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
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


