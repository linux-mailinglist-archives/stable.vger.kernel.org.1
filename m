Return-Path: <stable+bounces-219658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEySNGcin2mPZAQAu9opvQ
	(envelope-from <stable+bounces-219658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:25:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E719A8EF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87BF0303F0A1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FC63AEF34;
	Wed, 25 Feb 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z0mJLIvl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SFZp6nr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380239901C
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035408; cv=none; b=j+G+Ba4YgNAX4sFMOhlpkqQSWQ7j4Vvu7AastFGeP5DIVjZ+cGfCOnuwa1TovFX4M/ZMbtljMAg9uj816hnjZbW+Jgr4di3tmdgHClSagwZTu1Rjy+RcT4N8erDpIuS7G1Cx8FOR49dI5O6voZv3+q4lXaeJ+WApzRO+Bkw0da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035408; c=relaxed/simple;
	bh=uvDi56p72NPEhU5x9NbgVcVr/HnZoqA5LFpzZQzEyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9JcpsmOi+6T6BeCBA+xPwrCFmzGk5iDxPRFEbGlHkQmM/QanitV49mX9s+11N/UE3UsgeZzvfwimgxKeF521D/mykuiZmIQ4+aHnVV+/DeTb8GnQVCCt4dZJqqIU6e7lJcldG102GXnduWj4LCJ2dDYfDbabfyPT1YdO+RkTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z0mJLIvl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SFZp6nr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Feb 2026 17:03:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772035405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuAOEwcbuxPDOthkDebuJenJGz4r3TzDa6XCRiguOqA=;
	b=Z0mJLIvlOBdp27rGv40uO541EZSit8dscKUU4bKWXx24JJN/gvgvyRnK3F8h5u2Am/4INc
	3n+fkc3BHEjsRBJXPz4xZBjVjjp61dlOK8UCrWVuR2pkM1Tuv64QPaGc1DeBAq9GmZKWcF
	6aDW9rMj8IWs598/cUgYDKXgkbce8yytWKaKVhVR2Sx+H7FUYy5OicKykAzUMGRPWZPDIZ
	j9ML7W79lZ3Y40nR+aNiJab89CrPXw3Am979jbc2Wd3BFs+Ui7kuN87nnluzO3tvOETyO9
	VI7581Kw6Be7qXD332TQIM2TEPL+by+/DOzs0kwUHAbuUQ4djA1UF7S9rY8Dgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772035405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuAOEwcbuxPDOthkDebuJenJGz4r3TzDa6XCRiguOqA=;
	b=5SFZp6nrstrfQVlLoJT+dPmnePMnkXF9AzqD1ZVJkx7jvLVdEA65jJe1kvhWf19oENSkUY
	gpAZT/0FEwR7TqAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.18.y 6.19.y] ARM:
 clean up the memset64() C wrapper
Message-ID: <20260225165739-ef83ad77-eade-4fa8-bc6b-eb232d1985f5@linutronix.de>
References: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
 <2026022546-sloping-proactive-d4f7@gregkh>
 <20260225160327-91efd064-656c-409c-a1e1-aa8433a3ba6e@linutronix.de>
 <2026022556-poise-retrial-2090@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026022556-poise-retrial-2090@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219658-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,decadent.org.uk:email]
X-Rspamd-Queue-Id: E76E719A8EF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:14:09AM -0800, Greg KH wrote:
> On Wed, Feb 25, 2026 at 04:08:23PM +0100, Thomas Weiﬂschuh wrote:
> > On Wed, Feb 25, 2026 at 06:36:13AM -0800, Greg KH wrote:
> > > On Wed, Feb 25, 2026 at 12:35:09PM +0100, Thomas Weiﬂschuh wrote:
> > > > [ Upstream commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf ]
> > > > 
> > > > The current logic to split the 64-bit argument into its 32-bit halves is
> > > > byte-order specific and a bit clunky.  Use a union instead which is
> > > > easier to read and works in all cases.
> > > > 
> > > > GCC still generates the same machine code.
> > > > 
> > > > While at it, rename the arguments of the __memset64() prototype to
> > > > actually reflect their semantics.
> > > > 
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
> > > > Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
> > > > Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
> > > > Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
> > > > ---
> > > > Hi stable team,
> > > > 
> > > > unfortunately the backports of commit 23ea2a4c7232 ("ARM: 9468/1: fix
> > > > memset64() on big-endian") does not work on 5.10 and 5.15 as
> > > > CONFIG_CPU_LITTLE_ENDIAN does not exist there, effectively breaking memset64()
> > > > on little-endian. Please use this variant instead which always works.
> > > > For consistency I prefer to have it backported to all versions.
> > > > ---
> > > >  arch/arm/include/asm/string.h | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
> > > > index b5ad23acb303..369781ec5511 100644
> > > > --- a/arch/arm/include/asm/string.h
> > > > +++ b/arch/arm/include/asm/string.h
> > > > @@ -33,13 +33,17 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
> > > >  }
> > > >  
> > > >  #define __HAVE_ARCH_MEMSET64
> > > > -extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
> > > > +extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
> > > >  static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
> > > >  {
> > > > -	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> > > > -		return __memset64(p, v, n * 8, v >> 32);
> > > > -	else
> > > > -		return __memset64(p, v >> 32, n * 8, v);
> > > > +	union {
> > > > +		uint64_t val;
> > > > +		struct {
> > > > +			uint32_t first, second;
> > > > +		};
> > > > +	} word = { .val = v };
> > > > +
> > > > +	return __memset64(p, word.first, n * 8, word.second);
> > > >  }
> > > >  
> > > >  #endif
> > > > 
> > > > ---
> > > 
> > > I don't understand, why is this patch needed at all?  What issue is it
> > > fixing to require this?
> > 
> > memset64() was broken on ARM big-endian. It was fixed in commit 23ea2a4c7232
> > ("ARM: 9468/1: fix memset64() on big-endian"). That fix was marked with a Fixes:
> > tag and was backported to all stable kernels. However that fix relies on the
> > kconfig symbol CONFIG_CPU_LITTLE_ENDIAN (as shown in the diff above).
> > That kconfig symbol does not exist on 5.10 and 5.15. So now memset64() is
> > broken on ARM little-endian on those branches.
> 
> So on ALL branches?  When did that config option get added?

It got added in commit 5d6f52671e76 ("ARM: rework endianess selection"),
released as part of v5.19.
So only 5.10.y and 5.15.y got broken by "ARM: 9468/1: fix memset64() on
big-endian".

> > The proposed works always, without requiring kconfig options.
> > The Fixes: tag target would differ between the stable branches,
> > so I left it out.
> 
> A fixes: for commit 23ea2a4c7232 should be correct, right?

Somewhat. The original commit 23ea2a4c7232 was not broken, only some of
its backports. But to keep the stable process happy let's use that.


Thomas

