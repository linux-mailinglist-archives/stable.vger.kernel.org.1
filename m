Return-Path: <stable+bounces-144368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A07AB6B77
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7364A0676
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A7272E4F;
	Wed, 14 May 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fWAkyBLb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3g5jwMC"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39C225401
	for <stable@vger.kernel.org>; Wed, 14 May 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226061; cv=none; b=bnti1mksvb9jqPciaDT5GD7P4VN/ul4BN9WCNUqmAKPhec+mnyEKdg+3zangqjfkCkDet2WF1AzQhP/1DR6LCUP7Dq6BLpumnDgu4mKN9w26YoJ5W6YLZ4uNaQE6u1KaF7rmsGE/CNekb8FrfNUE/RqjBdBmapagK3AJ/5SWtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226061; c=relaxed/simple;
	bh=V4enpT4DByOhJt17ArkkR/l1dPfdM466m2KfuD36n9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx5r8FWzinPHEicxIL9sQX+CHo33QySzLnQsYeEqjxFlX/uCwWSlsu/enL6Uzp6kecS9FUR620p8Sw79ZjPsKe6umv+Sfk4vFR+8H4qhc3X7QQUcsl3v6IEq35T5jpdRmgtS5M9emZ2pnRT5hBqKwDW/EsC+VyoCZSQFm8MxFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fWAkyBLb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3g5jwMC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B666C2540155;
	Wed, 14 May 2025 08:34:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 08:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747226054;
	 x=1747312454; bh=97neBx1tWKuZ17rsnXdhzvYDgSlwWh9yWI9TP6ZOeXg=; b=
	fWAkyBLbuMIZsCXcBK0Pm8ewOmJbiuIeT7FiyhvHi2GuuN8jJn3CE5DpB7YawoiC
	1+GoAYVbXYWXSrAbTpjFnP8Vbw+kzTZxIghwx0Drb7PCowlOBqAMEHVTlOSX5c62
	oJwXg+/JpxYVjPeF3lb/6hYiSc2qtAta1iMTEHLBJIwBbQlmcqsXSZVvVe5LSbOc
	nuvqrGORg0MQLW9rZKrH9CaRezkK7T7vjlHWXSBxYlEwh+OFwihXdGvt4W8n/WVS
	ZIsb6WoYz7TQsUObuN9cNGkCEuOFhyvcO1/lFuAyUmR6MZSTzH9RwaTfUPmPeDgZ
	0jF0B5Ni2bZpx8XEVEON7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747226054; x=
	1747312454; bh=97neBx1tWKuZ17rsnXdhzvYDgSlwWh9yWI9TP6ZOeXg=; b=A
	3g5jwMCo40Haze9ABxglu8p3fhu9wOr1s1iBx7wNMltWXJ500HiND9fAkzyE9K3n
	7hIMfU2h9KIFnJWQJloBrjnWYd0qfOSqyfxH13vakqsAlMrD3x5s9kqdAjicZkYd
	DxyXDV6hJyLKptzTNfHNb59+4cm4j+zqKFLWVnVk6Lw1FZMPQO6fVd+ZoFWSwToJ
	/xpOGsc+H9EnET9w34d2PJFYDs2qAvzCjT8sgSnO8AQXVbFyh44/WscOvpsO0iEG
	MyuJPvjS5nYqUYXZHN5TNF8iQmVaOzrUNulTmFb/MzqFGohJzrhznPyRGIyniNfg
	WjUHBr0zMErDpxcT9Ttvg==
X-ME-Sender: <xms:xo0kaMaed-U0fOeXYTcStS0pbridT0hdFhWZFDU2NRt0GaRmL2DNhA>
    <xme:xo0kaHaaEoeob5eZGIR_YZtzMaVs3i047X01NsnZMAgEkBCHBFgnZR27iSuU37kx8
    twC-6SUy8Rt6g>
X-ME-Received: <xmr:xo0kaG8g2ulFGMSW3eDijLSw5IuhjVoT-baQufXiSJtjtcclxQpdTG01C60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegveevtefgveejffffveeluefhjeefgeeuveeftedujedufedu
    teejtddtheeuffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgt
    ohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hhohhlghgvrhesrghpphhlihgvugdqrghshihntghhrhhonhihrdgtohhmpdhrtghpthht
    ohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrfigrnhdrkhhumhgr
    rhdrghhuphhtrgeslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:xo0kaGr1Ovh9EGLg08elKwn76Q0hnhL_o66TCkU3y9RftYEmAs3n8A>
    <xmx:xo0kaHp-kw8ohpNvC5l8xeP-qdzAvYi6XNM6rYkxb5nZTDj2rdR0DQ>
    <xmx:xo0kaEQSzQrEMw4Tl4e0EmaZkHSBZebOXFAZn1EYVRR09qKt9ZM1lw>
    <xmx:xo0kaHpwBxmfoPU2TGwV3MBj_ZJrbDixnePWdulGn4m9Rkho-j1b3w>
    <xmx:xo0kaF5k_H0qy49_hmisHbsqpQ9OfuMz79s95jiNXww-W5C-q6A2C3fu>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:34:13 -0400 (EDT)
Date: Wed, 14 May 2025 14:32:26 +0200
From: Greg KH <greg@kroah.com>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: 6.14.7-rc1: undefined reference to
 `__x86_indirect_its_thunk_array' when CONFIG_CPU_MITIGATIONS is off
Message-ID: <2025051416-pushing-pushiness-81b3@gregkh>
References: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
 <f88e97c3-aaa0-a24f-3ef6-f6da38706839@applied-asynchrony.com>
 <20250514113952.GB16434@noisy.programming.kicks-ass.net>
 <fe4e737e-d2b4-1d62-d5ef-b6f294f5909e@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe4e737e-d2b4-1d62-d5ef-b6f294f5909e@applied-asynchrony.com>

On Wed, May 14, 2025 at 02:11:26PM +0200, Holger Hoffstätte wrote:
> On 2025-05-14 13:39, Peter Zijlstra wrote:
> > On Wed, May 14, 2025 at 12:13:29PM +0200, Holger Hoffstätte wrote:
> > > cc: peterz
> > > 
> > > On 2025-05-14 09:45, Holger Hoffstätte wrote:
> > > > While trying to build 6.14.7-rc1 with CONFIG_CPU_MITIGATIONS unset:
> > > > 
> > > >     LD      .tmp_vmlinux1
> > > > ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
> > > > /tmp/linux-6.14.7/arch/x86/net/bpf_jit_comp.c:660:(.text+0x97e): undefined reference to `__x86_indirect_its_thunk_array'
> > > > make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
> > > > make[1]: *** [/tmp/linux-6.14.7/Makefile:1234: vmlinux] Error 2
> > > > make: *** [Makefile:251: __sub-make] Error 2
> > > > 
> > > > - applying 9f35e33144ae aka "x86/its: Fix build errors when CONFIG_MODULES=n"
> > > > did not help
> > > > 
> > > > - mainline at 9f35e33144ae does not have this problem (same config)
> > > > 
> > > > Are we missing a commit in stable?
> > > 
> > > It seems commit e52c1dc7455d ("x86/its: FineIBT-paranoid vs ITS") [1]
> > > is missing in the stable queue. It replaces the direct array reference
> > > in bpf_jit_comp.c:emit_indirect_jump() with a mostly-empty function stub
> > > when !CONFIG_MITIGATION_ITS, which is why mainline built and -stable
> > > does not.
> > > 
> > > Unfortunately it does not seem to apply on top of 6.14.7-rc1 at all.
> > > Any good suggestions?
> > > 
> > > thanks
> > > Holger
> > > 
> > > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e52c1dc7455d32c8a55f9949d300e5e87d011fa6
> > 
> > Right, this is forever the problem with these embargoed things that
> > side-step the normal development cycle and need to be backported to hell
> > :/
> > 
> > Let me go update this stable.git thing.
> > 
> > /me twiddles thumbs for a bit, this is one fat tree it is..
> > 
> > Argh, I needed stable-rc.git
> > 
> > more thumb twiddling ...
> > 
> > simply picking the few hunks from that fineibt commit should do the
> > trick I think.
> > 
> > /me stomps on it some ... voila! Not the prettiest thing, but definilty
> > good enough I suppose. Builds now, must be perfect etc.. :-)
> > 
> > ---
> > 
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> > index 47948ebbb409..f2294784babc 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/stringify.h>
> >   #include <linux/objtool.h>
> >   #include <asm/asm.h>
> > +#include <asm/bug.h>
> >   #define ALT_FLAGS_SHIFT		16
> > @@ -128,10 +129,17 @@ static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> >   extern void its_init_mod(struct module *mod);
> >   extern void its_fini_mod(struct module *mod);
> >   extern void its_free_mod(struct module *mod);
> > +extern u8 *its_static_thunk(int reg);
> >   #else /* CONFIG_MITIGATION_ITS */
> >   static inline void its_init_mod(struct module *mod) { }
> >   static inline void its_fini_mod(struct module *mod) { }
> >   static inline void its_free_mod(struct module *mod) { }
> > +static inline u8 *its_static_thunk(int reg)
> > +{
> > +	WARN_ONCE(1, "ITS not compiled in");
> > +
> > +	return NULL;
> > +}
> >   #endif
> >   #if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 7a10e3ed5d0b..48fd04e90114 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -240,6 +272,13 @@ static void *its_allocate_thunk(int reg)
> >   	return its_init_thunk(thunk, reg);
> >   }
> > +u8 *its_static_thunk(int reg)
> > +{
> > +	u8 *thunk = __x86_indirect_its_thunk_array[reg];
> > +
> > +	return thunk;
> > +}
> > +
> >   #endif
> >   /*
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a5b65c09910b..a31e58c6d89e 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -663,7 +663,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> >   	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
> >   		OPTIMIZER_HIDE_VAR(reg);
> > -		emit_jump(&prog, &__x86_indirect_its_thunk_array[reg], ip);
> > +		emit_jump(&prog, its_static_thunk(reg), ip);
> >   	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
> >   		EMIT_LFENCE();
> >   		EMIT2(0xFF, 0xE0 + reg);
> > 
> 
> Can confirm that it now links, as expected. Just in case:
> 
>   Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Wonderful, thanks for testing!

greg k-h

