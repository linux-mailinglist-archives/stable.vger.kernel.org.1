Return-Path: <stable+bounces-62365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A393EE55
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB011F2517F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0FD12A16D;
	Mon, 29 Jul 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHga3cBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C36A8DB
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237538; cv=none; b=cDPUtlOmsEUXEekXJQEe2cGcBkXdqrC5DPJRLKRPdkCpo3J0PyOnbLqjFHEHP2MGQ/zfMMOjCNcdXXWbopSaW8E0fMeKsWBlGhueTXHbQgUHHN4hGlcufucZvlXu1Ga1uT/QLvfYo6gIrKdg9je5F2SuhnXC/T+8QblWt3H9O2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237538; c=relaxed/simple;
	bh=00i5Xa1Nt9Ye5DRs2jOmJwu+oCN6QSgXUkHmfJ1L+6w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YU9xmSnRCxPOqYBQRTCrWOehVZyw2vvTpzJOcllFBSEN16efrrsCmmAin9qq9lKgl5pj5sS6qni3/hGssvmgpOp9Y89/qWNU9MKpRiqc9I/BAE+aumZIy3iUyVoZTEtRMIrnXrQf7+DWWthv1xtfDZMso20hY3c4GMnfYK9feo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHga3cBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B56C4AF0A;
	Mon, 29 Jul 2024 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237538;
	bh=00i5Xa1Nt9Ye5DRs2jOmJwu+oCN6QSgXUkHmfJ1L+6w=;
	h=Subject:To:Cc:From:Date:From;
	b=bHga3cBevRCqA+dDPHswpBmCjZCtRzx70+xrVu17yXGQpV1/gmfxzbRb+KvOt3Eoc
	 mz7LJOBoiUOlCUpolY3vekntf4wNZmW/CDoD1TxojLZm63CT12h+1Dj8HWqPYqSSed
	 lZ0Tm1SGr/fsDy5zdfkub7IDnFLC4x1iX0VV6j3Y=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix kernel NULL pointer dereference when" failed to apply to 6.10-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,hughd@google.com,muchun.song@linux.dev,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:18:54 +0200
Message-ID: <2024072954-overhung-citrus-9daa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1390a3334a48ecac5175865fd433d55eec255db8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072954-overhung-citrus-9daa@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

1390a3334a48 ("mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1390a3334a48ecac5175865fd433d55eec255db8 Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Tue, 9 Jul 2024 20:04:33 +0800
Subject: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 migrating hugetlb folio

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

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 80a93b69652f..11f25e00a293 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2166,6 +2166,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		nid = numa_mem_id();
 retry:
 	folio = __folio_alloc(gfp_mask, order, nid, nmask);
+	/* Ensure hugetlb folio won't have large_rmappable flag set. */
+	if (folio)
+		folio_clear_large_rmappable(folio);
 
 	if (folio && !folio_ref_freeze(folio, 1)) {
 		folio_put(folio);


