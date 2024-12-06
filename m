Return-Path: <stable+bounces-99994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC39E7B99
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C28285BC3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453B222C6C1;
	Fri,  6 Dec 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8eXyada"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECA22C6C0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523713; cv=none; b=EN7rjgITvQ/BrErdgaYj3nQ15thymvT9E0FjRugDBUFIiazcZ5gKe/vXsH48FtnMSNz/nsQrrd19b2TYbemjjnSWQhT1y0EWZe62IaqxqZJOBaT3DODMa4hHuEgQwdbP7Y/PtOc/eL29Hblo6sKut16j3ButqyLejBfdmngsrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523713; c=relaxed/simple;
	bh=mMXN8UY+5jag5K48Lybbtf+3vHwqL3Yqi8ZSLsthOM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I1ZUFBV+dqJVVk4cPbVNKHJaFbVk4Qsg+pPCfblLaz3k78FcmBBu2M3iQhmmFOvg6G8h5oIsQWyYoJdnW/49BvA/CoEBrClrmUXdd96L6Y2rkMY3jOId5yVmcL9DZj6VnWnXejZwJM6fYt7xhW4oVYzDRcYGpfOduS28bNSlD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8eXyada; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215348d1977so21685955ad.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 14:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733523710; x=1734128510; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+kpL6smuteWwQLLIWBSUleVhMRe9MwdnP1rS1Hbs0c=;
        b=j8eXyadadniqcpScRxfR0bA9tGG1VYaB8rXJ41AmR+3VjFqn6NFcHygyGL2fXBIYuU
         lcWTq8hcDHp/OICTL7Kzd8XLRJz1l5aRDsYDRCG3W9LsUzMvyFhCc8HYEE7sBO0oF0BO
         6c3RjSuRm4O71GYsn3+rs0F5j3SCpshd6+sKC2xHswgjfNc7b3oo655/P+7Rog/8lyRd
         IZ1I5b4WqABCMUOZMGEZvtzzeVi2LbUnFMBO5Wpm80XNzJigR5LAvWAVwZw8KalIKa7E
         fJnjShNu9C99Ol/dh/Bokbr2gZPgkwXkUcS3mOHRC7KcN3ZnOzgpmfvFWo4p5iyIW3e9
         beug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733523710; x=1734128510;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+kpL6smuteWwQLLIWBSUleVhMRe9MwdnP1rS1Hbs0c=;
        b=Eiv6Me3LKTzou8DV5XpxVYLnXJn63gsm/cjcvzgiAjrklucNWTYsSFGsXu6V+cXf9Z
         PP65EOahz2l2BEH9V9LoKhoI8StPBgpSAPnJWgbTmRdKq+u0yQIz7tMhu15gjJ4Egeib
         nSLQqqxynYMqP/oXrtxkGaZm5QtDpNB+ezEep+eQKNXjXMxrX354CX2mj/+ExwcKlAPV
         1sfu+/2KKRDKIsk9fFeP4XG16c7oBCz57RFdb2HGR2iLm8mcT5bDT8prACj3+TDaF5ls
         hkyJH+TLofNSLnmjp4QsS42I57qbtx1oWHY0UP7pctPFgA88+HQgEGu9G+TTSPngetgs
         yr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPzxLayX7JrGgMif4m52VKJ3F6frTDH1u350n8YgMTfLzgPYw4iRVGb3eUPBCCieUULdSO2nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uw6XvPWy1PP5ehQqOZrrt6Qjo+1TEV6ftBRbqtaJmGfpvY+e
	M+Z9Yx0x9qf4CM9Ecrxo5Z9BoW7F0rbmkIkggJHGKg3nlHJoUN41rlOgC2vkQj1aSqw/ROgaTXQ
	Lig==
X-Gm-Gg: ASbGnctO64UME4/jaPXa+eIHV9jtH/EWzGxW+TxqVcUrMczzrN1oh7OJok2RWML3NgB
	DdT3LKYpurqJeaGdzlsqFtP+rscqnpZfxcWKkj4TA5+aRCTa0wYs9hnBeMupLBgIlgJEc3/TjDE
	PAueMDI/9VF9i51kVNW2q3kW72hOXzzoKDLDzI9fjj9aRP9OE/oDQyiuI+IuvLzlbbqJfbRh7z5
	6bH/2Swo6x6wGbdDE1RFsZHPaKOpdyjbB+vRm0IaA3U+F2n1oPxM4lijG9E9xFudR7Xa5u7VYN0
	E9R2rGCHWoX/XDZwN1SVc/+38akHCdRZ6w==
X-Google-Smtp-Source: AGHT+IFvWQPTzIxqXtDKMwb7TH3lqHGthAZz1/GR+nIx/vhNSvbOcbuGM5aUnToGuiFJnxhds+OBYg==
X-Received: by 2002:a17:902:f78b:b0:216:1543:1962 with SMTP id d9443c01a7336-21615431b14mr74986395ad.23.1733523710368;
        Fri, 06 Dec 2024 14:21:50 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca691fsm3517010b3a.148.2024.12.06.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 14:21:49 -0800 (PST)
Date: Fri, 6 Dec 2024 14:21:38 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: roman.gushchin@linux.dev, akpm@linux-foundation.org, seanjc@google.com, 
    stable@vger.kernel.org, vbabka@suse.cz, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] mm: page_alloc: move mlocked flag clearance
 into" failed to apply to 6.6-stable tree
In-Reply-To: <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
Message-ID: <97594aca-8bfe-78d6-fa86-688af7610c83@google.com>
References: <2024111714-varsity-grub-d888@gregkh> <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Nov 2024, Hugh Dickins wrote:
> On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 66edc3a5894c74f8887c8af23b97593a0dd0df4d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111714-varsity-grub-d888@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> For 6.6 and 6.1 please use this replacement patch:

I notice that there's now a 6.6.64-rc1 out for review, but without
Roman's mlocked flag clearance patch.  No desperate need to get it into
an rc of 6.6.64, but we wouldn't want it to go missing indefinitely.

Thanks,
Hugh

> 
> From 9de12cbafdf2fae7d5bfdf14f4684ce3244469df Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Wed, 6 Nov 2024 19:53:54 +0000
> Subject: [PATCH] mm: page_alloc: move mlocked flag clearance into
>  free_pages_prepare()
> 
> commit 66edc3a5894c74f8887c8af23b97593a0dd0df4d upstream.
> 
> Syzbot reported a bad page state problem caused by a page being freed
> using free_page() still having a mlocked flag at free_pages_prepare()
> stage:
> 
>   BUG: Bad page state in process syz.5.504  pfn:61f45
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61f45
>   flags: 0xfff00000080204(referenced|workingset|mlocked|node=0|zone=1|lastcpupid=0x7ff)
>   raw: 00fff00000080204 0000000000000000 dead000000000122 0000000000000000
>   raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>   page_owner tracks the page as allocated
>   page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 8443, tgid 8442 (syz.5.504), ts 201884660643, free_ts 201499827394
>    set_page_owner include/linux/page_owner.h:32 [inline]
>    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>    prep_new_page mm/page_alloc.c:1545 [inline]
>    get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
>    __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
>    alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>    kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
>    kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
>    kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5488 [inline]
>    kvm_dev_ioctl+0x12dc/0x2240 virt/kvm/kvm_main.c:5530
>    __do_compat_sys_ioctl fs/ioctl.c:1007 [inline]
>    __se_compat_sys_ioctl+0x510/0xc90 fs/ioctl.c:950
>    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>    __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
>    do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
>    entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>   page last free pid 8399 tgid 8399 stack trace:
>    reset_page_owner include/linux/page_owner.h:25 [inline]
>    free_pages_prepare mm/page_alloc.c:1108 [inline]
>    free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
>    folios_put_refs+0x76c/0x860 mm/swap.c:1007
>    free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
>    __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
>    tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
>    tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
>    tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
>    tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
>    exit_mmap+0x496/0xc40 mm/mmap.c:1926
>    __mmput+0x115/0x390 kernel/fork.c:1348
>    exit_mm+0x220/0x310 kernel/exit.c:571
>    do_exit+0x9b2/0x28e0 kernel/exit.c:926
>    do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>    __do_sys_exit_group kernel/exit.c:1099 [inline]
>    __se_sys_exit_group kernel/exit.c:1097 [inline]
>    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>    x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 8442 Comm: syz.5.504 Not tainted 6.12.0-rc6-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>   Call Trace:
>    <TASK>
>    __dump_stack lib/dump_stack.c:94 [inline]
>    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>    bad_page+0x176/0x1d0 mm/page_alloc.c:501
>    free_page_is_bad mm/page_alloc.c:918 [inline]
>    free_pages_prepare mm/page_alloc.c:1100 [inline]
>    free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
>    kvm_destroy_vm virt/kvm/kvm_main.c:1327 [inline]
>    kvm_put_kvm+0xc75/0x1350 virt/kvm/kvm_main.c:1386
>    kvm_vcpu_release+0x54/0x60 virt/kvm/kvm_main.c:4143
>    __fput+0x23f/0x880 fs/file_table.c:431
>    task_work_run+0x24f/0x310 kernel/task_work.c:239
>    exit_task_work include/linux/task_work.h:43 [inline]
>    do_exit+0xa2f/0x28e0 kernel/exit.c:939
>    do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>    __do_sys_exit_group kernel/exit.c:1099 [inline]
>    __se_sys_exit_group kernel/exit.c:1097 [inline]
>    __ia32_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
>    ia32_sys_call+0x2624/0x2630 arch/x86/include/generated/asm/syscalls_32.h:253
>    do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>    __do_fast_syscall_32+0xb4/0x110 arch/x86/entry/common.c:386
>    do_fast_syscall_32+0x34/0x80 arch/x86/entry/common.c:411
>    entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>   RIP: 0023:0xf745d579
>   Code: Unable to access opcode bytes at 0xf745d54f.
>   RSP: 002b:00000000f75afd6c EFLAGS: 00000206 ORIG_RAX: 00000000000000fc
>   RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 00000000ffffff9c RDI: 00000000f744cff4
>   RBP: 00000000f717ae61 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>   R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>    </TASK>
> 
> The problem was originally introduced by commit b109b87050df ("mm/munlock:
> replace clear_page_mlock() by final clearance"): it was focused on
> handling pagecache and anonymous memory and wasn't suitable for lower
> level get_page()/free_page() API's used for example by KVM, as with this
> reproducer.
> 
> Fix it by moving the mlocked flag clearance down to free_page_prepare().
> 
> The bug itself if fairly old and harmless (aside from generating these
> warnings), aside from a small memory leak - "bad" pages are stopped from
> being allocated again.
> 
> Link: https://lkml.kernel.org/r/20241106195354.270757-1-roman.gushchin@linux.dev
> Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reported-by: syzbot+e985d3026c4fd041578e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6729f475.050a0220.701a.0019.GAE@google.com
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/page_alloc.c | 15 +++++++++++++++
>  mm/swap.c       | 20 --------------------
>  2 files changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7272a922b838..3d7e685bdd0b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1082,12 +1082,27 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	int bad = 0;
>  	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
>  	bool init = want_init_on_free();
> +	struct folio *folio = page_folio(page);
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
>  	trace_mm_page_free(page, order);
>  	kmsan_free_page(page, order);
>  
> +	/*
> +	 * In rare cases, when truncation or holepunching raced with
> +	 * munlock after VM_LOCKED was cleared, Mlocked may still be
> +	 * found set here.  This does not indicate a problem, unless
> +	 * "unevictable_pgs_cleared" appears worryingly large.
> +	 */
> +	if (unlikely(folio_test_mlocked(folio))) {
> +		long nr_pages = folio_nr_pages(folio);
> +
> +		__folio_clear_mlocked(folio);
> +		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> +		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
> +	}
> +
>  	if (unlikely(PageHWPoison(page)) && !order) {
>  		/*
>  		 * Do not let hwpoison pages hit pcplists/buddy
> diff --git a/mm/swap.c b/mm/swap.c
> index cd8f0150ba3a..42082eba42de 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -89,14 +89,6 @@ static void __page_cache_release(struct folio *folio)
>  		__folio_clear_lru_flags(folio);
>  		unlock_page_lruvec_irqrestore(lruvec, flags);
>  	}
> -	/* See comment on folio_test_mlocked in release_pages() */
> -	if (unlikely(folio_test_mlocked(folio))) {
> -		long nr_pages = folio_nr_pages(folio);
> -
> -		__folio_clear_mlocked(folio);
> -		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> -		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
> -	}
>  }
>  
>  static void __folio_put_small(struct folio *folio)
> @@ -1021,18 +1013,6 @@ void release_pages(release_pages_arg arg, int nr)
>  			__folio_clear_lru_flags(folio);
>  		}
>  
> -		/*
> -		 * In rare cases, when truncation or holepunching raced with
> -		 * munlock after VM_LOCKED was cleared, Mlocked may still be
> -		 * found set here.  This does not indicate a problem, unless
> -		 * "unevictable_pgs_cleared" appears worryingly large.
> -		 */
> -		if (unlikely(folio_test_mlocked(folio))) {
> -			__folio_clear_mlocked(folio);
> -			zone_stat_sub_folio(folio, NR_MLOCK);
> -			count_vm_event(UNEVICTABLE_PGCLEARED);
> -		}
> -
>  		list_add(&folio->lru, &pages_to_free);
>  	}
>  	if (lruvec)
> -- 
> 2.47.0.338.g60cca15819-goog
> 

