Return-Path: <stable+bounces-93828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C829D18E3
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75319B2207A
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B361E1301;
	Mon, 18 Nov 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HC9BvHFQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3731AA1FF
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958135; cv=none; b=bNeSGRk5EpdjUqpO9RJzUgNrS3rTL73FsPMLRmSUOUbvtFjHvmRcM1K98Yzu1kuOvFaHbKYITBwdXf6crsboBLvAeZJwmFznujccbJ4t6irtlgwMmmnsSw3rcpJOaz6GpzzHhBvWH/kHub8fox0gXO8Twsbt3FlkbxC4XzeIHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958135; c=relaxed/simple;
	bh=hippO2WRcgBrEgO3iuQQgjW0bcDVg/Oi22/RsGrlV5w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pxPejgQZGc5xnLlAOjaVxhszaPxUBCwjG0r4ff5tvcx7n/HrufT2xy3WV/QtRA/0FiJicSLB2u//3iruVtCIjV+2zs/0m6562Ey0TnjT2+cPRB3d/5cyQNQOTANfdBpDPas2jKill3/opLgFbCFcSPe19d3sIIj7J8N8QfsXTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HC9BvHFQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c805a0753so800735ad.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958132; x=1732562932; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7t4m5Z37YOfTxskiXTWmspFh27xW8LKY9pzYa5vEjts=;
        b=HC9BvHFQYqJo71tiwOI1kSH07ZCpLNaBv2odP+0HI1mAzoEH8Roqujy1oouEiln1/5
         +h+OGdW48TQAB74nh65i0TvHZHrn/mhgB9O+b5Jt3wj+w+/eqaWdBF10KIITOE7jRKVi
         lC6xrjlDTImcod/63RTx81s7yfdbA/qaYfuap3c2vVixXm97pdsD0irIFNjrxTxyyEMh
         Dxj/a5xDiQjN8Vc8QhHFaEfHSgtKQAuOLDiezpuiC6TK8DW33JKCU88jviv7h8ITWF67
         YeLEIe9wqwloE63++gA8zrMl97ojjh6KsJyQOsspcA44DkaDbZ7cEpN1rz1+UbJjvF6A
         T1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958132; x=1732562932;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t4m5Z37YOfTxskiXTWmspFh27xW8LKY9pzYa5vEjts=;
        b=Hdzr4G0gZmKgY/ITH3+zNrn86iH5es+TiPUNS5jyWvpz4hbI/rtRP23MpC94NGfANk
         W5D6YJjSpt2BJR5N7YPvpT6PXXUJX9aBW6fqyXBejgFjveEqXxyW4LvAV7HCLFY02ixS
         M0/U4N7K3McdFvHPQ8b4ZRcDZ9cPiQF1Fy0CE3s6HccyLeI4/21lGj34i6Y5N8MddyWC
         cuOBHL/8Br6yx/x5jAd6rEIEDaHikeDDvUr3jQ10UTeny/ltONyGuxNbpnVUwSgjg8go
         apKOpdb4+66SAWz3zzGxcvUBYgtHYG3H3uwLABYiIl2xF8WF491sI+Gg/mV3JwzURhPb
         cYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFJfZtM91267Ie+2ijRNmc613U+GPXgOlx3/v2gQfiK3Wgx6io8qTKNcrmTdnx+lKXV08qe5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNorIXN5UBPrbu5FFSh3xIMxMcsLhf9WXlGqX5YW/dokotMDlZ
	qQ3btLLgman3c29u16WSo91M5rWB7GUQ6bSnn9GybbjrOwhwuSTFLiLm/tmTKw==
X-Google-Smtp-Source: AGHT+IFxkSi/K5kMLV+yEYMel+9OqiQso3dX3TsT/O/eTu1HwYUVmCqmc1lcsxgqATy6DZhjTBsYog==
X-Received: by 2002:a17:902:da92:b0:20e:590f:58af with SMTP id d9443c01a7336-211d0d62174mr208717105ad.1.1731958132357;
        Mon, 18 Nov 2024 11:28:52 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211fe7244b0sm38178875ad.198.2024.11.18.11.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 11:28:51 -0800 (PST)
Date: Mon, 18 Nov 2024 11:28:42 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: roman.gushchin@linux.dev, akpm@linux-foundation.org, hughd@google.com, 
    seanjc@google.com, stable@vger.kernel.org, vbabka@suse.cz, 
    willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] mm: page_alloc: move mlocked flag clearance
 into" failed to apply to 6.6-stable tree
In-Reply-To: <2024111714-varsity-grub-d888@gregkh>
Message-ID: <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
References: <2024111714-varsity-grub-d888@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 66edc3a5894c74f8887c8af23b97593a0dd0df4d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111714-varsity-grub-d888@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

For 6.6 and 6.1 please use this replacement patch:

From 9de12cbafdf2fae7d5bfdf14f4684ce3244469df Mon Sep 17 00:00:00 2001
From: Roman Gushchin <roman.gushchin@linux.dev>
Date: Wed, 6 Nov 2024 19:53:54 +0000
Subject: [PATCH] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()

commit 66edc3a5894c74f8887c8af23b97593a0dd0df4d upstream.

Syzbot reported a bad page state problem caused by a page being freed
using free_page() still having a mlocked flag at free_pages_prepare()
stage:

  BUG: Bad page state in process syz.5.504  pfn:61f45
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61f45
  flags: 0xfff00000080204(referenced|workingset|mlocked|node=0|zone=1|lastcpupid=0x7ff)
  raw: 00fff00000080204 0000000000000000 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
  page_owner tracks the page as allocated
  page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 8443, tgid 8442 (syz.5.504), ts 201884660643, free_ts 201499827394
   set_page_owner include/linux/page_owner.h:32 [inline]
   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
   prep_new_page mm/page_alloc.c:1545 [inline]
   get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
   kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
   kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
   kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5488 [inline]
   kvm_dev_ioctl+0x12dc/0x2240 virt/kvm/kvm_main.c:5530
   __do_compat_sys_ioctl fs/ioctl.c:1007 [inline]
   __se_compat_sys_ioctl+0x510/0xc90 fs/ioctl.c:950
   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
   __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
   do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
  page last free pid 8399 tgid 8399 stack trace:
   reset_page_owner include/linux/page_owner.h:25 [inline]
   free_pages_prepare mm/page_alloc.c:1108 [inline]
   free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
   folios_put_refs+0x76c/0x860 mm/swap.c:1007
   free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
   __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
   tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
   tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
   tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
   tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
   exit_mmap+0x496/0xc40 mm/mmap.c:1926
   __mmput+0x115/0x390 kernel/fork.c:1348
   exit_mm+0x220/0x310 kernel/exit.c:571
   do_exit+0x9b2/0x28e0 kernel/exit.c:926
   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
   __do_sys_exit_group kernel/exit.c:1099 [inline]
   __se_sys_exit_group kernel/exit.c:1097 [inline]
   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
   x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Modules linked in:
  CPU: 0 UID: 0 PID: 8442 Comm: syz.5.504 Not tainted 6.12.0-rc6-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
   bad_page+0x176/0x1d0 mm/page_alloc.c:501
   free_page_is_bad mm/page_alloc.c:918 [inline]
   free_pages_prepare mm/page_alloc.c:1100 [inline]
   free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
   kvm_destroy_vm virt/kvm/kvm_main.c:1327 [inline]
   kvm_put_kvm+0xc75/0x1350 virt/kvm/kvm_main.c:1386
   kvm_vcpu_release+0x54/0x60 virt/kvm/kvm_main.c:4143
   __fput+0x23f/0x880 fs/file_table.c:431
   task_work_run+0x24f/0x310 kernel/task_work.c:239
   exit_task_work include/linux/task_work.h:43 [inline]
   do_exit+0xa2f/0x28e0 kernel/exit.c:939
   do_group_exit+0x207/0x2c0 kernel/exit.c:1088
   __do_sys_exit_group kernel/exit.c:1099 [inline]
   __se_sys_exit_group kernel/exit.c:1097 [inline]
   __ia32_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
   ia32_sys_call+0x2624/0x2630 arch/x86/include/generated/asm/syscalls_32.h:253
   do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
   __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
   do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
   entry_SYSENTER_compat_after_hwframe+0x84/0x8e
  RIP: 0023:0xf745d579
  Code: Unable to access opcode bytes at 0xf745d54f.
  RSP: 002b:00000000f75afd6c EFLAGS: 00000206 ORIG_RAX: 00000000000000fc
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 00000000ffffff9c RDI: 00000000f744cff4
  RBP: 00000000f717ae61 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   </TASK>

The problem was originally introduced by commit b109b87050df ("mm/munlock:
replace clear_page_mlock() by final clearance"): it was focused on
handling pagecache and anonymous memory and wasn't suitable for lower
level get_page()/free_page() API's used for example by KVM, as with this
reproducer.

Fix it by moving the mlocked flag clearance down to free_page_prepare().

The bug itself if fairly old and harmless (aside from generating these
warnings), aside from a small memory leak - "bad" pages are stopped from
being allocated again.

Link: https://lkml.kernel.org/r/20241106195354.270757-1-roman.gushchin@linux.dev
Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Reported-by: syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6729f475.050a0220.701a.0019.GAE@google.com
Acked-by: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/page_alloc.c | 15 +++++++++++++++
 mm/swap.c       | 20 --------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7272a922b838..3d7e685bdd0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1082,12 +1082,27 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
 	bool init = want_init_on_free();
+	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
 
+	/*
+	 * In rare cases, when truncation or holepunching raced with
+	 * munlock after VM_LOCKED was cleared, Mlocked may still be
+	 * found set here.  This does not indicate a problem, unless
+	 * "unevictable_pgs_cleared" appears worryingly large.
+	 */
+	if (unlikely(folio_test_mlocked(folio))) {
+		long nr_pages = folio_nr_pages(folio);
+
+		__folio_clear_mlocked(folio);
+		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
+		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
+	}
+
 	if (unlikely(PageHWPoison(page)) && !order) {
 		/*
 		 * Do not let hwpoison pages hit pcplists/buddy
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..42082eba42de 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -89,14 +89,6 @@ static void __page_cache_release(struct folio *folio)
 		__folio_clear_lru_flags(folio);
 		unlock_page_lruvec_irqrestore(lruvec, flags);
 	}
-	/* See comment on folio_test_mlocked in release_pages() */
-	if (unlikely(folio_test_mlocked(folio))) {
-		long nr_pages = folio_nr_pages(folio);
-
-		__folio_clear_mlocked(folio);
-		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
-		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
-	}
 }
 
 static void __folio_put_small(struct folio *folio)
@@ -1021,18 +1013,6 @@ void release_pages(release_pages_arg arg, int nr)
 			__folio_clear_lru_flags(folio);
 		}
 
-		/*
-		 * In rare cases, when truncation or holepunching raced with
-		 * munlock after VM_LOCKED was cleared, Mlocked may still be
-		 * found set here.  This does not indicate a problem, unless
-		 * "unevictable_pgs_cleared" appears worryingly large.
-		 */
-		if (unlikely(folio_test_mlocked(folio))) {
-			__folio_clear_mlocked(folio);
-			zone_stat_sub_folio(folio, NR_MLOCK);
-			count_vm_event(UNEVICTABLE_PGCLEARED);
-		}
-
 		list_add(&folio->lru, &pages_to_free);
 	}
 	if (lruvec)
-- 
2.47.0.338.g60cca15819-goog

