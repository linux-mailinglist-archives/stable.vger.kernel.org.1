Return-Path: <stable+bounces-87601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9017A9A7069
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEA6B21A3E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A71E8852;
	Mon, 21 Oct 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOLpYKB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wAZ44351";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Atl5suZa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/cOIq6Vo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C81C330C;
	Mon, 21 Oct 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530125; cv=none; b=BtrZQ56JK1y9mhah0OGtpT2eczzvOly+7B3fd6fPL2BXr/8ZMlujgYZ0ZFDGdtf6O/+bnntA9gEdV6CbWYDpQh9KfoidhfxACESXuRd8lGnxmQw3J+3CYzema+Sf78O5OvJL34BtVEOb1oROPrWx7WBEDux5j3IfkO6LvumqCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530125; c=relaxed/simple;
	bh=LmQHHW5tL5kXv9ztrix65krYMX/7RlAD1pznEU+ev5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCI/IbVojv2al1a2sombN1GZBr6ViChLhF5nah8Idw6wzhKJGvFhKa7rpv+3zCsBzn384WfSlIWRVupRERRSIthTnqC9bG9IbCp7RtuR8GKL4/ZGl9reO/glp9tAkcbn4wiOsQQ24sK60JKJsXwZe9WNCMfI2hlR0NcriInxEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOLpYKB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wAZ44351; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Atl5suZa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/cOIq6Vo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8F6621E12;
	Mon, 21 Oct 2024 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729530120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qL2sV5Z0b98yyR74FjF91iCz2oU3cOo70bbq4klnkv0=;
	b=YOLpYKB5YEAMHgRyUWfxpeUevxafa8UiF4Th4gq2ZTupJhQHrH3Xcfr7htCom8KR+1W/cp
	EeuOTYz7UBYXKhfBILjP/GrCbowPqYOk8h/3lovDdgEzh9W94He1r4s0nJJqtuq7vnyDsV
	kUKj+sY+Bqn9TZXtlhn2C7bnITVaNo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729530120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qL2sV5Z0b98yyR74FjF91iCz2oU3cOo70bbq4klnkv0=;
	b=wAZ44351vMGSEmE2U07Cb518FW+rzJMr6zIPYy+FOao+Fo/xKrTsq8s5yl0VCqaKo44LyU
	9FijTYLsBtcOjYBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729530119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qL2sV5Z0b98yyR74FjF91iCz2oU3cOo70bbq4klnkv0=;
	b=Atl5suZaNI1j4r/15BO2SdfH9HMNiN0wgHVse+fWnWooWWu2SynpEKL/JvWXfcPeJTXf48
	ZyL8wp5x+G0Ig6dvOvqhcqiUbpVwGCoq88qrYFyYhcaMG6L8qv9YE/93b3sPLOyX12OLrG
	dWhouJ/VWtu0PpWfG8CwWZYt9GGCZBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729530119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qL2sV5Z0b98yyR74FjF91iCz2oU3cOo70bbq4klnkv0=;
	b=/cOIq6VoDGH+5cndAEFEyvpD5et/auwiU870j3sCinC9gI3WzRvZAypTriJwjmSyBJ2/fM
	tkpTQyU+iNur/LBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943D1136DC;
	Mon, 21 Oct 2024 17:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j4m8IweJFmdeCQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 17:01:59 +0000
Message-ID: <c5cd0ad5-9d9d-4df3-ab20-c5de2a380894@suse.cz>
Date: Mon, 21 Oct 2024 19:01:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>
References: <20241021164837.2681358-1-roman.gushchin@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241021164837.2681358-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,syzkaller.appspot.com:url]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/21/24 18:48, Roman Gushchin wrote:
> Syzbot reported [1] a bad page state problem caused by a page
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
> The problem was originally introduced by
> commit b109b87050df ("mm/munlock: replace clear_page_mlock() by final
> clearance"): it was handling focused on handling pagecache
> and anonymous memory and wasn't suitable for lower level
> get_page()/free_page() API's used for example by KVM, as with
> this reproducer.

Does that mean KVM is mlocking pages that are not pagecache nor anonymous,
thus not LRU? How and why (and since when) is that done?

> Fix it by moving the mlocked flag clearance down to
> free_page_prepare().
> 
> The bug itself if fairly old and harmless (aside from generating these
> warnings), so the stable backport is likely not justified.

But since there's a Cc: stable below, it will be backported :)

> Closes: https://syzkaller.appspot.com/x/report.txt?x=169a47d0580000
> Fixes: b109b87050df ("mm/munlock: replace clear_page_mlock() by final clearance")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: <stable@vger.kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/page_alloc.c |  9 +++++++++
>  mm/swap.c       | 14 --------------
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bc55d39eb372..24200651ad92 100644
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
> @@ -1053,6 +1054,14 @@ __always_inline bool free_pages_prepare(struct page *page,
>  	if (memcg_kmem_online() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);
>  
> +	if (unlikely(folio_test_mlocked(folio))) {
> +		long nr_pages = folio_nr_pages(folio);
> +
> +		__folio_clear_mlocked(folio);
> +		zone_stat_mod_folio(folio, NR_MLOCK, -nr_pages);
> +		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
> +	}

Why drop the useful comment?

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


