Return-Path: <stable+bounces-66142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B794CD77
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3130281CEC
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF9E190693;
	Fri,  9 Aug 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbMIqjAl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D77BA41;
	Fri,  9 Aug 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196510; cv=none; b=KIukBxbVeWH7R7GSMDEuJKtEq1pJg/VuN6mxeCux5Sukx7aZtaDSIajt8DWf/VTmWoWNpfmaGgBla/Fjic30AIJZpYuBiSjZw3R39LZb/G6DCDk/AybjeG+fn9hbBqcn2isKCjGtTAzbwQmh2ybAxX7FvPhEXCA1YEhDwMEvuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196510; c=relaxed/simple;
	bh=TECRTJPH0nWvIGoX3s/S8rF+s/S8bWXOdSq7Hn14Mn4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTHjgmIUwLu+9Z8UosYaqtnXllwPsr6npGl/1SArcuPkt2m/bsR6Q71RTB82sy2qoVubaaWiqYtOFtOWzjb8l36q2TTBWA3TJgn9oxurEz8GrSpTvTZQ8Z3YDA5BJiDMP+KHveV6XHIShnwTWL981duMp6DjD8msqnG/wgvlOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbMIqjAl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso20325861fa.2;
        Fri, 09 Aug 2024 02:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723196506; x=1723801306; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5iX1/IG6jtHq1Cd/wpVRMCC2IDAUkyqowaJYsLDHSM=;
        b=CbMIqjAl3bq7WSUjV4FQ877r2NpQnGd2VyoCwrNDsAJAE6lKqDOfFaOWMIXAm9uC1Q
         FlyW7WN0ZrjW/OfWE7D8b367MIjJ/Hd3Uiw2ReD3Ew1QotVgH4uedPSuzcATtsilS8Ru
         eBTVyrR/DLA0koj47Q4n0/cbdixKnYTxs6Zlt5Nh3mFgasmQfgbzgdHkxxvwwRawj4Kf
         U0P5T6quSTyk32euLeX7g9uYacThf06HnKx2n4ujEIGrQ9X7C8jEAObip1g1FUM4TGUQ
         +LgDZV+coMLxHIyPSkRJeS6uqF62R8RCzTdmdwrcK6Z4vtLjkSabViMflVn2tPlFNJ5i
         hDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723196506; x=1723801306;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5iX1/IG6jtHq1Cd/wpVRMCC2IDAUkyqowaJYsLDHSM=;
        b=fTf4aCIz00v/m3DaZXgVpvkLR+4hs3hAbosIFXeXOcyYDVCdrXFAzCRUN4ExPsTyBs
         LX+kyXKlN9qGMDQtrqkW1d1l+EEQ6Zkd5QrckVdvuUYYForM2qeBumrdEZm8rQzAHw9/
         USfT+0Kdf9Asesbg/t2L++u6wiBNlSMSm8j2cyaaZFuKiy6JqpDdG+vK7HFD9WDe1fP1
         pfFsSGjYWYhZbWTwSmFnrOWxc/sxxtz6i0qKREsi7/v8J+F/E2ZzPsUDCu9bXgpQdA+O
         WFGNsaj6PHFimUlLPF1de9OA+7cg6fNn7X3/HLacIUCgzHJZo9o3IJzn7upJc3ewTMaj
         uc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUxXqPRLHxNstvqh80uXGfI5U+ZsNhIwQWgmR5+/S6eEDXVRxnzOzw3249qtrQuSSjsaNY31Smj2YRvTasKC1sArBYy8soXmU+fwRbhkIPLA7IzUOfIVdc3VS+3v6ZpfUnQfr6c
X-Gm-Message-State: AOJu0YxNTINlnjXKJoTCjV4/ZHrqWKW11UPePfXXsTVxNyKnjT65nwMg
	uIA3k46vsHUcYB30+xpNGshUweuXg+3tJ2XWkeZoI1LBnnfPb1iL
X-Google-Smtp-Source: AGHT+IFo2g3pXbdsimxbhg0VDttWVuBRTxu5yRyePmJxDoKwFTR3KGVq1wuiMjYaImqjpz0HEpEOig==
X-Received: by 2002:a05:651c:154a:b0:2ef:2c86:4d43 with SMTP id 38308e7fff4ca-2f1a6d00286mr8914121fa.3.1723196505901;
        Fri, 09 Aug 2024 02:41:45 -0700 (PDT)
Received: from pc636 (host-90-233-216-8.mobileonline.telia.com. [90.233.216.8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1adf63sm25321541fa.40.2024.08.09.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:41:45 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 9 Aug 2024 11:41:42 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, Hailong Liu <hailong.liu@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZrXkVhEg1B0yF5_Q@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrXiUvj_ZPTc0yRk@tiehlicka>

On Fri, Aug 09, 2024 at 11:33:06AM +0200, Michal Hocko wrote:
> On Fri 09-08-24 09:05:05, Barry Song wrote:
> > On Fri, Aug 9, 2024 at 12:20 AM Hailong Liu <hailong.liu@oppo.com> wrote:
> > >
> > > The __vmap_pages_range_noflush() assumes its argument pages** contains
> > > pages with the same page shift. However, since commit e9c3cda4d86e
> > > ("mm, vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags
> > > includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> > > and page allocation failed for high order, the pages** may contain
> > > two different page shifts (high order and order-0). This could
> > > lead __vmap_pages_range_noflush() to perform incorrect mappings,
> > > potentially resulting in memory corruption.
> > >
> > > Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> > > kvmalloc(2M, __GFP_NOFAIL|GFP_X)
> > >     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
> > >         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
> > >             vmap_pages_range()
> > >                 vmap_pages_range_noflush()
> > >                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> > >
> > > We can remove the fallback code because if a high-order
> > > allocation fails, __vmalloc_node_range_noprof() will retry with
> > > order-0. Therefore, it is unnecessary to fallback to order-0
> > > here. Therefore, fix this by removing the fallback code.
> > >
> > > Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> > > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > > Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
> > > Cc: <stable@vger.kernel.org>
> > > CC: Barry Song <21cnbao@gmail.com>
> > > CC: Baoquan He <bhe@redhat.com>
> > > CC: Matthew Wilcox <willy@infradead.org>
> > > ---
> > 
> > Acked-by: Barry Song <baohua@kernel.org>
> > 
> > because we already have a fallback here:
> > 
> > void *__vmalloc_node_range_noprof :
> > 
> > fail:
> >         if (shift > PAGE_SHIFT) {
> >                 shift = PAGE_SHIFT;
> >                 align = real_align;
> >                 size = real_size;
> >                 goto again;
> >         }
> 
> This really deserves a comment because this is not really clear at all.
> The code is also fragile and it would benefit from some re-org.
> 
> Thanks for the fix.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
I agree. This is only clear for people who know the code. A "fallback"
to order-0 should be commented.

--
Uladzislau Rezki

