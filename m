Return-Path: <stable+bounces-59338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36093132B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF8A1C2183F
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E6189F57;
	Mon, 15 Jul 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRs6VYXV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD060189F53
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043414; cv=none; b=jECKhHCO0U3xwFKSA+04UDkd/B8xDzsW4ZMfnRgeek+n+39dRt78uEJNKiTaZfxiNFBH0W9s5ps5aFROe7LlHnyM6MhuoGeHLTwyIdf1wOW9VsKDr1V9DeJB/unrlTfEG48SMOOa7baNX3CmGqdIRzOo3FBD0GEHw/aunrvjsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043414; c=relaxed/simple;
	bh=+iZv80Qf2Trpkf+V5egzD5Ub5ywsUkz5isII+qlLKu0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LPFOx8VG+ZbtvXustDoPe3r/vWSum0QPnmGHemJyj5LGU4/UkbH2pah8qrHwqq21+clxuxIMEpXrWo6pfwIhZvkvsGRqCoZTs+2yNjn5vg24Mqed8lyh9JPKmddIAuU4dkQ6C30UaO/LaBzdeAkDmCJt4maKOq5o4zf9ve4Knak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRs6VYXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618A2C4AF0A;
	Mon, 15 Jul 2024 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043413;
	bh=+iZv80Qf2Trpkf+V5egzD5Ub5ywsUkz5isII+qlLKu0=;
	h=Subject:To:Cc:From:Date:From;
	b=YRs6VYXVoJY9auqINA02gMUBhaoo4slHC29AqfIMHhRsrXWcP3tAg58H65NDqDvEl
	 YlPvL7bAegy6tidsWcNxiOAcEMSY9KgPjjkuNF2OVNsd28gQOUceiBoz48O/qz++Yq
	 RLUVrqSEjJHsk4jurtYehaH8sJMhNpvUe5bK1xlM=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix kernel NULL pointer dereference when" failed to apply to 6.9-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,hughd@google.com,muchun.song@linux.dev,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:36:51 +0200
Message-ID: <2024071550-nemeses-shamrock-962b@gregkh>
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
git cherry-pick -x f708f6970cc9d6bac71da45c129482092e710537
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071550-nemeses-shamrock-962b@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

f708f6970cc9 ("mm/hugetlb: fix kernel NULL pointer dereference when migrating hugetlb folio")
f6a8dd98a2ce ("hugetlb: convert alloc_buddy_hugetlb_folio to use a folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f708f6970cc9d6bac71da45c129482092e710537 Mon Sep 17 00:00:00 2001
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
index fe44324d6383..43e1af868cfd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2162,6 +2162,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		nid = numa_mem_id();
 retry:
 	folio = __folio_alloc(gfp_mask, order, nid, nmask);
+	/* Ensure hugetlb folio won't have large_rmappable flag set. */
+	if (folio)
+		folio_clear_large_rmappable(folio);
 
 	if (folio && !folio_ref_freeze(folio, 1)) {
 		folio_put(folio);


