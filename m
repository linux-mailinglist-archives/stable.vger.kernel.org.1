Return-Path: <stable+bounces-211522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MAtB3kZd2kCcQEAu9opvQ
	(envelope-from <stable+bounces-211522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:36:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047384E01
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D393003EBE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FE2C11E8;
	Mon, 26 Jan 2026 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jc3nYqHo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhGU+wB7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jc3nYqHo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hhGU+wB7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E7237180
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769412980; cv=none; b=bQbnEEqlNVazm/XJ0SLNHjdKVM81+1KAXKJ0JQvZTL8sQXJkew/ohtptKc4u1loMCJu4h4GywYsbOu/eSVlSBZ8/cMZwojcqs2Xi3riO+d+u3nDKejecyUhdEYbWwUPJfRXc2YGCyZy6hujV1wR6RV/+e6Ypa7R6uA/ZV86J0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769412980; c=relaxed/simple;
	bh=EMynoi20VU5rE9tX9QngZyGm9gZLrMIVdPgwitCbG1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glspA2SeEXqniFn0b//pSy+W/4bQxXq5B0AuGmZtwBRouxSJjh54OhlG9Q4JgiutLyNq8/jF901Eka8EVWWKgnK/6QbOyX8vVl+dal8G1nYHyeXyk3znIDmKt4owkWK7TjRSdkHOp+QmyqMv/4CUAVQe8okI02gkKtQ5zq5aTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jc3nYqHo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhGU+wB7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jc3nYqHo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hhGU+wB7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23AD05BCC9;
	Mon, 26 Jan 2026 07:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769412977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tg6Un9JDoItEu2TLhpUrMlNcAaah4S+DhL52h5p3KdM=;
	b=jc3nYqHo+UAiWqIRSu8cBvux7S43/SrKDjWr+w1msHpp3uoQbfsNEQ9hjufSVWKxN7huaO
	J+6mTWbKZyvMfSsUBvgG9DqH282Mb4+WiN+kbnOEHbPaf/UNvWUZPfVzwz6qcypUdgJYQQ
	Ww+pgmD0UgSZ9/mfU74uHyV0+0rZlOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769412977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tg6Un9JDoItEu2TLhpUrMlNcAaah4S+DhL52h5p3KdM=;
	b=hhGU+wB7h48uhizsUBhD+usUwtZMk3oOzfuow5bSCW1zMH8jd5KUT+GtiB0Zs5hJnvMNGG
	GhPHnF/0/nqDoDAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769412977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tg6Un9JDoItEu2TLhpUrMlNcAaah4S+DhL52h5p3KdM=;
	b=jc3nYqHo+UAiWqIRSu8cBvux7S43/SrKDjWr+w1msHpp3uoQbfsNEQ9hjufSVWKxN7huaO
	J+6mTWbKZyvMfSsUBvgG9DqH282Mb4+WiN+kbnOEHbPaf/UNvWUZPfVzwz6qcypUdgJYQQ
	Ww+pgmD0UgSZ9/mfU74uHyV0+0rZlOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769412977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tg6Un9JDoItEu2TLhpUrMlNcAaah4S+DhL52h5p3KdM=;
	b=hhGU+wB7h48uhizsUBhD+usUwtZMk3oOzfuow5bSCW1zMH8jd5KUT+GtiB0Zs5hJnvMNGG
	GhPHnF/0/nqDoDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02A8A139E9;
	Mon, 26 Jan 2026 07:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0uVEAHEZd2kKZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Jan 2026 07:36:17 +0000
Message-ID: <2b116198-b27a-4b20-90b2-951343f9fff1@suse.cz>
Date: Mon, 26 Jan 2026 08:36:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, cl@gentwo.org, rientjes@google.com,
 surenb@google.com, hao.li@linux.dev,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20260124104614.9739-1-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260124104614.9739-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-211522-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,suse.cz:mid,suse.cz:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 7047384E01
X-Rspamd-Action: no action

On 1/24/26 11:46, Harry Yoo wrote:
> When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> can be allocated from the same slab we're allocating the array for.
> This led to obj_exts_in_slab() incorrectly returning true [1],
> although the array is not allocated from wasted space of the slab.
> 
> Vlastimil Babka observed that this problem should be fixed even when
> ignoring its incompatibility with obj_exts_in_slab(), because it creates
> slabs that are never freed as there is always at least one allocated
> object.
> 
> To avoid this, use the next kmalloc size or large kmalloc when
> kmalloc_slab() returns the same cache we're allocating the array for.
> 
> In case of random kmalloc caches, there are multiple kmalloc caches for
> the same size and the cache is selected based on the caller address.
> Because it is fragile to ensure the same caller address is passed to
> kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
> to (s->object_size + 1) when the sizes are equal.
> 
> Note that this doesn't happen when memory allocation profiling is
> disabled, as when the allocation of the array is triggered by memory
> cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
> Cc: stable@vger.kernel.org
> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Thanks! Just wondering if we could simplify a bit.

> ---
>  mm/slub.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3ff1c475b0f1..43ddb96c4081 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2104,6 +2104,52 @@ static inline void init_slab_obj_exts(struct slab *slab)
>  	slab->obj_exts = 0;
>  }
>  
> +/*
> + * Calculate the allocation size for slabobj_ext array.
> + *
> + * When memory allocation profiling is enabled, the obj_exts array
> + * could be allocated from the same slab cache it's being allocated for.
> + * This would prevent the slab from ever being freed because it would
> + * always contain at least one allocated object (its own obj_exts array).
> + *
> + * To avoid this, increase the allocation size when we detect the array
> + * would come from the same cache, forcing it to use a different cache.
> + */
> +static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
> +					 struct slab *slab, gfp_t gfp)
> +{
> +	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
> +	struct kmem_cache *obj_exts_cache;
> +
> +	/*
> +	 * slabobj_ext array for KMALLOC_CGROUP allocations
> +	 * are served from KMALLOC_NORMAL caches.
> +	 */
> +	if (!mem_alloc_profiling_enabled())
> +		return sz;
> +
> +	if (sz > KMALLOC_MAX_CACHE_SIZE)
> +		return sz;

Could we bail out here immediately if !is_kmalloc_normal(s)?

> +
> +	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);

Then do this.

> +	if (s == obj_exts_cache)
> +		return obj_exts_cache->object_size + 1;

But not this.

> +	/*
> +	 * Random kmalloc caches have multiple caches per size, and the cache
> +	 * is selected by the caller address. Since caller address may differ
> +	 * between kmalloc_slab() and actual allocation, bump size when both
> +	 * are normal kmalloc caches of same size.
> +	 */
> +	if (IS_ENABLED(CONFIG_RANDOM_KMALLOC_CACHES) &&

Instead just compare object_size unconditionally.

> +			is_kmalloc_normal(s) &&

This we already checked.

> +			is_kmalloc_normal(obj_exts_cache) &&

I think this is guaranteed thanks to "gfp &= ~OBJCGS_CLEAR_MASK;" below so
we don't need it.

> +			(s->object_size == obj_exts_cache->object_size))
> +		return obj_exts_cache->object_size + 1;
> +
> +	return sz;
> +}
> +
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		        gfp_t gfp, bool new_slab)
>  {
> @@ -2112,26 +2158,26 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	unsigned long new_exts;
>  	unsigned long old_exts;
>  	struct slabobj_ext *vec;
> +	size_t sz;
>  
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
>  
> +	sz = obj_exts_alloc_size(s, slab, gfp);
> +
>  	/*
>  	 * Note that allow_spin may be false during early boot and its
>  	 * restricted GFP_BOOT_MASK. Due to kmalloc_nolock() only supporting
>  	 * architectures with cmpxchg16b, early obj_exts will be missing for
>  	 * very early allocations on those.
>  	 */
> -	if (unlikely(!allow_spin)) {
> -		size_t sz = objects * sizeof(struct slabobj_ext);
> -
> +	if (unlikely(!allow_spin))
>  		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
>  				     slab_nid(slab));
> -	} else {
> -		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> -				   slab_nid(slab));
> -	}
> +	else
> +		vec = kmalloc_node(sz, gfp | __GFP_ZERO, slab_nid(slab));
> +
>  	if (!vec) {
>  		/*
>  		 * Try to mark vectors which failed to allocate.
> @@ -2145,6 +2191,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		return -ENOMEM;
>  	}
>  
> +	VM_WARN_ON_ONCE(virt_to_slab(vec)->slab_cache == s);
> +
>  	new_exts = (unsigned long)vec;
>  	if (unlikely(!allow_spin))
>  		new_exts |= OBJEXTS_NOSPIN_ALLOC;


