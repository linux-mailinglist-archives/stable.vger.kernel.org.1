Return-Path: <stable+bounces-28067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597087AFFA
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 19:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A664B1C2563F
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 18:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13AE63411;
	Wed, 13 Mar 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMGKg4EC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C66281D
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351012; cv=none; b=R0J/pfZAQxX3hr8un8OFIIqfYEubCiZlK0xYaoQPWQy1XeBg0EVQX/8jA3r5L337sPgO9WMNKM+6yVphH9TqiklERMC55KQznKjUuzJQQgF09wfT6lBcbj7O6P2sOePhrszeMHepz9F6kA+ImS55GqIOiKZd5lDJkI5TALa5ARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351012; c=relaxed/simple;
	bh=qE9WN0G7vqIW6urvfjtascr1kEa+MwOFnJlUgn9El1E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MyOvb5Q0KQ/qSCVaSw3lqrqBZfluZnQQy+Lkx7Cm36IVIVPY/llYBddpgIw2KvynEmaw1li9QeTbyQFQBXuWOdBihq0qr8RSh92XTCArwgoeTnqwsRedYB8VEgqPpnb7POF9jR4DnZukx4uKwaMSOIFTKBaviqqx1uxXZg91kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMGKg4EC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609fc742044so1241377b3.1
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710351010; x=1710955810; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDZyfj8uQkTVjkzThm7shPFLmVnEzQeIt/9Q/lnq+ak=;
        b=tMGKg4ECLT9JyOxL046zaLNag1Wk1iyvLsQ3J8va+kp1LIXJWF6uqZWOKeQncpeqYT
         XL1kdw8YkE2pj7lCoae4YJBmZTnC0W0XE/Pzl/ZR62LWZi6SPcL2kSNua60TKeCrkGXl
         0902DTRt2DicgB8Ef+LjEtWjiV00V8CF11sDkHqYsvJcaXQYPU3uac7MNhGJfdcRFks6
         AIAZ3I5CbzLhavtgOX6kRvtpcJMtOjs8nRLuP7dYoFMGWmPIeQkdT2icwoEhPm+UOlw3
         L6pt7NuK18xYBWTYkmx/A7C633WQQoYSXvUpmIYuyREP3zeoi2Xdhv8pVdsap+LTRVYQ
         QgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351010; x=1710955810;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDZyfj8uQkTVjkzThm7shPFLmVnEzQeIt/9Q/lnq+ak=;
        b=GkE9EhV2SmTH2PGGLJQgEEW5/gruyYA5hfQl2UcyvV4vPi9+ZxAsO1A+Dy5Kf2CfLJ
         1V6MOmudqghAXQ4suqG+z4RSmCDXcIPX5lppTRyqXEHq6G6J3ur2GBCSFHduz9dPDN7V
         ysFwJg+7zyClk3V7xP7Y6qHKyRj/nVoifzHFGLNOp1jYrGPQXjT52yD9NET93ZSMH08s
         n2bE9uK5r+wtnXJc5/m5zCElEmu9LGLFj0n4xQv+loLD7cYA8oSVJhkxTCoIw2ebX9IF
         1g+pjQfln/p4dQKT+Bg/35KabyjrVTUza2cm4Bs6YTTGvIStMgR43a7AXQ1Cm2ZCkBrF
         VGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUa0nSND/0PyPGl6MALRrm4zMJCm+xzO7aU/kiWhNrBHvcXMEttkPgZQobLINo18z0+oxmS0CCM1rVYa5/pkd2C3r0rRBAG
X-Gm-Message-State: AOJu0YysUqXPH4Mxol7183uwtaTv6MeECgFq/HeG6MMYZJjemxhpzzU1
	eXFa7Qkut6o335fLu7Z0Xrx1K8mnZgYrvptvMcF9xZU7voz8HSIOfvqwZbu0Xg==
X-Google-Smtp-Source: AGHT+IGubD4Di1OqoOZhz8NRbIKSGmeys0QcYHPC2dp20EmYgN3ILwPFrQbaE4JB5gpUAvenkkwgqQ==
X-Received: by 2002:a81:7cc4:0:b0:609:f5b5:5731 with SMTP id x187-20020a817cc4000000b00609f5b55731mr3580689ywc.21.1710351008104;
        Wed, 13 Mar 2024 10:30:08 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q74-20020a81994d000000b006097887f574sm2557690ywg.80.2024.03.13.10.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:30:07 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:29:56 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Huang Ying <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, Zi Yan <ziy@nvidia.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 05/60] mm: migrate: remove PageTransHuge check in
 numamigrate_isolate_page()
In-Reply-To: <20240313163707.615000-6-sashal@kernel.org>
Message-ID: <e4f8cd8f-db70-5a09-ad6e-6ec5fa2788b0@google.com>
References: <20240313163707.615000-1-sashal@kernel.org> <20240313163707.615000-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Mar 2024, Sasha Levin wrote:

> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> [ Upstream commit a8ac4a767dcd9d87d8229045904d9fe15ea5e0e8 ]
> 
> Patch series "mm: migrate: more folio conversion and unification", v3.
> 
> Convert more migrate functions to use a folio, it is also a preparation
> for large folio migration support when balancing numa.
> 
> This patch (of 8):
> 
> The assert VM_BUG_ON_PAGE(order && !PageTransHuge(page), page) is not very
> useful,
> 
>    1) for a tail/base page, order = 0, for a head page, the order > 0 &&
>       PageTransHuge() is true
>    2) there is a PageCompound() check and only base page is handled in
>       do_numa_page(), and do_huge_pmd_numa_page() only handle PMD-mapped
>       THP
>    3) even though the page is a tail page, isolate_lru_page() will post
>       a warning, and fail to isolate the page
>    4) if large folio/pte-mapped THP migration supported in the future,
>       we could migrate the entire folio if numa fault on a tail page
> 
> so just remove the check.
> 
> Link: https://lkml.kernel.org/r/20230913095131.2426871-1-wangkefeng.wang@huawei.com
> Link: https://lkml.kernel.org/r/20230913095131.2426871-2-wangkefeng.wang@huawei.com
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 2774f256e7c0 ("mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index")

No it is not: that one is appropriate to include, this one is not.

Hugh

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  mm/migrate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b4d972d80b10c..6f8ad6b64c9bc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2506,8 +2506,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
>  
> -	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
> -
>  	/* Do not migrate THP mapped by multiple processes */
>  	if (PageTransHuge(page) && total_mapcount(page) > 1)
>  		return 0;
> -- 
> 2.43.0
> 
> 

