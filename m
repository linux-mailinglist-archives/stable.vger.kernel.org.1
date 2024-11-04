Return-Path: <stable+bounces-89762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEB9BC0C9
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 23:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E82848B2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 22:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B21FCF5F;
	Mon,  4 Nov 2024 22:22:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752901FCC69;
	Mon,  4 Nov 2024 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758962; cv=none; b=r1VgpINLAwIw1WaEpmLndCg6P8Fbvfk1At3D3peq/o0Z9B8CFBNLjPlg7XycmAXOXNXZDq4kE3KZRsa2zlC0LsV9ByIB5kk0fDj57fRrwaZ8dkojW9AcJMVGznaimwDWR0lZKb4z4iQCGE3w/S/Yfnq6a1UgsAG0ry9b+Ecatb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758962; c=relaxed/simple;
	bh=fQDuHF64QCcKGHlSWkxvwvE/0DUo+g/TMJYzEtZ3hKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPEQU89UdZqgLMCfVRy7sjS0AUMf+d08C3osAUHWjLsl4V3CqOpiPP5/8YdqfBENpfU2HMiVIxciB/H+BbyKC2qF6/XVqeECNR8Z4ZZXbQVh/5qkQ4g5Figo9Y2blVbOgJwtxTERhy8UDciXUKnZRfx/NZYTlwFSECyeum6muKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7ECC4CECE;
	Mon,  4 Nov 2024 22:22:39 +0000 (UTC)
Date: Mon, 4 Nov 2024 22:22:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Koichiro Den <koichiro.den@gmail.com>,
	Peter Collingbourne <pcc@google.com>, cl@linux.com,
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, kees@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <ZylJLXSTAY8TLijb@arm.com>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
 <ZykLxG5Tyet5HcwL@casper.infradead.org>
 <8202821f-05bc-41f8-9de3-bf78899a7c7b@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8202821f-05bc-41f8-9de3-bf78899a7c7b@suse.cz>

On Mon, Nov 04, 2024 at 07:16:20PM +0100, Vlastimil Babka wrote:
> On 11/4/24 19:00, Matthew Wilcox wrote:
> > On Tue, Nov 05, 2024 at 12:08:37AM +0900, Koichiro Den wrote:
> >> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> >> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> >> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> >> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> >> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> >> size 16 twice. This duplication triggers warnings on boot:
> > 
> > Wouldn't this be easier?
> 
> They wanted it to depend on actual HW capability / kernel parameter, see
> d949a8155d13 ("mm: make minimum slab alignment a runtime property")
> 
> Also Catalin's commit referenced above was part of the series that made the
> alignment more dynamic for other cases IIRC. So I doubt we can simply reduce
> it back to a build-time constant.

I principle, I wouldn't reduce it back to constant though the 8 vs 16
difference is not significant. It matter if one enables KASAN_HW_TAGS
and wants to run it on hardware without MTE, getting the *-8 caches
back.

That said, I haven't managed to trigger this warning yet. Do I need
other config options than KASAN_HW_TAGS and DEBUG_VM?

-- 
Catalin

