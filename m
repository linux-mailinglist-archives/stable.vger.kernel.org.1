Return-Path: <stable+bounces-219649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPbyIVYTn2nWYwQAu9opvQ
	(envelope-from <stable+bounces-219649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:20:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36091997B2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A238E30D30E3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBBA3D7D7A;
	Wed, 25 Feb 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="enN3rECh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYZ+sfsO"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1C3D6699
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032461; cv=none; b=SBPobwdKL3n3gvelD6g+ZvmH1HszbndwVwz27muCByJ6EqtaaGE4NYO5V+bLqlAro92ACR9Cx+jejS4ygcpagNr3eUobiI9Zn54UJD2tIK2dWRsOZilQIB5J/MLVzF4H9ihYqn1V6A2vtYDcskKGSIiusjQ2CFC1tGSd18h6szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032461; c=relaxed/simple;
	bh=dulNlIKoCfV62gXnVo3v2F8sQPcv/mE1mb3Os0do3x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTUg6ZcAt2iJ6Y6jIoG8LbeOZEnoILaktHbYVk72ukWawJxyxiq+XoEOeVmVm/L9Yj2UIlP52RO9kUjFdqJFLtEejHr+K72EnWz+4pWI9xgxLy6h7HXtiylVLLbPYLQmHrdIWVkqMbm8wh15oh4HJYOcTPvok8gU1i6N1SaCYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=enN3rECh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYZ+sfsO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0E18140019A;
	Wed, 25 Feb 2026 10:14:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772032458;
	 x=1772118858; bh=LO01i9OpMyfG3+2kwXspen0PxerY4AIxEAm1XdyI6QE=; b=
	enN3rEChO7UWxgwDMLaK273siOhNf7xWe54GomuFrwq8VQzmZjezqRGgkXGQIz2M
	6GjtcqjBMLhN7Rlkn4ctmFbdCqjzYpkmKQ/jPlBZBVfc46Fa2FeT8qb6bABHMH7l
	ezdaT+oVX9Xgf8JhV5OO6MZCoLhbvUJIkEXyBHrbj3rbNG64e2VTgON2IL2vyarG
	dAb03RrLgyB/jFPLRkmPKkhbALZh+qNf8a/3Eyv4vP5EHJGqk5BZ8NgkdxCNHJeI
	lAm1Qn3evlkBRc32RQS5A8iEf9weMTLgF4fgnK57N/IGo260DN6WGuv9zq8nxIbC
	9o+OpEbOvT/PSw7vrbHWOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772032458; x=
	1772118858; bh=LO01i9OpMyfG3+2kwXspen0PxerY4AIxEAm1XdyI6QE=; b=C
	YZ+sfsO0w+OkSBbXNSZYl+R1lJVLjnn1CIe0VdNjiD6zBoFOjAJ5GF71J7GMQh7c
	OK+5gRPwFWG7/bdRnHeexr/cTWSTOmQs8i+Fo3QCg248qtJAQeNNnlyzU+NiltD+
	l2jAb7ms9EE9H3XVu6BNsA/pRtKjExLYSgcl0KoH3ftN8ARYLLCKsn+01umiY6dP
	zwaTDt8T93YjhZO/AwYjWthi3RvrWWho9611KGztH+XrQwJudP4mV/WL8cMyliEF
	jy+td6p0aAtmvnB6HekFTs7CCHUQzo07ssaqkT5NZyb6kBkgUss8kUxhP1H9TRPi
	rMwSJf4dIYYouHRzrR+4A==
X-ME-Sender: <xms:yhGfaZ42qEZpYSaoMCYVuCH267nyJVyXx8LjyFpA2cY6PHq87uT1hw>
    <xme:yhGfafFFy1ZqVUxTQEYAg0Im2KSmv3SW9MG4P9gxnKQi3L3iHL_9X1nk_2vGma7ex
    19uw9qtuF17fXlJ7KOLXJM3zbNTB0ioUAg97Ep3Hi3IbgVU>
X-ME-Received: <xmr:yhGfacAPCpde7IlhCOeOAdTO4FFaH5bHIzoLVC4nzZXLMhEinrmemYu-KOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegveevte
    fgveejffffveeluefhjeefgeeuveeftedujedufeduteejtddtheeuffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdifvghishhssh
    gthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopegsvghnseguvggtrgguvghnthdrohhrghdruhhk
X-ME-Proxy: <xmx:yhGfacy658B8zmD6hdnNm2jfWq9_KSx4Sah9_Fxhah8bs0NE4Rj7rA>
    <xmx:yhGfaY4U3GdAVBzDu3jvy7wKTGLxk_11Vw7kWbZpDGk_LsBpYvQ1tw>
    <xmx:yhGfaVwn-QBdYldht9s2hq7F5CxKOkRx38oH3ZezaLkixCTNXUh09w>
    <xmx:yhGfaUeFDSQ64F2vETArBTCVOoy8MMsnBoxV_uVzHFZ_J4xAZWV_vw>
    <xmx:yhGfaXg91CBBScvAd6maFsjxr37VT7_U0v5o9VnuV_3KXdhdKnvXPcVX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 10:14:18 -0500 (EST)
Date: Wed, 25 Feb 2026 07:14:09 -0800
From: Greg KH <greg@kroah.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.18.y 6.19.y] ARM:
 clean up the memset64() C wrapper
Message-ID: <2026022556-poise-retrial-2090@gregkh>
References: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
 <2026022546-sloping-proactive-d4f7@gregkh>
 <20260225160327-91efd064-656c-409c-a1e1-aa8433a3ba6e@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225160327-91efd064-656c-409c-a1e1-aa8433a3ba6e@linutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219649-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,decadent.org.uk:email,messagingengine.com:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: E36091997B2
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 04:08:23PM +0100, Thomas Weiﬂschuh wrote:
> On Wed, Feb 25, 2026 at 06:36:13AM -0800, Greg KH wrote:
> > On Wed, Feb 25, 2026 at 12:35:09PM +0100, Thomas Weiﬂschuh wrote:
> > > [ Upstream commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf ]
> > > 
> > > The current logic to split the 64-bit argument into its 32-bit halves is
> > > byte-order specific and a bit clunky.  Use a union instead which is
> > > easier to read and works in all cases.
> > > 
> > > GCC still generates the same machine code.
> > > 
> > > While at it, rename the arguments of the __memset64() prototype to
> > > actually reflect their semantics.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
> > > Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
> > > Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
> > > Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
> > > ---
> > > Hi stable team,
> > > 
> > > unfortunately the backports of commit 23ea2a4c7232 ("ARM: 9468/1: fix
> > > memset64() on big-endian") does not work on 5.10 and 5.15 as
> > > CONFIG_CPU_LITTLE_ENDIAN does not exist there, effectively breaking memset64()
> > > on little-endian. Please use this variant instead which always works.
> > > For consistency I prefer to have it backported to all versions.
> > > ---
> > >  arch/arm/include/asm/string.h | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
> > > index b5ad23acb303..369781ec5511 100644
> > > --- a/arch/arm/include/asm/string.h
> > > +++ b/arch/arm/include/asm/string.h
> > > @@ -33,13 +33,17 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
> > >  }
> > >  
> > >  #define __HAVE_ARCH_MEMSET64
> > > -extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
> > > +extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
> > >  static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
> > >  {
> > > -	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> > > -		return __memset64(p, v, n * 8, v >> 32);
> > > -	else
> > > -		return __memset64(p, v >> 32, n * 8, v);
> > > +	union {
> > > +		uint64_t val;
> > > +		struct {
> > > +			uint32_t first, second;
> > > +		};
> > > +	} word = { .val = v };
> > > +
> > > +	return __memset64(p, word.first, n * 8, word.second);
> > >  }
> > >  
> > >  #endif
> > > 
> > > ---
> > 
> > I don't understand, why is this patch needed at all?  What issue is it
> > fixing to require this?
> 
> memset64() was broken on ARM big-endian. It was fixed in commit 23ea2a4c7232
> ("ARM: 9468/1: fix memset64() on big-endian"). That fix was marked with a Fixes:
> tag and was backported to all stable kernels. However that fix relies on the
> kconfig symbol CONFIG_CPU_LITTLE_ENDIAN (as shown in the diff above).
> That kconfig symbol does not exist on 5.10 and 5.15. So now memset64() is
> broken on ARM little-endian on those branches.

So on ALL branches?  When did that config option get added?

> The proposed works always, without requiring kconfig options.
> The Fixes: tag target would differ between the stable branches,
> so I left it out.

A fixes: for commit 23ea2a4c7232 should be correct, right?

thanks,

greg k-h

