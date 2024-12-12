Return-Path: <stable+bounces-100906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393109EE6A8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 13:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B19165140
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C2206283;
	Thu, 12 Dec 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdtHGBUY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A2205AA5
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006400; cv=none; b=MM8B1tnFLSYa/llAGLx2DXoqTke3sViXZYObp/9M2ZBjZBYCESh3VwLJupoet1btnHg7iC6yUHZY7nwP9keVqpcDcdiXgv4LYvy1xvejdrut0eJJh3oZMGZx5GTEC7VzduljoS37P1m8qumuLlIKdnBXu3EWUq82ukIjxoe7zg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006400; c=relaxed/simple;
	bh=6+4ftoPMyDWJ/EW43OnEVwuexdTq2qMg/JFSAqyflIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKGiux6Yj6JkrBP3Fvue6ttFjZRwhLocVrUSV06IkceYO/nCZmofkU/0aKjhD6cfwDsY5UyPqME8ImpjGnNItbqS2DimXmdcx1/5m4Rfvnh9RjW34rXkltEaud2VV/XpjJr2+G89mVtIo66aQsOm2MAQyAj85KdqCn5LZzkVhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdtHGBUY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so278514f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 04:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734006396; x=1734611196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMW58xtFVKDI069GjXZg2dD8GBgbY07ZYprS8XRa5kc=;
        b=YdtHGBUYcUvfyBfGeTubSJH8ajNazKhBaj5w8l6+rRLV3kKjWpWKRac4PRjvTccWxk
         6asPDPdlZ6ZWExwqfP5Il/QoF604HJ6vLIZf+54KbwR/2sl+rQDe7dvpL1ZVKObA/QIk
         dgo75cDz4xw5wldXfltnGR5XFuTbHgJ1rufzrs8WhoghYe7V0NYOp3mFhrDhhsmTJ/am
         rbbpwdFRFJZQu28Q61X0eno0I0/d/yhVO4wWsAtW7HzFoJGSPGkLxnnZHpfSWfkoCcc7
         i/VgzeCjXt88YONDiUBH6sGHePrkmDTVQvmR2tJR1TpO56/GMNO1yaKqacIA3pNkWH7Y
         J2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006396; x=1734611196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMW58xtFVKDI069GjXZg2dD8GBgbY07ZYprS8XRa5kc=;
        b=Q0k7K7fz67qOrywXjEb2Ilq1VeYEWPKIhPu7eSK5u8hJJYM7Kztaj5f/Uc0Nm2PJdh
         vOhKim1iXOQszcDkRV4xYXyvoV4yl6v3ED4AwDNmDGpf5qmruOngFo+g2AQCm04YNR6/
         u82ccl7ZqEzYGsalPHqSkHHBD58OIkILEV9qpi0dHY0ChnaedGNiCs/CknHjkVlMKYs0
         aJnH5jjEI/00qTtLEzo7Wc/ITpeDgm/FE/AZ10/HB1kGr1GcIVhaL2hhEX4X281Q+RwD
         kQif4PjR/3DpJIKaLqEiYR6eOCO2hZUssmuIP/wGFy9yoMXZSEDHuXJOECCMAGOX0zXW
         J+hw==
X-Forwarded-Encrypted: i=1; AJvYcCU8oJ1xCMeAwQ1htqgMHx3wraqo7knsI1j7WVb5FbcXcXuOn9sJdUL9nJD5ThZ9QyRbSNgKkxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzONTR6FSeoqFjBQMMlGapyUs879p7LYR+wJQvTvw7sgNKl19qC
	Mgo1sDGLucHCJy/RvnFELE1MYMTvfurlxfZqOHVhu2rqiYJ2yf/DQuXKSrifH10=
X-Gm-Gg: ASbGncsvokBzkbt3x2Lbo1yjAneUTuEXPTUrVhpt+ffR+dSlTIgBfxj62JsErifQ2Ev
	Uf7qAf1QKjvKJDOsQ6JjcSnuwdqXe65LUYeLzdHOyskbwNr+hzLNZU3Gn0bMR3R6s4PgxCEtcnf
	K0FIqemVnraG8Q6OdX7C3ugGADG0llGS/LYSyOA933qxsdCI11cvJ5yLLV3c/wzHhGdrdTBieY+
	zEa5h/t24iQkDtzxwZ/1nRlakAddl5zFiXEwIsuvbDKHpc=
X-Google-Smtp-Source: AGHT+IG4/pMDJNly6UpcXjj9YqlCTPXUKoKZr4j95kG0fcImiNV2JPjd07+8pLaKIe3xJptBa0NikQ==
X-Received: by 2002:a05:6000:410f:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-3864cea200amr4204805f8f.27.1734006396535;
        Thu, 12 Dec 2024 04:26:36 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed8dsm15780115e9.23.2024.12.12.04.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:26:36 -0800 (PST)
Date: Thu, 12 Dec 2024 13:26:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Message-ID: <Z1rWexnnXMmpIAEj@tiehlicka>
References: <20241211202538.168311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>

On Wed 11-12-24 20:25:37, Matthew Wilcox wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmalloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f009b21705c1..5c88d0e90c20 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3374,7 +3374,8 @@ void vfree(const void *addr)
>  		struct page *page = vm->pages[i];
>  
>  		BUG_ON(!page);
> -		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> +			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
>  		/*
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
> @@ -3382,7 +3383,8 @@ void vfree(const void *addr)
>  		__free_page(page);
>  		cond_resched();
>  	}
> -	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> +	if (!(vm->flags & VM_MAP_PUT_PAGES))
> +		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
>  	kvfree(vm->pages);
>  	kfree(vm);
>  }
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

