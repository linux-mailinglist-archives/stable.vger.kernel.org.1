Return-Path: <stable+bounces-131840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E70A814F5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB35C19E4012
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14623F411;
	Tue,  8 Apr 2025 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="dBa6NX0t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5431D23A562
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138218; cv=none; b=nc+dzPgD3wVn+yRLk8hxYyWICazbybap2vy1biD0P5SIqGGm0DMzroh2mwjEBx6v1CjwCNWXwfjTcQoaGQEMb3vxoPlIZjpCLpRXovxV6ASbYByLLfyMLn1YD++ZNNQeyZ2vienPFKzXGGnovY6zjSebM6w20gt8aI5tV4y0eOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138218; c=relaxed/simple;
	bh=7tq6qaJMbHnZOnMEprQALgIh/9nLaUKXPKzYdt7v+CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnBRnQBlKWSPUE5B90YbY/5JDkuLqGPglhK7E5eBDQYIG2KzfAJVTG2lpgWXI1YWawCVTm/Rc2FzWrN5XVw/iAD/cU+2nVoI43qedg2KDEgViolxTQoBRX8lPk47btqsvHaTHgUmB+1KwI0LycIPXlv9AGwzAVouRkY1UzBrLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=dBa6NX0t; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4775ce8a4b0so104447281cf.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744138214; x=1744743014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwDylyzDPsrF74vrQtby3ilZT9HGhvLa0st+FyPJEAY=;
        b=dBa6NX0tarjtThFStMeNNBRnSSGXj9cqox7iZmB80uqo8xp50jjgqDNuEXu90ag6mR
         UrBs6RgPM9Vn7x/WLHOY51mhoIVO8hgxxF+mTspM15scq9RIGbhAda0cLs+/AoDcJh5d
         7RONoGaSv249xvjObSK1vka6pFKS+jAuzrKGV4cAAU+tM7N2lZ8GiQ0UPQ19Oz20zK4j
         zgk93lp7e315fEpzBbunfibGNLYhpTyaNCitRX5BuHJn740xR6N6jT4PDwb05byOOel1
         6lWINEu7VulmE/G88qLzTLhY3rYTZc4+9kHJhIhrAlCEEz1VZZpv6SGQOsbiNjpu+7U0
         MOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138214; x=1744743014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwDylyzDPsrF74vrQtby3ilZT9HGhvLa0st+FyPJEAY=;
        b=bg6JKz7T5p0HtQLN19JwRnP5JLzJsKbth/w0wO/SYydLHl+ZXqX4mejQdfbejmLvl+
         HB6bpUwQ4jdSNcn3GYGiLUWyONG5aWKBR9A0+qbYHp2zttl11BlWL0YnRY9v4XUtK5RE
         PPPG4v1ZDOuvWpd8PQYhRyTgErnYGgFWPFGpVFksvWXEwMzgMoxWs60YJjmATOBmsogG
         TRvEYHO08HBW42XSSFjKErdfp9+Xd9yq6HEjylH8owEeVia8Z2ps0/j1FReLcGbg/eUS
         4S7iSgJcslZ2xY2kcZacH+E9Py9fd+lajxqpVcXuGLORAfp9ZOd22kWhSEPW+9aujSSZ
         vHoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvK4TjYHD6EZFyO6od/KhpeV31Q6omxBc5YT1inSiNL1EpSCiPTOwJceqDlPqOs2/GITlowJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9zDlOY/mTYBtFmm5DXSUoh64FJOULq7QNF0tJB4XDf09V68Jb
	8TpNSCZvOj+5T1540VDBW9p5oOeytJIODgppQY/U8NBZXE3+bHpOLB6fzDBg0/E=
X-Gm-Gg: ASbGncvDKyb3eIAkuPQZ/adSQqUcXV/SW7wBoUotDHkb+K5992MCcO5HFIA/cYbf11F
	urubcNjcQaEcBZTZOC9kq/p+UwyRxJ2T3aT47bgdcPnHRZ5tKefoL03iAkvy5F0bfM0GymU6l9o
	L+aaq85qKIHPcvJO3k+u2nHFxnj/tXfWnHy0GE4ga30j3iOgCIOHlHR5K8P8yMyMVIJz+JJHQyM
	3S3GdcafvqyryCbOAdBf7crIdSyc+wXYtcT1QWM3z0yESqcvLa6sgmVFGksucWSUjGJLAQbcGan
	qbOsIm3503jf5AemP2Zp8DeKSWGyy3v2Wi6SIk4nTVs=
X-Google-Smtp-Source: AGHT+IHbWilH5kMWNF4Wf7I0KGh/1NSK677mnEizu3hGba+oaeLYEvko8oaHEsEM9Yb1/YDtPtxO5Q==
X-Received: by 2002:ac8:5d04:0:b0:476:90ee:bc6a with SMTP id d75a77b69052e-4795f2e3607mr761051cf.28.1744138213965;
        Tue, 08 Apr 2025 11:50:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4791b088346sm81560331cf.41.2025.04.08.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:50:13 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:50:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Carlos Song <carlos.song@nxp.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Message-ID: <20250408185009.GF816@cmpxchg.org>
References: <20250407180154.63348-1-hannes@cmpxchg.org>
 <D91FIQHR9GEK.3VMV7CAKW1BFO@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D91FIQHR9GEK.3VMV7CAKW1BFO@google.com>

On Tue, Apr 08, 2025 at 05:22:00PM +0000, Brendan Jackman wrote:
> On Mon Apr 7, 2025 at 6:01 PM UTC, Johannes Weiner wrote:
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2194,11 +2194,11 @@ try_to_claim_block(struct zone *zone, struct page *page,
> >   * The use of signed ints for order and current_order is a deliberate
> >   * deviation from the rest of this file, to make the for loop
> >   * condition simpler.
> > - *
> > - * Return the stolen page, or NULL if none can be found.
> >   */
> 
> This commentary is pretty confusing now, there's a block of text that
> kinda vaguely applies to the aggregate of __rmqueue_steal(),
> __rmqueue_fallback() and half of __rmqueue(). I think this new code does
> a better job of speaking for itself so I think we should just delete
> this block comment and replace it with some more verbosity elsewhere.

I'm glad you think so, let's remove it then!

> > +/* Try to claim a whole foreign block, take a page, expand the remainder */
> 
> Also on the commentary front, I am not a fan of "foreign" and "native":
> 
> - "Foreign" is already used in this file to mean NUMA-nonlocal.
> 
> - We already have "start" and "fallback" being used in identifiers
>   as adjectives to describe the mitegratetype concept.
> 
>   I wouldn't say those are _better_, "native" and "foreign" might be
>   clearer, but it's not worth introducing inconsistency IMO.

That's a fair point, no objection to renaming them.

> >  static __always_inline struct page *
> > -__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> > +__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
> >  						unsigned int alloc_flags)
> >  {
> >  	struct free_area *area;
> 
> [pasting in more context that wasn't in the original diff..]
> >	/*
> >	 * Find the largest available free page in the other list. This roughly
> >	 * approximates finding the pageblock with the most free pages, which
> >	 * would be too costly to do exactly.
> >	 */
> >	for (current_order = MAX_PAGE_ORDER; current_order >= min_order;
> >				--current_order) {
> 
> IIUC we could go one step further here and also avoid repeating this
> iteration? Maybe something for a separate patch though?

That might be worth a test, but agree this should be a separate patch.

AFAICS, in the most common configurations MAX_PAGE_ORDER is only one
step above pageblock_order or even the same. It might not be worth the
complication.

> Anyway, the approach seems like a clear improvement, thanks. I will need
> to take a closer look at it tomorrow, I've run out of brain juice today.

Much appreciate you taking a look, thanks.

> Here's what I got from redistributing the block comment and flipping
> the terminology:
> 
> diff --git i/mm/page_alloc.c w/mm/page_alloc.c
> index dfb2b3f508af..b8142d605691 100644
> --- i/mm/page_alloc.c
> +++ w/mm/page_alloc.c
> @@ -2183,21 +2183,13 @@ try_to_claim_block(struct zone *zone, struct page *page,
>  }
>  
>  /*
> - * Try finding a free buddy page on the fallback list.
> - *
> - * This will attempt to claim a whole pageblock for the requested type
> - * to ensure grouping of such requests in the future.
> - *
> - * If a whole block cannot be claimed, steal an individual page, regressing to
> - * __rmqueue_smallest() logic to at least break up as little contiguity as
> - * possible.
> + * Try to allocate from some fallback migratetype by claiming the entire block,
> + * i.e. converting it to the allocation's start migratetype.
>   *
>   * The use of signed ints for order and current_order is a deliberate
>   * deviation from the rest of this file, to make the for loop
>   * condition simpler.
>   */
> -
> -/* Try to claim a whole foreign block, take a page, expand the remainder */
>  static __always_inline struct page *
>  __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>                                                 unsigned int alloc_flags)
> @@ -2247,7 +2239,10 @@ __rmqueue_claim(struct zone *zone, int order, int start_migratetype,
>         return NULL;
>  }
>  
> -/* Try to steal a single page from a foreign block */
> +/*
> + * Try to steal a single page from some fallback migratetype. Leave the rest of
> + * the block as its current migratetype, potentially causing fragmentation.
> + */
>  static __always_inline struct page *
>  __rmqueue_steal(struct zone *zone, int order, int start_migratetype)
>  {
> @@ -2307,7 +2302,9 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>         }
>  
>         /*
> -        * Try the different freelists, native then foreign.
> +        * First try the freelists of the requested migratetype, then try
> +        * fallbacks. Roughly, each fallback stage poses more of a fragmentation
> +        * risk.

How about "then try fallback modes with increasing levels of
fragmentation risk."

>          * The fallback logic is expensive and rmqueue_bulk() calls in
>          * a loop with the zone->lock held, meaning the freelists are
> @@ -2332,7 +2329,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>         case RMQUEUE_CLAIM:
>                 page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
>                 if (page) {
> -                       /* Replenished native freelist, back to normal mode */
> +                       /* Replenished requested migratetype's freelist, back to normal mode */
>                         *mode = RMQUEUE_NORMAL;

This line is kind of long now. How about:

			/* Replenished preferred freelist, back to normal mode */

But yeah, I like your proposed changes. Would you care to send a
proper patch?

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

