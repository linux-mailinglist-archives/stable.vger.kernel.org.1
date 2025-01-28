Return-Path: <stable+bounces-111055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CDFA21221
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 20:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33545161E45
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA621DED64;
	Tue, 28 Jan 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JNN1uygY"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA91DE4FA
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091989; cv=none; b=n6/gsJbcjGhofIdQkx67FxUsCAV8+s4i0eMfYCEPDUyIBiI9B7tP5rc5tfPKIcPv1qDJaJ5EkWB/+hu4eWB7j9qZ5xJHqd80mJ4X6NoG4b2P9UB3nX2u8cXmjZ0zK4LwxOrA7XNtySPdtCDOLB+YsuRTZyvm43E8Oszetn5KMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091989; c=relaxed/simple;
	bh=QadaU0M36VTSJ5NF3ZjtBNPxE8qG8x/ksViSYdyNYis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbyETBSPRmcfpR0VT46sv2UQTDMHZv5vU+zSmxNsuhppApROTOqwJGlxvBoEdcedjDAN0Llh8u6LdE4+c2u0pg7r025M0vU3p8SqXDHpeLfjbhGKX5LgYn5TneFWcccgRjqgbIeye9rW96qxB7od7aTmNiuCglH+T6Rg1q7mbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JNN1uygY; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 19:19:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738091983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0rsO5JuIwjI5YH8nG8ffxUOU3TO+bJybM752ZjwPgo=;
	b=JNN1uygY2u1TyRhqWdGPJY+RiglaJICTc6795+pcxRCMKH/q4U5BfnhW4NJ4PGQULpjMHJ
	ncIVvQHm9d6Mk29RQqBJ2C8pxefzQ3CsyiN3ft+daa67EiDPomJnlMCVPr5p06ZQD4RoJb
	l982H3Z4tBaoV3yhD6kEX25q952bbyk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Message-ID: <Z5kty3MCeILaoLwz@google.com>
References: <20250128185507.2176-1-42.hyeyoo@gmail.com>
 <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR11MB81206771932B54FCFFD0DF2CC9EF2@SA3PR11MB8120.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 28, 2025 at 07:09:05PM +0000, Sridhar, Kanchana P wrote:
> Hi Hyeonggon,
> 
> > -----Original Message-----
> > From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Sent: Tuesday, January 28, 2025 10:55 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Weiner
> > <hannes@cmpxchg.org>; Yosry Ahmed <yosryahmed@google.com>; Nhat
> > Pham <nphamcs@gmail.com>; Chengming Zhou
> > <chengming.zhou@linux.dev>; Andrew Morton <akpm@linux-
> > foundation.org>
> > Cc: linux-mm@kvack.org; Hyeonggon Yoo <42.hyeyoo@gmail.com>;
> > stable@vger.kernel.org
> > Subject: [PATCH v2 mm-hotfixes] mm/zswap: fix inconsistent charging when
> > zswap_store_page() fails
> > 
> > Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> > skips charging any zswapped base pages when it failed to zswap the entire
> > folio.
> > 
> > However, when some base pages are zswapped but it failed to zswap
> > the entire folio, the zswap operation is rolled back.
> > When freeing zswap entries for those pages, zswap_entry_free() uncharges
> > the pages that were not previously charged, causing zswap charging to
> > become inconsistent.
> > 
> > This inconsistency triggers two warnings with following steps:
> >   # On a machine with 64GiB of RAM and 36GiB of zswap
> >   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
> >   $ sudo reboot
> > 
> >   Two warnings are:
> >     in mm/memcontrol.c:163, function obj_cgroup_release():
> >       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> > 
> >     in mm/page_counter.c:60, function page_counter_cancel():
> >       if (WARN_ONCE(new < 0, "page_counter underflow: %ld
> > nr_pages=%lu\n",
> > 	  new, nr_pages))
> > 
> > While objcg events should only be accounted for when the entire folio is
> > zswapped, objcg charging should be performed regardlessly.
> > Fix accordingly.
> > 
> > After resolving the inconsistency, these warnings disappear.
> > 
> > Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > ---
> > 
> > v1->v2:
> > 
> >  Fixed objcg events being accounted for on zswap failure.
> > 
> >  Fixed the incorrect description. I misunderstood that the base pages are
> >  going to be stored in zswap, but their zswap entries are freed immediately.
> > 
> >  Added a comment on why it charges pages that are going to be removed
> >  from zswap.
> > 
> >  mm/zswap.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6504174fbc6a..10b30ac46deb 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1568,20 +1568,26 @@ bool zswap_store(struct folio *folio)
> > 
> >  		bytes = zswap_store_page(page, objcg, pool);
> >  		if (bytes < 0)
> > -			goto put_pool;
> > +			goto charge_zswap;
> >  		compressed_bytes += bytes;
> >  	}
> > 
> > -	if (objcg) {
> > -		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> > +	if (objcg)
> >  		count_objcg_events(objcg, ZSWPOUT, nr_pages);
> > -	}
> > 
> >  	atomic_long_add(nr_pages, &zswap_stored_pages);
> >  	count_vm_events(ZSWPOUT, nr_pages);
> > 
> >  	ret = true;
> > 
> > +charge_zswap:
> > +	/*
> > +	 * Charge zswapped pages even when it failed to zswap the entire
> > folio,
> > +	 * because zswap_entry_free() will uncharge them anyway.
> > +	 * Otherwise zswap charging will become inconsistent.
> > +	 */
> > +	if (objcg)
> > +		obj_cgroup_charge_zswap(objcg, compressed_bytes);
> 
> Thanks for finding this bug! I am thinking it might make sense to charge
> and increment the zswap_stored_pages counter in zswap_store_page().
> Something like:
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b84c20d889b1..fd2a72598a8a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *page,
>  	entry->pool = pool;
>  	entry->swpentry = page_swpentry;
>  	entry->objcg = objcg;
> +	if (objcg)
> +		obj_cgroup_charge_zswap(objcg, entry->length);
>  	entry->referenced = true;
>  	if (entry->length) {
>  		INIT_LIST_HEAD(&entry->lru);
>  		zswap_lru_add(&zswap_list_lru, entry);
>  	}
> +	atomic_long_inc(&zswap_stored_pages);
>  
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
> 
> What do you think?
> 
> Yosry, Nhat, Johannes, please let me know if this would be a cleaner
> approach. If so, I don't think we would be losing a lot of performance
> by not doing the one-time charge per folio, but please let me know
> your thoughts as well.

This is certainly cleaner, and thanks for catching that
zswap_stored_pages cleanup is also wrong.

I am not sure if this has meaningful impact on performance, but it seems
like we are doing a bit more work in the common success case to avoid
the work in the uncommon failure case.

Moving the charge (and atomic addition) above the zswap_store_page()
loop would be doing the opposite, albeit less clean.

I don't feel strongly either way, but I slightly prefer the latter.

> 
> Thanks,
> Kanchana
> 
> >  put_pool:
> >  	zswap_pool_put(pool);
> >  put_objcg:
> > --
> > 2.47.1
> 
> 

