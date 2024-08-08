Return-Path: <stable+bounces-66059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C994C05D
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC01C20D00
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548618F2D9;
	Thu,  8 Aug 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5cMfwdw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD518EFC4;
	Thu,  8 Aug 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129076; cv=none; b=Nkn2mfoRa5fZjPYEzGHXksCsHtFNPbEPadasWTEIenX02PwC2NIc0BRgPI/SVcC5HhQOL2piyTuUQvekUbqznAqIo3iqaJ+AdGlzL/z9s4RpRl6xNRCKxX8/N3j3eMFaOKKE+DaaOyVug2gZ8Cd+/CalEzViEGqpxd4LKEDOO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129076; c=relaxed/simple;
	bh=5xKyELSGhpDNrsQy8AFW/c1PT84yF84Q0ubf8w9Kek4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9N3HVX9VoDy05eRfhOWJozfvOXSx+WYRzwdkokOcM+35/JhlwHiNZ4ng0nXITy1TYaW2mjYNXRT2bgK7ozm+/0MlM1nfXvXIBXkVeDXfXIoMFJhP8TdUDjz1jnGrFvodD6/FTD0BmFEqfPiOq6eWTj44h2HZ8704WQlmrML+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5cMfwdw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f0277daa5so1471513e87.0;
        Thu, 08 Aug 2024 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723129073; x=1723733873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRAXcnqJvd1Unv4TrFWZ76L2wyRT9GpRxYCN6xWJEOU=;
        b=b5cMfwdwC6I50zzmchTwmNzgGHmvehaLQNPGOqr/FKIfiG5hQG9keIwzsslloJmlvo
         nLb29OwGuLkOMKzcIKgc1+ijGk2hyt4crlOk73Ey5ZMdjB03pzUVaNyzu+qieVP4hJgU
         +2NLuktCBkw97/LUxA+53aPnHc/rNKnjZ4y1fRKap4zRCr6N4C+fH/nWU2dEHn2SQVjQ
         BWpPbrXSHvgQP3jlElVpx9D/A67Aw20pcG7CERICYa3uVosl7CkiAAU692GA3sSQxj/9
         7YgF8SJZpLRNLdhR0wwYEiMvnzHqhjxSbeDfkEfn0EJdjouoETkn46LuwBG7s74HE/by
         09rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129073; x=1723733873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRAXcnqJvd1Unv4TrFWZ76L2wyRT9GpRxYCN6xWJEOU=;
        b=G9+Vl0/2wZsgEa9vmS53FEcP9e3CAGenaRo4TqjVDoIHTEjUo/5D6UirFx72zHkCwy
         mmXmhAImU9FMNTTHzdfaWeY52ydSf0mXoxHXioi4YirZ9EMp1xSLJ10Gn4gzFfNqKmhj
         /wduQ6RcPnJBYgjsjP31Ad40PXjEwnooop6NRhjscOTpohMuD4QmkelrO0yi3c20qjGs
         HHic2WYBEFxT7pDykWirHF/SWNv4lEkSYnq1BZDIuUGYBeAUsr4zGW/Xx1B7pPzr/y8w
         D0dxxm0377YSopZMbibq24dbEbNXUpSlwlHqsggGuiRFKGtGMH7famYd4zaFBgUM0YO8
         nWGg==
X-Forwarded-Encrypted: i=1; AJvYcCUwmXoruRVwVXP0htwQRE4ZBqnhcHqvV/dqECvxmoCskyLzuzwN6HbHcVToCoC2XFfZQ2SdT62vKs8e0ds=@vger.kernel.org, AJvYcCXpCaWpSCDM8fqhLs+YKxdfL+dMFYbNdKrUQq7edRx0WEtF8qtvARiYaOzbeBdV9WA19N89K4wb@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVx8RA8XiSzsvkMN9+tpwtJ68zPJ/+uU6Nx9S1kGc1Uba+lVV
	l9QFBUYBR6qs4OtpaNhqA4eZ+OAgZWc2QzqeYRAIFXTPQLpDz1+F
X-Google-Smtp-Source: AGHT+IFCVvIDBofYk3clzOAIKSchxWfKCwsdWlbOmBBfYTqKyhO5fdJv5JzAnYDiUfd3VGx+2pr+aQ==
X-Received: by 2002:a05:6512:31d6:b0:530:daaa:271c with SMTP id 2adb3069b0e04-530e5820097mr1851027e87.16.1723129072228;
        Thu, 08 Aug 2024 07:57:52 -0700 (PDT)
Received: from pc636 (host-90-235-1-92.mobileonline.telia.com. [90.235.1.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3f27ccsm668593e87.69.2024.08.08.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 07:57:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 8 Aug 2024 16:57:49 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>, Baoquan He <bhe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZrTc7SLz-f5E2SS4@pc636>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808122019.3361-1-hailong.liu@oppo.com>

On Thu, Aug 08, 2024 at 08:19:56PM +0800, Hailong Liu wrote:
> The __vmap_pages_range_noflush() assumes its argument pages** contains
> pages with the same page shift. However, since commit e9c3cda4d86e
> ("mm, vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags
> includes __GFP_NOFAIL with high order in vm_area_alloc_pages()
> and page allocation failed for high order, the pages** may contain
> two different page shifts (high order and order-0). This could
> lead __vmap_pages_range_noflush() to perform incorrect mappings,
> potentially resulting in memory corruption.
> 
> Users might encounter this as follows (vmap_allow_huge = true, 2M is for PMD_SIZE):
> kvmalloc(2M, __GFP_NOFAIL|GFP_X)
>     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
>             vmap_pages_range()
>                 vmap_pages_range_noflush()
>                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> 
> We can remove the fallback code because if a high-order
> allocation fails, __vmalloc_node_range_noprof() will retry with
> order-0. Therefore, it is unnecessary to fallback to order-0
> here. Therefore, fix this by removing the fallback code.
> 
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
> Cc: <stable@vger.kernel.org>
> CC: Barry Song <21cnbao@gmail.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/vmalloc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..af2de36549d6 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3584,15 +3584,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			page = alloc_pages_noprof(alloc_gfp, order);
>  		else
>  			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> -		if (unlikely(!page)) {
> -			if (!nofail)
> -				break;
> -
> -			/* fall back to the zero order allocations */
> -			alloc_gfp |= __GFP_NOFAIL;
> -			order = 0;
> -			continue;
> -		}
> +		if (unlikely(!page))
> +			break;
> 
>  		/*
>  		 * Higher order allocations must be able to be treated as
> ---
> Sorry for fat fingers. with .rej file. resend this.
> 
> Baoquan suggests set page_shift to 0 if fallback in (2 and concern about
> performance of retry with order-0. But IMO with retry,
> - Save memory usage if high order allocation failed.
> - Keep consistancy with align and page-shift.
> - make use of bulk allocator with order-0
> 
> [2] https://lore.kernel.org/lkml/20240725035318.471-1-hailong.liu@oppo.com/
> --
> 2.30.0
>
Makes sense to me.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you!

--
Uladzislau Rezki

