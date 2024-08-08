Return-Path: <stable+bounces-66037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100894BE19
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 15:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64B31F234F8
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2518B475;
	Thu,  8 Aug 2024 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVYWyKfk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148418A6B3
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122101; cv=none; b=i+iq1Wfhk+zwfWReLKpTfdfCZwjSfT5cx+yzOdTEHwcq+g7Jm+xRt61cB+jqI1bFolX3GiVEc3GDFa8FI0f8jPM5KWBs3edJESbV4s70TIDY9KeNrv+k2nNp5HeCK7DZyLM6nJhYHdnsOXDNulrTAXwOkEkPMxhNd0wg1rDp4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122101; c=relaxed/simple;
	bh=WJy6riYAQprnZmd05jyphtNgpH79mGG9qZWdFFY2/ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9jdKLH4qO01QJKuiblISM1HdgML+/7wKlZaMw3MY3vX1ApeAEhkjGsvNI+2v8jGfuHtUTly4C1ZKYu8W9EEU+uA/2Wkt7sb+WCHgoFh9/StA+J0sjEHQfWeLEf0yAHCdwbH62QeIqnTqM+/bqqBhqwSiDQDO/JhR9udjpCCHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVYWyKfk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723122097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3VVVcICw5YU8pAW4Og/Up208pv4Neli8fjInWAkHzw=;
	b=GVYWyKfk1ShVPA0I5CfVWOFnubfGHeW9XVMvfMa1L4hI9GYjFw7/7mWNFo/Qxk2vzWNjqP
	5X8f8hYiA0sA8DDMMf5MWiD1tZwY2bY+aXzHwWtKB195v5dlPP1lSimRiORQ5SEhmItE+C
	+dGqWIStXxfO0f6//vQqqOAA5VJ5yls=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-GwE64XWmM2KMGDVLNsI64g-1; Thu,
 08 Aug 2024 09:01:35 -0400
X-MC-Unique: GwE64XWmM2KMGDVLNsI64g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 160401955F4B;
	Thu,  8 Aug 2024 13:01:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3CA3300018D;
	Thu,  8 Aug 2024 13:01:29 +0000 (UTC)
Date: Thu, 8 Aug 2024 21:01:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <ZrTBpUyNRzFrAXpf@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/08/24 at 08:19pm, Hailong Liu wrote:
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

This looks great, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>


