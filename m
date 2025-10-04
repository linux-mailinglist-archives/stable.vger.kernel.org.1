Return-Path: <stable+bounces-183353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3704BB884E
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 04:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3654E9784
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 02:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB727E045;
	Sat,  4 Oct 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7cdn82/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D131DF256
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759544008; cv=none; b=uSVhuk/j3BlQ0vS4KkA1N5OPXckZlehVi5T04Wni1pnao4tQAHgIY5gvd3j12uHR87m0mv/zxjqlKjzejRBCY139AKbYLrrF+WLtm4hePFmquOye1/2wZqLsqIEivr8NSkaNtqQQ4qFOu++np014wLtBIItallaZtrOBAKZLOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759544008; c=relaxed/simple;
	bh=IC1wAmF1V4kC4QdEDu0MSID9io6Ti43c6Cb+uzw0By4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRzlMFjBME7VAqfhnmFFhm+f/w2sIRhRpLfDBsxNdxCyr2NnSePLu3/AkU6Gf14AbkgtRaxD8FSketwYT+BcuCnZHBIQ9lyVDvLTtUOn6B5bIk8rAjOfyYAXYj+Z7YfUkNqUNz0EK7XzQRDNVaTDIKtDE/g2GwC/zDeiXf6uf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7cdn82/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b4736e043f9so519260966b.0
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 19:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759544005; x=1760148805; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJLGML/fAE3TNb3uOnRyVtfPhEJ/kKcyWW/gv7o0MK0=;
        b=c7cdn82/CkmKbB1ArwgNSANWO/EJQRsZOS9KLNCWPcWFg5LrzBShtbCs9grqJHXvBf
         zHYB944Q7KOjieY/FwwI62uNeo6c5XfIIhaLRuEr8Zj0kURcYBbkO4ejTb3IsEVbmYlP
         0Z+Q+tUOyXxwFqti9mQakZOUyJR2JRYw+8FcMieO88azGZf7R3RMwHXNaqqVB1tOhbG/
         zq2VIK47gLCy0srrao9vFcyOumvqj1z2HD8SZ0m8QxX/drWUZQWughwGrBwGG6sws80t
         O4WfaH8G5nVf8vHN9Z4qZSIIsasMsHDNDuLwwD1B6lid2cjjElw3bL6HCftkc7LEwK9S
         YS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759544005; x=1760148805;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJLGML/fAE3TNb3uOnRyVtfPhEJ/kKcyWW/gv7o0MK0=;
        b=kNKvohwWh09YH1NyTXFzDzzZjXAKmmM/P6GMrLWyxPkpTiu7nVLI2BrOXk8IOw3+Ye
         ryn2dmtWf3C3AEnVsFaZHp3Q11e4ZBbIapjirohp8BopYhIN72YWaarOis9ZkZHPn+sn
         vgRd40Cc+JVLRHYaKdDBwurCylYRwBJD6FfWTw1FKo9fnfOYyEkDgYhs+JfEK3SwtTgX
         WeucJHfQnR44t4oRnPcEwr1ITslnRqNFLPPekGxJpNV6xAXlZsDaml9EwijsBcQYrB2t
         e/LozptbA+kitxzzGBwiTVbjf+5ziWsN7nz4fym/szRjW0pJ/S9x0ULaY0B8a7E1hh6g
         hKBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHhmwqWYRnXdRzt7GpUTU6EzvvNW4vpDQgfitIsaUxq+bDX91bIbsVobpWz1o/WR8EGhor0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5eDvE8Et3qHN7EUU2xH6DN6NpVf52JW+zLaA8Ghx+Sb9hh5sa
	pq8nS1wznrDrTWbVVpT3oLIiVm+N0guzBS8MBAoUCFfIXKVPOa+OgL1I
X-Gm-Gg: ASbGncucsFhTeVv8WDyioI15sVWFSt46ZBF97j0vTYq4WAAWZczYOXpjn3KgAZiLFdu
	LI1ouGjkLoJC0AHMVde+4IMUvjbHm3nwfBSJ1B0oXmhUUH9BPxcRC4zXkHKeYoWqNRiTafB7qX3
	WVMp1w6U1u29WGuqrYOR8leb8Zjj3PDDeeA1lLE2mfVp2TajzpFeaoROTkEeGH7U/po+Ajh+dNs
	I8eSG9GVQp7l790OsIMfZOVVBo59yteeX9XtgP07ShgXEL3KR96N+B7AqsfYowM1AX4jJ17jUIa
	gNtxW8J4VEpeLTNeJTDgpW88IPbO7X1Or7l0B4iCIQIlZBJl0UDAv09mdGDvhbVHAI5pOjtWz57
	HpbmHkXVoJv6r4XGCP0/xD+n6Eq2Ndv6f8Q6JZNN5n6M3fRyWLms7QomZ
X-Google-Smtp-Source: AGHT+IH6Q3EMy72+qe0t0hsQggbLgNWiTJAlAWog89Yxth2YTCEdR/jsq63Jce8LF6RMeQgMSpj70A==
X-Received: by 2002:a17:907:3f9f:b0:b3e:fe8f:764 with SMTP id a640c23a62f3a-b49c47abb5dmr658409766b.32.1759544004993;
        Fri, 03 Oct 2025 19:13:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm569595766b.36.2025.10.03.19.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Oct 2025 19:13:24 -0700 (PDT)
Date: Sat, 4 Oct 2025 02:13:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Lance Yang <lance.yang@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, wangkefeng.wang@huawei.com,
	stable@vger.kernel.org, ryan.roberts@arm.com, dev.jain@arm.com,
	npache@redhat.com, baohua@kernel.org, akpm@linux-foundation.org,
	david@redhat.com
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Message-ID: <20251004021324.t2mysqcblqvwa4bv@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
 <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 03, 2025 at 10:08:37AM -0400, Zi Yan wrote:
>On 3 Oct 2025, at 9:49, Lance Yang wrote:
>
>> Hey Wei,
>>
>> On 2025/10/2 09:38, Wei Yang wrote:
>>> We add pmd folio into ds_queue on the first page fault in
>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>> memory pressure. This should be the same for a pmd folio during wp
>>> page fault.
>>>
>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>>> to add it to ds_queue, which means system may not reclaim enough memory
>>
>> IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
>> started unconditionally adding all new anon THPs to _deferred_list :)
>>
>>> in case of memory pressure even the pmd folio is under used.
>>>
>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>>> folio installation consistent.
>>>
>>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>>
>> Shouldn't this rather be the following?
>>
>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>
>Yes, I agree. In this case, this patch looks more like an optimization
>for split underused THPs.
>
>One observation on this change is that right after zero pmd wp, the
>deferred split queue could be scanned, the newly added pmd folio will
>split since it is all zero except one subpage. This means we probably
>should allocate a base folio for zero pmd wp and map the rest to zero
>page at the beginning if split underused THP is enabled to avoid
>this long trip. The downside is that user app cannot get a pmd folio
>if it is intended to write data into the entire folio.

Thanks for raising this.

IMHO, we could face the similar situation in __do_huge_pmd_anonymous_page().
If my understanding is correct, the allocated folio is zeroed and we don't
have idea how user would write data to it.

Since shrinker is active when memory is low, maybe vma_alloc_anon_folio_pmd()
has told use current status of the memory. If it does get a pmd folio, we are
probably having enough memory in the system.

>
>Usama might be able to give some insight here.
>

-- 
Wei Yang
Help you, Help me

