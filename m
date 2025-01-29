Return-Path: <stable+bounces-111185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4FA220E9
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C066D18843C6
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B118F2EA;
	Wed, 29 Jan 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fgKMYeaV"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A2224EA
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165980; cv=none; b=rQydY+BocbZtTWnDyLl0SSmiaNT4n1EoL7Meyewga/nDcUe2uIMjqWHK0i9ACNHr1IJUCf6g2qOFUP1OjlD9+erJHkbR9CuvFrNaMLyU1yfEGshnNxSFZpAgUvDit3ywy/2taEjEJ6gtNjkT4/nuY9qytuWhDadGdZrqZtW8AEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165980; c=relaxed/simple;
	bh=/LbYKvu9cbGNymwRyJmJMc7DNOO3Kl1ZYFdJ8XLSXrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZEV0pCcobk+AisoKFMvaMx/4H3heOiEl5/jPh4DiXZG50wQdkxsTnU68IpDevi/PKJV+7yzqCbgPRQIcR+D20gTwI3R9H3eJCt2CmMyYFTU87ui3ZucOdAaJ0nf642w2yYRDTsjLWmwsvABtiqz98FKGrHf9rPkcMWKyhdiGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fgKMYeaV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 15:52:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738165969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1nxnH7gjC69f//PjTAZ5mo7TGKKM+PlswgbxJc4ez1U=;
	b=fgKMYeaVyFXoLO4EWB/7RZnkoYR62K5VcsC4Ztt7NtILluStj90KVBXplBev7biJirI64W
	Qvh74BLbqF6Ol3hmsQdF3EP8wpRMDeQn4YovYtslIHifDv3aOoebLE9mH2QeCP7oY2CquU
	69xeBj+hptdhQ0QEo3lk8WoGHZ34Uig=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 mm-hotfixes] mm/zswap: fix inconsistency when
 zswap_store_page() fails
Message-ID: <Z5pOzXjLql45eZ6v@google.com>
References: <20250129100844.2935-1-42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129100844.2935-1-42.hyeyoo@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 29, 2025 at 07:08:44PM +0900, Hyeonggon Yoo wrote:
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> skips charging any zswap entries when it failed to zswap the entire
> folio.
> 
> However, when some base pages are zswapped but it failed to zswap
> the entire folio, the zswap operation is rolled back.
> When freeing zswap entries for those pages, zswap_entry_free() uncharges
> the zswap entries that were not previously charged, causing zswap charging
> to become inconsistent.
> 
> This inconsistency triggers two warnings with following steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
> 
>   The two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> 
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
> 	  new, nr_pages))
> 
> zswap_stored_pages also becomes inconsistent in the same way.
> 
> As suggested by Kanchana, increment zswap_stored_pages and charge zswap
> entries within zswap_store_page() when it succeeds. This way,
> zswap_entry_free() will decrement the counter and uncharge the entries
> when it failed to zswap the entire folio.
> 
> While this could potentially be optimized by batching objcg charging
> and incrementing the counter, let's focus on fixing the bug this time
> and leave the optimization for later after some evaluation.
> 
> After resolving the inconsistency, the warnings disappear.
> 
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I have a few nits, but generally:

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
> 
> v2 -> v3:
>   - Adjusted Kanchana's feedback:
>     - Fixed inconsistency in zswap_stored_pages
>     - Now objcg charging and incrementing zswap_store_pages is done
>       within zswap_stored_pages, one by one
> 
>  mm/zswap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6504174fbc6a..f0bd962bffd5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *page,
>  	entry->pool = pool;
>  	entry->swpentry = page_swpentry;
>  	entry->objcg = objcg;
> +	if (objcg)
> +		obj_cgroup_charge_zswap(objcg, entry->length);

nit: This can be moved to the existing if (objcg) check where we call
obj_cgroup_get(). At that point there shouldn't be a possibility of
failure. If you want to keep it here to make it obvious that we only
charge when we set entry->objcg that's fine, but we can probably move
obj_cgroup_get() here as well in this case.

>  	entry->referenced = true;
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap_list_lru, entry);
>  	}
> +	atomic_long_inc(&zswap_stored_pages);

nit: If you keep the charging after setting entry->objcg because that's
when the freeing path will uncharge, then perhaps you want to move this
after the tree store is successful, because at that point the freeing
path will decrement the counter.

>  	return entry->length;
>  
> @@ -1526,7 +1529,6 @@ bool zswap_store(struct folio *folio)
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
>  	struct zswap_pool *pool;
> -	size_t compressed_bytes = 0;
>  	bool ret = false;
>  	long index;
>  
> @@ -1569,15 +1571,11 @@ bool zswap_store(struct folio *folio)
>  		bytes = zswap_store_page(page, objcg, pool);
>  		if (bytes < 0)
>  			goto put_pool;

Do we need 'bytes' anymore? I think we don't even need
zswap_store_page() to return the compressed size anymore. Seems like a
boolean will suffice.

> -		compressed_bytes += bytes;
>  	}
>  
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +	if (objcg)
>  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> -	}
>  
> -	atomic_long_add(nr_pages, &zswap_stored_pages);
>  	count_vm_events(ZSWPOUT, nr_pages);
>  
>  	ret = true;
> -- 
> 2.47.1
> 
> 

