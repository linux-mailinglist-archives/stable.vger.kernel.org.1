Return-Path: <stable+bounces-70067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B226595D3B1
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6881F22E0D
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE318BB8E;
	Fri, 23 Aug 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoyRXL9Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD0187855;
	Fri, 23 Aug 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431376; cv=none; b=UydlLFaM5bHIUViT8GZmOcpXfSJ4mDNjdBjxO8OllupG5Qo74c3DcZJdKvkTFWYPbiaGRHQzX/XuAft/f0BF8fg8c3fAn6padt7CmohFAKSJOgGWVNDd8mjh8WlChb0r/a4SD1GaM7cRU3Iyt3KgxnN+wF0s/nw4DrvaoQJ2Ivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431376; c=relaxed/simple;
	bh=Fmg79+pJqZ+Uvq9jbhFMYqgVb7MuD37XaqN3PuP27tY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njK6Mzhgk71feQDJWa/YCYtOjRb5KmZ+TRomcdvdsFBy4AiPrn3Srw8NWmq3zygsi4/EAfmfC2JYPUnN05KeLsIggd6wbfPGj3IXXqmnJwZN6qrZAWzsoejB4nF5fSRc6yCfrU2Uj6Pd0jFD2rLihXPBfRWdMwLkkAYVkd0onNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoyRXL9Q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01b8738dso1735702e87.1;
        Fri, 23 Aug 2024 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724431373; x=1725036173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cK52LZ2pqFwye/usYRJoo3LbuS95xxU06k6WwSINR4E=;
        b=WoyRXL9QoTZisXjRcuzFlkTDBTOgxiTIKs7F5pFLszxyTaQa97PRLTGfi3zOGtnTT9
         ebPPqu3hfOIwreYFi7jjfH/i0W/YH5MqPnCakuU1D3H5IWAfBzkE088EVFjrXl0I2D5t
         Wi+r3Wsu/VGhKr7co4k2KH+ikUUuejxC6zE4z6a/9SRhndEOYZpHxBpO8E5KJqYMEASW
         5Rl+D88gY2dJietP+vJtO9DSUJDShpCHsghbgw2WfvplvmLdBIDulLQu3OsxY1pkoQwc
         nMwWtteP2cJFriOS3sHUhn+Kjju79alunjDeI34EZ6p0szzRJVgga31fQqW6zYeqkiVL
         FyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724431373; x=1725036173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK52LZ2pqFwye/usYRJoo3LbuS95xxU06k6WwSINR4E=;
        b=A4fmQXlAgBC7Xz5TMnxqW2US6JGV4H/lAHAhR6RvL1sx5kE2pj7Db5BL+OjUznoXJ2
         8uA3sriLiz9gHZiBsDLd70OLhuO89CynVeaBNKXbI6Ff/I73Ex7lShdD46Xei0R/KsuB
         IDBq7hY9H5nRtVuimkyFTUcSFIelIgzBt6q6emailMbII3pNQlRT/yCv8DzdMcB+9shW
         8qOKEdmX46/bGR5Lc3eio2PsRGAKM/seJDjmIX+ncMyyPPGVse+OK2SWKwdaghx9vxDA
         fAvLMJC/PSjDGZzNHRXuLL1QOgNila953xa5EDPV6XgMMRV+nUTSqWaScdOglMtiPZUS
         yrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPUWHCENqFInKJjyjmF101SFASZLMAXcCpad6cOv5yY1NIWQb5Ixdhh1n8mMcHTUvoCd9FLcKo@vger.kernel.org, AJvYcCXEMRC7OkYThGecWc6tYcbl7wjr7PmHGAGSaJsXBUCMyuaK2pnqW7SnwektsQ1Vgjy1gkN0dbQ4dvrwLZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaq2lnhHM9A4uSZZfo2H0G5live17roXgmkOLLtXlb3tjMp75z
	GjJdhlrCHp3si6LxIWtYvYPejvCjaOfk4KwUg08wJZMz57uPOozN
X-Google-Smtp-Source: AGHT+IGr8qEq/yllkgFywwhHWY1jskPoCv5mtjeA3Qu0q5m5j5/g/7q1bo6S2bl5O71wtvcRv3WwKw==
X-Received: by 2002:a05:6512:3986:b0:530:e1f6:6eca with SMTP id 2adb3069b0e04-534387bb5c6mr1935292e87.37.1724431372039;
        Fri, 23 Aug 2024 09:42:52 -0700 (PDT)
Received: from pc638.lan ([84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6e4sm590346e87.225.2024.08.23.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:42:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Fri, 23 Aug 2024 18:42:47 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Hailong Liu <hailong.liu@oppo.com>, Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zsi8Byjo4ayJORgS@pc638.lan>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr9G-d6bMU4_QodJ@tiehlicka>

Hello, Michal.

> 
> Let me clarify what I would like to have clarified:
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..fea90a39f5c5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3510,13 +3510,13 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
>  EXPORT_SYMBOL_GPL(vmap_pfn);
>  #endif /* CONFIG_VMAP_PFN */
>  
> +/* GFP_NOFAIL semantic is implemented by __vmalloc_node_range_noprof */
>  static inline unsigned int
>  vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> -	gfp_t alloc_gfp = gfp;
> -	bool nofail = gfp & __GFP_NOFAIL;
> +	gfp_t alloc_gfp = gfp & ~ __GFP_NOFAIL;
>  	struct page *page;
>  	int i;
>  
> @@ -3527,9 +3527,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * more permissive.
>  	 */
>  	if (!order) {
> -		/* bulk allocator doesn't support nofail req. officially */
> -		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> -
>  		while (nr_allocated < nr_pages) {
>  			unsigned int nr, nr_pages_request;
>  
> @@ -3547,12 +3544,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 * but mempolicy wants to alloc memory by interleaving.
>  			 */
>  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> -				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
> +				nr = alloc_pages_bulk_array_mempolicy_noprof(alloc_gfp,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
>  			else
> -				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
> +				nr = alloc_pages_bulk_array_node_noprof(alloc_gfp, nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
> @@ -3566,13 +3563,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			if (nr != nr_pages_request)
>  				break;
>  		}
> -	} else if (gfp & __GFP_NOFAIL) {
> -		/*
> -		 * Higher order nofail allocations are really expensive and
> -		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> -		 * and compaction etc.
> -		 */
> -		alloc_gfp &= ~__GFP_NOFAIL;
>  	}
>  
>  	/* High-order pages or fallback path if "bulk" fails. */
> -- 
>
See below the change. It does not do any functional change and it is rather
a small refactoring, which includes the comment i wanted to add and what you
wanted to be clarified(if i got you correctly):

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3f9b6bd707d2..24fad2e48799 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
-	gfp_t alloc_gfp = gfp;
-	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
-		/* bulk allocator doesn't support nofail req. officially */
-		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
-
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -3563,12 +3558,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
+				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp & ~__GFP_NOFAIL,
 							nr_pages_request,
 							pages + nr_allocated);
-
 			else
-				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
+				/* bulk allocator doesn't support nofail req. officially */
+				nr = alloc_pages_bulk_array_node_noprof(gfp & ~__GFP_NOFAIL, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -3582,24 +3577,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else if (gfp & __GFP_NOFAIL) {
-		/*
-		 * Higher order nofail allocations are really expensive and
-		 * potentially dangerous (pre-mature OOM, disruptive reclaim
-		 * and compaction etc.
-		 */
-		alloc_gfp &= ~__GFP_NOFAIL;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
-		if (!nofail && fatal_signal_pending(current))
+		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages_noprof(alloc_gfp, order);
+			page = alloc_pages_noprof(gfp, order);
 		else
-			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
+			page = alloc_pages_node_noprof(nid, gfp, order);
+
 		if (unlikely(!page))
 			break;
 
@@ -3666,7 +3655,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+	/*
+	 * Higher order nofail allocations are really expensive and
+	 * potentially dangerous (pre-mature OOM, disruptive reclaim
+	 * and compaction etc.
+	 *
+	 * Please note, the __vmalloc_node_range_noprof() falls-back
+	 * to order-0 pages if high-order attempt has been unsuccessful.
+	 */
+	area->nr_pages = vm_area_alloc_pages(page_order ?
+		gfp_mask &= ~__GFP_NOFAIL : gfp_mask | __GFP_NOWARN,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
<snip>

Is that aligned with your wish?

Thanks!

--
Uladzislau Rezki

