Return-Path: <stable+bounces-146352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F597AC3DFE
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 12:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA21118977DD
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46391F4CB1;
	Mon, 26 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlFXHTP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128C194A60
	for <stable@vger.kernel.org>; Mon, 26 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256294; cv=none; b=AKDZ4u80SZRUvRzxh9NakWT++1D92SrSazoC9fIBvYyBx348Nc00YaafT8Xkb3SUxtXN343hJBWFllWfkj0QpQpLD9MZLsSZOOs0tMsQ43LowL23sbQpExKYuLMlh8szVeOloUJvLeRKOUwLQzTEvcevY7FlmhgveiTuHJfe/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256294; c=relaxed/simple;
	bh=P3nxWtUPOffI+lM6/2y4QHosuhvbE/lV8bSjvNoa8iM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qShX4QdNrN3ISsEQTtNJc0K4YbherFbijEyjscPLLFY3MfgIBIYW8LPGeZq6kGgklhq5uTvAmE4yBmTc80TGIWPUy0Y2wxnoEusZ82B8gOY6xNUGs2ZVmnFltDUvz9eVmiQirv54yqGAsL8XqKk23Lp53i+vJvheWTorXPfLZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlFXHTP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B2DC4CEE7;
	Mon, 26 May 2025 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748256294;
	bh=P3nxWtUPOffI+lM6/2y4QHosuhvbE/lV8bSjvNoa8iM=;
	h=Subject:To:Cc:From:Date:From;
	b=TlFXHTP4kHMRySsachMKxis4nqf+P/MHyn6qp3/zmpckpfvFKZUIuwCxsG890+01H
	 nW8D3cQH/v3eXIIDDjDn66RgpT4nw45im3gozTaBR8O0q9oS6uLpnxm94BTeYIe0o4
	 mjCIu+x54ILuOqvuIFzdaoM7BC/lvliQVTjjggmo=
Subject: FAILED: patch "[PATCH] mm: fix copy_vma() error handling for hugetlb mappings" failed to apply to 6.12-stable tree
To: rcn@igalia.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,jannh@google.com,lorenzo.stoakes@oracle.com,osalvador@suse.de,revest@google.com,stable@vger.kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 May 2025 12:44:49 +0200
Message-ID: <2025052649-cymbal-eggplant-f524@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ee40c9920ac286c5bfe7c811e66ff899266d2582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052649-cymbal-eggplant-f524@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee40c9920ac286c5bfe7c811e66ff899266d2582 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo=20Navarro?= <rcn@igalia.com>
Date: Fri, 23 May 2025 14:19:10 +0200
Subject: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If, during a mremap() operation for a hugetlb-backed memory mapping,
copy_vma() fails after the source vma has been duplicated and opened (ie.
vma_link() fails), the error is handled by closing the new vma.  This
updates the hugetlbfs reservation counter of the reservation map which at
this point is referenced by both the source vma and the new copy.  As a
result, once the new vma has been freed and copy_vma() returns, the
reservation counter for the source vma will be incorrect.

This patch addresses this corner case by clearing the hugetlb private page
reservation reference for the new vma and decrementing the reference
before closing the vma, so that vma_close() won't update the reservation
counter.  This is also what copy_vma_and_data() does with the source vma
if copy_vma() succeeds, so a helper function has been added to do the
fixup in both functions.

The issue was reported by a private syzbot instance and can be reproduced
using the C reproducer in [1].  It's also a possible duplicate of public
syzbot report [2].  The WARNING report is:

============================================================
page_counter underflow: -1024 nr_pages=1024
WARNING: CPU: 0 PID: 3287 at mm/page_counter.c:61 page_counter_cancel+0xf6/0x120
Modules linked in:
CPU: 0 UID: 0 PID: 3287 Comm: repro__WARNING_ Not tainted 6.15.0-rc7+ #54 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
RIP: 0010:page_counter_cancel+0xf6/0x120
Code: ff 5b 41 5e 41 5f 5d c3 cc cc cc cc e8 f3 4f 8f ff c6 05 64 01 27 06 01 48 c7 c7 60 15 f8 85 48 89 de 4c 89 fa e8 2a a7 51 ff <0f> 0b e9 66 ff ff ff 44 89 f9 80 e1 07 38 c1 7c 9d 4c 81
RSP: 0018:ffffc900025df6a0 EFLAGS: 00010246
RAX: 2edfc409ebb44e00 RBX: fffffffffffffc00 RCX: ffff8880155f0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81c4a23c R09: 1ffff1100330482a
R10: dffffc0000000000 R11: ffffed100330482b R12: 0000000000000000
R13: ffff888058a882c0 R14: ffff888058a882c0 R15: 0000000000000400
FS:  0000000000000000(0000) GS:ffff88808fc53000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b33e0 CR3: 00000000076d6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 page_counter_uncharge+0x33/0x80
 hugetlb_cgroup_uncharge_counter+0xcb/0x120
 hugetlb_vm_op_close+0x579/0x960
 ? __pfx_hugetlb_vm_op_close+0x10/0x10
 remove_vma+0x88/0x130
 exit_mmap+0x71e/0xe00
 ? __pfx_exit_mmap+0x10/0x10
 ? __mutex_unlock_slowpath+0x22e/0x7f0
 ? __pfx_exit_aio+0x10/0x10
 ? __up_read+0x256/0x690
 ? uprobe_clear_state+0x274/0x290
 ? mm_update_next_owner+0xa9/0x810
 __mmput+0xc9/0x370
 exit_mm+0x203/0x2f0
 ? __pfx_exit_mm+0x10/0x10
 ? taskstats_exit+0x32b/0xa60
 do_exit+0x921/0x2740
 ? do_raw_spin_lock+0x155/0x3b0
 ? __pfx_do_exit+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? _raw_spin_lock_irq+0xc5/0x100
 do_group_exit+0x20c/0x2c0
 get_signal+0x168c/0x1720
 ? __pfx_get_signal+0x10/0x10
 ? schedule+0x165/0x360
 arch_do_signal_or_restart+0x8e/0x7d0
 ? __pfx_arch_do_signal_or_restart+0x10/0x10
 ? __pfx___se_sys_futex+0x10/0x10
 syscall_exit_to_user_mode+0xb8/0x2c0
 do_syscall_64+0x75/0x120
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x422dcd
Code: Unable to access opcode bytes at 0x422da3.
RSP: 002b:00007ff266cdb208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007ff266cdbcdc RCX: 0000000000422dcd
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000004c7bec
RBP: 00007ff266cdb220 R08: 203a6362696c6720 R09: 203a6362696c6720
R10: 0000200000c00000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000002 R14: 00007ffe1cb5f520 R15: 00007ff266cbb000
 </TASK>
============================================================

Link: https://lkml.kernel.org/r/20250523-warning_in_page_counter_cancel-v2-1-b6df1a8cfefd@igalia.com
Link: https://people.igalia.com/rcn/kernel_logs/20250422__WARNING_in_page_counter_cancel__repro.c [1]
Link: https://lore.kernel.org/all/67000a50.050a0220.49194.048d.GAE@google.com/ [2]
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Florent Revest <revest@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8f3ac832ee7f..4861a7e304bb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -275,6 +275,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
+void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -468,6 +469,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
+{
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 55e6796b24d0..6a3cf7935c14 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1250,7 +1250,7 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
 /*
  * Reset and decrement one ref on hugepage private reservation.
  * Called with mm->mmap_lock writer semaphore held.
- * This function should be only used by move_vma() and operate on
+ * This function should be only used by mremap and operate on
  * same sized vma. It should never come here with last ref on the
  * reservation.
  */
@@ -7939,3 +7939,17 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_unshare_pmds(vma, ALIGN(vma->vm_start, PUD_SIZE),
 			ALIGN_DOWN(vma->vm_end, PUD_SIZE));
 }
+
+/*
+ * For hugetlb, mremap() is an odd edge case - while the VMA copying is
+ * performed, we permit both the old and new VMAs to reference the same
+ * reservation.
+ *
+ * We fix this up after the operation succeeds, or if a newly allocated VMA
+ * is closed as a result of a failure to allocate memory.
+ */
+void fixup_hugetlb_reservations(struct vm_area_struct *vma)
+{
+	if (is_vm_hugetlb_page(vma))
+		clear_vma_resv_huge_pages(vma);
+}
diff --git a/mm/mremap.c b/mm/mremap.c
index 7db9da609c84..0d4948b720e2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1188,8 +1188,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
-	if (is_vm_hugetlb_page(vma))
-		clear_vma_resv_huge_pages(vma);
+	fixup_hugetlb_reservations(vma);
 
 	/* Tell pfnmap has moved from this vma */
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
diff --git a/mm/vma.c b/mm/vma.c
index 839d12f02c88..a468d4c29c0c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1834,6 +1834,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
+	fixup_hugetlb_reservations(new_vma);
 	vma_close(new_vma);
 
 	if (new_vma->vm_file)


