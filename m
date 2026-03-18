Return-Path: <stable+bounces-227166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAB6AoUUu2k3ewIAu9opvQ
	(envelope-from <stable+bounces-227166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613542C2D7C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF1F930EA99E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900A372EE1;
	Wed, 18 Mar 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cBJzGbUW"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA730E855;
	Wed, 18 Mar 2026 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868115; cv=none; b=JRVW4oBjmJyZ4q73U4mTuAmlGtJH2u288ZOV8y6M3lFyChkWW04qF7GU28FFHus/c58e+4kuCaQHBGfTkH7+SCsTI3A/6Cf0mV5z/Op+y1PRyi2OpcGuoVCIaY+1W9AUk/C0oK0ccW4CAc/thEv73sgjOcFoFZcSU6LSBRuy/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868115; c=relaxed/simple;
	bh=Xqx6dmgb0ioudpy6192ppJWLGBqssqNOrrQswckNcUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/99sQgCc1PuvbCeUHum1aYH+q2zUH8L/+TW8jSPbou6TQnDt/dX9FCSOy6MYRYXZDTPbOy39cGM+OR9yaVjyAgP3tp2HtBB1v2nxyreAPxyi0Km3QMJbaOrN0DjbtvNtJhlNn/7OxZMn7aAv4cMW3/R/yRobVY/fnvkIE1RJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cBJzGbUW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8388540E0220;
	Wed, 18 Mar 2026 21:08:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wzsJmcxjMNll; Wed, 18 Mar 2026 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773868108; bh=TJhzsiJG0lXQZmoMzmqNkYGCLY2FBBwerleqdIyrnK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBJzGbUW7RqKETx+MG0VjdmZXevS+0Ouu1q8NEbJW/MLIR9ho9mgfbpSEZ+NcYTal
	 kOUW9zUWEocbpTpb7kkgBrEXeE0ATYjgHQyc+Lgmiuofh52mci4djEsmDPBVpgOsp2
	 vVDlbvj4+LCVMdIXV9LNvtDiIIUae7Dyu/ZlRHkZGlRcgRf7OY/7N/IlQQpvR+fE7x
	 Y+Q/SMb/O4ikc51G39yT+isNnIfq6E4iG5xodKvqMDnPRYoRQb6ws8A4a9Gsg7TI97
	 /FQLe/uTWAwgCN3r9m+MKN+Cm63iYTzBtXrKHJP0Bun8kXpyPMCnWJB++V4km+U3Ic
	 Ixf6nV2ujT+DsQBy6J48ES06CwySdjoQX8i4mS1IRSLqKCKm0TL43fVq0z/Y+1Qu7h
	 oxt6QIuzndawc7q5d61Osl4mcJfGqifVoG/dz2GynPbZn2svuTemo/Gck8JJb0IoR2
	 oAYcDoaxjJlv/7gsKTOQyXkSY1L8sSjmb3CmPKmnHL3/YkDoJVp+hix2UlaP3IhnNw
	 VETmiX1SpuKhD4Rw0HvsI7eK22Gz1HaGmInk6gg7MjDnxmLTryHcUX7UagpCbN7sn3
	 HvitLokBYtYDt2WMmnFXJIulqzened+1Ldvo+0MxH+U0BBsSlCrUBdFVMcnF32zXc9
	 Piz7rM4rWrxl1Sz8otqGXeRc=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id AF25340E01D6;
	Wed, 18 Mar 2026 21:08:18 +0000 (UTC)
Date: Wed, 18 Mar 2026 22:08:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.9+@tip-bot2.tec.linutronix.de,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Disable CR pinning during CPU bringup
Message-ID: <20260318210813.GEabsUPblg3mkGxMqk@fat_crate.local>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227166-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 613542C2D7C
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

My idea was that this is only temporary and then, ontop, we'll do something
like this:

https://lore.kernel.org/r/cb492a37-3517-4738-b435-73311402e820@intel.com

I.e., you figure out all the CR4 pinned bits on the BSP *once*, cast them in
stone and then replicate them on the APs when they come up.

I.e., you figure everything out the earliest and then no more switching.

Then all that gunk will disappear, hopefully.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

