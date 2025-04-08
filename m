Return-Path: <stable+bounces-128923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA9A7FC05
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F07AC0D2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B50269D06;
	Tue,  8 Apr 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ln93y4Dl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A4269B1E;
	Tue,  8 Apr 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107938; cv=none; b=rWJPox/XIBgUPMJvHdg0vukY1hoBPBGiT8J7ENlVv3+I4kiFPzsi3eRKELTpJ4FxD1HeveSBiI5xbkkrralMNCZgIiKLcuUl5TdNj2saJm38Hvmjo9TVhFjZVjwjsl9I03Y3VrLgQ/j2t/N7b7dG1FfQS57TwXq08P8/T2h9NUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107938; c=relaxed/simple;
	bh=WNd3UrZJsicmtANKvaFvVu56kyEgn9856WU+rYWqJn8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZwbJrbmjTFAXwWsykek2gKgLz/r9FTbwNvYY7w5jvZW99p4Cx0WecAMP6r5Cg1H4NU436RZiqm4Kh2GnDrVF+TIpEYD30OjOBJU4BIUKn1TxDjfu2EaevpFMFfC/87wTYZLQtbs7Qha3HpNkrOxLEzTXpba1yv9bOvq5wB//hiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ln93y4Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E61C4CEE8;
	Tue,  8 Apr 2025 10:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744107938;
	bh=WNd3UrZJsicmtANKvaFvVu56kyEgn9856WU+rYWqJn8=;
	h=Subject:To:Cc:From:Date:From;
	b=Ln93y4Dlak4j5+tKVRsmqF4y6qtrOfCfklHBG/JJaoRWskacX1dIonn4jzecWuevN
	 BgYcOxvrjQfQwzTwsarggFXT305oSJ/IDeR2z/tPb7cmnIwBZHpJi+ZnuVsrEFok8I
	 ecGhfeLG0ennldHnN/5GMv6mCrqxH5QYhYkoijoE=
Subject: FAILED: patch "[PATCH] mm/vmscan: don't try to reclaim hwpoison folio" failed to apply to 6.14-stable tree
To: tujinjiang@huawei.com, akpm@linux-foundation.org,
	david@redhat.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	stable@vger.smtp.subspace.kernel.org, kernel.org@web.codeaurora.org,
	sunnanyong@huawei.com, wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:23:21 +0200
Message-ID: <2025040821-frostlike-grandly-ca1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0449544c6482179ac84530b61fc192a6527bfd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040821-frostlike-grandly-ca1b@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b0449544c6482179ac84530b61fc192a6527bfd Mon Sep 17 00:00:00 2001
From: Jinjiang Tu <tujinjiang@huawei.com>
Date: Tue, 18 Mar 2025 16:39:39 +0800
Subject: [PATCH] mm/vmscan: don't try to reclaim hwpoison folio

Syzkaller reports a bug as follows:

Injecting memory failure for pfn 0x18b00e at process virtual address 0x20ffd000
Memory failure: 0x18b00e: dirty swapcache page still referenced by 2 users
Memory failure: 0x18b00e: recovery action for dirty swapcache page: Failed
page: refcount:2 mapcount:0 mapping:0000000000000000 index:0x20ffd pfn:0x18b00e
memcg:ffff0000dd6d9000
anon flags: 0x5ffffe00482011(locked|dirty|arch_1|swapbacked|hwpoison|node=0|zone=2|lastcpupid=0xfffff)
raw: 005ffffe00482011 dead000000000100 dead000000000122 ffff0000e232a7c9
raw: 0000000000020ffd 0000000000000000 00000002ffffffff ffff0000dd6d9000
page dumped because: VM_BUG_ON_FOLIO(!folio_test_uptodate(folio))
------------[ cut here ]------------
kernel BUG at mm/swap_state.c:184!
Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
Modules linked in:
CPU: 0 PID: 60 Comm: kswapd0 Not tainted 6.6.0-gcb097e7de84e #3
Hardware name: linux,dummy-virt (DT)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_to_swap+0xbc/0x158
lr : add_to_swap+0xbc/0x158
sp : ffff800087f37340
x29: ffff800087f37340 x28: fffffc00052c0380 x27: ffff800087f37780
x26: ffff800087f37490 x25: ffff800087f37c78 x24: ffff800087f377a0
x23: ffff800087f37c50 x22: 0000000000000000 x21: fffffc00052c03b4
x20: 0000000000000000 x19: fffffc00052c0380 x18: 0000000000000000
x17: 296f696c6f662865 x16: 7461646f7470755f x15: 747365745f6f696c
x14: 6f6621284f494c4f x13: 0000000000000001 x12: ffff600036d8b97b
x11: 1fffe00036d8b97a x10: ffff600036d8b97a x9 : dfff800000000000
x8 : 00009fffc9274686 x7 : ffff0001b6c5cbd3 x6 : 0000000000000001
x5 : ffff0000c25896c0 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff0000c25896c0 x0 : 0000000000000000
Call trace:
 add_to_swap+0xbc/0x158
 shrink_folio_list+0x12ac/0x2648
 shrink_inactive_list+0x318/0x948
 shrink_lruvec+0x450/0x720
 shrink_node_memcgs+0x280/0x4a8
 shrink_node+0x128/0x978
 balance_pgdat+0x4f0/0xb20
 kswapd+0x228/0x438
 kthread+0x214/0x230
 ret_from_fork+0x10/0x20

I can reproduce this issue with the following steps:

1) When a dirty swapcache page is isolated by reclaim process and the
   page isn't locked, inject memory failure for the page.
   me_swapcache_dirty() clears uptodate flag and tries to delete from lru,
   but fails.  Reclaim process will put the hwpoisoned page back to lru.

2) The process that maps the hwpoisoned page exits, the page is deleted
   the page will never be freed and will be in the lru forever.

3) If we trigger a reclaim again and tries to reclaim the page,
   add_to_swap() will trigger VM_BUG_ON_FOLIO due to the uptodate flag is
   cleared.

To fix it, skip the hwpoisoned page in shrink_folio_list().  Besides, the
hwpoison folio may not be unmapped by hwpoison_user_mappings() yet, unmap
it in shrink_folio_list(), otherwise the folio will fail to be unmaped by
hwpoison_user_mappings() since the folio isn't in lru list.

Link: https://lkml.kernel.org/r/20250318083939.987651-3-tujinjiang@huawei.com
Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Nanyong Sun <sunnanyong@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: <stable@vger,kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 98e6ac82e428..2b2ab386cab5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1127,6 +1127,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (!folio_trylock(folio))
 			goto keep;
 
+		if (folio_contain_hwpoisoned_page(folio)) {
+			unmap_poisoned_folio(folio, folio_pfn(folio), false);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
 		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
 
 		nr_pages = folio_nr_pages(folio);


