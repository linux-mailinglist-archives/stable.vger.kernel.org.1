Return-Path: <stable+bounces-93590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882129CF486
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196971F23A04
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6DE1D435C;
	Fri, 15 Nov 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yp7mpSM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVTxIvJI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QPePSUhw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3o7xi6s1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A517BB32;
	Fri, 15 Nov 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697572; cv=none; b=FxRCB72T8QKlAg/5GW2TcO4L90dlZ1ZvznM8O3sZeewPw7Eg3TQSp53ONs15ruKfCjYapxj6NqOH5BwtvyNrN8RNC80rmI11q+Lkx5fM8645Feo0tfgUiOhMC++zL4NLDRjKUhgJSoJe3teX07gXnRGfUxZE8s7w7KsolPbdpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697572; c=relaxed/simple;
	bh=1eJbjNaTJtoezSmArbo25H8Wqr8YeQiybqWGq+ew4sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0IhGShQ0CiUy4Au0POQkRPPcZ457gznR7/vB2eXTBh0mO6fdCbPaDrZuYKZRhAcfRvdLHAGAZNx6H56FKo98AyGfqLeUDp4jOZfFzVmCsViJL5wfLKssVgPx9OipTf+RiMrgYjuZtOYmMzLyLDhjB4C0huUIzkz3Ezk+ypenXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yp7mpSM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVTxIvJI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QPePSUhw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3o7xi6s1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 952B62117B;
	Fri, 15 Nov 2024 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731697566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eXpQ5/Bhx3ZBQhUJC7flTpCe8EKcfTBc1bkMrTXMsiI=;
	b=Yp7mpSM8MpNEzPJ/7Fu7US7olN+xjRA3arpa73cmRCONBXqt3CSJ4mybCfVV3bl3Q9d2g3
	y5vOf9u/JJlKhYjTL0WRhHR3BAwRUJeF3iN0zNqAzscoI6gn2jkUdE97/3BJj0l6Ub+CN6
	GUNEQPHBYdONQoHkGr6I11AAx9DHLmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731697566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eXpQ5/Bhx3ZBQhUJC7flTpCe8EKcfTBc1bkMrTXMsiI=;
	b=RVTxIvJI1Cx1Fj0KTDBX2r2hv4Q/INIkhQzLIOSwWg6TXl2bf2F00kExAih746/dlHAUsq
	6u5f3BKtardblPDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731697565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eXpQ5/Bhx3ZBQhUJC7flTpCe8EKcfTBc1bkMrTXMsiI=;
	b=QPePSUhwEc7J92kTIQGRKu9J7sO6ZTZjAccUinTqN+RGegveG2Pb44S/SKpjOIXFevk0fd
	ccXwnbLc6ztE7hQEdLVRxXZdt2HlXdmSYfAYYOW0Qosg7X2YH7iw6KvpApmDITkSDWVsE5
	YuD25CwH28+/XLv5P7VLgpqhPmACNMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731697565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eXpQ5/Bhx3ZBQhUJC7flTpCe8EKcfTBc1bkMrTXMsiI=;
	b=3o7xi6s1DjW/DJAROCrJonuuJLvJfC/WMcViAhqk37QiYtmVsqMqw8S42rGT9vndXAwyFO
	t+8+/FUFIOi53WDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7155D134B8;
	Fri, 15 Nov 2024 19:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1JRNG52bN2fSewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Nov 2024 19:06:05 +0000
Message-ID: <2979df31-ce8c-4382-ab01-7e66f852099d@suse.cz>
Date: Fri, 15 Nov 2024 20:06:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 4/4] mm: resolve faulty mmap_region() error path
 behaviour
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1731671441.git.lorenzo.stoakes@oracle.com>
 <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <4cb9b846f0c4efcc4a2b21453eea4e4d0136efc8.1731671441.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,google.com,vger.kernel.org,kvack.org,redhat.com,arm.com,kernel.org,davemloft.net,gaisler.com,HansenPartnership.com,gmx.de];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/15/24 13:40, Lorenzo Stoakes wrote:
> [ Upstream commit 5de195060b2e251a835f622759550e6202167641 ]
> 
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
> 
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently
> observed issues with resource leaks and observable inconsistent state.
> 
> Taking advantage of previous patches in this series we move a number of
> checks earlier in the code, simplifying things by moving the core of the
> logic into a static internal function __mmap_region().
> 
> Doing this allows us to perform a number of checks up front before we do
> any real work, and allows us to unwind the writable unmap check
> unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> validation unconditionally also.
> 
> We move a number of things here:
> 
> 1. We preallocate memory for the iterator before we call the file-backed
>    memory hook, allowing us to exit early and avoid having to perform
>    complicated and error-prone close/free logic. We carefully free
>    iterator state on both success and error paths.
> 
> 2. The enclosing mmap_region() function handles the mapping_map_writable()
>    logic early. Previously the logic had the mapping_map_writable() at the
>    point of mapping a newly allocated file-backed VMA, and a matching
>    mapping_unmap_writable() on success and error paths.
> 
>    We now do this unconditionally if this is a file-backed, shared writable
>    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
>    doing so does not invalidate the seal check we just performed, and we in
>    any case always decrement the counter in the wrapper.
> 
>    We perform a debug assert to ensure a driver does not attempt to do the
>    opposite.
> 
> 3. We also move arch_validate_flags() up into the mmap_region()
>    function. This is only relevant on arm64 and sparc64, and the check is
>    only meaningful for SPARC with ADI enabled. We explicitly add a warning
>    for this arch if a driver invalidates this check, though the code ought
>    eventually to be fixed to eliminate the need for this.
> 
> With all of these measures in place, we no longer need to explicitly close
> the VMA on error paths, as we place all checks which might fail prior to a
> call to any driver mmap hook.
> 
> This eliminates an entire class of errors, makes the code easier to reason
> about and more robust.
> 
> Link: https://lkml.kernel.org/r/6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Tested-by: Mark Brown <broonie@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c | 103 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 56 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 322677f61d30..e457169c5cce 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2652,7 +2652,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return do_mas_munmap(&mas, mm, start, len, uf, false);
>  }
>  
> -unsigned long mmap_region(struct file *file, unsigned long addr,
> +static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
>  {
> @@ -2750,26 +2750,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
>  	vma->vm_pgoff = pgoff;
>  
> -	if (file) {
> -		if (vm_flags & VM_SHARED) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto free_vma;
> -		}
> +	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +		error = -ENOMEM;
> +		goto free_vma;
> +	}
>  
> +	if (file) {
>  		vma->vm_file = get_file(file);
>  		error = mmap_file(file, vma);
>  		if (error)
> -			goto unmap_and_free_vma;
> +			goto unmap_and_free_file_vma;
> +
> +		/* Drivers cannot alter the address of the VMA. */
> +		WARN_ON_ONCE(addr != vma->vm_start);
>  
>  		/*
> -		 * Expansion is handled above, merging is handled below.
> -		 * Drivers should not alter the address of the VMA.
> +		 * Drivers should not permit writability when previously it was
> +		 * disallowed.
>  		 */
> -		if (WARN_ON((addr != vma->vm_start))) {
> -			error = -EINVAL;
> -			goto close_and_free_vma;
> -		}
> +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> +				!(vm_flags & VM_MAYWRITE) &&
> +				(vma->vm_flags & VM_MAYWRITE));
> +
>  		mas_reset(&mas);
>  
>  		/*
> @@ -2792,7 +2794,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  				vma = merge;
>  				/* Update vm_flags to pick up the change. */
>  				vm_flags = vma->vm_flags;
> -				goto unmap_writable;
> +				goto file_expanded;

I think we might need a mas_destroy() somewhere around here otherwise we
leak the prealloc? In later versions the merge operation takes our vma
iterator so it handles that if merge succeeds, but here we have to cleanup
our mas ourselves?

>  			}
>  		}
>  
> @@ -2800,31 +2802,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)
> -			goto free_vma;
> +			goto free_iter_vma;
>  	} else {
>  		vma_set_anonymous(vma);
>  	}
>  
> -	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> -		error = -EINVAL;
> -		if (file)
> -			goto close_and_free_vma;
> -		else if (vma->vm_file)
> -			goto unmap_and_free_vma;
> -		else
> -			goto free_vma;
> -	}
> -
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> -		error = -ENOMEM;
> -		if (file)
> -			goto close_and_free_vma;
> -		else if (vma->vm_file)
> -			goto unmap_and_free_vma;
> -		else
> -			goto free_vma;
> -	}
> +#ifdef CONFIG_SPARC64
> +	/* TODO: Fix SPARC ADI! */
> +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +#endif
>  
>  	if (vma->vm_file)
>  		i_mmap_lock_write(vma->vm_file->f_mapping);
> @@ -2847,10 +2833,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	khugepaged_enter_vma(vma, vma->vm_flags);
>  
> -	/* Once vma denies write, undo our temporary denial count */
> -unmap_writable:
> -	if (file && vm_flags & VM_SHARED)
> -		mapping_unmap_writable(file->f_mapping);
> +file_expanded:
>  	file = vma->vm_file;
>  expanded:
>  	perf_event_mmap(vma);
> @@ -2879,28 +2862,54 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	vma_set_page_prot(vma);
>  
> -	validate_mm(mm);
>  	return addr;
>  
> -close_and_free_vma:
> -	vma_close(vma);
> -unmap_and_free_vma:
> +unmap_and_free_file_vma:
>  	fput(vma->vm_file);
>  	vma->vm_file = NULL;
>  
>  	/* Undo any partial mapping done by a device driver. */
>  	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
> -	if (file && (vm_flags & VM_SHARED))
> -		mapping_unmap_writable(file->f_mapping);
> +free_iter_vma:
> +	mas_destroy(&mas);
>  free_vma:
>  	vm_area_free(vma);
>  unacct_error:
>  	if (charged)
>  		vm_unacct_memory(charged);
> -	validate_mm(mm);
>  	return error;
>  }
>  
> +unsigned long mmap_region(struct file *file, unsigned long addr,
> +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +			  struct list_head *uf)
> +{
> +	unsigned long ret;
> +	bool writable_file_mapping = false;
> +
> +	/* Allow architectures to sanity-check the vm_flags. */
> +	if (!arch_validate_flags(vm_flags))
> +		return -EINVAL;
> +
> +	/* Map writable and ensure this isn't a sealed memfd. */
> +	if (file && (vm_flags & VM_SHARED)) {
> +		int error = mapping_map_writable(file->f_mapping);
> +
> +		if (error)
> +			return error;
> +		writable_file_mapping = true;
> +	}
> +
> +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +
> +	/* Clear our write mapping regardless of error. */
> +	if (writable_file_mapping)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	validate_mm(current->mm);
> +	return ret;
> +}
> +
>  static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
>  {
>  	int ret;


