Return-Path: <stable+bounces-195207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F44C717DB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 0BB992967F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97D3597B;
	Thu, 20 Nov 2025 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb9hoHzh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70395433AD
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596996; cv=none; b=qdgv5rJkZxR1nEcwulCtvu5PJm3XK31ZVhxZTS0QPiUk7zypACjJf9dI9BOzIovQty2sdQYvL7TI5/JMWV0K0pOILbJQp+stkXEBOu/alXMRpnkpJLsnskVGeUqbpjQwKUS+l+feIvAu6bPe9uJyFFjrT4bmrmhg95PXO6MLS3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596996; c=relaxed/simple;
	bh=d/oLv0C3UdluSdiB49o+78hCRD1kOlM34qb1o0Gpch8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MosvZ2ZVirwWpmaDoLwKJQE7fpfknckQlLOX5+GTNLlFs9zuucJpmHobou3RZdUBfmwlGbfxYqaSS7RCjwNKLxbTekbmIyh8ZywMvoRlocKtE1ewTeME7gJQtbsIiaV5JmcVxHHhL00SZKdo9eUMP9/0bvmLRnnNuS/+8oYzqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb9hoHzh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7277324054so49734966b.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 16:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763596993; x=1764201793; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t+tZGe9uPMEL6NC2FsGJb7IY/g6VnOK/izDWaDIkV8=;
        b=cb9hoHzh0HLWGBLuWMUlIty+PrbKjx+7QQK63zMuKc5TOzsqh6vMtuZMHKe0w5bt65
         so84bI7i4bIBnAQhbBqm2RoXVfLNlt9syADNFOROpii7C/2A1G5A7H+atGXC6ZmYzIyg
         TaPOx7gbXQlJddLGAkszZUEijfdWBAbGJK7hoKjyECouQKZb0bFHIDs1pff+eo5zKn7v
         lqk1/qiPFp8i7EjnB+SWtiHyX/vfkevTqYj6qX8uXHn8P8SXudlauT+vkiO8zJ2aHUyO
         kIgcl/FLVjCKVh6aDNYhRyxcZt5b4u4rppv31+2pfyLNFuYOHHXJruXVAWlUKrP2W+tW
         ENjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763596993; x=1764201793;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9t+tZGe9uPMEL6NC2FsGJb7IY/g6VnOK/izDWaDIkV8=;
        b=HvvXseFX3Qk4bd+blHS8tFaPJB12BXggTxBq/dDpMdhQTggP1Dgtp7kh1tT+zVIVrt
         nNOAUL37jxEaFn4tfXCM4+cXihawF7BECf2Bc7umcXf/cEqpsFDqQfNSBVPDI/TuPQvY
         KrIbHreDmkTvxJ5rig/UeTyDmxjhmvo+VWPtER56HGSIA8dzdh+xOnFg1N60aPRpXB+m
         WOfAH3NC/OvxZFJ5OmxFE++mFDLF9MMIGgm03rbD/0OsNjVUFEcc8dUkiaITcMFzEA7R
         QwhVH3q4XyL+sowMas+ZQiDNpIWkks0oep4e1+hNf++y0mLGuYHDY8z0uo86FcRTBRrM
         9WVg==
X-Forwarded-Encrypted: i=1; AJvYcCVnf0r50lfWDmpvIqWZddz4eRAKsH9B4cpQII/UoUFJoTHvT/00VAuWgtg714+iiQP9nJu8QlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYM0OCvZ3DyOXiLTspjcN9oufKJv7K8E7y5fvwfhZq+vG7bhuL
	xfHRwuhRF6+7SGu6dFblpz7jk1VVNpMJD3o5iTC/i1Bcqq6/kQBwVcrh
X-Gm-Gg: ASbGnctzW0RAGwIqvzGPYSxYgaGHtfj+TVFKlvyzqq16qdHrgxNL2gTowvaNRPh17Vm
	zj8D9Q1Jo4cpEVAJY5NVs7kpJYKkCT4if7MkDVV0pwTngnOJxtwa/zlldEeEM06cYdFxm/N4PrH
	z1LRSdJJ+RsG1fCBLTa6f38OWDJUbMb49/jomuvlwE9JR1mu0+3kEi+ITwd1PUDND3AQcwbvVJV
	POFuo44wsz9txME4nr2uF3d57ZmWmR9YPHzAmi/3n1NSySLUXIIJqpwph4v8OoyVcEgcmioX3i8
	UmZADSfehQBIYTShrYDpPZIc98mWyxJAOQMQCom7MPL+cp70BNF1l7teZLWZ8EZcJlqKQxd6/GM
	pYH7ObVGSb2u8CAQIzLo61LLO4UQA/r+IqJNiaXy3bNC9F8dyDKThuSIfZ7UZGxNpH35TQTZR0t
	LN7d9nbwwx/NLrDHQyGubosUvG
X-Google-Smtp-Source: AGHT+IHT2hZSu74IUohA1zPTQeoQ1iTPEo0hunoIYzaiahhr9utAe+nh50zUj9sCroMbMDw+uYE68g==
X-Received: by 2002:a17:906:ee8d:b0:b73:398c:c5a7 with SMTP id a640c23a62f3a-b7655457881mr99890766b.41.1763596992696;
        Wed, 19 Nov 2025 16:03:12 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655050d05sm60811066b.70.2025.11.19.16.03.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Nov 2025 16:03:12 -0800 (PST)
Date: Thu, 20 Nov 2025 00:03:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix NULL pointer deference when
 splitting folio
Message-ID: <20251120000312.xasxdzmmztvp4spa@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119235302.24773-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 19, 2025 at 11:53:02PM +0000, Wei Yang wrote:
>Commit c010d47f107f ("mm: thp: split huge page to any lower order
>pages") introduced an early check on the folio's order via
>mapping->flags before proceeding with the split work.
>
>This check introduced a bug: for shmem folios in the swap cache and
>truncated folios, the mapping pointer can be NULL. Accessing
>mapping->flags in this state leads directly to a NULL pointer
>dereference.
>
>This commit fixes the issue by moving the check for mapping != NULL
>before any attempt to access mapping->flags.
>
>Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Cc: Zi Yan <ziy@nvidia.com>
>Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>Cc: <stable@vger.kernel.org>
>
>---
>This patch is based on current mm-new, latest commit:
>
>    febb34c02328 dt-bindings: riscv: Add Svrsw60t59b extension description
>
>v2:
>  * just move folio->mapping ahead
>---
> mm/huge_memory.c | 22 ++++++++++------------
> 1 file changed, 10 insertions(+), 12 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index efea42d68157..4e9e920f306d 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3929,6 +3929,16 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
> 		return -EINVAL;
> 
>+	/*
>+	 * Folios that just got truncated cannot get split. Signal to the
>+	 * caller that there was a race.
>+	 *
>+	 * TODO: this will also currently refuse shmem folios that are in the
>+	 * swapcache.
>+	 */
>+	if (!is_anon && !folio->mapping)
>+		return -EBUSY;
>+

This one would have a conflict on direct cherry-pick to current master and
mm-stable.

But if I move this code before (folio != page_folio(split_at) ...), it could
be apply to mm-new and master/mm-stable smoothly.

Not sure whether this could make Andrew's life easier.

> 	if (new_order >= old_order)
> 		return -EINVAL;
> 
>@@ -3965,18 +3975,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 		gfp_t gfp;
> 
> 		mapping = folio->mapping;
>-
>-		/* Truncated ? */
>-		/*
>-		 * TODO: add support for large shmem folio in swap cache.
>-		 * When shmem is in swap cache, mapping is NULL and
>-		 * folio_test_swapcache() is true.
>-		 */
>-		if (!mapping) {
>-			ret = -EBUSY;
>-			goto out;
>-		}
>-
> 		min_order = mapping_min_folio_order(folio->mapping);
> 		if (new_order < min_order) {
> 			ret = -EINVAL;
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

