Return-Path: <stable+bounces-119757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D32A46D58
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 22:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DF16BF1B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C437224249;
	Wed, 26 Feb 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyPPWAxE"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA2218591
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605053; cv=none; b=idndGBNe05AZk5Epqx5gEGk5aYadINVMRGPQnj6W3YhiBitfdAvhM1NKJLgMj698RcOCqBfMlkvcDk8vM0Wm5TAVjQJfhM2zoz6SKCJ4EiX8HCllFa9bhiXAwVodhHfSAHQ7PZOYSIAGvY5BOAjGKL7TyIQ/oaYOIpo+hxJkwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605053; c=relaxed/simple;
	bh=t4znlvu/N1sdiJLnPFZguZXq2eiz7OvDH3WW/R0/urw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owel0CWNwop5hQw2eGEn8nPjE7s4Advnwlz1a4Ph9+wMTXmSwWrVzHm4N+0FCk7RWLDw4PKyVRi4D/lcxL5wMDQtjvVGq1qCxu34zlecie+XaliyuM7X8E/PAH4zI0ATZ537ZNg7PF7TFxjpe4wZ1n1aNkir2RhIUfbXFCffAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyPPWAxE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 21:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740605038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJQGr+aTHnne3w5uc9X4/jJeY03gqZ4f7+KcAq7dW68=;
	b=LyPPWAxEWmkvlpAaeOkB0LyTb0NOTyoQALIAYITZFvXbCw88dvPQBXQB/eTmb24p3dHat1
	ocBilEY5UdJy0v873ihFR79MORCfmEvIN5z4HrsdJV2uGgJQx7HxGbvOWYODYX1sN8JIF/
	v0rGNQ/GP1Apni1yTp6ebXEYPZKHj2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, linux-mm@kvack.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+1a517ccfcbc6a7ab0f82@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: zswap: fix crypto_free_acomp() deadlock in
 zswap_cpu_comp_dead()
Message-ID: <Z7-GaVJHC_1ynigx@google.com>
References: <20250226185625.2672936-1-yosry.ahmed@linux.dev>
 <20250226200016.GB3949421@google.com>
 <Z796VjPjno2PLTut@google.com>
 <20250226211628.GD3949421@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226211628.GD3949421@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 09:16:28PM +0000, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 08:32:22PM +0000, Yosry Ahmed wrote:
> > On Wed, Feb 26, 2025 at 08:00:16PM +0000, Eric Biggers wrote:
> > > On Wed, Feb 26, 2025 at 06:56:25PM +0000, Yosry Ahmed wrote:
> > > > Currently, zswap_cpu_comp_dead() calls crypto_free_acomp() while holding
> > > > the per-CPU acomp_ctx mutex. crypto_free_acomp() then holds scomp_lock
> > > > (through crypto_exit_scomp_ops_async()).
> > > > 
> > > > On the other hand, crypto_alloc_acomp_node() holds the scomp_lock
> > > > (through crypto_scomp_init_tfm()), and then allocates memory.
> > > > If the allocation results in reclaim, we may attempt to hold the per-CPU
> > > > acomp_ctx mutex.
> > > 
> > > The bug is in acomp.  crypto_free_acomp() should never have to wait for a memory
> > > allocation.  That is what needs to be fixed.
> > 
> > crypto_free_acomp() does not explicitly wait for an allocation, but it
> > waits for scomp_lock (in crypto_exit_scomp_ops_async()), which may be
> > held while allocating memory from crypto_scomp_init_tfm().
> > 
> > Are you suggesting that crypto_exit_scomp_ops_async() should not be
> > holding scomp_lock?
> 
> I think the solution while keeping the bounce buffer in place would be to do
> what the patch
> https://lore.kernel.org/linux-crypto/Z6w7Pz8jBeqhijut@gondor.apana.org.au/ does,
> i.e. make the actual allocation and free happen outside the lock.

I am fine with a solution like that if Herbert is fine with it. Although
as I mentioned, I think this patch is nice to have anyway.

> 
> > > But really the bounce buffering in acomp (which is what is causing this problem)
> > > should not exist at all.  There is really no practical use case for it; it's
> > > just there because of the Crypto API's insistence on shoehorning everything into
> > > scatterlists for no reason...
> > 
> > I am assuming this about scomp_scratch logic, which is what we need to
> > hold the scomp_lock for, resulting in this problem.
> 
> Yes.
> 
> > If this is something that can be done right away I am fine with dropping
> > this patch for an alternative fix, although it may be nice to reduce the
> > lock critical section in zswap_cpu_comp_dead() to the bare minimum
> > anyway.
> 
> Well, unfortunately the whole Crypto API philosophy of having a single interface
> for software and for hardware offload doesn't really work.  This is just yet
> another example of that; it's a problem caused by shoehorning software
> compression into an interface designed for hardware offload.  zcomp really
> should just use the compression libs directly (like most users of compression in
> the kernel already do), and have an alternate code path specifically for
> hardware offload (using acomp) for the few people who really want that.

zcomp is for zram, zswap does not use it. If zswap is not going to use
the crypto API we'll want something like zcomp or maybe reuse zcomp
itself. That's a problem for another day :) 

