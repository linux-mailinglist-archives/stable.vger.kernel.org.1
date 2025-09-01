Return-Path: <stable+bounces-176826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A43B3DF5D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5533017E96A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625430DEB4;
	Mon,  1 Sep 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvzZEtnf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270630BBBB;
	Mon,  1 Sep 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720842; cv=none; b=HEomKJJJJF61eqHIVrSEbVUQ2I+/f8sDzmsNLTjvfa/xu/ytKDMcP7T/op+aidqYhqhDynvB6bX+AVBc/byZv23WL0QcIPn7xPsm4HLYqBbI9a5jCb4naEOU/nPUgskk4Bm68npgCL7z1IwhsvmXCZSFOmzlQ2yd0lgrAtlMe+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720842; c=relaxed/simple;
	bh=xdBpXog1GiRP0Q+r7/o6p9y3+5U7IVokkzzpPYFL7aM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyK0HS0G2SsgXwVEiamG9tyLPEeBIM+OO15hrwE+aK/lBQaAav+LhF19DqwY0O1+MiKQdMPxVexxL1aEY3l1gAyBQm/YwKQH+GYGpCC3KfIWe2woqgvLQqq8Xn3JOy024684bWNHlymI4D0JNfyPOXupS2jTeI7vb/hodkKmxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvzZEtnf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f646b1db8so3785745e87.0;
        Mon, 01 Sep 2025 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756720838; x=1757325638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbZ25W8iCAPDZ+e84V/asPNaTiH1EdBFg9Cchs0HHvk=;
        b=GvzZEtnfEK9ikObrXvTXVe5HLeSNzcyvSRkVswB953Tyb4FsZaGYgID/exRzr2UT1i
         KqbILSDhnPewR7gyCdG2SkRkbAj/AHB2j98VOy60IPJy/ACyhnAmgnBErczaq2m5mN0c
         Skqb2ir5yVLomTW4ZObgk6bHAtd1RG/gAGEhAz6LHDPnMgr6QIsakB7OqEHi1I2LENE+
         59wmBM/d57j8+MmMCNUARAQlXPncHtWUJ9mVU6jiNv98b7q7bf0vPhSgGQiGdMn9S4vj
         luuQCf94Y5L3EFF0Dqbj04v74Dx26X6ROdJ+ga5VGpA1pvPstsaOTzgXSL68KWRLkctT
         +yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720838; x=1757325638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbZ25W8iCAPDZ+e84V/asPNaTiH1EdBFg9Cchs0HHvk=;
        b=XMJQjBEoRqPfutGparL0hf5wkauZdLF7YuH71H5gA3ZwkUClqEHEwchzsPKgTndacU
         kNuzwgu7O7u4c6X/jChK7N2b/0K3tYH6Apj6KkR+KHMHz4+cz4R3jBE7XqoWwgzoFE14
         o6o9epFT1y44lWVQeiKS3fX2B80oeqIbOVzXCuE7y9qe5q6hKlyWvwRVJmJk9D0RTLhJ
         inibd/P5ANQvhTaA1UtTH3RykAeX6oQhieSjb8NvA6Xe1QUGWidQokOnnfx/sYAvPaMH
         5EZNZHtdw4pUcz9hEoMLGWOYU3nkbI0s+2OC169L6Jczpcfyy5JWrh49XCqLYORHaNqW
         /u6A==
X-Forwarded-Encrypted: i=1; AJvYcCUr9yFYl7gviu3Y2ayV+l/DZ0W4XorNe7vld8NisZ4AHb/jg8UPzUvVyUIo9cdtxdUwpWqegw6I@vger.kernel.org, AJvYcCVvr3bnOIV2obg4/++eSi1fUDMovmaWW506kRryulx5PRgorFregNPjp3RQ8iGzPZnv2IokTHrZjvWTZmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AtdPDy+iT1RYXCJ/2FsIl0OpoNdVD6cSzsKDH8GFWfBS5Qrf
	xP1WqyfoTa+xCRRNQJ72HsrENaD9c4NPJ8nz7vLTNNsqAI7zvfkFKPGXzl2Yhv4Q
X-Gm-Gg: ASbGnct5XmufOvk7UhKfn8Tf+eGXVCSFD2YS+ebN8xRuikGUW/Ox9Mb2pxB3sH5VdxL
	sz/RKMrIirzWkBcMAcKrDvDjwbm1Sfg+BabELQF4J5TivUjz/vi7AErR/VcOAL6l3EFEQYqh0CE
	MBqxNOdflLNYYeo7XYzwZNRfC2oeUxOHU54CeyIGvJbLcKCYGgwtgsVB7M6Lg96lf8kESFFlGaP
	VYFSQnlh8wnSFpbmAZ/A40EEADX60Su2tqJAaRSQg2snGlsWgNPo2oZ1/znM/dzxjfKPh9q6nj2
	4nUkN4a4lH0q79P3OmBY20uqUPc7DFPDwYCAv9TDmUflIDzhSuRox84gsVAlGIog/v4buEGuuDR
	+63vUOyT13k29m95Kl99Vk7kfCFdx
X-Google-Smtp-Source: AGHT+IEkJWQKPGB/V5gDesXHhU7t+HLT3boR3bVvrdNVX0y2aL9Wqfy8sEgiMLTdUoIHPa1mK7qSCQ==
X-Received: by 2002:a05:6512:b97:b0:55f:4e18:c583 with SMTP id 2adb3069b0e04-55f7099a326mr2203573e87.56.1756720838021;
        Mon, 01 Sep 2025 03:00:38 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6ff236efsm1951003e87.1.2025.09.01.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 03:00:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Mon, 1 Sep 2025 12:00:35 +0200
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLVuw2UkYUcL_Oi0@pc638.lan>
References: <20250831121058.92971-1-urezki@gmail.com>
 <20250831122410.fa3dcddb4a11757ebb16b376@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831122410.fa3dcddb4a11757ebb16b376@linux-foundation.org>

On Sun, Aug 31, 2025 at 12:24:10PM -0700, Andrew Morton wrote:
> On Sun, 31 Aug 2025 14:10:58 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> > and always allocate memory using the hardcoded GFP_KERNEL flag. This
> > makes them inconsistent with vmalloc(), which was recently extended to
> > support GFP_NOFS and GFP_NOIO allocations.
> > 
> > Page table allocations performed during shadow population also ignore
> > the external gfp_mask. To preserve the intended semantics of GFP_NOFS
> > and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
> > memalloc scope.
> > 
> > This patch:
> >  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
> >  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
> >  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
> >    around apply_to_page_range();
> >  - Updates vmalloc.c and percpu allocator call sites accordingly.
> > 
> > To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Why cc:stable?
> 
> To justify this we'll need a description of the userspace visible
> effects of the bug please.  We should always provide this information
> when fixing something.  Or when adding something.  Basically, all the
> time ;)
> 
Yes, i am not aware about any report. I was thinking more about that
"mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc" was incomplete and thus
is a good candidate for stable.

We can drop it for the stable until there are some reports from people.
If there are :)

Thanks!

--
Uladzislau Rezki

