Return-Path: <stable+bounces-41668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05BD8B56CF
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89501C2179A
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC146452;
	Mon, 29 Apr 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NgP40Vub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B34501B
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390456; cv=none; b=bC0AOFxrlHQdggaMIX4jhXIReJyWhYbY6m0ksjmDAqksXjybn1FcB+hgIqU9QEnCdqsYmCP/S6aQ+2NLZW3YsFUnSzN1e9TTp9It7Z/N3GJDmKGnZrkKpeyZHPhpC8Bco0mivb8q2Tuhrl4s0KRkM61T7Eo8lbrAsPhdChNVwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390456; c=relaxed/simple;
	bh=4hEPd8P5kRnbYbFJ5Oh1Djn8VTLmb49g1RgFccS6h9Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FQLuezX4sD6DKLjRopk34+vA+6cIHhQTwFezbDYwK165riFduhdBOlM5oaHkZUNTg2uo5Mm6lISWpJ41jwHQX0PbiF6qRqcE3wZbIOHVZahvy7EHR31bVAEjb/RsxUbWD6GwltFLUD00f4T+6bRNQiVC7Dw7lXm/UoHcpC5RU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NgP40Vub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683B3C113CD;
	Mon, 29 Apr 2024 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390455;
	bh=4hEPd8P5kRnbYbFJ5Oh1Djn8VTLmb49g1RgFccS6h9Q=;
	h=Subject:To:Cc:From:Date:From;
	b=NgP40Vub7Q8tG1u7RC69UNT0+CY6RnGH454bhxaASJrv9eSCkKryiwO6iInUjl/sj
	 nxigTkvsYMyXTz+5lsMZ5edqpN29/bPbUKXxRsFrezafFzJ6nvy1EWMaJIsOELj6pK
	 c4i3vmmXtX+XS5BcLwuqgQBRQLOUrnKJenb2pFfg=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when" failed to apply to 6.1-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:34:13 +0200
Message-ID: <2024042912-visibly-carpool-70bd@gregkh>
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
git cherry-pick -x 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042912-visibly-carpool-70bd@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

52ccdde16b65 ("mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()")
32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
d6ef19e25df2 ("mm/hugetlb: convert update_and_free_page() to folios")
cfd5082b5147 ("mm/hugetlb: convert remove_hugetlb_page() to folios")
1a7cdab59b22 ("mm/hugetlb: convert dissolve_free_huge_page() to folios")
911565b82853 ("mm/hugetlb: convert destroy_compound_gigantic_page() to folios")
cb67f4282bf9 ("mm,thp,rmap: simplify compound page mapcount handling")
dad6a5eb5556 ("mm,hugetlb: use folio fields in second tail page")
0356c4b96f68 ("mm/hugetlb: convert free_huge_page to folios")
de656ed376c4 ("mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios")
f074732d599e ("mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios")
a098c977722c ("mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios")
4781593d5dba ("mm/hugetlb: unify clearing of RestoreReserve for private pages")
149562f75094 ("mm/hugetlb: add hugetlb_folio_subpool() helpers")
d340625f4849 ("mm: add private field of first tail to struct page and struct folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Fri, 19 Apr 2024 16:58:19 +0800
Subject: [PATCH] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()

When I did memory failure tests recently, below warning occurs:

DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 8 PID: 1011 at kernel/locking/lockdep.c:232 __lock_acquire+0xccb/0x1ca0
Modules linked in: mce_inject hwpoison_inject
CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire+0xccb/0x1ca0
RSP: 0018:ffffa7a1c7fe3bd0 EFLAGS: 00000082
RAX: 0000000000000000 RBX: eb851eb853975fcf RCX: ffffa1ce5fc1c9c8
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffffa1ce5fc1c9c0
RBP: ffffa1c6865d3280 R08: ffffffffb0f570a8 R09: 0000000000009ffb
R10: 0000000000000286 R11: ffffffffb0f2ad50 R12: ffffa1c6865d3d10
R13: ffffa1c6865d3c70 R14: 0000000000000000 R15: 0000000000000004
FS:  00007ff9f32aa740(0000) GS:ffffa1ce5fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff9f3134ba0 CR3: 00000008484e4000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 lock_acquire+0xbe/0x2d0
 _raw_spin_lock_irqsave+0x3a/0x60
 hugepage_subpool_put_pages.part.0+0xe/0xc0
 free_huge_folio+0x253/0x3f0
 dissolve_free_huge_page+0x147/0x210
 __page_handle_poison+0x9/0x70
 memory_failure+0x4e6/0x8c0
 hard_offline_page_store+0x55/0xa0
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xbc/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9f3114887
RSP: 002b:00007ffecbacb458 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007ff9f3114887
RDX: 000000000000000c RSI: 0000564494164e10 RDI: 0000000000000001
RBP: 0000564494164e10 R08: 00007ff9f31d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007ff9f321b780 R14: 00007ff9f3217600 R15: 00007ff9f3216a00
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 8 PID: 1011 Comm: bash Kdump: loaded Not tainted 6.9.0-rc3-next-20240410-00012-gdb69f219f4be #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 panic+0x326/0x350
 check_panic_on_warn+0x4f/0x50
 __warn+0x98/0x190
 report_bug+0x18e/0x1a0
 handle_bug+0x3d/0x70
 exc_invalid_op+0x18/0x70
 asm_exc_invalid_op+0x1a/0x20
RIP: 0010:__lock_acquire+0xccb/0x1ca0
RSP: 0018:ffffa7a1c7fe3bd0 EFLAGS: 00000082
RAX: 0000000000000000 RBX: eb851eb853975fcf RCX: ffffa1ce5fc1c9c8
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffffa1ce5fc1c9c0
RBP: ffffa1c6865d3280 R08: ffffffffb0f570a8 R09: 0000000000009ffb
R10: 0000000000000286 R11: ffffffffb0f2ad50 R12: ffffa1c6865d3d10
R13: ffffa1c6865d3c70 R14: 0000000000000000 R15: 0000000000000004
 lock_acquire+0xbe/0x2d0
 _raw_spin_lock_irqsave+0x3a/0x60
 hugepage_subpool_put_pages.part.0+0xe/0xc0
 free_huge_folio+0x253/0x3f0
 dissolve_free_huge_page+0x147/0x210
 __page_handle_poison+0x9/0x70
 memory_failure+0x4e6/0x8c0
 hard_offline_page_store+0x55/0xa0
 kernfs_fop_write_iter+0x12c/0x1d0
 vfs_write+0x380/0x540
 ksys_write+0x64/0xe0
 do_syscall_64+0xbc/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff9f3114887
RSP: 002b:00007ffecbacb458 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007ff9f3114887
RDX: 000000000000000c RSI: 0000564494164e10 RDI: 0000000000000001
RBP: 0000564494164e10 R08: 00007ff9f31d1460 R09: 000000007fffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 00007ff9f321b780 R14: 00007ff9f3217600 R15: 00007ff9f3216a00
 </TASK>

After git bisecting and digging into the code, I believe the root cause is
that _deferred_list field of folio is unioned with _hugetlb_subpool field.
In __update_and_free_hugetlb_folio(), folio->_deferred_list is
initialized leading to corrupted folio->_hugetlb_subpool when folio is
hugetlb.  Later free_huge_folio() will use _hugetlb_subpool and above
warning happens.

But it is assumed hugetlb flag must have been cleared when calling
folio_put() in update_and_free_hugetlb_folio().  This assumption is broken
due to below race:

CPU1					CPU2
dissolve_free_huge_page			update_and_free_pages_bulk
 update_and_free_hugetlb_folio		 hugetlb_vmemmap_restore_folios
					  folio_clear_hugetlb_vmemmap_optimized
  clear_flag = folio_test_hugetlb_vmemmap_optimized
  if (clear_flag) <-- False, it's already cleared.
   __folio_clear_hugetlb(folio) <-- Hugetlb is not cleared.
  folio_put
   free_huge_folio <-- free_the_page is expected.
					 list_for_each_entry()
					  __folio_clear_hugetlb <-- Too late.

Fix this issue by checking whether folio is hugetlb directly instead of
checking clear_flag to close the race window.

Link: https://lkml.kernel.org/r/20240419085819.1901645-1-linmiaohe@huawei.com
Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 05371bf54f96..ce7be5c24442 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1781,7 +1781,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
 	 */
-	if (clear_dtor) {
+	if (folio_test_hugetlb(folio)) {
 		spin_lock_irq(&hugetlb_lock);
 		__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);


