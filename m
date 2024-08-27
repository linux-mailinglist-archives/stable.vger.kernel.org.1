Return-Path: <stable+bounces-70300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EAA96023C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82175285607
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 06:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756014659A;
	Tue, 27 Aug 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dcpLicI1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20910A3E
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741380; cv=none; b=NjppY17BHMT3/1YWtAX4GnF9ozjvLAfAGy5eJ8TIQu1FvUw++z1oXzyKujUTVY04f1mZWqcb/Z+rUjkM7faiXW1jpX0BTZVfEcB43gqxRctCiXMYl4cwoJXNhCpfG5Uyvo4iTIe0EDGM+QukEjt2Rd1Kw/y+IABxg/xG2/wFM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741380; c=relaxed/simple;
	bh=7HWr9j5eKfZPszNvP2TblmnYYnWh07niu4cy+zDMGzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYOBXsOPfzFVFQ1/VT0Fat0yNW3pq+YEIsk4pbpPDT8URRgB+EQ2Blfy8dZT1MqnXKASD6dzbCiAdYQINvPXoOim/L3wEo1Tr/Lh71WkLPsEIDU9sNpZdixvVXBfOIxW/UG3Sg7p1OL0K1SxWF8BuwKbokl1m8E8XRLs+UpbKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dcpLicI1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8695cc91c8so541748466b.3
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724741376; x=1725346176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqtpVWY8T6ecoXnDsB9l8HlClxrmCb3D7K0NvHPEgqM=;
        b=dcpLicI1wyEHcTnF+S7lub7AxszxXN+RIO9iYu774U/GS6plsHpx7rqbRzrm5k6fLA
         ND/0q7ULZSXYW82yNAxN604fnDEGsfGoxryd6FWSoNuoicHpjJ5MyR8rYJ362v9pR+96
         3aZ5pQZvLLT+FO9E3lIrnPmG4KolUOoakX2tM6aZpUOW2G021hclbyY+7AE1VqUs3zlJ
         mrpM7r3/7fmGXBDt9awmwIL5fX8QOfJxPl5RnXMZ9QG7PhMMWwmnUKBIg9wHJh8Bf6Z5
         Yr0Vg1ABS3VUgZCVBTyx4DQw2P9EfDEv0RLxpxiVs7jKgA7dm/OEBZUtBhaHQSGX+mrc
         3/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724741376; x=1725346176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqtpVWY8T6ecoXnDsB9l8HlClxrmCb3D7K0NvHPEgqM=;
        b=MpMW+LQFC2YzLVSliaH13yaLqiUgVaujsO8M1pxrq2gAYsAZuDaS7mxngbnQIQc4c5
         aJOnrjJGCzXPXvR9TiqCxAL0un7toCHGkxHD7Yu4yzyKtVij1H8YmeGvxeQNkc1SXVRz
         XtDov64XC8OKaKArvXOlYp8ItD9W6rHsaFxeJhUHVDwWk7cK5OK6bxmof8sZD9SIQSE1
         Im3gVriciUR6axnmmeBtaLtZfIsXyhIfc46SelGfk3jd2OI3yF//0aJQ1Jm7eYSGMkCw
         dEKgULb7do58oaSHw+wOc3PP/GlcKT76iGvrY9qDQCb6bk0gL3eJlv+/9htb8wnU/EMx
         tAjA==
X-Forwarded-Encrypted: i=1; AJvYcCUpGNW2k8yPc9If5VlljxZn2MrycW2Yp990XV31ZIPQo9FC34k4k3hrN94ARtlishQ+rsGoZx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2iAx6t0nieZ4ctNoRPZ/C7+zMxaDqjgmHxi+8Ik338keBeMC
	M66RjLoCTJWuy/lDahPdnaTCW+QKY+2phbINrpMryYF3bOaeCEa/VL2GteS0vsU=
X-Google-Smtp-Source: AGHT+IEQaDxUQ/mlcLiBRdVgUBiBvE1qUZl0Y74jY/67JgEu7wmyQfM1VHkIQX+Tr0cFaJ7OOxTEPw==
X-Received: by 2002:a17:907:6d0a:b0:a86:7c5d:1856 with SMTP id a640c23a62f3a-a86e3be5c89mr137351066b.46.1724741376203;
        Mon, 26 Aug 2024 23:49:36 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582c41bsm69699366b.98.2024.08.26.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:49:35 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:49:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zs12_8AZ0k_WRWUE@tiehlicka>
References: <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
 <Zsx3ULRaVu5Lh46Q@pc636>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsx3ULRaVu5Lh46Q@pc636>

On Mon 26-08-24 14:38:40, Uladzislau Rezki wrote:
> On Mon, Aug 26, 2024 at 09:52:42AM +0200, Michal Hocko wrote:
> > On Fri 23-08-24 18:42:47, Uladzislau Rezki wrote:
> > [...]
> > > @@ -3666,7 +3655,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > >  	page_order = vm_area_page_order(area);
> > >  
> > > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > > +	/*
> > > +	 * Higher order nofail allocations are really expensive and
> > > +	 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > > +	 * and compaction etc.
> > > +	 *
> > > +	 * Please note, the __vmalloc_node_range_noprof() falls-back
> > > +	 * to order-0 pages if high-order attempt has been unsuccessful.
> > > +	 */
> > > +	area->nr_pages = vm_area_alloc_pages(page_order ?
> > > +		gfp_mask &= ~__GFP_NOFAIL : gfp_mask | __GFP_NOWARN,
> > >  		node, page_order, nr_small_pages, area->pages);
> > >  
> > >  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > > <snip>
> > > 
> > > Is that aligned with your wish?
> > 
> > I am not a great fan of modifying gfp_mask inside the ternary operator
> > like that. It makes the code harder to read. Is there any actual reason
> > to simply drop GFP_NOFAIL unconditionally and rely do the NOFAIL
> > handling for all orders at the same place?
> > 
> 1. So, for bulk we have below:
> 
> /* gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL; */
> 
> I am not sure if we need it but it says it does not support it which
> is not clear for me why we have to drop __GFP_NOFAIL for bulk(). There
> is a fallback to a single page allocator. If passing __GFP_NOFAIL does
> not trigger any warning or panic a system, then i do not follow why
> we drop that flag.
> 
> Is that odd?

I suspect this was a pre-caution more than anything.

> 2. High-order allocations. Do you think we should not care much about
> it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
> if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
> keeping NOFAIL for high-order sounds like not a good approach to me.

We should avoid high order allocations with GFP_NOFAIL at all cost.

> 3. "... at the same place?"
> Do you mean in the __vmalloc_node_range_noprof()?
> 
> __vmalloc_node_range_noprof()
>     -> __vmalloc_area_node(gfp_mask)
>         -> vm_area_alloc_pages()
> 
> if, so it is not straight forward, i.e. there is one more allocation:
> 
> <snip>
> static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> 				 pgprot_t prot, unsigned int page_shift,
> 				 int node)
> {
> ...
> 	/* Please note that the recursion is strictly bounded. */
> 	if (array_size > PAGE_SIZE) {
> 		area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
> 					area->caller);
> 	} else {
> 		area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
> 	}
> ...
> }
> <snip>
> 
> whereas it is easier to do it inside of the __vmalloc_area_node().

Right. The allocation path is quite convoluted here. If it is just too
much of a hassle to implement NOFAIL at a single place then we should
aim at reducing that. Having that at 3 different layers is just begging
for inconsistences.
-- 
Michal Hocko
SUSE Labs

