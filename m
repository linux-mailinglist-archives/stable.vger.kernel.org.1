Return-Path: <stable+bounces-53917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D4690EBD9
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9731F24CC3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C950B14EC4C;
	Wed, 19 Jun 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtM5nfeT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AD14EC42;
	Wed, 19 Jun 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802054; cv=none; b=gdGXlr0sDwxsBegGThezE64ZTYAfrEq1XMX5+zS/8mu/oFe/uofaj++1WCa6mhN8KZDsMrodrhSyizVr9+6Sc9td3Y6X5SN+Qh2pJZzFt9yCeoQMFKgiwnW0rUNobs8VMrJOLbUqz/OQFsoQ43UBXTtF8c05XMYOmvfsEGxx81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802054; c=relaxed/simple;
	bh=ZgLsBEIl9P8nDG2i6cHqRz5cRWhdc4jRAcsZj5+wdow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caYGb7LlnHJaNURBUQego9e0LOyGQxoeIQw2n6Q8ZF1LsOeBNxz64uYX+qbBqJRCvZkdARItspB8S/jjw1zF60ckDxDHYfy3NjOjNgKin55PBzicKD/djAu5T259hLDb68asTgwvfiiLEt9uG64zlFo6K42itI7CtPrPJnnsE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtM5nfeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039ACC4AF49;
	Wed, 19 Jun 2024 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802054;
	bh=ZgLsBEIl9P8nDG2i6cHqRz5cRWhdc4jRAcsZj5+wdow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtM5nfeT0nhClDQ1JxX756spnUrieYZ70Iq676g6l833Q/Lu89XApuvlygptrZ23t
	 jtvKw1fsKET1NkSQK3YFr9UACuJRAJjhg9aIZhJgGIj9Rs49f6EF4xEEd7obfhY7dz
	 38smW71kJ4cIcL4ZT2DfJFbSIiUyiWpZo6FsH2rY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 067/267] mm/memory-failure: fix handling of dissolved but not taken off from buddy pages
Date: Wed, 19 Jun 2024 14:53:38 +0200
Message-ID: <20240619125608.928397377@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 8cf360b9d6a840700e06864236a01a883b34bbad ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9c27ec0a27a30..c7e2b609184b6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1212,7 +1212,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		folio_put(folio);
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
2.43.0




