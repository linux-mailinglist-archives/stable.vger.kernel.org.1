Return-Path: <stable+bounces-227167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNVCLuEUu2k3ewIAu9opvQ
	(envelope-from <stable+bounces-227167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:10:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA22C2DB2
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D3530C4514
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA436C0C1;
	Wed, 18 Mar 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYmMikI5"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E1374161;
	Wed, 18 Mar 2026 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868209; cv=none; b=EaRgJQmrdHC3biaE3NS15Z6CPZXvtl6K/gU5JsBJyxvSlGMd4IvbXcujT4rEdl205JfA13XqHsN+wD+4SQeiqVBj8KO6jA4CIpwieUF8ChPpPFf+E7c8/4DDTSKUGHQwG6iNqxnaUszilvDzpJ9hdd9fVvitEUC6Ap4W2XiT0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868209; c=relaxed/simple;
	bh=HdzSdFCqa0NsLI9+vlnMyR5HhJv5zufD9ToL3pTZGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzdGW+XM9IcXc/yhZHC+K4elUPlsbaFed5Xay5vYTUyibiuMWeUNLA92uUvF9NDRNG/CN1pzAwljNRmNVXnZAGCgrRtzDgHIkJc6vN9MykfFqN00XvOfZpr5r2R+FXgCJBf/Hv036HZlYjDQt8Vh0Xb+Hug9OC0qu3YTNpSy64M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MYmMikI5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EY1mjTKPcq49c0oDU/sBcFdPcjBcvXLBCcNIUMXgvyk=; b=MYmMikI5MfNIrBiLnX1UU0a4KR
	qIbA+Juus5otsuD/8heU6TCwqFCQp8cKzLwDSIFV24gX7J8/puPhdoMRDsMEraV6Zqba7ROUmVRas
	jEzpYYJ5ktnegtvZhc5eTMjNxlG1n/0UBuYBbixZmQ5cXJU7wLfPaXi8bqW1MQ35yMrDik0WciL72
	tAenzGL1qfaqHceAR470XLCfaWsiiY3B2HKBob/QYqi/nKThDqweU16aZPS2WKHKYew+YAz3xpuSm
	MBr1zxB7LiQPOBa6HIe2PPe6YXUJyp+rcfQZs4P0FHJ978HVrXpvp5gQ+JNBdAXqAkwS24n2DYbAm
	for316bQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2y9H-0000000519W-1qF1;
	Wed, 18 Mar 2026 21:09:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C4A9301BDE; Wed, 18 Mar 2026 22:09:50 +0100 (CET)
Date: Wed, 18 Mar 2026 22:09:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260318210950.GC3739106@noisy.programming.kicks-ass.net>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
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
	TAGGED_FROM(0.00)[bounces-227167-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55AA22C2DB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:47:22PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 18, 2026 at 06:51:10PM -0000, tip-bot2 for Dave Hansen wrote:
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -437,6 +437,21 @@ static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_C
> >  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> >  static unsigned long cr4_pinned_bits __ro_after_init;
> >  
> > +static bool cr_pinning_enabled(void)
> > +{
> > +	if (!static_branch_likely(&cr_pinning))
> > +		return false;
> > +
> > +	/*
> > +	 * Do not enforce pinning during CPU bringup. It might
> > +	 * turn on features that are not set up yet, like FRED.
> > +	 */
> > +	if (!cpu_online(smp_processor_id()))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> Urgh, so this means all an attack needs to do is disable the online bit
> and it gets to poke CR4 bits.
> 
> This seems unfortunate.
> 
> And sure, randomly clearing the online bit will eventually cause havoc,
> but I suspect you still get plenty time until the system goes wobbly.

So what is the problem with removing FRED from cr4_pinned_mask?
Specifically, set it up such that if you 'accidentally' clear that, the
machines insta dies a horrible death.

So currently we setup an IDT and everything, then setup the FRED MSRs,
flip CR4_FRED and call it a day. But we could just explicitly poison all
the IDT stuff to cause tripple faults.

Fixing that up is a much bigger ask of an attacker, no?

