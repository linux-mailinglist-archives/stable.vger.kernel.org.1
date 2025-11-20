Return-Path: <stable+bounces-195211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA9C719B0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2A1662F8FF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B855204F93;
	Thu, 20 Nov 2025 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTHPtuT/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6DF20459A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599660; cv=none; b=upACCX0DAQtGSnsp8cp8kY1DnrKiIc9iU3REB0eO7edSUweAp8JTGrSlZQXP3A6HxVloNvmkssy8Tex3tEwSspfjBddSOwCUkZTu7ggAbcswWRu/Ikn6ibovgJr+LLAx2+Ek4fr0nnbhC1xAntQJ5/Oxi0RRkzPDf3OLwbJo+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599660; c=relaxed/simple;
	bh=J310qq1L3oUrlDEvEHDntktfg0vHAwqZqEUC6HAdGNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJX/IwZdWA2R7FasnikwHMhYXGPW7NYfqGAFUAb3gZ+2xmQnfIvzX9uHuE6pSxVqrBVBSVJplxgNnXdNOpW9MfHcuZZSOrwPvNL5JK3H7W795l/iJ9mesB23KAZ08Xk15UhUfAR9Y4lQJnb8bD7V2DpXEgf0wQDY1jCKEMhzawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTHPtuT/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7277324054so53386766b.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763599656; x=1764204456; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/P67X+tOkro4N9DxBcXvDCHrMw8zb4DFRG/1PsXQbs=;
        b=aTHPtuT/dBSrmKafb4ab+5mjhJWeRrtjNMuTRrsPGX2y6+NO62JgXNIb0ji7VE4dhB
         qSFmk8VY6WN+vj6MiHnot/KB4kKjPSOa/MnWv6nJZc3+WgIfgF3vS0/FecexAl/D3vqt
         Or/15sUMmJ9qOOH904nrcAY7NgV2/+UfyERE9SJgVzlI1azt9jNAgBgXge16+iF3uL5e
         YuQaWvO1uVv2HDDrvxFiQeRT3kTXKCgfDnK1Q+nQqhnAdAOejpkri3n4jRzGMj19jdRv
         Pg28qINRId+KJ3a04m++7XdGx7DIflq4vXNPSOAbfrwru3jG2jXiwMk0mjpXcNdv/4bu
         FcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599656; x=1764204456;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/P67X+tOkro4N9DxBcXvDCHrMw8zb4DFRG/1PsXQbs=;
        b=GzpsMxkyQ2XPRuvHwhMky5ujzSLier0Tl/O6gqa3f4Gv4jMXPRvTZR6buUFZU4Ybjm
         YrLh8OIHM8BQ1smF5i4UaHoxvzZKAr19HKCyyS4v3J/DFIHZKzYlATujAyFLcvrQ/fAP
         w5zRbmyOxgVu7J5003HLM6ln5tJS34t1MW+kkoKu+PKeSJxb2mUtKjigJnpsfed3KI6X
         jYqeoFwK4EBCNuLdGYsSo+6IejfPuJ/uqzyQuXcJJYez5IkyBi6Hai4fTcJr7H9KCgHD
         WdrAq5ZCSDpOi5S1xgwU1NvCGbBxgOTml+SXIoo4AcbTOFOrYJJM86qqYiZ8zsgu1oiM
         TEaw==
X-Forwarded-Encrypted: i=1; AJvYcCUvRKiGFd7DxUWzeIvEzcZ0EGn2zP53bMXl/4d/Pc7ZJvqT/p3LtWauT8mOzpSVlkO7pUnLugE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmaCfyuaUfMZ/QeOm86dFUE14J0Biub0mawUe46stEMCUQ1UQH
	RNJ1klJcUH7nlitCbLmrL1EdjWU4EitGALtBWYbtqnGE3dQTfkQa7b/y
X-Gm-Gg: ASbGnctx1QqHUsFpmPF2wjnqjJNjGzBT2f6rbM0cLou9v+G2QSe4EMhKQWfbw2JxpPJ
	M8iQ765OvUlGfQHVhT1K3O9Z5kcPDZAuNUWkeF1mZTq8n+gduZsh8v+bKEOr/zpQyP/6RfnWEMk
	0XEJBkxMxRhGh4M76PUvX1fT5zByYJSSWN5z2s+US7gZLAJKX80WhuWsm6/dCFGh2onyilzSvsw
	ulKqJDDuWCQvubsUasEb0ysQB1R6jEXDKVLRJMUh/36cgEPTbMsvqSmabT75bBDr4d6/vRGXbdl
	+magdKSeQ+JnZIanFGUb1W19vtHzhgut66WqS5h7PsGluISS10T82KXdsxs9AFtgxg2MkOxg6N4
	qYmzAn8bPe+tTZqdmDiR/W76ijKSc+zSJ/w6L1s5cdFewoWBWY9YznX3d1CekNfrMpHN1dgVMHj
	PXS8RkFlZM4zyYcA==
X-Google-Smtp-Source: AGHT+IHN7VWtMO14c9xDQq914ZJx1tXNG2tHafnw8FSgGsDSWuZ/SH5/VJQ/QIuDTYiSsmkR4cRwIA==
X-Received: by 2002:a17:907:2d94:b0:b73:3ced:2f66 with SMTP id a640c23a62f3a-b7655295778mr91038966b.14.1763599656277;
        Wed, 19 Nov 2025 16:47:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdd659sm72546466b.7.2025.11.19.16.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 16:47:35 -0800 (PST)
Date: Thu, 20 Nov 2025 00:47:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix NULL pointer deference when
 splitting shmem folio in swap cache
Message-ID: <20251120004735.52z7r4xmogw7mbsj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119012630.14701-1-richard.weiyang@gmail.com>
 <a5437eb1-0d5f-48eb-ba20-70ef9d02396b@kernel.org>
 <20251119122325.cxolq3kalokhlvop@master>
 <59b1d49f-42f5-4e7e-ae23-7d96cff5b035@kernel.org>
 <950DEF53-2447-46FA-83D4-5D119C660521@nvidia.com>
 <4f9df538-f918-4036-b72c-3356a4fff81e@kernel.org>
 <FA37F8FD-DDAB-43B0-9BEA-2AC25986767E@nvidia.com>
 <822641bc-daea-46e1-b2cb-77528c32dae6@kernel.org>
 <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14253d62-0a85-4f61-aed6-72da17bcef77@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 03:46:14PM +0100, David Hildenbrand (Red Hat) wrote:
>On 19.11.25 15:37, David Hildenbrand (Red Hat) wrote:
>> > > Given folio_test_swapcache() might have false positives,
>> > > I assume we'd need a
>> > > 
>> > > 	folio_test_swapbacked() && folio_test_swapcache(folio)
>> > > 
>> > > To detect large large shmem folios in the swapcache in all cases here.
>> > > 
>> > > Something like the following would hopefully do:
>> > > 
>> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> > > index 2f2a521e5d683..57aab66bedbea 100644
>> > > --- a/mm/huge_memory.c
>> > > +++ b/mm/huge_memory.c
>> > > @@ -3515,6 +3515,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>> > >           return ret;
>> > >    }
>> > >    +static bool folio_test_shmem_swapcache(struct folio *folio)
>> > > +{
>> > > +       VM_WARN_ON_ONCE_FOLIO(folio_test_anon(folio), folio);
>> > > +       /* These folios do not have folio->mapping set. */
>> > > +       return folio_test_swapbacked(folio) && folio_test_swapcache(folio);
>> > > +}
>> > > +
>> > >    bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>> > >                   bool warns)
>> > >    {
>> > > @@ -3524,6 +3531,9 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>> > >                                   "Cannot split to order-1 folio");
>> > >                   if (new_order == 1)
>> > >                           return false;
>> > > +       } else if (folio_test_shmem_swapcache(folio)) {
>> > > +               /* TODO: support shmem folios that are in the swapcache. */
>> > > +               return false;
>> > 
>> > With this, truncated shmem returns -EINVALID instead of -EBUSY now.
>> > Can s390_wiggle_split_folio() such folios?
>> 
>> [noting that s390_wiggle_split_folio() was just one caller where I new
>> the return value differs. I suspect there might be more.]
>> 
>> I am still not clear on that one.
>> 
>> s390x obtains the folio while walking the page tables. In case it gets
>> -EBUSY it simply retries to obtain the folio from the page tables.
>> 
>> So assuming there was concurrent truncation and we returned -EBUSY, it
>> would just retry walking the page tables (trigger a fault to map a
>> folio) and retry with that one.
>> 
>> I would assume that the shmem folio in the swapcache could never have
>> worked before, and that there is no way to make progress really.
>> 
>> In other words: do we know how we can end up with a shmem folio that is
>> in the swapcache and does not have folio->mapping set?
>> 
>> Could that think still be mapped into the page tables? (I hope not, but
>> right now I am confused how that can happen )
>> 
>
>Ah, my memory comes back.
>
>vmscan triggers shmem_writeout() after unmapping the folio and after making sure that there are no unexpected folio references.
>
>shmem_writeout() will do the shmem_delete_from_page_cache() where we set folio->mapping = NULL.
>
>So anything walking the page tables (like s390x) could never find it.
>
>
>Such shmem folios really cannot get split right now until we either reclaimed them (-> freed) or until shmem_swapin_folio() re-obtained them from the swapcache to re-add them to the swapcache through shmem_add_to_page_cache().
>
>So maybe we can just make our life easy and just keep returning -EBUSY for this scenario for the time being?
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 2f2a521e5d683..5ce86882b2727 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>        if (folio != page_folio(split_at) || folio != page_folio(lock_at))
>                return -EINVAL;
>+       /*
>+        * Folios that just got truncated cannot get split. Signal to the
>+        * caller that there was a race.
>+        *
>+        * TODO: this will also currently refuse shmem folios that are in
>+        * the swapcache.
>+        */
>+       if (!is_anon && !folio->mapping)
>+               return -EBUSY;
>+
>        if (new_order >= folio_order(folio))
>                return -EINVAL;
>@@ -3659,17 +3669,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>                gfp_t gfp;
>                mapping = folio->mapping;
>-
>-               /* Truncated ? */
>-               /*
>-                * TODO: add support for large shmem folio in swap cache.
>-                * When shmem is in swap cache, mapping is NULL and
>-                * folio_test_swapcache() is true.
>-                */
>-               if (!mapping) {
>-                       ret = -EBUSY;
>-                       goto out;
>-               }
>+               VM_WARN_ON_ONCE_FOLIO(!mapping, folio);
>                min_order = mapping_min_folio_order(folio->mapping);
>                if (new_order < min_order) {
>

One more thing come up my mind.

Current folio_split_supported() is used in try_folio_split_to_order().

Here are related commits:

[1] commit 7460b470a131f985a70302a322617121efdd7caa
    Author: Zi Yan <ziy@nvidia.com>
    Date:   Fri Mar 7 12:40:00 2025 -0500

        mm/truncate: use folio_split() in truncate operation

[2] commit 77008e1b2ef73249bceb078a321a3ff6bc087afb
    Author: Zi Yan <ziy@nvidia.com>
    Date:   Thu Oct 16 21:36:30 2025 -0400
    
        mm/huge_memory: do not change split_huge_page*() target order silently

[1] looks fine, because before calling folio_split_supported(),
min_order_for_split() would return negative if !folio->mapping.

But [2] moves min_order_for_split() from try_folio_split_to_order() to it
caller.

Currently it looks good, but not sure it will leave potential misuse.

>
>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

