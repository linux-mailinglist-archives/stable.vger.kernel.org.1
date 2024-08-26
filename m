Return-Path: <stable+bounces-70220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994E395F18D
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5043E2814A9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F1189B90;
	Mon, 26 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip3KphGJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9C17A938;
	Mon, 26 Aug 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675928; cv=none; b=Yj+sQIjuk6QyI7mB6YwS0esRRbhIzM/2CxnCPwYEIv7MVb98LQzcM4oDy1lB1IG14OuX1gXbqPRC0RPppCSVyYuaZU2wmiT8Fv3VliTYqA3AV5LLLCsHz4jEv/7/PHDRFd+PA4L+PDTMLcgnCxmab5qnCsoZUqRLM8g5yAcVkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675928; c=relaxed/simple;
	bh=dJdnZ5ljiYzon9wlR3qO7rVKiFeex5Y4ZkIv7cXssrI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKqKVbfXanPN6rUnV2vH4+m2d4OJgifQ/DD8aoGzFXU3UBvZi+k/HSpWbbm0AsTSZDdN2qdxuCEUJPZF7pdR31efOj2ux5J2ozkulI5HSOKMRtf/LFGyS3IBGlZhQnM3CD2glCn6xYvET8ifQ0voV6j/9u8aHOBNATo+4PU61Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip3KphGJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53349ee42a9so4997929e87.3;
        Mon, 26 Aug 2024 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724675924; x=1725280724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUcKfLAym9RgJQXf8u4aRWq8QimdjCW4ky2IF0nSbXY=;
        b=Ip3KphGJhcaVIt7lANtbtLdk6Ttvv+AtZZkX9khEj4PhPUzcjhy53XutdRZT7o3cRm
         f2S87nd7BA/S4lm2i3oUoKLvyP5FHRQ+ZsXMfVOgoq0rmbZtEwX17rYkFBXdZJv0pTt6
         jSaXAVwZ9fQSWgDSAEPdUAeV5HXjGlIq0aqIXBTfOjhm1LwJo9vGEOR8ypKNePew84hY
         khY6I2WuRPZlj0+2N5znnWm8Wwp/sqRDZm0O8b/tLqTNxZ+IkR7ZId1VwsDbSmKnZWNK
         /Q1GYoZ7R99WLwaDJgGqdRa9aGpS0rlxN12mWgO8sUbQVPYUIoNJUO+0XHi3aW/dQaj6
         473w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675924; x=1725280724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUcKfLAym9RgJQXf8u4aRWq8QimdjCW4ky2IF0nSbXY=;
        b=JeedOsRwwPcFD550nXtSIldIf81ILatZnciN4K4umzNOh4lhCwAGUE+zVWSHZjTCFG
         gjp7ZZ5W8xDVkXWQWwMmksIRm22f8/pbNhP2IPXKTXBfWf4sRnFfRU1kX6anVx/PWjiW
         SHqWjJtkbD/oFAY7mDG2snQmwq0IjyRc3N8B1djJkGIL6skgzvvHMRyH7epmNRRDmlwU
         2Cm9mC8xOhgi7tBnRcX16bw1XLVaSdZfcHmE23QvtG+c9FHL4n3kccNKFPKho9NlHFJt
         adyWzMr9Mwc64qHPt7yeFeoao6oK7YJlMKaLQp6pDh1a9qizVt5ozzxcJ/7jKg82+V2t
         /gug==
X-Forwarded-Encrypted: i=1; AJvYcCWfMyaRl1cctXvBHU2qTF8Nbi9dYTxX3qFEFBZpuWHnQFGyvaQ7yKXLHg6m8DNTddr3bctTIkNe@vger.kernel.org, AJvYcCXIkGNMnUqUpxHrZSltrxB7RaXmyb1I43kicu7hPOgOKYmsVCJOjFRpLX2ZFCSf4dhAXt36gVEVhG/wPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtotQl2Q21EITNCo+LU/zpQ+aIQ1NKGPGwRMYMsR2E+9Y1AXu
	ihdYelMoW0XBPP/I7nE1YUNdYJF8M+AsexCrUg+Vz4NKBgGEQU9k
X-Google-Smtp-Source: AGHT+IGbTf+VsX5gFBfM6+4OipwiFcXtyiVl/tjE1rJLDp+pQs84mlRaqWOBgLukkLBlHENEQ2VlTA==
X-Received: by 2002:a05:6512:1285:b0:533:4642:9e06 with SMTP id 2adb3069b0e04-53438785875mr6312303e87.34.1724675923455;
        Mon, 26 Aug 2024 05:38:43 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea2959fsm1502393e87.43.2024.08.26.05.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:38:43 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 26 Aug 2024 14:38:40 +0200
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
Message-ID: <Zsx3ULRaVu5Lh46Q@pc636>
References: <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
 <Zsw0Sv9alVUb1DV2@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsw0Sv9alVUb1DV2@tiehlicka>

On Mon, Aug 26, 2024 at 09:52:42AM +0200, Michal Hocko wrote:
> On Fri 23-08-24 18:42:47, Uladzislau Rezki wrote:
> [...]
> > @@ -3666,7 +3655,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> >  	page_order = vm_area_page_order(area);
> >  
> > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > +	/*
> > +	 * Higher order nofail allocations are really expensive and
> > +	 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > +	 * and compaction etc.
> > +	 *
> > +	 * Please note, the __vmalloc_node_range_noprof() falls-back
> > +	 * to order-0 pages if high-order attempt has been unsuccessful.
> > +	 */
> > +	area->nr_pages = vm_area_alloc_pages(page_order ?
> > +		gfp_mask &= ~__GFP_NOFAIL : gfp_mask | __GFP_NOWARN,
> >  		node, page_order, nr_small_pages, area->pages);
> >  
> >  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > <snip>
> > 
> > Is that aligned with your wish?
> 
> I am not a great fan of modifying gfp_mask inside the ternary operator
> like that. It makes the code harder to read. Is there any actual reason
> to simply drop GFP_NOFAIL unconditionally and rely do the NOFAIL
> handling for all orders at the same place?
> 
1. So, for bulk we have below:

/* gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL; */

I am not sure if we need it but it says it does not support it which
is not clear for me why we have to drop __GFP_NOFAIL for bulk(). There
is a fallback to a single page allocator. If passing __GFP_NOFAIL does
not trigger any warning or panic a system, then i do not follow why
we drop that flag.

Is that odd?

2. High-order allocations. Do you think we should not care much about
it when __GFP_NOFAIL is set? Same here, there is a fallback for order-0
if "high" fails, it is more likely NO_FAIL succeed for order-0. Thus
keeping NOFAIL for high-order sounds like not a good approach to me.

3. "... at the same place?"
Do you mean in the __vmalloc_node_range_noprof()?

__vmalloc_node_range_noprof()
    -> __vmalloc_area_node(gfp_mask)
        -> vm_area_alloc_pages()

if, so it is not straight forward, i.e. there is one more allocation:

<snip>
static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
				 pgprot_t prot, unsigned int page_shift,
				 int node)
{
...
	/* Please note that the recursion is strictly bounded. */
	if (array_size > PAGE_SIZE) {
		area->pages = __vmalloc_node_noprof(array_size, 1, nested_gfp, node,
					area->caller);
	} else {
		area->pages = kmalloc_node_noprof(array_size, nested_gfp, node);
	}
...
}
<snip>

whereas it is easier to do it inside of the __vmalloc_area_node().

>
> Not that I care about this much TBH. It is an improvement to drop all
> the NOFAIL specifics from vm_area_alloc_pages.
> 
I agree. I also do not like modifying gfp flags on different levels and
different cases. To me there is only one case. It is high-order requests
with NOFAIL. For this i think we should keep our approach, i mean
dropping NOFAIL and repeat because we have a fallback.

--
Uladzislau Rezki

