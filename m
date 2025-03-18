Return-Path: <stable+bounces-124777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC152A67152
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751614236BD
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269C207649;
	Tue, 18 Mar 2025 10:30:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFB174EE4
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293810; cv=none; b=FsS06SjOnushAabZboWEfujAe3yOBxHzz42VgH/SspzRR7Zyax5OMSKc7tzHZ0N755czmzmQtpJBTpOyYpTVGEzQyc0K61luMdS1PGlo4evIpC/eBYF7+u5hpIm4ddlp3goDPnhI1oWnv55kTjCj07Yn4csB1wPjvottUr/kKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293810; c=relaxed/simple;
	bh=EdabUAIfaMKIaOKwtMa0jovhx1HTqoOj94cOWNAKY3M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZtfS4HEC6LRwq3ZXcQHXWlqIWw9d0KdnNB2NnfdYUaH5dyjLKfikXZSVMqDF+3H7jPhbqXh2Ddx/8cwKJboPaN1YeKOzxKqm105neCpEwz0sGNNm28b1DEN2snT5oLSASOhQRhEHbFUr+fiTef2jqgtWygjQ9jrTn3Pt4cfD2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A20A152B;
	Tue, 18 Mar 2025 03:30:11 -0700 (PDT)
Received: from [10.163.44.33] (unknown [10.163.44.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8CE93F63F;
	Tue, 18 Mar 2025 03:30:00 -0700 (PDT)
Message-ID: <d97659e0-850b-46f5-8fb2-25b531adf75a@arm.com>
Date: Tue, 18 Mar 2025 15:59:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [Patch v2 1/3] mm/memblock: pass size instead of end to
 memblock_set_node()
To: Wei Yang <richard.weiyang@gmail.com>, rppt@kernel.org,
 akpm@linux-foundation.org, yajun.deng@linux.dev
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20250318071948.23854-1-richard.weiyang@gmail.com>
 <20250318071948.23854-2-richard.weiyang@gmail.com>
Content-Language: en-US
In-Reply-To: <20250318071948.23854-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 12:49, Wei Yang wrote:
> The second parameter of memblock_set_node() is size instead of end.
> 
> Since it iterates from lower address to higher address, finally the node
> id is correct. But during the process, some of them are wrong.
> 
> Pass size instead of end.

Makes sense.

> 
> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")

The commit is correct here which had introduced the problem.

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mike Rapoport <rppt@kernel.org>
> CC: Yajun Deng <yajun.deng@linux.dev>
> CC: <stable@vger.kernel.org>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 64ae678cd1d1..85442f1b7f14 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2192,7 +2192,7 @@ static void __init memmap_init_reserved_pages(void)
>  		if (memblock_is_nomap(region))
>  			reserve_bootmem_region(start, end, nid);
>  
> -		memblock_set_node(start, end, &memblock.reserved, nid);
> +		memblock_set_node(start, region->size, &memblock.reserved, nid);
>  	}
>  
>  	/*

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

