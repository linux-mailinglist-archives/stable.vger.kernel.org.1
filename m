Return-Path: <stable+bounces-45566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705D8CC025
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 13:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722001C21CF9
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7482899;
	Wed, 22 May 2024 11:22:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877968289A;
	Wed, 22 May 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376962; cv=none; b=BowvoyVYBTD7O3T5Vkcbi14LvQVQ9uRkX+yF4VCR/prWT5MeSj56L1AyhkAG9vfA01mC2/TmllHnXxPR6anEK84oBpNrF5D6z7UvYWTI1CPq5/Om52nNi5/wax89vG/qceo1SFEDbSb+W9OaDipeKyIUCWQhukfr3G2RNukcshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376962; c=relaxed/simple;
	bh=F+eLMP7vomG4vgGnf2QTGMnK4y1oDm374YCutBXL7wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZStDywAVhFGYMF4ff7lXLFDjIOhRQEaYw9S3dUVJplgBPYajMu/K05U4HaCUDdrqPaf/MJ/enrA2wj44FJsPK7EwCUMvYmdfMCaBGHQqo7WJtfSFCzOyDKWHbPYDiLkt8ga7EC5V7RfDk1a1KClnFfBLOKOuTp7QRoK8213ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E86A61BF207;
	Wed, 22 May 2024 11:22:32 +0000 (UTC)
Message-ID: <fd2100a8-a17c-460c-a8e8-b5cede3d51c1@ghiti.fr>
Date: Wed, 22 May 2024 13:22:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: rewrite __kernel_map_pages() to fix sleeping
 in invalid context
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <cover.1715750938.git.namcao@linutronix.de>
 <1289ecba9606a19917bc12b6c27da8aa23e1e5ae.1715750938.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <1289ecba9606a19917bc12b6c27da8aa23e1e5ae.1715750938.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 15/05/2024 07:50, Nam Cao wrote:
> __kernel_map_pages() is a debug function which clears the valid bit in page
> table entry for deallocated pages to detect illegal memory accesses to
> freed pages.
>
> This function set/clear the valid bit using __set_memory(). __set_memory()
> acquires init_mm's semaphore, and this operation may sleep. This is
> problematic, because  __kernel_map_pages() can be called in atomic context,
> and thus is illegal to sleep. An example warning that this causes:
>
> BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1578
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2, name: kthreadd
> preempt_count: 2, expected: 0
> CPU: 0 PID: 2 Comm: kthreadd Not tainted 6.9.0-g1d4c6d784ef6 #37
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff800060dc>] dump_backtrace+0x1c/0x24
> [<ffffffff8091ef6e>] show_stack+0x2c/0x38
> [<ffffffff8092baf8>] dump_stack_lvl+0x5a/0x72
> [<ffffffff8092bb24>] dump_stack+0x14/0x1c
> [<ffffffff8003b7ac>] __might_resched+0x104/0x10e
> [<ffffffff8003b7f4>] __might_sleep+0x3e/0x62
> [<ffffffff8093276a>] down_write+0x20/0x72
> [<ffffffff8000cf00>] __set_memory+0x82/0x2fa
> [<ffffffff8000d324>] __kernel_map_pages+0x5a/0xd4
> [<ffffffff80196cca>] __alloc_pages_bulk+0x3b2/0x43a
> [<ffffffff8018ee82>] __vmalloc_node_range+0x196/0x6ba
> [<ffffffff80011904>] copy_process+0x72c/0x17ec
> [<ffffffff80012ab4>] kernel_clone+0x60/0x2fe
> [<ffffffff80012f62>] kernel_thread+0x82/0xa0
> [<ffffffff8003552c>] kthreadd+0x14a/0x1be
> [<ffffffff809357de>] ret_from_fork+0xe/0x1c
>
> Rewrite this function with apply_to_existing_page_range(). It is fine to
> not have any locking, because __kernel_map_pages() works with pages being
> allocated/deallocated and those pages are not changed by anyone else in the
> meantime.
>
> Fixes: 5fde3db5eb02 ("riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>   arch/riscv/mm/pageattr.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 410056a50aa9..271d01a5ba4d 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -387,17 +387,33 @@ int set_direct_map_default_noflush(struct page *page)
>   }
>   
>   #ifdef CONFIG_DEBUG_PAGEALLOC
> +static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
> +{
> +	int enable = *(int *)data;
> +
> +	unsigned long val = pte_val(ptep_get(pte));
> +
> +	if (enable)
> +		val |= _PAGE_PRESENT;
> +	else
> +		val &= ~_PAGE_PRESENT;
> +
> +	set_pte(pte, __pte(val));
> +
> +	return 0;
> +}
> +
>   void __kernel_map_pages(struct page *page, int numpages, int enable)
>   {
>   	if (!debug_pagealloc_enabled())
>   		return;
>   
> -	if (enable)
> -		__set_memory((unsigned long)page_address(page), numpages,
> -			     __pgprot(_PAGE_PRESENT), __pgprot(0));
> -	else
> -		__set_memory((unsigned long)page_address(page), numpages,
> -			     __pgprot(0), __pgprot(_PAGE_PRESENT));
> +	unsigned long start = (unsigned long)page_address(page);
> +	unsigned long size = PAGE_SIZE * numpages;
> +
> +	apply_to_existing_page_range(&init_mm, start, size, debug_pagealloc_set_page, &enable);
> +
> +	flush_tlb_kernel_range(start, start + size);
>   }
>   #endif
>   


And you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


