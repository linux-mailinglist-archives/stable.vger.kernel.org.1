Return-Path: <stable+bounces-87630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D599A901C
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C16B220A4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C81C9EB9;
	Mon, 21 Oct 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u38O1dgU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CD1C9B82
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540185; cv=none; b=Ouy5Ri6WAHUu2RcDWIRZzNSD7mD5cGPoEd5zE3VPm3Ta/QBht8C9fRmY5JWDYTZtNS6ohaTMy9Gz8qoKrgtvTO1vI4qarWPQwNhihCSRuA+lKj5HEWstPRB3S/dPb3I8Ldt6h/cb1QsLkEhiRjW8QEnltW2FJQATPTcult13alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540185; c=relaxed/simple;
	bh=HTep6Ps/b0VqQuVOG52oSj2XTrXoOn40CM7dR4EIEOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MKa/J0s+JJ/MOtHJNayT00jzdPUoyiPCw9u45/f2hHgJu7VQHqDP8H1E9TZK30mAS6S/GRW75ePSmyQAhrzsXweKl7Oo35+6nlThYdcPaDHn6TG0b+t8LuxvaJnAyhTQHbBZyXD4AZHuKJPf/gQd1GrcvLpT2wEfkVfsqdNUPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u38O1dgU; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2574292a12.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729540182; x=1730144982; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIAEhXnz+TycYsOXq4fwUScpNqUcxMY2FROsK0V63/0=;
        b=u38O1dgUi9XNpaywyCUwduuXJ9Nc4q2RPX1D/Yq5Vb3OTTT/z4A+25TEsVWxq7QNf4
         X7JF6sW6MT+lqBO5h0xTtzXB2WNGuQe3+C+Qutew8+KCulr+0MZzNRBn9Wuz4ota5ztz
         vYPk0nw1oeO2fsGegij3qpgdNhBr33WPZGttJlNc/RTlv48iYYee0ocFZv38ten/6iLG
         yLRzV5Q4PnZ0v2zP2O8ZlSQR/JaLcKkStZIKEGxntXzqr8+dfqQOlAeTJD1R9W40khZH
         cF7ML29gfA8UVY19YwYJzKUxfhhVPfmq+h4rpjMFE8jdPm6PmgkjFYhXeCr2dyvMJiAf
         HH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540182; x=1730144982;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TIAEhXnz+TycYsOXq4fwUScpNqUcxMY2FROsK0V63/0=;
        b=iGvfkHW1TqTtULZ76yrrsdGk8SEDj/dfs14vRlBD79F9PQN8ONZXxGvNihw0qrQrmF
         8YyDr0H3J8vQVYF+UboS8NwTio9vIsPX/DTvSfJXAVPtctUrw7PZTYaQELUVa7LxUvmR
         29/jslQ7XSjGgkBP1uTLpqikgXrXiJTPD3l2QeWMGmVtK+lTILKZ+xT+gyTN0gJzFnf/
         WBf4i1Drl2zwtVmiR/6vYFc0b8IJ15QRcyhLfqFnnggtZZm9KCcI5x34VKZLgSFLtkOY
         VUkqhTcnLBb9Sqd6eADEFokzrg592M5lR12SF9g0+Zh6Sh/68+QtdCnH0Cp3Qxz2hcmf
         9T3A==
X-Forwarded-Encrypted: i=1; AJvYcCXXBBfWKr900DJQVQa9MCVtE1hCmU6rl8CcdyHAX6CiHOh8v3tsIW0mf4C3mU555SehcnIsgOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ejZYPdyYIKKUpRkXaNxvL/5kza8k4VJSBRE0U+EheZDWRL1D
	vYsYBZgUOBaHgJRW5gCVdh/5zqV4hSzw1ErboKfzNvW+o+p4uhb+yJiuG0A7rA==
X-Google-Smtp-Source: AGHT+IE7LBFDuXD464oDX7R+3pKFv6gB/pDONRd/qrGrJhWZX+JT1kChQtcaO3T6c0R4R1FchyglYw==
X-Received: by 2002:a05:6a21:a24b:b0:1d9:275b:4f06 with SMTP id adf61e73a8af0-1d96debc9a1mr86139637.19.1729540181812;
        Mon, 21 Oct 2024 12:49:41 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407f63sm3277862b3a.204.2024.10.21.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:49:40 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:49:28 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
In-Reply-To: <20241021173455.2691973-1-roman.gushchin@linux.dev>
Message-ID: <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Roman Gushchin wrote:

> Syzbot reported a bad page state problem caused by a page
> being freed using free_page() still having a mlocked flag at
> free_pages_prepare() stage:
> 
>   BUG: Bad page state in process syz.0.15  pfn:1137bb
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881137bb870 pfn:0x1137bb
>   flags: 0x400000000080000(mlocked|node=0|zone=1)
>   raw: 0400000000080000 0000000000000000 dead000000000122 0000000000000000
>   raw: ffff8881137bb870 0000000000000000 00000000ffffffff 0000000000000000
>   page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>   page_owner tracks the page as allocated
>   page last allocated via order 0, migratetype Unmovable, gfp_mask
>   0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 3005, tgid
>   3004 (syz.0.15), ts 61546  608067, free_ts 61390082085
>    set_page_owner include/linux/page_owner.h:32 [inline]
>    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>    prep_new_page mm/page_alloc.c:1545 [inline]
>    get_page_from_freelist+0x3008/0x31f0 mm/page_alloc.c:3457
>    __alloc_pages_noprof+0x292/0x7b0 mm/page_alloc.c:4733
>    alloc_pages_mpol_noprof+0x3e8/0x630 mm/mempolicy.c:2265
>    kvm_coalesced_mmio_init+0x1f/0xf0 virt/kvm/coalesced_mmio.c:99
>    kvm_create_vm virt/kvm/kvm_main.c:1235 [inline]
>    kvm_dev_ioctl_create_vm virt/kvm/kvm_main.c:5500 [inline]
>    kvm_dev_ioctl+0x13bb/0x2320 virt/kvm/kvm_main.c:5542
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:907 [inline]
>    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0x69/0x110 arch/x86/entry/common.c:83
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   page last free pid 951 tgid 951 stack trace:
>    reset_page_owner include/linux/page_owner.h:25 [inline]
>    free_pages_prepare mm/page_alloc.c:1108 [inline]
>    free_unref_page+0xcb1/0xf00 mm/page_alloc.c:2638
>    vfree+0x181/0x2e0 mm/vmalloc.c:3361
>    delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3282
>    process_one_work kernel/workqueue.c:3229 [inline]
>    process_scheduled_works+0xa5c/0x17a0 kernel/workqueue.c:3310
>    worker_thread+0xa2b/0xf70 kernel/workqueue.c:3391
>    kthread+0x2df/0x370 kernel/kthread.c:389
>    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> A reproducer is available here:
> https://syzkaller.appspot.com/x/repro.c?x=1437939f980000
> 
> The problem was originally introduced by
> commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
> clearance"): it was handling focused on handling pagecache
> and anonymous memory and wasn't suitable for lower level
> get_page()/free_page() API's used for example by KVM, as with
> this reproducer.
> 
> Fix it by moving the mlocked flag clearance down to
> free_page_prepare().
> 
> The bug itself if fairly old and harmless (aside from generating these
> warnings).
> 
> Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000
> Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: <stable@vger.kernel.org>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks Roman - I'd been preparing a similar patch, so agree that this is
the right fix.  I don't think there's any need to change your text, but
let me remind us that any "Bad page" report stops that page from being
allocated again (because it's in an undefined, potentially dangerous
state): so does amount to a small memory leak even if otherwise harmless.

> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/page_alloc.c | 15 +++++++++++++++
>  mm/swap.c       | 14 --------------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bc55d39eb372..7535d78862ab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1044,6 +1044,7 @@ __always_inline bool free_pages_prepare(struct page *page,
>  	bool skip_kasan_poison = should_skip_kasan_poison(page);
>  	bool init = want_init_on_free();
>  	bool compound = PageCompound(page);
> +	struct folio *folio = page_folio(page);
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> @@ -1053,6 +1054,20 @@ __always_inline bool free_pages_prepare(struct page *page,
>  	if (memcg_kmem_online() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);
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
>  		/* Do not let hwpoison pages hit pcplists/buddy */
>  		reset_page_owner(page, order);
> diff --git a/mm/swap.c b/mm/swap.c
> index 835bdf324b76..7cd0f4719423 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -78,20 +78,6 @@ static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
>  		lruvec_del_folio(*lruvecp, folio);
>  		__folio_clear_lru_flags(folio);
>  	}
> -
> -	/*
> -	 * In rare cases, when truncation or holepunching raced with
> -	 * munlock after VM_LOCKED was cleared, Mlocked may still be
> -	 * found set here.  This does not indicate a problem, unless
> -	 * "unevictable_pgs_cleared" appears worryingly large.
> -	 */
> -	if (unlikely(folio_test_mlocked(folio))) {
> -		long nr_pages = folio_nr_pages(folio);
> -
> -		__folio_clear_mlocked(folio);
> -		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> -		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
> -	}
>  }
>  
>  /*
> -- 
> 2.47.0.105.g07ac214952-goog
> 
> 

