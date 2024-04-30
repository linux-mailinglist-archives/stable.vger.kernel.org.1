Return-Path: <stable+bounces-41806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CFA8B6C09
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 09:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1A1F226B7
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2C3B295;
	Tue, 30 Apr 2024 07:44:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3E3AC34
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463081; cv=none; b=HrwYQLWVSsDbxqsbjYArAugK/918sbWOQPLpuKttiEuMEHNVle6Mmu8FHKNn+rg7FgiB1w9vgdxOje3yRduN24yzckoFghvKI4eACUsqxtDJ+qNpU/xEDWlLxFLWzcplnkZ7vsw9UVqZHsTRha0HfwhHJYi/pDsV+/sAeRpD8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463081; c=relaxed/simple;
	bh=7zyhbhlFFQle4hiXAk6I3SjBmLwfQGS7LONUPl3vuUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/Efsi5tnmNcJtbr0OjhhVUad0RdD8+BX0Rt5g5WilNZr6I0imsEAfnL+dpMZN+trEdbGPR+VnCM38g6TrR91dYZtupSGtUDxmBi1A3slUAYVayWTaiNlC83T4SFkPj7+pkMdaNxFqfeoLOHQybtvWbr0mUoJZelEDFxKpC7lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VTByK6wt5zcZxY;
	Tue, 30 Apr 2024 15:43:21 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FB05140416;
	Tue, 30 Apr 2024 15:44:29 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 15:44:28 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()
Date: Tue, 30 Apr 2024 15:41:46 +0800
Message-ID: <20240430074146.2489498-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024042912-visibly-carpool-70bd@gregkh>
References: <2024042912-visibly-carpool-70bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

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
(cherry picked from commit 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 37288a7f0fa6..8573da127939 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1796,7 +1796,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb destructor under the hugetlb lock.
 	 */
-	if (clear_dtor) {
+	if (folio_test_hugetlb(folio)) {
 		spin_lock_irq(&hugetlb_lock);
 		__clear_hugetlb_destructor(h, page);
 		spin_unlock_irq(&hugetlb_lock);
-- 
2.33.0


