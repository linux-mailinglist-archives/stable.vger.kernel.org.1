Return-Path: <stable+bounces-89713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0037C9BB921
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AEE1F2267B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AE1BFE01;
	Mon,  4 Nov 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KkXBae4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r76XiQJV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KkXBae4R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r76XiQJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB81BF804;
	Mon,  4 Nov 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734818; cv=none; b=AxJBJS6B41ElnN00txHuEqmTqOmmLRTWYuik13ek3wOX1mvxupyQai+pLteD2c2Xiy3Z+LV3gSa4NYRS2gfyFn23IEX+SVc40ncSQpBdFCr5Bcyo06mVU2akus+CG8tORWGfhOSQAyQlvG/ID10Oj009TiH+aWBNE1wnFFLmNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734818; c=relaxed/simple;
	bh=HxuiUfcTqcifbxADkWP58bQBTki/pU9aORvUINBUQXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbmb0GbE7GFuM0aSkMEXgMA2+Hkgqeqkb+8o5yE/foZi5p/U1FBcrDIjkR80oO5bDQZvaHzJgV+fyrkAT91hdWnJpwCR6v62ONKelcpVDLyO0Olri+LysrUYIsExN4nAhFYmR4q0aZxfZ7Ec5/VXRg9dR2LJJbHcHChLOel3kiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KkXBae4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r76XiQJV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KkXBae4R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r76XiQJV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D0321F7F5;
	Mon,  4 Nov 2024 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730734812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9FM42PMqwddbsYCWzllPenk1QdNSJ/UI80tDK+Ud65s=;
	b=KkXBae4RhT7D9H+yB9xzy3Z6/fd7NjrQkk0CBlMIe1T07SbdZVdMKGjFGImju/lmJ5HwHA
	TR8RKX/0NHRuvp10gHNwNI3FGquk2JF42/hZDvtSlR9OtgL/Ll++JiCbL6w1HeNO51h+Cq
	1wjQHNJ/oCfM59OM8FXqgNE2xMDaQI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730734812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9FM42PMqwddbsYCWzllPenk1QdNSJ/UI80tDK+Ud65s=;
	b=r76XiQJVBKknrSNlof6zf7osiwNaBVpXcu29ZsCtbVmI14fp5e5UaHK8VgXJ0HzMzOHduj
	OhfrAeVqbvZjVeDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730734812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9FM42PMqwddbsYCWzllPenk1QdNSJ/UI80tDK+Ud65s=;
	b=KkXBae4RhT7D9H+yB9xzy3Z6/fd7NjrQkk0CBlMIe1T07SbdZVdMKGjFGImju/lmJ5HwHA
	TR8RKX/0NHRuvp10gHNwNI3FGquk2JF42/hZDvtSlR9OtgL/Ll++JiCbL6w1HeNO51h+Cq
	1wjQHNJ/oCfM59OM8FXqgNE2xMDaQI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730734812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9FM42PMqwddbsYCWzllPenk1QdNSJ/UI80tDK+Ud65s=;
	b=r76XiQJVBKknrSNlof6zf7osiwNaBVpXcu29ZsCtbVmI14fp5e5UaHK8VgXJ0HzMzOHduj
	OhfrAeVqbvZjVeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 804BA13503;
	Mon,  4 Nov 2024 15:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QX39HtzqKGfUGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 04 Nov 2024 15:40:12 +0000
Message-ID: <9e6fd342-ef7f-4648-afa3-bf704c87bf8f@suse.cz>
Date: Mon, 4 Nov 2024 16:40:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Content-Language: en-US
To: Koichiro Den <koichiro.den@gmail.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, kees@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241104150837.2756047-1-koichiro.den@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/4/24 16:08, Koichiro Den wrote:
> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> size 16 twice. This duplication triggers warnings on boot:
> 
> [    2.325108] ------------[ cut here ]------------
> [    2.325135] kmem_cache of name 'memdup_user-16' already exists
> [    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> [    2.327957] Modules linked in:
> [    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
> [    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> [    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
> [    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
> [    2.328942] sp : ffff800083d6fc50
> [    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
> [    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
> [    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> [    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
> [    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> [    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> [    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    2.329291] Call trace:
> [    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
> [    2.329499]  kmem_buckets_create+0xfc/0x320
> [    2.329526]  init_user_buckets+0x34/0x78
> [    2.329540]  do_one_initcall+0x64/0x3c8
> [    2.329550]  kernel_init_freeable+0x26c/0x578
> [    2.329562]  kernel_init+0x3c/0x258
> [    2.329574]  ret_from_fork+0x10/0x20
> [    2.329698] ---[ end trace 0000000000000000 ]---
> 
> [    2.403704] ------------[ cut here ]------------
> [    2.404716] kmem_cache of name 'msg_msg-16' already exists
> [    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> [    2.404842] Modules linked in:
> [    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
> [    2.405026] Tainted: [W]=WARN
> [    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> [    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
> [    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
> [    2.405111] sp : ffff800083d6fc50
> [    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
> [    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
> [    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> [    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
> [    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> [    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> [    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    2.405287] Call trace:
> [    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
> [    2.405305]  kmem_buckets_create+0xfc/0x320
> [    2.405315]  init_msg_buckets+0x34/0x78
> [    2.405326]  do_one_initcall+0x64/0x3c8
> [    2.405337]  kernel_init_freeable+0x26c/0x578
> [    2.405348]  kernel_init+0x3c/0x258
> [    2.405360]  ret_from_fork+0x10/0x20
> [    2.405370] ---[ end trace 0000000000000000 ]---
> 
> To address this, alias kmem_cache for sizes smaller than min alignment
> to the aligned sized kmem_cache, as done with the default system kmalloc
> bucket.
> 
> Cc: <stable@vger.kernel.org> # 6.11.x
> Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
> Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
> ---

Thanks for catching this.
Wonder if we could make this a lot simpler in kmem_buckets_create() by
starting with the current:

size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;

and adding:

aligned_idx = __kmalloc_index(size, false);

now the rest of the loop iteration would work with aligned_idx and if it
differs from idx, we assign the cache pointer also to idx, etc.

This should avoid duplicating the alignment calculation as we just extract
from kmalloc_caches[] the result of what new_kmalloc_cache() already did?

Vlastimil


>  mm/slab_common.c | 102 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 62 insertions(+), 40 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 3d26c257ed8b..64140561dd0e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -354,6 +354,38 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>  }
>  EXPORT_SYMBOL(__kmem_cache_create_args);
>  
> +static unsigned int __kmalloc_minalign(void)
> +{
> +	unsigned int minalign = dma_get_cache_alignment();
> +
> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> +	    is_swiotlb_allocated())
> +		minalign = ARCH_KMALLOC_MINALIGN;
> +
> +	return max(minalign, arch_slab_minalign());
> +}
> +
> +static unsigned int __kmalloc_aligned_size(unsigned int idx)
> +{
> +	unsigned int aligned_size = kmalloc_info[idx].size;
> +	unsigned int minalign = __kmalloc_minalign();
> +
> +	if (minalign > ARCH_KMALLOC_MINALIGN)
> +		aligned_size = ALIGN(aligned_size, minalign);
> +
> +	return aligned_size;
> +}
> +
> +static unsigned int __kmalloc_aligned_idx(unsigned int idx)
> +{
> +	unsigned int minalign = __kmalloc_minalign();
> +
> +	if (minalign > ARCH_KMALLOC_MINALIGN)
> +		return __kmalloc_index(__kmalloc_aligned_size(idx), false);
> +
> +	return idx;
> +}
> +
>  static struct kmem_cache *kmem_buckets_cache __ro_after_init;
>  
>  /**
> @@ -381,7 +413,10 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  				  void (*ctor)(void *))
>  {
>  	kmem_buckets *b;
> -	int idx;
> +	unsigned int idx;
> +	unsigned long mask = 0;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
>  
>  	/*
>  	 * When the separate buckets API is not built in, just return
> @@ -402,43 +437,47 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  
>  	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
>  		char *short_size, *cache_name;
> +		unsigned int aligned_size = __kmalloc_aligned_size(idx);
> +		unsigned int aligned_idx = __kmalloc_aligned_idx(idx);
>  		unsigned int cache_useroffset, cache_usersize;
> -		unsigned int size;
>  
> +		/* this might be an aliased kmem_cache */
>  		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
>  			continue;
>  
> -		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> -		if (!size)
> -			continue;
> -
>  		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
>  		if (WARN_ON(!short_size))
>  			goto fail;
>  
> -		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> -		if (WARN_ON(!cache_name))
> -			goto fail;
> -
> -		if (useroffset >= size) {
> +		if (useroffset >= aligned_size) {
>  			cache_useroffset = 0;
>  			cache_usersize = 0;
>  		} else {
>  			cache_useroffset = useroffset;
> -			cache_usersize = min(size - cache_useroffset, usersize);
> +			cache_usersize = min(aligned_size - cache_useroffset, usersize);
>  		}
> -		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> -					0, flags, cache_useroffset,
> -					cache_usersize, ctor);
> -		kfree(cache_name);
> -		if (WARN_ON(!(*b)[idx]))
> -			goto fail;
> +
> +		if (!(*b)[aligned_idx]) {
> +			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> +			if (WARN_ON(!cache_name))
> +				goto fail;
> +			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, aligned_size,
> +						0, flags, cache_useroffset,
> +						cache_usersize, ctor);
> +			if (WARN_ON(!(*b)[aligned_idx])) {
> +				kfree(cache_name);
> +				goto fail;
> +			}
> +			set_bit(aligned_idx, &mask);
> +		}
> +		if (idx != aligned_idx)
> +			(*b)[idx] = (*b)[aligned_idx];
>  	}
>  
>  	return b;
>  
>  fail:
> -	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
> +	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
>  		kmem_cache_destroy((*b)[idx]);
>  	kmem_cache_free(kmem_buckets_cache, b);
>  
> @@ -871,24 +910,12 @@ void __init setup_kmalloc_cache_index_table(void)
>  	}
>  }
>  
> -static unsigned int __kmalloc_minalign(void)
> -{
> -	unsigned int minalign = dma_get_cache_alignment();
> -
> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> -	    is_swiotlb_allocated())
> -		minalign = ARCH_KMALLOC_MINALIGN;
> -
> -	return max(minalign, arch_slab_minalign());
> -}
> -
>  static void __init
> -new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
> +new_kmalloc_cache(unsigned int idx, enum kmalloc_cache_type type)
>  {
>  	slab_flags_t flags = 0;
> -	unsigned int minalign = __kmalloc_minalign();
> -	unsigned int aligned_size = kmalloc_info[idx].size;
> -	int aligned_idx = idx;
> +	unsigned int aligned_size = __kmalloc_aligned_size(idx);
> +	unsigned int aligned_idx = __kmalloc_aligned_idx(idx);
>  
>  	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
>  		flags |= SLAB_RECLAIM_ACCOUNT;
> @@ -914,11 +941,6 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
>  	if (IS_ENABLED(CONFIG_MEMCG) && (type == KMALLOC_NORMAL))
>  		flags |= SLAB_NO_MERGE;
>  
> -	if (minalign > ARCH_KMALLOC_MINALIGN) {
> -		aligned_size = ALIGN(aligned_size, minalign);
> -		aligned_idx = __kmalloc_index(aligned_size, false);
> -	}
> -
>  	if (!kmalloc_caches[type][aligned_idx])
>  		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
>  					kmalloc_info[aligned_idx].name[type],
> @@ -934,7 +956,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
>   */
>  void __init create_kmalloc_caches(void)
>  {
> -	int i;
> +	unsigned int i;
>  	enum kmalloc_cache_type type;
>  
>  	/*


