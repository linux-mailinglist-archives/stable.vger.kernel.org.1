Return-Path: <stable+bounces-176500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E7B381C8
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 13:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5913B97F3
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A92F0C66;
	Wed, 27 Aug 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ly7Ftn4O"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0932EF654;
	Wed, 27 Aug 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295694; cv=none; b=s4DLxoe1gtAdMYj77dMkTCpa5ExmtwVq+eZG3xFSDN3CkCfQ9Fpx6Xtjz+Xuhpe9DxYT7EzGx84fG5GAI0BFbjxO45oztJi19eXcJ9JsHTnQRkRjJp1VoQB+m0sc4dmjpIMKqOuoYT+39BOYPZ2EAyqcVPu1++Y/9ZLK18EBtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295694; c=relaxed/simple;
	bh=DgO9Epj7G2V28nyOzTrJaqwkdkVXgDII+nsQFo4uC20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwRksWaqtSFy9HJUQYkA/mQul7BWp1Xp28q2viSc80nqlfd8WuOc3PW0ADVqFVmTjySXRNMALE9SB6rsUBQXsnri36/SVYk/3ydBUwl4Og6r3JdF6gVm6I8KFKYiMFjM5W0ZwW9TAstHmd8HnWNT3jXnPBr5/uuiXMule41O80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ly7Ftn4O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1SETbkkiyAcHoMOg7Wufx5MV5M7AVJxVK6U7XSX1J5g=; b=Ly7Ftn4ODuY2i0EHsYb5yvwujB
	NC4Bc+N7474XTWJCxKx36OhqN25SeLOTtvPv8bciOggkYnu5AhL/87gi4ICNdFZqHr10w4sCcXia4
	mcnhh1BrY0EygFMjzg/P9zGbgKmLn1MHwtUYzhwJwiyvA02cNYZlbW5bPpkI/KCEgtG1PxjJN/p77
	v87riijzESGWjixPb9IjaJwfChuEenLkfIgnvzvHYFIkSWCHQdSH4fgDnlM317ITgcCjue0SmfMHi
	O7WOvisvcbMjnt2JOBkWDSY1SFP2YYcVr8N/IthEYTVKKQgv3EgwZZtEMPZ0yyMPADvow0kbt3bfa
	KNFzGrsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urEjn-00000004QAZ-0REC;
	Wed, 27 Aug 2025 11:54:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4979C3002BF; Wed, 27 Aug 2025 13:54:47 +0200 (CEST)
Date: Wed, 27 Aug 2025 13:54:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Eero Tamminen <oak@helsinkinet.fi>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250827115447.GR3289052@noisy.programming.kicks-ass.net>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
 <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
 <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org>
 <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
 <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org>

On Wed, Aug 27, 2025 at 05:17:19PM +1000, Finn Thain wrote:
> 
> On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> 
> > On Mon, Aug 25, 2025 at 06:03:23PM +1000, Finn Thain wrote:
> > > 
> > > On Mon, 25 Aug 2025, Peter Zijlstra wrote:
> > > 
> > > > 
> > > > And your architecture doesn't trap on unaligned atomic access ?!!?!
> > > > 
> > > 
> > > Right. This port doesn't do SMP.
> > 
> > There is RMW_INSN which seems to imply a compare-and-swap instruction of 
> > sorts. That is happy to work on unaligned storage?
> > 
> 
> Yes, the TAS and CAS instructions are happy to work on unaligned storage. 
> 
> However, these operations involve an indivisible bus cycle that hogs the 
> bus to the detriment of other processors, DMA controllers etc. So I 
> suspect lock alignment would tend to shorten read-modify-write cycles, and 
> improve efficiency, when CONFIG_RMW_INSN is enabled.
> 
> Most m68k platforms will have CONFIG_RMW_INSN disabled, or else simply 
> don't implement TAS and CAS. In this case, lock alignment might still 
> help, just because L1 cache entries are long words. I've not tried to 
> measure this.

Fair enough; this sounds a little like the x86 LOCK prefix, it will work
on unaligned memory, but at tremendous cost (recent chips have an
optional exception on unaligned).

Anyway, I'm not opposed to adding an explicit alignment to atomic_t.
Isn't s32 or __s32 already having this?

But I think it might make sense to have a DEBUG alignment check right
along with adding that alignment, just to make sure things are indeed /
stay aligned.

