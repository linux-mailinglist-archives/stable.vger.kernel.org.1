Return-Path: <stable+bounces-89814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775B9BCB04
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 11:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597E21C22521
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05A1D2F72;
	Tue,  5 Nov 2024 10:51:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8111D2F48;
	Tue,  5 Nov 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803901; cv=none; b=AUlk42iFAI+rQq6tuUVm/gHvpqZCkf3ttQvjYXMvO8Xtkolpd/S8XRdtt8m1C5yey5SSAN1vyG0RVK07BQBYVY44wVSx+Ma+TUYifqySr/IE9GhetATgjrG1A3q52okX3sFvPFZrMyk36qq8eFiau+PJRDwipaDzYaxOeeHQt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803901; c=relaxed/simple;
	bh=JCduaAp7dOeRgXy+BkzoDK46oi51ypHdAiEnxGSZR0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzr9rsJHXl9rBUO5b7gE4vEwNYT2zzSEEqe3p68QPWSmBuD/gBp99IgBjWlp0+PbgK1Hr/FeKyrRR8GSxa6bIpFLZifZxFFCWcDW6fYifhhqeDnSlWaK0bMnpqHx3KAF7Vnz5Pfrr4rIvnV9sN0/KLOUCpoHajEHzlRnEPbE+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DABC4CECF;
	Tue,  5 Nov 2024 10:51:38 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:51:36 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Koichiro Den <koichiro.den@gmail.com>
Cc: vbabka@suse.cz, cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <Zyn4uGY7pObMD14u@arm.com>
References: <20241105022747.2819151-1-koichiro.den@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105022747.2819151-1-koichiro.den@gmail.com>

On Tue, Nov 05, 2024 at 11:27:47AM +0900, Koichiro Den wrote:
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 3d26c257ed8b..db6ffe53c23e 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -380,8 +380,11 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  				  unsigned int usersize,
>  				  void (*ctor)(void *))
>  {
> +	unsigned long mask = 0;
> +	unsigned int idx;
>  	kmem_buckets *b;
> -	int idx;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
>  
>  	/*
>  	 * When the separate buckets API is not built in, just return
> @@ -403,7 +406,7 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
>  		char *short_size, *cache_name;
>  		unsigned int cache_useroffset, cache_usersize;
> -		unsigned int size;
> +		unsigned int size, aligned_idx;
>  
>  		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
>  			continue;
> @@ -416,10 +419,6 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  		if (WARN_ON(!short_size))
>  			goto fail;
>  
> -		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> -		if (WARN_ON(!cache_name))
> -			goto fail;
> -
>  		if (useroffset >= size) {
>  			cache_useroffset = 0;
>  			cache_usersize = 0;
> @@ -427,18 +426,29 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
>  			cache_useroffset = useroffset;
>  			cache_usersize = min(size - cache_useroffset, usersize);
>  		}
> -		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
> -					0, flags, cache_useroffset,
> -					cache_usersize, ctor);
> -		kfree(cache_name);
> -		if (WARN_ON(!(*b)[idx]))
> -			goto fail;
> +
> +		aligned_idx = __kmalloc_index(size, false);
> +		if (!(*b)[aligned_idx]) {
> +			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
> +			if (WARN_ON(!cache_name))
> +				goto fail;
> +			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
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

It looks fine. This pretty much matches the logic in new_kmalloc_cache()
(from commit 963e84b0f262).

>  	return b;
>  
>  fail:
> -	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
> +	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
>  		kmem_cache_destroy((*b)[idx]);
>  	kmem_cache_free(kmem_buckets_cache, b);

I gave this a try with swiotlb=noforce as well (which pushed the minimum
alignment to 64). So:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

