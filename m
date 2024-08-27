Return-Path: <stable+bounces-70348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26695960AE6
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351261C21F4E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E81BC9EE;
	Tue, 27 Aug 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRJ8/Eq7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A71BC9FD;
	Tue, 27 Aug 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762858; cv=none; b=CVdxJJ8hjPSLfCcZQ620oUkbO3PbfQf/auCzCQQ20zayTiESNi6fz2PillkJXK/csRS6lm+KdQRn/5boUR3wiUHeZLXrcBCxIb4idEkX26tcN3g6iLX3G+77hAnuiyyJKjQBUZF8Qq/dpYFR0D2jm117I3mUwoxCCsfBXiLhWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762858; c=relaxed/simple;
	bh=2Gk8PZbMT6/gqj4CAJeNZFNHkhDwFprEuUlxugkVmFg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQe4Lj9nLKfMspbVge9W1MPiUqrqBlf+iqcN4lnV3bFYzeLQjH5gHtcn38seSNHAEcPtC708UBeb4wWkIr2D0VdqBD1YgBLzhs/gwyQnGrK+HdMMafINhLIqjm3J7K0/GHwzODSb98tGtHHG6FrHX/9Zq8aIj4aN4WDkh1OjJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRJ8/Eq7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f2868783so50065701fa.2;
        Tue, 27 Aug 2024 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724762855; x=1725367655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTsY1OQvaQ96+WTh0hHjByyS4uHxvasMiB+TQotf8Dw=;
        b=WRJ8/Eq7lCLUaCPrPnH576faB/JCpKS+22Hmt8iD5N9q4lQzHuMOqucXG9D4bTL1sW
         GXHqyKUldS4sJgHAeVRNKVlMjsiF9F/C6MsyrOaD9YNUSBVMd+jMgmmx70gWyaXmXMsN
         V5I8eZvDhX8J+HxjXfJtOhH7iB6dUSUQVHH9e/+iQHGZpF+pD+ScY9D8OQxiKgWfik2X
         bcp+5ICcED1L4mDf5u6W6+xhiNUjGJzLfOFI3KRMV0h6zDv7DTTcel+8bLRuCGp9EGCu
         QaxKWYDoUROUngAlmvdMSbadlQHU6gi8o4zJz//YWEA7ykcIaZe4sIrtLMMVRFbxGkV3
         pguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724762855; x=1725367655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTsY1OQvaQ96+WTh0hHjByyS4uHxvasMiB+TQotf8Dw=;
        b=pmDzNp89OKOnqSEhqZGfhCRQQiQEgy+lD/3AoMcuhoh6ycO0quxUMb9yGi66UH+alj
         D4cvWDJkyk4osUiybVTU0tQuarhSJQMEYnHbZotkFdErNBqMZCs0fctD/sv4Vb3cAIcM
         YhhNBB2xb8EivDGp3c4NNQKipITHZFXM4QVPN0jy3+wP/rZ1la/h0LEFmCFcwOvZ8xWx
         SnKH3nVtSinBk8KABPWJeSJMnZexzUXQ3//wdmjYM4XaEKmCJtxkpEUOd22/R+vX2HQx
         oChWM4bhZBSdVXuXUF2eSXGzhLlnUIyL1Pmqzq3mSyGXCnIrkgihNc1+wjlgfYs7Ngf9
         V44g==
X-Forwarded-Encrypted: i=1; AJvYcCXc+eM6tQP3nrDwajQMlvnc22UyIoQ2DoyFul/1BUMHDDSQl8gNMwklivspEvQPzcGirwFOLu1G@vger.kernel.org, AJvYcCXvE5+6q63UrdrH/m+Q8uCXrtvO0EO9M32r2WytdsmzjziRufuvLxsmeHh+OulcXd+Gfm6u0YcDZ2FmcPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTk/W1/4o1UviAraV8LHl4KhKkhBMEsoYtiCuC9qVjlieWey1B
	cAb3djvxevKaDfTKPUYs2wvS28Hp5Xts9KQ1PBN0kucyQ/vXO4kESOjNuA==
X-Google-Smtp-Source: AGHT+IFpmby8qEhRSQcb+/YF//pOeyUg9yGHuBr9W9k2QuOxSz9CDjC9ConH0eXNYDwRzCMuNXSLmA==
X-Received: by 2002:a2e:4e11:0:b0:2ef:21b3:cdef with SMTP id 38308e7fff4ca-2f514a44caamr17878701fa.25.1724762854290;
        Tue, 27 Aug 2024 05:47:34 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047defaasm15320271fa.66.2024.08.27.05.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:47:33 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Aug 2024 14:47:30 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zs3K4h5ulL1zlj6L@pc636>
References: <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
 <Zs12_8AZ0k_WRWUE@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs12_8AZ0k_WRWUE@tiehlicka>

On Tue, Aug 27, 2024 at 08:49:35AM +0200, Michal Hocko wrote:
> On Mon 26-08-24 14:38:40, Uladzislau Rezki wrote:
> > On Mon, Aug 26, 2024 at 09:52:42AM +0200, Michal Hocko wrote:
> > > On Fri 23-08-24 18:42:47, Uladzislau Rezki wrote:
> > > [...]
> > > > @@ -3666,7 +3655,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > > >  	page_order = vm_area_page_order(area);
> > > >  
> > > > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > > > +	/*
> > > > +	 * Higher order nofail allocations are really expensive and
> > > > +	 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > > > +	 * and compaction etc.
> > > > +	 *
> > > > +	 * Please note, the __vmalloc_node_range_noprof() falls-back
> > > > +	 * to order-0 pages if high-order attempt has been unsuccessful.
> > > > +	 */
> > > > +	area->nr_pages = vm_area_alloc_pages(page_order ?
> > > > +		gfp_mask &= ~__GFP_NOFAIL : gfp_mask | __GFP_NOWARN,
> > > >  		node, page_order, nr_small_pages, area->pages);
> > > >  
> > > >  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > > > <snip>
> > > > 
> > > > Is that aligned with your wish?
> > > 
> > > I am not a great fan of modifying gfp_mask inside the ternary operator
> > > like that. It makes the code harder to read. Is there any actual reason
> > > to simply drop GFP_NOFAIL unconditionally and rely do the NOFAIL
> > > handling for all orders at the same place?
> > > 
> > 1. So, for bulk we have below:
> > 
> > /* gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL; */
> > 
> > I am not sure if we need it but it says it does not support it which
> > is not clear for me why we have to drop __GFP_NOFAIL for bulk(). There
> > is a fallback to a single page allocator. If passing __GFP_NOFAIL does
> > not trigger any warning or panic a system, then i do not follow why
> > we drop that flag.
> > 
> > Is that odd?
> 
> I suspect this was a pre-caution more than anything.
> 
OK, then i drop it.

> > 2. High-order allocations. Do you think we should not care much about
> > it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> > if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> > keeping NOFAIL for high-order sounds like not a good approach to me.
> 
> We should avoid high order allocations with GFP_NOFAIL at all cost.
> 
What do you propose here? Fail such request?

> > 3. "... at the same place?"
> > Do you mean in the __vmalloc_node_range_noprof()?
> > 
> > __vmalloc_node_range_noprof()
> >     -> __vmalloc_area_node(gfp_mask)
> >         -> vm_area_alloc_pages()
> > 
> > if, so it is not straight forward, i.e. there is one more allocation:
> > 
> > <snip>
> > static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > 				 pgprot_t prot, unsigned int page_shift,
> > 				 int node)
> > {
> > ...
> > 	/* Please note that the recursion is strictly bounded. */
> > 	if (array_size > PAGE_SIZE) {
> > 		area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
> > 					area->caller);
> > 	} else {
> > 		area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
> > 	}
> > ...
> > }
> > <snip>
> > 
> > whereas it is easier to do it inside of the __vmalloc_area_node().
> 
> Right. The allocation path is quite convoluted here. If it is just too
> much of a hassle to implement NOFAIL at a single place then we should
> aim at reducing that. Having that at 3 different layers is just begging
> for inconsistences.
>
Hard to not agree :)

--
Uladzislau Rezki

