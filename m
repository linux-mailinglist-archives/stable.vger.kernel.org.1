Return-Path: <stable+bounces-227172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AbnAn0au2k+fAIAu9opvQ
	(envelope-from <stable+bounces-227172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:34:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8D2C30E7
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF21321D1BA
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D8E388E64;
	Wed, 18 Mar 2026 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4Ik2h2/"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85238A73D;
	Wed, 18 Mar 2026 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869438; cv=none; b=E2PyORq77FMw6zHQY0kV1bH0qKjTZr4t9xjrl5TXof8p8QDNO7qUlSpRPXBJXz8GuyqOmNBgESpbgZ5VzWlTcQfCKB9uRFmcgYonubwzKUurQiFragZ4ejawh/bP/VvFX5GkBrT9ZgYCRXSxmq4QwemawYaUufOInAWcgku6ZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869438; c=relaxed/simple;
	bh=j8P6XA3phh4loiw/P2IzqXacEwrJcZ/OQXQmSsiMgFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBQAG/nCk3Aqmt4JIw4wnSgyJICAJP8quGKbgoBzJVfakuLHVKRW29LSRsQFd0SyYldsW5EBIdH0wo3Fk/FkF79m+qmhtVn5ggnl3Gdm53ffHlEIzxthgWy2zZRse7NUlEJcEpGnVEhhhtlwOEQOV815eyGhY2snil2E/FzAncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4Ik2h2/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x1352H4Ct4rnpL7fyNSvQ5yARD0zPDaJWM0fA3ySkQQ=; b=S4Ik2h2/vW7AKvVo0g0MY0vLBv
	ql1hGB5xdUqgLHe046TGA3sAJhGPUkLS2WdbAPt0ovYsCy/vww399BrkSwi5bVnDe7i0BivicnJlj
	3Uhsgy8KIAySGWK7T8ftM5mmzR9BIkOSJA9eV6Pbrx3l7oAAxFmptIWmvLl0Uip0UecgtPXSsR/3u
	/uOprV7km0moNEt6XN8d5gOAy7DGKPfDXaRteecHD7AozP9tcm458DEmqKaVgtCPS8dotBQO6m35k
	D5qqoWIm4LN8TH+fSbPHnmBlyZaM9db92ydGmrVQ+8lF899godTScFf2LlyekM7p9VNThciFpWb+E
	eCWBjreg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2yTG-000000052eE-1rPl;
	Wed, 18 Mar 2026 21:30:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DEFC23004F8; Wed, 18 Mar 2026 22:30:29 +0100 (CET)
Date: Wed, 18 Mar 2026 22:30:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260318213029.GP3738010@noisy.programming.kicks-ass.net>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
 <20260318210813.GEabsUPblg3mkGxMqk@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318210813.GEabsUPblg3mkGxMqk@fat_crate.local>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227172-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: A6A8D2C30E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:08:13PM +0100, Borislav Petkov wrote:
> On Wed, Mar 18, 2026 at 09:47:22PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 18, 2026 at 06:51:10PM -0000, tip-bot2 for Dave Hansen wrote:
> > > --- a/arch/x86/kernel/cpu/common.c
> > > +++ b/arch/x86/kernel/cpu/common.c
> > > @@ -437,6 +437,21 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
> > >  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> > >  static unsigned long cr4_pinned_bits __ro_after_init;
> > >  
> > > +static bool cr_pinning_enabled(void)
> > > +{
> > > +	if (!static_branch_likely(&cr_pinning))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * Do not enforce pinning during CPU bringup. It might
> > > +	 * turn on features that are not set up yet, like FRED.
> > > +	 */
> > > +	if (!cpu_online(smp_processor_id()))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > 
> > Urgh, so this means all an attack needs to do is disable the online bit
> > and it gets to poke CR4 bits.
> > 
> > This seems unfortunate.
> > 
> > And sure, randomly clearing the online bit will eventually cause havoc,
> > but I suspect you still get plenty time until the system goes wobbly.
> 
> My idea was that this is only temporary and then, ontop, we'll do something

This isn't temporary, this is marked for infinite backports :/ And it is
really really bad.

> like this:
> 
> https://lore.kernel.org/r/cb492a37-3517-4738-b435-73311402e820@intel.com

I'm not understanding.

> I.e., you figure out all the CR4 pinned bits on the BSP *once*, cast them in
> stone and then replicate them on the APs when they come up.

That's what we do now. Its just that the AP bringup code doesn't seem
capable of dealing with this.

