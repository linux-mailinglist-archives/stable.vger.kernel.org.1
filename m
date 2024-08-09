Return-Path: <stable+bounces-66139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794594CD52
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F02B2136A
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066BD1487FE;
	Fri,  9 Aug 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dlX4/Odm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DFBA41
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195835; cv=none; b=e6YtEbV9RWqnNBLOUQSWcsQnkH3Crvp8suJFkVBsH10dC7gSGn43gbb57WdErswkkCayW1ilWmAXwpcmky8QYywJhqNXz7KjT1rvgDmnQlcnIW1x+B/qzcmlcTvNPJlYhcEEvhwQR93YmtuKkQPOwt2hGgJvRCND8/N9Q+osmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195835; c=relaxed/simple;
	bh=tdmaRs6BNYebtw8XNYqPvj2lWnzQ4DIdWp18QivOHtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCDW5iOGYVJ2SwykE9uWo9Pnhwoo2DSAkpNFbm311a4gD1uxTxqrCGjmYjdDEg2CgiPPWwJt1FtkUY3aGcwle31mMNbTWLKiUNai6dHbktzcM9cqszvI+u42TZ873LDjLBdVpsSeF+jZ5NfPGK4+2/azko2nQfZK5J6JYaw5xVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dlX4/Odm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so2052651a12.0
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723195832; x=1723800632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d/kZ1LJefavLTlQyNFcMmpoYpJe8zxqltVX08slcKI=;
        b=dlX4/OdmS5NS8keucXPOlliyHg0rVRqAXuZdXtvUw5MKtz8aFXXoZ4GFNMSHgiXcQT
         bJulFOhy7Vcnp0UWH4vMRbIBDMl3uQspLxGiJChbGt7vh4Ol9RZ6krx2oFnBOY+1uxOg
         +fpn7xZzbTNPBst4/tCTvAamIOzwHzkRz6+8Ta4Fa5f/c75oMv6Wb8npXoDv2mSYR/mf
         oMTiKEWB0VLZGKKWPXyEnqWebFEkbjSSJKUwomN5OcTJ+xtgyPIbInE7K3hM4LPibw2H
         EVFmxAKQgA0f1FCMM4bkxaM/iT1a1vmZHDA0EBkQbw+MSgcroqLhJltiUI59tR8xPTH5
         0RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195832; x=1723800632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d/kZ1LJefavLTlQyNFcMmpoYpJe8zxqltVX08slcKI=;
        b=hQ7UA/MB05qJUw2eZ1EVZIzSrGFH42oTPK6zeIdAUV5SQdp5upZ25/quVslAoaEB4P
         jYY7n+fXIcZP9dOLKwNK1WK+hVTw0etN4f5dQtLQamDqVV1AYIhCZQa848w0xYqGEdPG
         1o19YTDu7Jft1/LprFsaVlgRZQjRwJjoX0PnjUCbGCWszvre1+ufiUnUM02pCKVCFXJI
         i6TMMNKLe7EQOs0rNAXo0J9s48RXGXjXyJVb8YBoWa5493eUHaCJHIC4og8FYre+gBXp
         Z5lm7z61ZIrCrLBEbgytU1NXrtXzTId/UU8DHZ/LY7iglhI+yelXE9kQUQ5oclEjeAdu
         asxA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8G55izYkZ055ztbq4+lj9sT5Pt/efU67jdPCLRrGnwChVTd+PPI2q08Ruz8HRc2eEuzU+fBFfT86co12Eh+f2C4xjDjl
X-Gm-Message-State: AOJu0YzjBQBUhIGspyI84AAHpHBcurVPLNnB9cvN1bxptQ9+Da8GL6DU
	/9ri90sipemoyHyHNvEVv55ifHbCLXbw9sQhaQlJn6uGxyQAMhchGyJCApFPN7A=
X-Google-Smtp-Source: AGHT+IFjC0qy3uP2+neAGLE+UMB33qAmjbX/Sw9++k7wwZlr+KvlaqHUFcj9ClAk+hM2cAgKc+ddNQ==
X-Received: by 2002:a05:6402:1913:b0:5b9:df62:15cd with SMTP id 4fb4d7f45d1cf-5bd0a6a554fmr766291a12.32.1723195831962;
        Fri, 09 Aug 2024 02:30:31 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1f0b2sm1370175a12.28.2024.08.09.02.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:30:31 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:30:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Tangquan . Zheng" <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1] mm/vmalloc: fix page mapping if vm_area_alloc_pages()
 with high order fallback to order 0
Message-ID: <ZrXhtprBHew7SL_v@tiehlicka>
References: <20240808120121.2878-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808120121.2878-1-hailong.liu@oppo.com>

On Thu 08-08-24 20:00:58, Hailong Liu wrote:
> The __vmap_pages_range_noflush() assumes its argument pages** contains
> pages with the same page shift. However, since commit e9c3cda4d86e
> (mm, vmalloc: fix high order __GFP_NOFAIL allocations), if gfp_flags
> includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> and page allocation failed for high order, the pages** may contain
> two different page shifts (high order and order-0). This could
> lead __vmap_pages_range_noflush() to perform incorrect mappings,
> potentially resulting in memory corruption.
> 
> Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> kvmalloc(2M, __GFP_NOFAIL|GFP_X)
>     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
>             vmap_pages_range()
>                 vmap_pages_range_noflush()
>                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> 
> We can remove the fallback code because if a high-order
> allocation fails, __vmalloc_node_range_noprof() will retry with
> order-0. Therefore, it is unnecessary to fallback to order-0
> here. Therefore, fix this by removing the fallback code.
> 
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> Reported-by: Tangquan.Zheng <zhengtangquan@oppo.com>
> Cc: <stable@vger.kernel.org>
> CC: Barry Song <21cnbao@gmail.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/vmalloc.c     | 11 ++---------
>  mm/vmalloc.c.rej | 10 ++++++++++

What is this?

>  2 files changed, 12 insertions(+), 9 deletions(-)
>  create mode 100644 mm/vmalloc.c.rej
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..af2de36549d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			page = alloc_pages_noprof(alloc_gfp, order);
>  		else
>  			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> -		if (unlikely(!page)) {
> -			if (!nofail)
> -				break;
> -
> -			/* fall back to the zero order allocations */
> -			alloc_gfp |= __GFP_NOFAIL;
> -			order = 0;
> -			continue;
> -		}
> +		if (unlikely(!page))
> +			break;

This just makes the NOFAIL allocation fail. So this is not a correct
fix.

> 
>  		/*
>  		 * Higher order allocations must be able to be treated as

-- 
Michal Hocko
SUSE Labs

