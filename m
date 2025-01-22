Return-Path: <stable+bounces-110141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DCA18FCF
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A01C7A3069
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBD20F987;
	Wed, 22 Jan 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iac3jNI5"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDF2116E4;
	Wed, 22 Jan 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542034; cv=none; b=YfluRGKGz3prrl50bEUS9th2iLJRsIOmgrSa9eQ+rellRtzp2MleBJKwF7Op4GiO+VPw03fHaWlRx0vK1JWO9AEalGDnArHfKGWzGHWdTCqXfYFeFxTbpqGsBg1so2lcCBz5tY/DMzO5d/yFdhC6W8xdpxC2ZkEQ/oXF89O4aB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542034; c=relaxed/simple;
	bh=ILeL1f47+GrAkZGDR+iHJ+46qy9WChsGKIrJFHET4TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB5wyrriYapnNMaXvBV4DYxM+NsWwzyFlYneEg0AotqxnyrrmNOHVsIatwjoUEnaj1oPW1S7rCKMHomqVf0IqobKvXkrwcUMwARK4PMt/TsXB7WLK71/73PM2OtrBFl7ZGl/hkcOID4nMEoGeorVUEePTAGREzmYOzikN24++LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iac3jNI5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=r8sXUK4Pu9xGMjH962+/871eElt5bfW0WpR7Q201t6I=; b=Iac3jNI5yHgS01QaEd/r16IoLb
	8EhbgbOxR7p4Zdyi6+LcI3dFKphaBmEmwC3rJrPPUSr8JxJfS59gOAJVKNzAY/Ialvj4sPYTqvOmq
	i9+mtvsueaWHVsoA6IXoE7DGsVVqPtyNWcpNCf/ctXJpQZwkf4LrLGBOchiytTZwOB0i5Ophshu/M
	wnF4o+mtaEdLJ3l/r5Fll1JOpjMmgsviHj44DYOYMI++QaMBridyQzgRdA+wRZU5pa1bHxTH+djxe
	L30LxE4vxCXIGNJEOvzz6jTJgfYMW2qYMHApDSNJuSlbRpFe1+LOUT1lBwtj5VK+33cpp5Q00Q4O0
	gMqP7VaQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taY3P-0000000140z-48tE;
	Wed, 22 Jan 2025 10:33:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 455E6300599; Wed, 22 Jan 2025 11:33:47 +0100 (CET)
Date: Wed, 22 Jan 2025 11:33:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix flush_tlb_range() when used for zapping
 normal PMDs
Message-ID: <20250122103347.GH7145@noisy.programming.kicks-ass.net>
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
 <a1fff596435121b01766bed27e401e8a27bf8f92.camel@surriel.com>
 <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1d9VdW+UQ3RYXMAe1-9muqz3SrC_cZ4UvcB=jpfR2X=Q@mail.gmail.com>

On Fri, Jan 03, 2025 at 11:11:51PM +0100, Jann Horn wrote:
> On Fri, Jan 3, 2025 at 10:55 PM Rik van Riel <riel@surriel.com> wrote:
> > On Fri, 2025-01-03 at 19:39 +0100, Jann Horn wrote:
> > > 02fc2aa06e9e0ecdba3fe948cafe5892b72e86c0..3da645139748538daac70166618d
> > > 8ad95116eb74 100644
> > > --- a/arch/x86/include/asm/tlbflush.h
> > > +++ b/arch/x86/include/asm/tlbflush.h
> > > @@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask
> > > *cpumask,
> > >       flush_tlb_mm_range((vma)->vm_mm, start,
> > > end,                  \
> > >                          ((vma)->vm_flags &
> > > VM_HUGETLB)           \
> > >                               ?
> > > huge_page_shift(hstate_vma(vma))      \
> > > -                             : PAGE_SHIFT, false)
> > > +                             : PAGE_SHIFT, true)
> > >
> > >
> >
> > The code looks good, but should this macro get
> > a comment indicating that code that only frees
> > pages, but not page tables, should be calling
> > flush_tlb() instead?
> 
> Documentation/core-api/cachetlb.rst seems to be the common place
> that's supposed to document the rules - the macro I'm touching is just
> the x86 implementation. (The arm64 implementation also has some fairly
> extensive comments that say flush_tlb_range() "also invalidates any
> walk-cache entries associated with translations for the specified
> address range" while flush_tlb_page() "only invalidates a single,
> last-level page-table entry and therefore does not affect any
> walk-caches".) I wouldn't want to add yet more documentation for this
> API inside the X86 code. I guess it would make sense to add pointers
> from the x86 code to the documentation (and copy the details about
> last-level TLBs from the arm64 code into the docs).

Right, that documentation update might be nice.

Anyway, I'm picking up this patch for tip/x86/mm once -rc1 happens.

Thanks!

