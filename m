Return-Path: <stable+bounces-89763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F499BC0EF
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C290B22B6C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A41C32E2;
	Mon,  4 Nov 2024 22:28:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BC1FDF99;
	Mon,  4 Nov 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759322; cv=none; b=ZAZMWJKQAvp4Z5sbHnsq346dZ0VA0B7PAW9zFs6MVpGE7LPT7uSjs8MlgFHFrjeWcXlUixDmxvnUqmB8q3NaXTW6POOsfjm9czQhAu+hTOy4XxFbH6XuMdEb7ZEQMYCtBpKbhEhcCi1kZsKq3op4xdGNq/cgqWtJVAkZ6Cm8Cvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759322; c=relaxed/simple;
	bh=7MPzMViPAvZC3vHGGXul4FFQHAN/J3MNF/vSrZpqfhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+NvqBrkjLWupEBrVH7ahvv40YOdXGx/xpYZgGd/C/CJrvI+DLVAFuaMpYPs4HF2hV1XSDscZdT8+FqA8wvVfPzfIZi+pn1+Ml35MunAkUyMZ6bCqSVS0UMqpRR/C1GwA6JUkzFgBPrSR89uAe6XOSDFyPQFOKcRRF7ZN4HW7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17B9C4CECE;
	Mon,  4 Nov 2024 22:28:39 +0000 (UTC)
Date: Mon, 4 Nov 2024 22:28:37 +0000
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
Message-ID: <ZylKlUqHkzLNwEHA@arm.com>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
 <ZykLxG5Tyet5HcwL@casper.infradead.org>
 <8202821f-05bc-41f8-9de3-bf78899a7c7b@suse.cz>
 <ZylJLXSTAY8TLijb@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZylJLXSTAY8TLijb@arm.com>

On Mon, Nov 04, 2024 at 10:22:37PM +0000, Catalin Marinas wrote:
> On Mon, Nov 04, 2024 at 07:16:20PM +0100, Vlastimil Babka wrote:
> > On 11/4/24 19:00, Matthew Wilcox wrote:
> > > On Tue, Nov 05, 2024 at 12:08:37AM +0900, Koichiro Den wrote:
> > >> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> > >> if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> > >> However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> > >> This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> > >> resulting in kmem_buckets_create() attempting to create a kmem_cache for
> > >> size 16 twice. This duplication triggers warnings on boot:
> > > 
> > > Wouldn't this be easier?
> > 
> > They wanted it to depend on actual HW capability / kernel parameter, see
> > d949a8155d13 ("mm: make minimum slab alignment a runtime property")
> > 
> > Also Catalin's commit referenced above was part of the series that made the
> > alignment more dynamic for other cases IIRC. So I doubt we can simply reduce
> > it back to a build-time constant.
> 
> I principle, I wouldn't reduce it back to constant though the 8 vs 16
> difference is not significant. It matter if one enables KASAN_HW_TAGS
> and wants to run it on hardware without MTE, getting the *-8 caches
> back.
> 
> That said, I haven't managed to trigger this warning yet. Do I need
> other config options than KASAN_HW_TAGS and DEBUG_VM?

Ah, I was missing SLAB_BUCKETS. I'll have a look tomorrow.

-- 
Catalin

