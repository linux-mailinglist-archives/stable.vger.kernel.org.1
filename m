Return-Path: <stable+bounces-211498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +It7D5O6dmkSVQEAu9opvQ
	(envelope-from <stable+bounces-211498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 01:51:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60022833B2
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 01:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B193003EAA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 00:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FB49620;
	Mon, 26 Jan 2026 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFK+0C+5"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B2487BE
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769388687; cv=none; b=Xt+IKtvm6X0fsHOvS2OWz5T7Zdna0+1X5f38kyMeWLAFX/GexaAMlOIBpBpX8BkdIwpHTCo27Zw7FFoh7pxBrogiIKY1uq5On8EiyTST2AZgAE/RpxmjkdPNAu8FUBU3ABC8daq61UZmx37gysKn0EQVeVHJRQLfcH/7p2kfpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769388687; c=relaxed/simple;
	bh=WzvOvEujohhNCftvh/GuUipfHM9bf8cGtWNYNf0rVKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQQ+jFqaydV6P3q99YYdTSGixfSywCQ5WiXV9sWUc4hGH6xO/Mr1XEf6OllNljCsV3HYsnx02s8WYUctO5cVtL4Ylab34e/r8X7DfcHfumdtobSHcziHPq5iYp4vB/8zkUZqs7ffo769CgqAsjabN+Zk0rHzeDydZ03DzATrNaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFK+0C+5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Jan 2026 08:51:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769388683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZMWMY+mIk/ZareEAhb040770CIAQtwMX6nJgk+aGIU=;
	b=bFK+0C+5whH7UFfoZq2PpP2omZlJpjnJVw3beo5c1GjYSQwSAmvXbbUO0Vqyjhnoh7R+gl
	oTG8DkvXS2jFMZdX1S1N04KpvYEr8TClJJU4t0RN//4AzCu9JigQ4LOx7N/uTsR87osS1B
	L6KVhQVKrWBg/Y+xonW68axjnb/FHug=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org, 
	cl@gentwo.org, rientjes@google.com, surenb@google.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Message-ID: <bbhrcvqbwuvf6l4xwv7ax6w5iwuixaivvuknvlgutnavxyllme@r5zkvsh7mwtw>
References: <20260124104614.9739-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124104614.9739-1-harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211498-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 60022833B2
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 07:46:14PM +0900, Harry Yoo wrote:
> When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> can be allocated from the same slab we're allocating the array for.
> This led to obj_exts_in_slab() incorrectly returning true [1],
> although the array is not allocated from wasted space of the slab.

This is indeed a tricky issue to uncover.

> 
> Vlastimil Babka observed that this problem should be fixed even when
> ignoring its incompatibility with obj_exts_in_slab(), because it creates
> slabs that are never freed as there is always at least one allocated
> object.
> 
> To avoid this, use the next kmalloc size or large kmalloc when
> kmalloc_slab() returns the same cache we're allocating the array for.

Nice approach.

> 
> In case of random kmalloc caches, there are multiple kmalloc caches for
> the same size and the cache is selected based on the caller address.
> Because it is fragile to ensure the same caller address is passed to
> kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
> to (s->object_size + 1) when the sizes are equal.

Good catch on this corner case!

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

Looks good to me!
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

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
> +
> +	obj_exts_cache = kmalloc_slab(sz, NULL, gfp, 0);
> +	if (s == obj_exts_cache)
> +		return obj_exts_cache->object_size + 1;
> +
> +	/*
> +	 * Random kmalloc caches have multiple caches per size, and the cache
> +	 * is selected by the caller address. Since caller address may differ
> +	 * between kmalloc_slab() and actual allocation, bump size when both
> +	 * are normal kmalloc caches of same size.
> +	 */
> +	if (IS_ENABLED(CONFIG_RANDOM_KMALLOC_CACHES) &&
> +			is_kmalloc_normal(s) &&
> +			is_kmalloc_normal(obj_exts_cache) &&
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
> -- 
> 2.43.0
> 

