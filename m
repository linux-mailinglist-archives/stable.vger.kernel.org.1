Return-Path: <stable+bounces-124757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC575A66694
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 03:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9533F3BA7ED
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77418DB2F;
	Tue, 18 Mar 2025 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygwdc0Mf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D2188938
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266695; cv=none; b=jp4MauUsJ8tRoN/tPNHaChVK2S7T1zLo8eAHeszcswGjC9DP5uT/CgcA0oTZECzmcCQRMloALnJwhZneEu4YYDEc9TCA41LlSkUspX/aRifEbCdeigL7uMNmH9FOoMsmty6QX+PQ2kpO9iFFqrHoAluwmyLwCbgvoJ0g5TsVJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266695; c=relaxed/simple;
	bh=aSaLdUOQBTigsVPQ3M1UjRsvcieVzDRuQRGBxtkpEoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EATm2oadn9eoxgX8h9DMqMoK6/XG2S5+d4PMP+EmNUEI+dJaUG6Tf+LsgcgHdoX6yJ6UaW3X4gVJPFGHqdNgqKKR1hGf+Gfe7etzpPFDi5lZvrdbhJM/Mbt5UbunxFTYoirespq7YXWZt3FVJUZojGrv6LzQNzCAYpDC1K/ZpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygwdc0Mf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so8511382a12.2
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742266692; x=1742871492; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi5DV8kK6A8fuA1aYBY10ebP1mOqFbAxgn/Eos6wI3w=;
        b=Ygwdc0MfcJb7+W87DHJ26b4rbHnEHCIzo6XdpUQpArDoJwVvqjk8+zelpXCenmwXmT
         qKuHOYTD0tOFaf32UhgTYxG1serRa6UYrl7FXsnRvfxh2lfEchRx/8W1YmbwICz2751p
         eUhS7ZpwoOpO7M20EkwV/8Ns9OSNzCwxLUpLLQAboi6QhbMUix6KAoRQwAxXdRjdA5xx
         jExEnTLv+YG/2v6/gpPQeCVlHipLjI3tykoNquMy1KGslrCLiEMeXiu7Cfe91PQBbJ4i
         KwfgTPsjC8DC3UMIFQVGZGMRr7+8JECZ+4KTCAcdAcO3CeDEwvTVCMVs7A+/JBfWowLZ
         sNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742266692; x=1742871492;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oi5DV8kK6A8fuA1aYBY10ebP1mOqFbAxgn/Eos6wI3w=;
        b=eU+n2FDtqmETHBXs1jySM6kF0peIyRcF4iH7rhGvn3c1DYvAe7sWl1oKhCeQwaNl+B
         S1vBzURttqafn5MPSz0YCjHxPxI1KtiBrwDoq+hyk+ms4KtY5zwpC9YIhXrhYnwk65tp
         bct6O7zBr8jkuffJbFhw51nZpliLNHoxZGLx8vwlwsszjj2gVZvjEYgoXQzO/DgjeMRV
         XX8inlkxPP2UVXBiVL3BGnbxv3wC1jhyEk/Db0Js8c0eKHa7sQIrxdnRQxeW0/2dB9CL
         A4ZwoWuM1GPtca4viHGtdVQBfg2k6gifM175S4EYsZcu7XZMDz8708klEF5Ek28jrl2q
         T4rw==
X-Forwarded-Encrypted: i=1; AJvYcCXtr88NXemGDclvW6bjyDCRQT5TGr+0uL7xlbdttzLo76t4kB0CMl1flFWC+w2U+afmg1EasCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lJEbTKpid3VduYzJXVY4zqtiFa2SgMU3nrVI6qkjgkE990k9
	KG/j+Jw21Tjy8Yw3UTfb5c1M6lZY0Lm4PZx25ZU4X1aUmpO4EXFd2pttLdc5
X-Gm-Gg: ASbGncv6H9rp0ypr7vTOAmXmIceTqAuEfxMjzgL9zxj45I088fisdmPY10aFKdX98w1
	fTVBDJujRm6mveYmA56CfGgtVxSWc7gAjIui1ae5IVhM02TwSYiovzd4HV7gDr1OgVqco58K4Ll
	HkdcOkBhawbRkn5+wBZdEzo1+EvV+lyFQ36auzQ9KgBknuG2IrA0cFRbkClskRDgdbQzcO5i2LF
	FVdZzgNS/7E8GUYsgzW92Ept+ZCrU5Fix0ANe6QdNy7CxLt97wiLWRzPJFkI4jYOtTqUQovfY/P
	fz/0X4nj5qgTagWki1SoAuZsvLDfWompwbkqBW2X2ZgE
X-Google-Smtp-Source: AGHT+IGIxuH9uLjfKi4krgI1q72QT+hWwcEhQZ8W3h8D0Igh5GdoyWgFjfQHt0zyiBgJcYL6KlBk7Q==
X-Received: by 2002:a05:6402:278a:b0:5e7:e3f3:8647 with SMTP id 4fb4d7f45d1cf-5e89f645652mr15619188a12.19.1742266691513;
        Mon, 17 Mar 2025 19:58:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e64asm6836433a12.4.2025.03.17.19.58.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Mar 2025 19:58:10 -0700 (PDT)
Date: Tue, 18 Mar 2025 02:58:09 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, Yajun Deng <yajun.deng@linux.dev>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memblock: repeat setting reserved region nid if
 array is doubled
Message-ID: <20250318025809.v2jpjbwy3yhc7cik@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
 <20250312130728.1117-3-richard.weiyang@gmail.com>
 <Z9L0z6CNZjh3V8A7@kernel.org>
 <20250314020351.bgdjmdjqnobu77s7@master>
 <Z9bvE-6KsbIGRcTm@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9bvE-6KsbIGRcTm@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Mar 16, 2025 at 05:32:35PM +0200, Mike Rapoport wrote:
>On Fri, Mar 14, 2025 at 02:03:51AM +0000, Wei Yang wrote:
>> On Thu, Mar 13, 2025 at 05:07:59PM +0200, Mike Rapoport wrote:
>> >> Commit 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()") introduce
>> >> a way to set nid to all reserved region.
>> >> 
>> >> But there is a corner case it will leave some region with invalid nid.
>> >> When memblock_set_node() doubles the array of memblock.reserved, it may
>> >> lead to a new reserved region before current position. The new region
>> >> will be left with an invalid node id.
>> >> 
>> >> Repeat the process when detecting it.
>> >> 
>> >> Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
>> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >> CC: Mike Rapoport <rppt@kernel.org>
>> >> CC: Yajun Deng <yajun.deng@linux.dev>
>> >> CC: <stable@vger.kernel.org>
>> >> ---
>> >>  mm/memblock.c | 12 ++++++++++++
>> >>  1 file changed, 12 insertions(+)
>> >> 
>> >> diff --git a/mm/memblock.c b/mm/memblock.c
>> >> index 85442f1b7f14..302dd7bc622d 100644
>> >> --- a/mm/memblock.c
>> >> +++ b/mm/memblock.c
>> >> @@ -2184,7 +2184,10 @@ static void __init memmap_init_reserved_pages(void)
>> >>  	 * set nid on all reserved pages and also treat struct
>> >>  	 * pages for the NOMAP regions as PageReserved
>> >>  	 */
>> >> +repeat:
>> >>  	for_each_mem_region(region) {
>> >> +		unsigned long max = memblock.reserved.max;
>> >> +
>> >>  		nid = memblock_get_region_node(region);
>> >>  		start = region->base;
>> >>  		end = start + region->size;
>> >> @@ -2193,6 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
>> >>  			reserve_bootmem_region(start, end, nid);
>> >>  
>> >>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
>> >> +
>> >> +		/*
>> >> +		 * 'max' is changed means memblock.reserved has been doubled
>> >> +		 * its array, which may result a new reserved region before
>> >> +		 * current 'start'. Now we should repeat the procedure to set
>> >> +		 * its node id.
>> >> +		 */
>> >> +		if (max != memblock.reserved.max)
>> >> +			goto repeat;
>> >
>> >This check can be moved outside the loop, can't it?
>> >
>> 
>> We can. You mean something like this?
>
>Yes, something like this.
> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 85442f1b7f14..67fd1695cce4 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -2179,11 +2179,14 @@ static void __init memmap_init_reserved_pages(void)
>>  	struct memblock_region *region;
>>  	phys_addr_t start, end;
>>  	int nid;
>> +	unsigned long max;
>
>maybe max_reserved?

Sure, will update it.

>>  
>>  	/*
>>  	 * set nid on all reserved pages and also treat struct
>>  	 * pages for the NOMAP regions as PageReserved
>>  	 */
>> +repeat:
>> +	max = memblock.reserved.max;
>>  	for_each_mem_region(region) {
>>  		nid = memblock_get_region_node(region);
>>  		start = region->base;
>> @@ -2194,6 +2197,13 @@ static void __init memmap_init_reserved_pages(void)
>>  
>>  		memblock_set_node(start, region->size, &memblock.reserved, nid);
>>  	}
>> +	/*
>> +	 * 'max' is changed means memblock.reserved has been doubled its
>> +	 * array, which may result a new reserved region before current
>> +	 * 'start'. Now we should repeat the procedure to set its node id.
>> +	 */
>> +	if (max != memblock.reserved.max)
>> +		goto repeat;
>>  
>>  	/*
>>  	 * initialize struct pages for reserved regions that don't have
>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

