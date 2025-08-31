Return-Path: <stable+bounces-176756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C91B3D2AE
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07548188FD1F
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094E235057;
	Sun, 31 Aug 2025 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaPpVzAu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60BF9D9;
	Sun, 31 Aug 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756642350; cv=none; b=M0RKQ8BGXuS8bXEZIBkeSvPlAQGhYm126xXPfccrBx7NGsgncwqDCCXlTSlUXf96oW3YkXkcNTGCvsyxjjVzV/0qdbv7CzGtmSn5QV1k8ag9bnf15YbNMpBAI/B/PyPj0T04Pn68dTLB6AxuON+nCV5q12uyDDbylfwDBrmW0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756642350; c=relaxed/simple;
	bh=5BtGY5EPA4lNroYZVvbYXNMVp4bZfsHIGj+MQjrRZH0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX6XeNRE2iSLrMO5+0Xl30fXxum0j34BN8Uo1olW3sp/OWq1F+5DXaF9SAC4EapF4OJ6aWtqMKO/8iEr6lfKDgsTWDpQdXZlxqxl2yIlgabpd5M4ilxnAqLeb/9nG/ASyL2QeKkBPDnUPTQhUwM87V2JldOE6VqgxAAF9Pv+Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaPpVzAu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6186cc17so2561650e87.2;
        Sun, 31 Aug 2025 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756642346; x=1757247146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/dhVZcd5Nyq2shVbKIb+s/eIzus38d+RCiUMAwTO2M=;
        b=PaPpVzAu3YHu17P5bPD5P6cF/B8tgSljqSQlUWs2FBBAcEZgvckrA63EaRO4ss0M3l
         81II4xSMI7IkhbVHC6YFdVEDpfu32/pFOXyhTu6rKYv8Ig/BDEXFhDTQ4pVtNsYSq5In
         KEJvwFo9EVcsKDE0KMFuerQYpkLS0RMcOurpvP7Ee4i+rtSnPSeHLWn8D089EPuaZFtz
         opH6/Y7ZBF6XjfJNOPxP9q8bReJLtQMRKVN+o3wAHfsSuYrJ8sN8zNhTyZz88iDQNpsQ
         OfHQK32J89cYr5wiHnOeAtoVWni18rEGdthtLMz0bAGk/jdFTPj6UUQ/PSBvher5HXTJ
         TNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756642346; x=1757247146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/dhVZcd5Nyq2shVbKIb+s/eIzus38d+RCiUMAwTO2M=;
        b=opzg2ggpvj8J2TteMiiz3jHm3/x33KFSWeZIrA6TaT95+MkaOnFcRB2MnomOMpHLtl
         hreTax9zEm1DR2IwrPJZQiAALMawUxG88YJiHoSvEDSt/9Ba6/ekv8KcodPGjIuSrwUi
         vWoNWCg+aNcLSNJ8n4NThDS4VwY43wjHSM5OBDscE+l09OzRIpyt/W5kFjXYgCLW2b/N
         gmyDpg8GUpLGayWVlsy07Nf8BDnPC+nRrdSo8qiSun5hbiRMjC0fEoYM8NlzTFYdQRaF
         /oJH3dcPXmWk8CtSXLjFD4spRQopQN3wOTcdPlcaPC4SEE+RxAfeDxmX3rMu8LQi8A8+
         QWnw==
X-Forwarded-Encrypted: i=1; AJvYcCUbuDH7ZDlxfOACvrXZ4x14PcjhFqHSd0ySwiFVsMbTGY3Be4CNdyES7xHDoHzISIu8o1d+f7yMdez/ZEk=@vger.kernel.org, AJvYcCXMsz8THSZ7NBo5NE38o4+ZxRgPxB0x4B/rsZWGjsdEGC9f1BEwNS1Gi68t22O4xfu3N4ZzYdMh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/gBJrDBYY4fcRBm9afSTJSHhZCvJ1DdJds5BqNmvJIjAuipd
	ui+DVpOqkl1+Orz9Ck38CS7YIAMyp8hBvCgq13P2BeAdiLOrXl/VGSfSFvYKdzQx
X-Gm-Gg: ASbGnctbWKpAmFLKbAXXGbabPO6TNe6X/YlzPQt+KBPPjLxIvmqFY/vEjMd556YJs38
	mp42pzFpz1CCo1BEmTMo+kGIALkMxk/C0GaquuIKhaqotQt8GsQ5l3uoRtyZ0g6rZuRkWOqvGE5
	bJ6ooiBAvLGExBjpRhvvjBotNwT/Rc5UUM/b2TZ0psyi15ygAsEMV6i+KoqB8PK/v78JL/7AP52
	8471/SxOKRIgG24NIrDXNuzaUo5kSGS/F0OcbJvsXoYky+dM+3V6qbxsPOD8YNxTrt3O9KVv3/I
	kweiQghZ+i9KnOQY5R9NLrY7/+ii0nSQJF+qSEMVHz0Bu2egXJ9pseLr6MbC3K1DY04rBQWY/f8
	=
X-Google-Smtp-Source: AGHT+IFOytm83B/8ww/DzxvWe7BVJbvgNih+SZzMyJNZPQenqFi+Eh46FMc/u1wMcgfRczNvRPmZsA==
X-Received: by 2002:a05:6512:6512:b0:55f:6aa7:c09 with SMTP id 2adb3069b0e04-55f7095524cmr870310e87.44.1756642345779;
        Sun, 31 Aug 2025 05:12:25 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc1d4sm2174032e87.22.2025.08.31.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 05:12:25 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sun, 31 Aug 2025 14:12:23 +0200
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
Message-ID: <aLQ8J2vuYi2POPsE@pc636>
References: <20250831121058.92971-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831121058.92971-1-urezki@gmail.com>

On Sun, Aug 31, 2025 at 02:10:58PM +0200, Uladzislau Rezki (Sony) wrote:
> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
> and always allocate memory using the hardcoded GFP_KERNEL flag. This
> makes them inconsistent with vmalloc(), which was recently extended to
> support GFP_NOFS and GFP_NOIO allocations.
> 
> Page table allocations performed during shadow population also ignore
> the external gfp_mask. To preserve the intended semantics of GFP_NOFS
> and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
> memalloc scope.
> 
> This patch:
>  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
>  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
>  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
>    around apply_to_page_range();
>  - Updates vmalloc.c and percpu allocator call sites accordingly.
> 
> To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/kasan.h |  6 +++---
>  mm/kasan/shadow.c     | 31 ++++++++++++++++++++++++-------
>  mm/vmalloc.c          |  8 ++++----
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2b..fe5ce9215821 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -562,7 +562,7 @@ static inline void kasan_init_hw_tags(void) { }
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  
>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> +int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end,
> @@ -574,7 +574,7 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
>  						       unsigned long size)
>  { }
>  static inline int kasan_populate_vmalloc(unsigned long start,
> -					unsigned long size)
> +					unsigned long size, gfp_t gfp_mask)
>  {
>  	return 0;
>  }
> @@ -610,7 +610,7 @@ static __always_inline void kasan_poison_vmalloc(const void *start,
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
>  						       unsigned long size) { }
>  static inline int kasan_populate_vmalloc(unsigned long start,
> -					unsigned long size)
> +					unsigned long size, gfp_t gfp_mask)
>  {
>  	return 0;
>  }
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d2c70cd2afb1..c7c0be119173 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
>  	}
>  }
>  
> -static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
> +static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
>  {
>  	unsigned long nr_populated, nr_total = nr_pages;
>  	struct page **page_array = pages;
>  
>  	while (nr_pages) {
> -		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> +		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
>  		if (!nr_populated) {
>  			___free_pages_bulk(page_array, nr_total - nr_pages);
>  			return -ENOMEM;
> @@ -353,25 +353,42 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
>  	return 0;
>  }
>  
> -static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
> +static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
>  {
>  	unsigned long nr_pages, nr_total = PFN_UP(end - start);
>  	struct vmalloc_populate_data data;
> +	unsigned int flags;
>  	int ret = 0;
>  
> -	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
>  	if (!data.pages)
>  		return -ENOMEM;
>  
>  	while (nr_total) {
>  		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
> -		ret = ___alloc_pages_bulk(data.pages, nr_pages);
> +		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
>  		if (ret)
>  			break;
>  
>  		data.start = start;
> +
> +		/*
> +		 * page tables allocations ignore external gfp mask, enforce it
> +		 * by the scope API
> +		 */
> +		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +			flags = memalloc_nofs_save();
> +		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +			flags = memalloc_noio_save();
> +
>  		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
>  					  kasan_populate_vmalloc_pte, &data);
> +
> +		if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +			memalloc_nofs_restore(flags);
> +		else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> +			memalloc_noio_restore(flags);
> +
>  		___free_pages_bulk(data.pages, nr_pages);
>  		if (ret)
>  			break;
> @@ -385,7 +402,7 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
>  	return ret;
>  }
>  
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> +int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask)
>  {
>  	unsigned long shadow_start, shadow_end;
>  	int ret;
> @@ -414,7 +431,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
>  	shadow_end = PAGE_ALIGN(shadow_end);
>  
> -	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
> +	ret = __kasan_populate_vmalloc(shadow_start, shadow_end, gfp_mask);
>  	if (ret)
>  		return ret;
>  
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..5edd536ba9d2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2026,6 +2026,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
>  
> +	/* Only reclaim behaviour flags are relevant. */
> +	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
>  	might_sleep();
>  
>  	/*
> @@ -2038,8 +2040,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 */
>  	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
>  	if (!va) {
> -		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> -
>  		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
>  		if (unlikely(!va))
>  			return ERR_PTR(-ENOMEM);
> @@ -2089,7 +2089,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	BUG_ON(va->va_start < vstart);
>  	BUG_ON(va->va_end > vend);
>  
> -	ret = kasan_populate_vmalloc(addr, size);
> +	ret = kasan_populate_vmalloc(addr, size, gfp_mask);
>  	if (ret) {
>  		free_vmap_area(va);
>  		return ERR_PTR(ret);
> @@ -4826,7 +4826,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  
>  	/* populate the kasan shadow space */
>  	for (area = 0; area < nr_vms; area++) {
> -		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
> +		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area], GFP_KERNEL))
>  			goto err_free_shadow;
>  	}
>  
> -- 
> 2.47.2
> 
+ Andrey Ryabinin <ryabinin.a.a@gmail.com>

--
Uladzislau Rezki

