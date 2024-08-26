Return-Path: <stable+bounces-70140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443195EB2C
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 10:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF691F224F4
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1523B13A257;
	Mon, 26 Aug 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hvsc95h1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BE12BF25
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658766; cv=none; b=RV8506SPqkAAvp62zzHbKqbEzcexgkYPojsxyh5Q/dQvtzK549LoSACbS5VG6zji1GyVd8/aJ5w6QGzgCYk3vYT7QfU+Bq8eEml2CrrwO04M6MIOjnqTGrbqLaf6r2u5ogG8o6gWeXGUbLqcUIiCx/JorNWpyP27EsnXFqyXfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658766; c=relaxed/simple;
	bh=uEAvcHdc2ebFd95oE2bW6T/wQ3szzEthBor+0WDO4HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlSkUj+obX/Ne6S2QOp/FFbjrreEXVUSNJztN5kC309yMox1omRW4ag2VDKvY8I0f0PYgohkB8sXLIIju4DY0XWykEPa2ZljMPG/Mzu3/jQviDKSHUa7lgLBsjOukICW2isfbRU447t2CQnVvsSKiB77GdQuuyiR66tBmK5/dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hvsc95h1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso4744536a12.2
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724658763; x=1725263563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mWpjqvTPtHlK5lheMP9E3P4lBAgBvroCp9x579oAwI=;
        b=Hvsc95h1Y6GE1vAQg4RPnM3V67FEYPjzGYW9XDw36M8AEe1j5JwcyxZqlrkhVP4D/L
         gh+mU8fdpLGHny1XT5ZOTA3AIUdVlE8JME3TrBIVJnEU6VRk3zjxXWG5dizpoDQYeAA7
         ascD7Nf20wzEVjQ1Jkr4ItBuORs6goehhGLF2F2OYJA6H1LErmOs7478AEXY84cspM9P
         0hp7Y3Ep2endyzDZDtCcNlnpRncmcoZIhAKpBwhiy6iFkOVBPK2qPAuF4cMsRYTza3Wo
         dJPJUMOl44Seay622o4WN29jzhM52yVS4H+17nqpDP5FU4cwDGBMx4IUj0s/maQPZ+9Q
         4prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724658763; x=1725263563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mWpjqvTPtHlK5lheMP9E3P4lBAgBvroCp9x579oAwI=;
        b=rSc4fiHzw4zSqvKTLJb21+xWXAi8aLswoxyYEeJU9xSbFNsexPRX7hs19Tb1xQ9D1K
         5B/IAkGSqt9oyOrMS9CjIoMyKSPYaW4Tx8s8ohHQs5CCemwNWYHtIkLPhW4mQ9fLDvOB
         BJ/apD9hYuXbJlvF38nELOyn3YeO7c3xG5793e/TB7hVGs21b3+0WA0MUeVVrxUYpsrg
         nU1wyUJzKt+08cErMDq9UZjVh8etmfnmlQqc/xhyAWfh+E7pwAyR+6d0tlCfv0G+fYQa
         lEc0x/QAdoBYuU/AVpcqkKI0ohfbEN8S/aY3S+xb/aygtN33P/a9VNVBEepnN560p4pP
         MfUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDVE3dDkkpihxHDRNerB7PoahH98IpMWOr9q0dzxg6wzf3pqvyoHgudEl3MVtkPN+R+Wx8O5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73dClnyPt3Epe/kFYY2vkBd27VA003rHSUV0JNkEJLDRvWVEo
	R0Pcr7l9gOIbYBWCFpUVzKS5rYTe6QIi1G1/yKF4pcRHdaMA5j6lzLFpM5QxZZM=
X-Google-Smtp-Source: AGHT+IEzV3jS/6ppHaAZh7jMr6N30qSPi273cP9sOA4SscXrkGrqDWhLVhBKUnQARYOoFbbsvyUckg==
X-Received: by 2002:a17:907:7e9e:b0:a80:f6a9:c311 with SMTP id a640c23a62f3a-a86a4e5c7demr677648066b.0.1724658762991;
        Mon, 26 Aug 2024 00:52:42 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b29sm624639566b.162.2024.08.26.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 00:52:42 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:52:42 +0200
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
Message-ID: <Zsw0Sv9alVUb1DV2@tiehlicka>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
 <Zr9G-d6bMU4_QodJ@tiehlicka>
 <Zsi8Byjo4ayJORgS@pc638.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsi8Byjo4ayJORgS@pc638.lan>

On Fri 23-08-24 18:42:47, Uladzislau Rezki wrote:
[...]
> @@ -3666,7 +3655,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
>  	page_order = vm_area_page_order(area);
>  
> -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> +	/*
> +	 * Higher order nofail allocations are really expensive and
> +	 * potentially dangerous (pre-mature OOM, disruptive reclaim
> +	 * and compaction etc.
> +	 *
> +	 * Please note, the __vmalloc_node_range_noprof() falls-back
> +	 * to order-0 pages if high-order attempt has been unsuccessful.
> +	 */
> +	area->nr_pages = vm_area_alloc_pages(page_order ?
> +		gfp_mask &= ~__GFP_NOFAIL : gfp_mask | __GFP_NOWARN,
>  		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> <snip>
> 
> Is that aligned with your wish?

I am not a great fan of modifying gfp_mask inside the ternary operator
like that. It makes the code harder to read. Is there any actual reason
to simply drop GFP_NOFAIL unconditionally and rely do the NOFAIL
handling for all orders at the same place?

Not that I care about this much TBH. It is an improvement to drop all
the NOFAIL specifics from vm_area_alloc_pages.

-- 
Michal Hocko
SUSE Labs

