Return-Path: <stable+bounces-23904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74437869170
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BE2B2909D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B213AA5C;
	Tue, 27 Feb 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="crz73isp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6813AA46
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039523; cv=none; b=jGUV5KjKLF3Fx8BgJoDLapiyQm+2t2x+z/bpR0+fqre8WuBzBWFTDT5Qtb2pExPnGzt+xp5MzeBI7lBkAtjhXYJb9DsStt2H84kiNppjLUGxj03X/pSrVGQ8RzzL+94vHRnwLE4cxNiwvWbyLoKZHYFl498KVyg1BEtBzuKvZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039523; c=relaxed/simple;
	bh=YWnf4fhMfu6a8335P5dL85a0eIqfM7qzzaSr1KbVaEw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K3DA6k7xrUnNrRjBCGD4SWkezlbomRuYngcqJSFDQQqyhC5sqkhNmV/Qa76bIGDVRqQg1e9xVDeiJhGFn7wVQhiLK7a8lf5qthF+P6OOiJj0gwD59cvblz0Xh1Eim5hIzA7pRq2180n9mzPyTrfQewNVDFtXFiJIOb2RiqR7TUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=crz73isp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6EEC433F1;
	Tue, 27 Feb 2024 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709039522;
	bh=YWnf4fhMfu6a8335P5dL85a0eIqfM7qzzaSr1KbVaEw=;
	h=Subject:To:Cc:From:Date:From;
	b=crz73ispfDZo0Vc1VRgmWB14HoeDRvwngaoNMs7xbqzppui3jS6cAxQD6p9afq9PD
	 w64HIw55Gw8i8veo90lixnnyxuBUvhtVbouah1f/TBGdsfM/uZS5KZWqpiR8DAvB2U
	 Y78ovLKrBvFyTVnoe1RIRCW9/KxIgSWMXUKmvejY=
Subject: FAILED: patch "[PATCH] memcg: fix use-after-free in uncharge_batch" failed to apply to 5.4-stable tree
To: mhocko@suse.com,akpm@linux-foundation.org,guro@fb.com,hannes@cmpxchg.org,hughd@google.com,shakeelb@google.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Feb 2024 14:12:00 +0100
Message-ID: <2024022759-crave-busily-bef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f1796544a0ca0f14386a679d3d05fbc69235015e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022759-crave-busily-bef7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f1796544a0ca ("memcg: fix use-after-free in uncharge_batch")
1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
8d22a9351035 ("mm/memcg: fix refcount error while moving and swapping")
d9eb1ea2bf87 ("mm: memcontrol: delete unused lrucare handling")
4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
f0e45fb4da29 ("mm: memcontrol: drop unused try/commit/cancel charge API")
9d82c69438d0 ("mm: memcontrol: convert anon and file-thp to new mem_cgroup_charge() API")
468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
be5d0a74c62d ("mm: memcontrol: switch to native NR_ANON_MAPPED counter")
0d1c20722ab3 ("mm: memcontrol: switch to native NR_FILE_PAGES and NR_SHMEM counters")
49e50d277ba2 ("mm: memcontrol: prepare move_account for removal of private page type counters")
9f762dbe19b9 ("mm: memcontrol: prepare uncharging for removal of private page type counters")
3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
6caa6a0703e0 ("mm: memcontrol: move out cgroup swaprate throttling")
14235ab36019 ("mm: shmem: remove rare optimization when swapin races with hole punching")
3fba69a56e16 ("mm: memcontrol: drop @compound parameter from memcg charging API")
abb242f57196 ("mm: memcontrol: fix stat-corrupting race in charge moving")
f4129ea3591a ("mm: fix NUMA node file count error in replace_page_cache()")
ffe945e633b5 ("khugepaged: do not stop collapse if less than half PTEs are referenced")
396bcc5299c2 ("mm: remove CONFIG_TRANSPARENT_HUGE_PAGECACHE")
85b9f46e8ea4 ("mm, thp: track fallbacks due to failed memcg charges separately")
dcdf11ee1441 ("mm, shmem: add vmstat for hugepage fallback")
9c315e4d7d8c ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()")
92d0510c3585 ("mm: kmem: switch to nr_pages in (__)memcg_kmem_charge_memcg()")
f4b00eab5004 ("mm: kmem: rename memcg_kmem_(un)charge() into memcg_kmem_(un)charge_page()")
50591183fa86 ("mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments")
10eaec2f63b6 ("mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments")
47e29d32afba ("mm/gup: page->hpage_pinned_refcount: exact pin counts for huge pages")
3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
3b78d8347d31 ("mm/gup: pass gup flags to two more routines")
c23a0c99793f ("mm/migrate: clean up some minor coding style")
92855270ff08 ("mm/memcontrol.c: cleanup some useless code")
f1f6a7dd9b53 ("mm, tree-wide: rename put_user_page*() to unpin_user_page*()")
aa4b87fe9ea3 ("powerpc: book3s64: convert to pin_user_pages() and put_user_page()")
19fed0dae94d ("vfio, mm: pin_user_pages (FOLL_PIN) and put_user_page() conversion")
1f815afcfca7 ("media/v4l2-core: pin_user_pages (FOLL_PIN) and put_user_page() conversion")
803e4572d7c5 ("mm/process_vm_access: set FOLL_PIN via pin_user_pages_remote()")
57459435cff5 ("goldish_pipe: convert to pin_user_pages() and put_user_page()")
eddb1c228f79 ("mm/gup: introduce pin_user_pages*() and FOLL_PIN")
3c7470b6f684 ("media/v4l2-core: set pages dirty upon releasing DMA buffers")
f4000fdf435b ("mm/gup: allow FOLL_FORCE for get_user_pages_fast()")
3567813eae5e ("vfio: fix FOLL_LONGTERM use, simplify get_user_pages_remote() call")
c4237f8b1f4f ("mm: fix get_user_pages_remote()'s handling of FOLL_LONGTERM")
a707cdd55f0f ("mm/gup: move try_get_compound_head() to top, fix minor issues")
a43e982082c2 ("mm/gup: factor out duplicate code from four routines")
fac0516b5534 ("mm: thp: don't need care deferred split queue in memcg charge move path")
f1fe80d4ae33 ("mm, thp: do not queue fully unmapped pages for deferred split")
acbfb087e3b1 ("mm/hugetlb: avoid looping to the same hugepage if !pages and !vmas")
867e5e1de14b ("mm: clean up and clarify lruvec lookup procedure")
242c37b459ce ("include/linux/memcontrol.h: fix comments based on per-node memcg")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1796544a0ca0f14386a679d3d05fbc69235015e Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Fri, 4 Sep 2020 16:35:24 -0700
Subject: [PATCH] memcg: fix use-after-free in uncharge_batch

syzbot has reported an use-after-free in the uncharge_batch path

  BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
  BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
  BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
  BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
  BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
  Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304

  CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
    __dump_stack lib/dump_stack.c:77 [inline]
    dump_stack+0x1f0/0x31e lib/dump_stack.c:118
    print_address_description+0x66/0x620 mm/kasan/report.c:383
    __kasan_report mm/kasan/report.c:513 [inline]
    kasan_report+0x132/0x1d0 mm/kasan/report.c:530
    check_memory_region_inline mm/kasan/generic.c:183 [inline]
    check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
    instrument_atomic_write include/linux/instrumented.h:71 [inline]
    atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
    atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
    page_counter_cancel mm/page_counter.c:54 [inline]
    page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
    uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
    uncharge_page+0x115/0x430 mm/memcontrol.c:6796
    uncharge_list mm/memcontrol.c:6835 [inline]
    mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
    release_pages+0x13a2/0x1550 mm/swap.c:911
    tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
    tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
    tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
    tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
    exit_mmap+0x296/0x550 mm/mmap.c:3185
    __mmput+0x113/0x370 kernel/fork.c:1076
    exit_mm+0x4cd/0x550 kernel/exit.c:483
    do_exit+0x576/0x1f20 kernel/exit.c:793
    do_group_exit+0x161/0x2d0 kernel/exit.c:903
    get_signal+0x139b/0x1d30 kernel/signal.c:2743
    arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
    exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
    exit_to_user_mode_prepare+0x8d/0x1b0 kernel/entry/common.c:166
    syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:241
    entry_SYSCALL_64_after_hwframe+0x44/0xa9

Commit 1a3e1f40962c ("mm: memcontrol: decouple reference counting from
page accounting") reworked the memcg lifetime to be bound the the struct
page rather than charges.  It also removed the css_put_many from
uncharge_batch and that is causing the above splat.

uncharge_batch() is supposed to uncharge accumulated charges for all
pages freed from the same memcg.  The queuing is done by uncharge_page
which however drops the memcg reference after it adds charges to the
batch.  If the current page happens to be the last one holding the
reference for its memcg then the memcg is OK to go and the next page to
be freed will trigger batched uncharge which needs to access the memcg
which is gone already.

Fix the issue by taking a reference for the memcg in the current batch.

Fixes: 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
Reported-by: syzbot+b5ea6fb6f139c8b9482b@syzkaller.appspotmail.com
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Hugh Dickins <hughd@google.com>
Link: https://lkml.kernel.org/r/20200820090341.GC5033@dhcp22.suse.cz
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..cfa6cbad21d5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6774,6 +6774,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
+
+	/* drop reference from uncharge_page */
+	css_put(&ug->memcg->css);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
@@ -6797,6 +6800,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = page->mem_cgroup;
+
+		/* pairs with css_put in uncharge_batch */
+		css_get(&ug->memcg->css);
 	}
 
 	nr_pages = compound_nr(page);


