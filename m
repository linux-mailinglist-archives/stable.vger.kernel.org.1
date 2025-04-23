Return-Path: <stable+bounces-136470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651DA99818
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0E3440CE6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91E28CF61;
	Wed, 23 Apr 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DIrA19eE"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD525CC73;
	Wed, 23 Apr 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433776; cv=none; b=sw8xtn9LRBd1NjrnpMsD04SyUW0o+X9dodnuoLywGl5jXZ2LqNl+XJrTrctw4R6F0pmV9Ph0yAL2H36y5w0ghOcAze5B0TeLLdxNap1Sx7IKtteqn5rRGL4z90XcDQFqVVXtv7uaiMmjCD+Rp0/of1ibQlm/se9RDrk0bQ/vi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433776; c=relaxed/simple;
	bh=5z7cjOyEamlQH3pwzXxO5wp1qSdeGHjnJYbTuF++6OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsO73p/tZyGm9lfBTG8JTbhoe2TA0a4z2emXGVA/ON093ojOvGIZ0ClGJ01dX6aRMItTMfQoKonoqNon7GzldYdii0pvB5ajKy/2LvB4vmK34Vzkt+5FmQNBPoTyCQrc13xqJDne2aUdn4JZqLit9v5BFAeLHMRfGBOuMir1ePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DIrA19eE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BA5F40E0192;
	Wed, 23 Apr 2025 18:42:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id b_q9ku6oQs4F; Wed, 23 Apr 2025 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745433764; bh=4QYwqXRcz4L81CMD3HxW+21FD+WaKwTbBEoH7IXvigA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIrA19eEjNfWtT787gu6rEJSRExOKb0AL8To3VBmth7NyiM+X66qOLiRb5hHhK+qn
	 VLR216whrM4s8CTXnkPf1NP+DY7nobyd5e4swJIJTbbBbhhS2B1fVhYRU890QL5Ae0
	 /c9r1XbzS4E5e8Ja0KD3DVT+w2KjUIW+fN+jtxRuDB+Mrlfs6vXLk27ZZwFxt4Dzwc
	 YzsayQSYgiMVfVLRhM/Ry+1LVGLkYfqsbZHE/52Okn9PQ/nPPKifq+X0GTE+FL7i6l
	 5+jmSd0W2CZAlbNdXYzJ1xMNaFQ6CXT6tWhTjurtbAhEkxT83tWeIxZJa7o5rQEfjZ
	 TgpB0dahyiUPY9yuMMXRzPIBpYD/NpFywzUzom4pr2jZVLA8fZrc7dbFaYyLklvPV2
	 v+M1UEQ63McL/5Io8VGXldkd7EZLTO7dZCp61m6Pj4KgwCCIKjRk5U16FkYwPugq90
	 31v9oxY8ELx+t0DV3+ci8ugxNFMrwtQEzfl2Cb/l79lkNKQ1e1OJp2omeSEY5dvjLt
	 1AmM948qC4IsYGbN0VEuHcFRvrq+quYFStqL6H78ExPPk5vsUsGtpyNQyJkpKU4kmW
	 9q5ttq8JP4fEdAjprrwrLEo5L5YXY+F+zs4zEdDgeAceMnv1ZARqwyuvmVvFcdxJI4
	 7GTAilLzyQDGL9KGebdKFGxE=
Received: from rn.tnic (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4F45240E01ED;
	Wed, 23 Apr 2025 18:42:25 +0000 (UTC)
Date: Wed, 23 Apr 2025 20:43:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: CONFIG_X86_HYPERVISOR (was: Re: [PATCH AUTOSEL 5.10 2/6]
 x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when
 running in a virtual machine)
Message-ID: <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local>
References: <aAKDyGpzNOCdGmN2@duo.ucw.cz>
 <aAKJkrQxp5on46nC@google.com>
 <20250418173643.GEaAKNq_1Nq9PAYf4_@fat_crate.local>
 <aAKaf1liTsIA81r_@google.com>
 <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local>
 <aAfQbiqp_yIV3OOC@google.com>
 <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local>
 <aAfynEK3wcfQa1qQ@google.com>
 <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local>
 <aAj0ySpCnHf_SX2J@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAj0ySpCnHf_SX2J@google.com>

On Wed, Apr 23, 2025 at 07:10:17AM -0700, Sean Christopherson wrote:
> On Wed, Apr 23, 2025, Borislav Petkov wrote:
> > > Eww.  Optimization to lessen the pain of DR7 interception.  It'd be nice to clean
> > > this up at some point, especially with things like SEV-ES with DebugSwap, where
> > > DR7 is never intercepted.
> > >   arch/x86/include/asm/debugreg.h:        if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
> > >   arch/x86/kernel/hw_breakpoint.c:                 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()
> > 
> > Patch adding it says "Because DRn access is 'difficult' with virt;..."
> > so yeah. I guess we need to agree how to do debug exceptions in guests.
> > Probably start documenting it and then have guest and host adhere to
> > that. I'm talking completely without having looked at what the code does
> > but the "handshake" agreement should be something like this and then we
> > can start simplifying code...
> 
> I don't know that we'll be able to simplify the code.
> 
> #DBs in the guest are complex because DR[0-3] aren't context switched by hardware,
> and running with active breakpoints is uncommon.  As a result, loading the guest's
> DRs into hardware on every VM-Enter is undesirable, because it would add significant
> latency (load DRs on entry, save DRs on exit) for a relatively rare situation
> (guest has active breakpoints).
> 
> KVM (and presumably other hypervisors) intercepts DR accesses so that it can
> detect when the guest has active breakpoints (DR7 bits enabled), at which point
> KVM does load the guest's DRs into hardware and disables DR interception until
> the next VM-Exit.
> 
> KVM also allows the host user to utilize hardware breakpoints to debug the guest,
> which further adds to the madness, and that's not something the guest can change
> or even influence.
> 
> So removing the "am I guest logic" entirely probably isn't feasible, because in
> the common case where there are no active breakpoints, reading cpu_dr7 instead
> of DR7 is a significant performance boost for "normal" VMs.

So I see three modes:

- default off - the usual case

- host debugs the guest

- guests are allowed to do breakpoints

So depending on what is enabled, the code can behave properly - it just
needs logic which tells the relevant code - guest or host - which of the
debugging mode is enabled. And then everything adheres to that and DTRT.

But before any of that, the even more important question is: do we even
care to beef it up that much?

I get the feeling that we don't so it likely is a "whatever's the
easiest" game.

> I mentioned SEV-ES+ DebugSwap because in that case DR7 is effectively guaranteed
> to not be intercepted, and so the native behavior of reading DR7 instead of the
> per-CPU variable is likely desirable.  I believe TDX has similar functionality
> (I forget if it's always on, or opt-in).

Aha, the choice was made by the CoCo hw designers - guests are allowed
to do breakpoints.

Oh well...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

