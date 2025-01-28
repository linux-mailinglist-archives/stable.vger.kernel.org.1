Return-Path: <stable+bounces-111052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F4EA211F1
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE518866FC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC913BADF;
	Tue, 28 Jan 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LYBancFX"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25F748D
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091054; cv=none; b=Y6jdApNNb69zEWDBhy1rmo8IOFN03IxCQBlv+epUPHD2TMm2kbBK9LraqX8KJeUE/2AZVg42IaVZQsHARprUSvR91i+DBC4dTguOCLucafLCd5WYmPvKERQVn8O7bWJUBFYXqKxZ40TuisbroCLkC9TsWkq8pY7pLnbgksqO1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091054; c=relaxed/simple;
	bh=IslGADIVkOo/lRF9FUbCILMoWbggUQX+RPjIqW7xwmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwgu7Gtz+sZcHNcdbMA4+h6F+N1Msn6humxLZPzx0rBtI2doAAUW+FdZzNjmmIhDn6DWtLEt6o8rTOEPsE2J+QY8OYc9uRYUh5fH9fWSl9P3oFGPBnJfQfm8dZU/Psuwcp41vTebn/qsVmxPA/kh6Vq4g7faajTjmisvcUKSvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LYBancFX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 19:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738091043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AFRuLzECQi3X37aibekIYYwDV2KO+vl70+JQWMTjrzc=;
	b=LYBancFXx7gyMq11rPnjg5evtJMSp8OangkBbA1ifr/6LjKpREua02y7Hjqk5/vTc1fm1O
	Gpy9gsKeKolCVhO1O/3+904YUT/XwtNwcLA/jlgms9IqcxHpiWHOs5E3BmdI71+K/0WFtV
	APwrtOBZiIwVdWjAV0QNrGhIMuPi5wY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Message-ID: <Z5kqHT1x-_0qtduA@google.com>
References: <20250128185507.2176-1-42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128185507.2176-1-42.hyeyoo@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 29, 2025 at 03:55:07AM +0900, Hyeonggon Yoo wrote:
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> skips charging any zswapped base pages when it failed to zswap the entire
> folio.
> 
> However, when some base pages are zswapped but it failed to zswap
> the entire folio, the zswap operation is rolled back.
> When freeing zswap entries for those pages, zswap_entry_free() uncharges
> the pages that were not previously charged, causing zswap charging to
> become inconsistent.
> 
> This inconsistency triggers two warnings with following steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
> 
>   Two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> 
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
> 	  new, nr_pages))
> 
> While objcg events should only be accounted for when the entire folio is
> zswapped, objcg charging should be performed regardlessly.
> Fix accordingly.
> 
> After resolving the inconsistency, these warnings disappear.
> 
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> 
> v1->v2:
> 
>  Fixed objcg events being accounted for on zswap failure.
> 
>  Fixed the incorrect description. I misunderstood that the base pages are
>  going to be stored in zswap, but their zswap entries are freed immediately.
> 
>  Added a comment on why it charges pages that are going to be removed
>  from zswap.
> 
>  mm/zswap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6504174fbc6a..10b30ac46deb 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
>  
>  		bytes = zswap_store_page(page, objcg, pool);
>  		if (bytes < 0)
> -			goto put_pool;
> +			goto charge_zswap;
>  		compressed_bytes += bytes;
>  	}
>  
> -	if (objcg) {
> -		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> +	if (objcg)
>  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> -	}
>  
>  	atomic_long_add(nr_pages, &zswap_stored_pages);
>  	count_vm_events(ZSWPOUT, nr_pages);
>  
>  	ret = true;
>  
> +charge_zswap:
> +	/*
> +	 * Charge zswapped pages even when it failed to zswap the entire folio,
> +	 * because zswap_entry_free() will uncharge them anyway.
> +	 * Otherwise zswap charging will become inconsistent.
> +	 */
> +	if (objcg)
> +		obj_cgroup_charge_zswap(objcg, compressed_bytes);

Thanks for fixing this!

Having to charge just to uncharge right after is annoying. Ideally we'd
just clear entry->objcg if we fail before charging, but we don't have a
direct reference to the entries here and another tree lookup is not
ideal either.

I guess we may be able to improve this handling once [1] lands, as we
can move the charging logic into zswap_store_folio() where we'd have
access to the entries.

For now, would the control flow be easier if we move the charge ahead of
the zswap_store_page() loop instead? There is an existing if (objcg)
block there as well.

[1]https://lore.kernel.org/linux-mm/20241221063119.29140-12-kanchana.p.sridhar@intel.com/

>  put_pool:
>  	zswap_pool_put(pool);
>  put_objcg:
> -- 
> 2.47.1
> 
> 

