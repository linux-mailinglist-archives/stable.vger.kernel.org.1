Return-Path: <stable+bounces-172445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD90B31C79
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5426FBA14C9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4B30F533;
	Fri, 22 Aug 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JvgN5/Ak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E4302747
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874043; cv=none; b=uKHkrC0VoEGGGnon73kVlHOhOOI9i/WF7FPChZJfvr6W7p54TnKSCHJ+r2+3cfyRojzj+Dt8v/zZv2amLcShnWyEFuXuvoPaaQO0tp33rAEfrf/8iOv+22BKZXTLZfG6AFGTaqDzDMMI5AAmKygctaE2qRtdp/VVtzhjPrci3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874043; c=relaxed/simple;
	bh=2Fgci5ewSqkv1nA7mBN33IKGPOhYRQt41kcMj0ij4FU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i7rgEO494FQasdhDlnUsGGBaruDqGhOcW70AnJDYDBX6L/abL0Eit1TU3/342texPomOkjwJuzXyY+6IYxzbH55rLNgPT4+PMys76FvS1EUnrZHDlEAwgPaECgdA1TyRG391bgaPU+syGvutYbqxoI0BzUTF5sG8bFcMXbnklWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvgN5/Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201DCC113CF;
	Fri, 22 Aug 2025 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755874041;
	bh=2Fgci5ewSqkv1nA7mBN33IKGPOhYRQt41kcMj0ij4FU=;
	h=Subject:To:Cc:From:Date:From;
	b=JvgN5/AkO2R+Q6XNeynjvYvLti4eU0hEZEr5y0glHAhf3E0tRCryQaKi50G72vuXt
	 XHVrdCfKN8dvJK7WlDqfezN8E7myaJ7Za+VrojUYt730pk8ZVj/ijTqD8BC+2RbmvV
	 UojuZ5zcmo0EDcVRAWGPQRuIaOwvYTTDs8uaXnH4=
Subject: FAILED: patch "[PATCH] mm/mremap: fix WARN with uffd that has remap events disabled" failed to apply to 6.12-stable tree
To: david@redhat.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,harry.yoo@oracle.com,jannh@google.com,lorenzo.stoakes@oracle.com,pfalcato@suse.de,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 16:47:18 +0200
Message-ID: <2025082218-untidy-blaspheme-a9c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 772e5b4a5e8360743645b9a466842d16092c4f94
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082218-untidy-blaspheme-a9c3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 772e5b4a5e8360743645b9a466842d16092c4f94 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Aug 2025 19:53:58 +0200
Subject: [PATCH] mm/mremap: fix WARN with uffd that has remap events disabled

Registering userfaultd on a VMA that spans at least one PMD and then
mremap()'ing that VMA can trigger a WARN when recovering from a failed
page table move due to a page table allocation error.

The code ends up doing the right thing (recurse, avoiding moving actual
page tables), but triggering that WARN is unpleasant:

WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_normal_pmd mm/mremap.c:357 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_pgt_entry mm/mremap.c:595 [inline]
WARNING: CPU: 2 PID: 6133 at mm/mremap.c:357 move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Modules linked in:
CPU: 2 UID: 0 PID: 6133 Comm: syz.0.19 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:move_normal_pmd mm/mremap.c:357 [inline]
RIP: 0010:move_pgt_entry mm/mremap.c:595 [inline]
RIP: 0010:move_page_tables+0x3832/0x44a0 mm/mremap.c:852
Code: ...
RSP: 0018:ffffc900037a76d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000032930007 RCX: ffffffff820c6645
RDX: ffff88802e56a440 RSI: ffffffff820c7201 RDI: 0000000000000007
RBP: ffff888037728fc0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000032930007 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900037a79a8 R14: 0000000000000001 R15: dffffc0000000000
FS:  000055556316a500(0000) GS:ffff8880d68bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30863fff CR3: 0000000050171000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 copy_vma_and_data+0x468/0x790 mm/mremap.c:1215
 move_vma+0x548/0x1780 mm/mremap.c:1282
 mremap_to+0x1b7/0x450 mm/mremap.c:1406
 do_mremap+0xfad/0x1f80 mm/mremap.c:1921
 __do_sys_mremap+0x119/0x170 mm/mremap.c:1977
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f00d0b8ebe9
Code: ...
RSP: 002b:00007ffe5ea5ee98 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007f00d0db5fa0 RCX: 00007f00d0b8ebe9
RDX: 0000000000400000 RSI: 0000000000c00000 RDI: 0000200000000000
RBP: 00007ffe5ea5eef0 R08: 0000200000c00000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f00d0db5fa0 R14: 00007f00d0db5fa0 R15: 0000000000000005
 </TASK>

The underlying issue is that we recurse during the original page table
move, but not during the recovery move.

Fix it by checking for both VMAs and performing the check before the
pmd_none() sanity check.

Add a new helper where we perform+document that check for the PMD and PUD
level.

Thanks to Harry for bisecting.

Link: https://lkml.kernel.org/r/20250818175358.1184757-1-david@redhat.com
Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/689bb893.050a0220.7f033.013a.GAE@google.com
Tested-by: Harry Yoo <harry.yoo@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mremap.c b/mm/mremap.c
index 33b642076205..e618a706aff5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -323,6 +323,25 @@ static inline bool arch_supports_page_table_move(void)
 }
 #endif
 
+static inline bool uffd_supports_page_table_move(struct pagetable_move_control *pmc)
+{
+	/*
+	 * If we are moving a VMA that has uffd-wp registered but with
+	 * remap events disabled (new VMA will not be registered with uffd), we
+	 * need to ensure that the uffd-wp state is cleared from all pgtables.
+	 * This means recursing into lower page tables in move_page_tables().
+	 *
+	 * We might get called with VMAs reversed when recovering from a
+	 * failed page table move. In that case, the
+	 * "old"-but-actually-"originally new" VMA during recovery will not have
+	 * a uffd context. Recursing into lower page tables during the original
+	 * move but not during the recovery move will cause trouble, because we
+	 * run into already-existing page tables. So check both VMAs.
+	 */
+	return !vma_has_uffd_without_event_remap(pmc->old) &&
+	       !vma_has_uffd_without_event_remap(pmc->new);
+}
+
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct pagetable_move_control *pmc,
 			pmd_t *old_pmd, pmd_t *new_pmd)
@@ -335,6 +354,8 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
 	/*
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -361,15 +382,6 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
 		return false;
 
-	/* If this pmd belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
@@ -418,6 +430,8 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 
 	if (!arch_supports_page_table_move())
 		return false;
+	if (!uffd_supports_page_table_move(pmc))
+		return false;
 	/*
 	 * The destination pud shouldn't be established, free_pgtables()
 	 * should have released it.
@@ -425,15 +439,6 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	if (WARN_ON_ONCE(!pud_none(*new_pud)))
 		return false;
 
-	/* If this pud belongs to a uffd vma with remap events disabled, we need
-	 * to ensure that the uffd-wp state is cleared from all pgtables. This
-	 * means recursing into lower page tables in move_page_tables(), and we
-	 * can reuse the existing code if we simply treat the entry as "not
-	 * moved".
-	 */
-	if (vma_has_uffd_without_event_remap(vma))
-		return false;
-
 	/*
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.


