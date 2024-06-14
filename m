Return-Path: <stable+bounces-52161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8389086A2
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7569C1F22263
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BF186E36;
	Fri, 14 Jun 2024 08:43:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38C184126
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354625; cv=none; b=H8jW0PNLmUK9dPiR/yYg5kiAgRNMCrRjkY0XknMICtNvFKyFYMfbB1HoifuUsju6aMMO65U6Y309MV+HQwAwHYpBkTc6mEAsMO/axVx46dWcYVt6O3pszxi3DjO7+jltWGCzLVln7FeviTfIK4GqzSei9joFPbs9U3fA71n9pVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354625; c=relaxed/simple;
	bh=P+2A0WdablO5xEbBNvMcmD33uNoe4QQdG3jaleh/Tw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjv4fr+5BIQPDTXBGq5laZKp7Sy2xG2anEhOEwqNmUrR9xUqqfygyUivWxml4vZnNtqItpcLxX4lFak/keWsptRIQ4fFLpofssQZUYBCBefvZDdpZVWD/cQxgHh16DlF6R7XIeyPFAVUsg7aTjuX9/jdbMJ2UTtge/kx99mXalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W0t4b2R2Dz2CjxF;
	Fri, 14 Jun 2024 16:39:43 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E089140337;
	Fri, 14 Jun 2024 16:43:32 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 16:43:31 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/memory-failure: fix handling of dissolved but not taken off from buddy pages
Date: Fri, 14 Jun 2024 16:39:45 +0800
Message-ID: <20240614083945.3186910-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <2024061349-snowdrop-pusher-dcdb@gregkh>
References: <2024061349-snowdrop-pusher-dcdb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

When I did memory failure tests recently, below panic occurs:

page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8cee00
flags: 0x6fffe0000000000(node=1|zone=2|lastcpupid=0x7fff)
raw: 06fffe0000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000009 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(!PageBuddy(page))
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:1009!
invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
RIP: 0010:__del_page_from_free_list+0x151/0x180
RSP: 0018:ffffa49c90437998 EFLAGS: 00000046
RAX: 0000000000000035 RBX: 0000000000000009 RCX: ffff8dd8dfd1c9c8
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff8dd8dfd1c9c0
RBP: ffffd901233b8000 R08: ffffffffab5511f8 R09: 0000000000008c69
R10: 0000000000003c15 R11: ffffffffab5511f8 R12: ffff8dd8fffc0c80
R13: 0000000000000001 R14: ffff8dd8fffc0c80 R15: 0000000000000009
FS:  00007ff916304740(0000) GS:ffff8dd8dfd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eae50124c8 CR3: 00000008479e0000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __rmqueue_pcplist+0x23b/0x520
 get_page_from_freelist+0x26b/0xe40
 __alloc_pages_noprof+0x113/0x1120
 __folio_alloc_noprof+0x11/0xb0
 alloc_buddy_hugetlb_folio.isra.0+0x5a/0x130
 __alloc_fresh_hugetlb_folio+0xe7/0x140
 alloc_pool_huge_folio+0x68/0x100
 set_max_huge_pages+0x13d/0x340
 hugetlb_sysctl_handler_common+0xe8/0x110
 proc_sys_call_handler+0x194/0x280
 vfs_write+0x387/0x550
 ksys_write+0x64/0xe0
 do_syscall_64+0xc2/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff916114887
RSP: 002b:00007ffec8a2fd78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055eae500e350 RCX: 00007ff916114887
RDX: 0000000000000004 RSI: 000055eae500e390 RDI: 0000000000000003
RBP: 000055eae50104c0 R08: 0000000000000000 R09: 000055eae50104c0
R10: 0000000000000077 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000004 R14: 00007ff916216b80 R15: 00007ff916216a00
 </TASK>
Modules linked in: mce_inject hwpoison_inject
---[ end trace 0000000000000000 ]---

And before the panic, there had an warning about bad page state:

BUG: Bad page state in process page-types  pfn:8cee00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8cee00
flags: 0x6fffe0000000000(node=1|zone=2|lastcpupid=0x7fff)
page_type: 0xffffff7f(buddy)
raw: 06fffe0000000000 ffffd901241c0008 ffffd901240f8008 0000000000000000
raw: 0000000000000000 0000000000000009 00000000ffffff7f 0000000000000000
page dumped because: nonzero mapcount
Modules linked in: mce_inject hwpoison_inject
CPU: 8 PID: 154211 Comm: page-types Not tainted 6.9.0-rc4-00499-g5544ec3178e2-dirty #22
Call Trace:
 <TASK>
 dump_stack_lvl+0x83/0xa0
 bad_page+0x63/0xf0
 free_unref_page+0x36e/0x5c0
 unpoison_memory+0x50b/0x630
 simple_attr_write_xsigned.constprop.0.isra.0+0xb3/0x110
 debugfs_attr_write+0x42/0x60
 full_proxy_write+0x5b/0x80
 vfs_write+0xcd/0x550
 ksys_write+0x64/0xe0
 do_syscall_64+0xc2/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f189a514887
RSP: 002b:00007ffdcd899718 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f189a514887
RDX: 0000000000000009 RSI: 00007ffdcd899730 RDI: 0000000000000003
RBP: 00007ffdcd8997a0 R08: 0000000000000000 R09: 00007ffdcd8994b2
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdcda199a8
R13: 0000000000404af1 R14: 000000000040ad78 R15: 00007f189a7a5040
 </TASK>

The root cause should be the below race:

 memory_failure
  try_memory_failure_hugetlb
   me_huge_page
    __page_handle_poison
     dissolve_free_hugetlb_folio
     drain_all_pages -- Buddy page can be isolated e.g. for compaction.
     take_page_off_buddy -- Failed as page is not in the buddy list.
	     -- Page can be putback into buddy after compaction.
    page_ref_inc -- Leads to buddy page with refcnt = 1.

Then unpoison_memory() can unpoison the page and send the buddy page back
into buddy list again leading to the above bad page state warning.  And
bad_page() will call page_mapcount_reset() to remove PageBuddy from buddy
page leading to later VM_BUG_ON_PAGE(!PageBuddy(page)) when trying to
allocate this page.

Fix this issue by only treating __page_handle_poison() as successful when
it returns 1.

Link: https://lkml.kernel.org/r/20240523071217.1696196-1-linmiaohe@huawei.com
Fixes: ceaf8fbea79a ("mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 8cf360b9d6a840700e06864236a01a883b34bbad)
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5378edad9df8..6d7792991ed7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1212,7 +1212,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p) >= 0) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		} else {
@@ -2082,7 +2082,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		folio_unlock(folio);
-		if (__page_handle_poison(p) >= 0) {
+		if (__page_handle_poison(p) > 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
 		} else {
-- 
2.33.0


