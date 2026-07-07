Return-Path: <stable+bounces-272350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAAUHFOYTGoqmwEAu9opvQ
	(envelope-from <stable+bounces-272350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:10:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05A717C82
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 08:10:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=ZwmlMDRN;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=sy2kZwDT;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272350-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272350-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39185301303B
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 06:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E93876B8;
	Tue,  7 Jul 2026 06:10:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C1217F27;
	Tue,  7 Jul 2026 06:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404622; cv=none; b=emSa5dNHopU4xUqiO3m40n+DKGhoKK3nqqUG3Tgs2w8A854UtH9GHNilrQBSTpBB4R2/t+n28Vg0GC3ptOFTfbmPbYZFrGE2QDh/Cp7vhKN0k+mJy4R6kPQT0uguJFgOIgUnOkCydMr54UhpuKgRo9D64OEMd9dzdVelVx9wXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404622; c=relaxed/simple;
	bh=EqpZfHi1bCaqP6NL8EAd2N5fLRl5b9vzswnYHDcYwUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg1qBm7GyApo7K7VOBmabUKRSxHX3Lh4PjMrWqbIDsb3gFAcFk1a6WmWs9rwAdDKyzIZu4GIRhASXZh+vdR95KYa+5lMfYW+tVdJrOhARK9O1P1kH+pbBBqJP7SeK74IRUz/9y8vjIkCbFexvdu/3Kv2/skCymrDFRlRyOL6r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwmlMDRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sy2kZwDT; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 7 Jul 2026 08:10:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783404619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0G9aukPV8pHjfG+rgqcQ/xQgpRWVh1vDYEUguo9B9Ag=;
	b=ZwmlMDRN9xRHfKOH5ruRR1URwK7dGw9QLIo/Qh0p5RPvQiLOMmbvkJHa+C1B/tAF1xi7OC
	20fO60M/VWCv1vtHjBCf52h+pqyXJ/5toDs0w07W0z7YpSyhRmEM7KkA9HwCNBcHKApK4C
	etG9k7ICTkBGR0zg3mNq6YQUUwfkDdeJNuOs4AccYHNfqIwn9AGL52TPKzdDXInSOBTIqM
	RGQ64SNvm57vbngaxCUM6O/xCVcLxboCaXCd1W91xOKwLtpxLRdQ1si92oJOAaCUZkUBPu
	gV6Jbb5haelguk1Q8vJfZT/rdvFonH4uvUAVlR64Uyfm8uV8lc1n/ROAtmc7qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783404619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0G9aukPV8pHjfG+rgqcQ/xQgpRWVh1vDYEUguo9B9Ag=;
	b=sy2kZwDTxAMLzqOr8h49dlNPDrKsyK/x6j4NGuclLiX5Jz+hKAwucdCw92/wYzD7GQORNZ
	iQTynay+/hT3JeAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260707080753-4e88aca1-b88d-4f6c-b37a-f7f3064bda5e@linutronix.de>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
 <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
 <20260706210158.GA73349@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706210158.GA73349@ax162>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272350-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:conor.dooley@microchip.com,m:twd2.me@gmail.com,m:palmer@rivosinc.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:namcao@linutronix.de,m:lkp@intel.com,m:stable@vger.kernel.org,m:twd2me@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,microchip.com,gmail.com,rivosinc.com,lists.infradead.org,vger.kernel.org,linutronix.de,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF05A717C82

On Mon, Jul 06, 2026 at 02:01:58PM -0700, Nathan Chancellor wrote:
> On Wed, Jul 01, 2026 at 11:21:22AM +0200, Thomas Weiﬂschuh wrote:
> > With LTO enabled the compiler assumes that the vDSO functions are not
> > used and optimizes them away completely. Currently this happens to
> > __vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
> > __vdso_gettimeofday() and __vdso_riscv_hwprobe().
> > 
> > Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/
> 
> While this change seems correct, is this really the fix for that report?
> It seems like that error happens in clang but I would expect this sort
> of issue to only appear once LTO has run through ld.lld?

At this point the vDSO userspace library has already run through ld.lld.
That has optimized away the futex symbols, which means their offsets are not
defined when building the regular vDSO *kernel* code.

> > Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/riscv/kernel/vdso/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > index a842dc034571..43ee881f6c6f 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -69,9 +69,9 @@ CPPFLAGS_$(vdso_lds) += -DHAS_VGETTIMEOFDAY
> >  endif
> >  
> >  # Disable -pg to prevent insert call site
> > -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > -CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > -CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
> > +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> > +CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> > +CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_LTO)
> >  
> >  # Force dependency
> >  $(obj)/$(vdso_o): $(obj)/$(vdso_so)
> > 
> > -- 
> > 2.55.0
> > 
> 
> -- 
> Cheers,
> Nathan

