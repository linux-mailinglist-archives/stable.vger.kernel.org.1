Return-Path: <stable+bounces-219665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM37G4shn2mPZAQAu9opvQ
	(envelope-from <stable+bounces-219665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:21:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDF19A7C0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B82D2308A02C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45DA3D903C;
	Wed, 25 Feb 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="JsbTvNl3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHHXF/8A"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398B23ABB9
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036340; cv=none; b=CUAEIVeSMo36mQWr6WBc/QkAFxHff3Sue/zhSicF660MJfFHlekBC/tLkvoqGMACPRnTNkQDiQTCJteM0FO9aNZTxsQfZNMZpeb/qpmD6l3Ttaq2+LuGDdtEuBEtJiGxPjHsv92zD9UJpN0/R4Jm+vIo76wxp2fhI+E2vFx4jZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036340; c=relaxed/simple;
	bh=tk8M5wHqyuuEHVesr1owtvZu6tthtE4LrEPk374YLgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkgWF0cWUm3YAlj4dhzULhfoLbfbX0HY4b+ucMFBY9l6A8602BN6JlwdwbvlnwE4YXGewO0HoWKWi3Q532QkLw+haBNAOq21Zu6aUwg2iiWBN6sSl8GeIi+sP+arHZZv8632ZhfqIctBC3I99bYuNkYOchSEseZ0WQk8163d9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=JsbTvNl3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHHXF/8A; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A7231400187;
	Wed, 25 Feb 2026 11:18:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 25 Feb 2026 11:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772036331;
	 x=1772122731; bh=xQSMxJ6SN8aiXZzol3cO89q/UGeDv6EdWvDteHAeoTg=; b=
	JsbTvNl3nESAXMkVpHQq8eLXhWfoErKE2EsRf9ILSutAiknHoIT/tKj3TEYCCZvO
	zPS5vWJlrYXe1+rDSbZXx+NJ7osxDSouIBk+zcoo/zDeRaEm+XPJ7FfsACLPlDF+
	NkgI5y5DLVvW3HgG76quKN8IS4Nt8w8xktYzyBUY57kJhBA4j53705/XhoCgmHhd
	MTPr/DLY2O3Sp8I55m7tbGHyYi6Br/G81kNiQx7cEx6Gvh1Y06EMCLjeTVGkjzSz
	9REqJUVBHLwQiW4Y7VuXyKO9QRYEWZ6JciSEqw2mAN4xrBHUnpIpIq/4sLvw3utb
	tMOyAroZ0lQHfogCcyHdYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772036331; x=
	1772122731; bh=xQSMxJ6SN8aiXZzol3cO89q/UGeDv6EdWvDteHAeoTg=; b=S
	HHXF/8A1dJ4AsvzWBkP0LR7fjG6hjR7WhlXyXQdrJ0IW3VIANhGzMaLXy11QJZuq
	Y6K8pbBKHnc40G2fAcxRf6CfneJkN2/i+1nbKd5zlq9PSIy8ETLoxyUKwLfYuAXl
	lDechFL+CGtQ38g+hRunoVjhBJaPmrXbR+bGh6hD1ysrsmmPyHPxexQUOCwK6wgz
	smylvu70j3Ub1HvarYrg1CbUdzhuNiPlJXcGWMMFfPa1M0EV23yzMOhgPGqIOyjX
	4oSGsek9BF5cHOniwwUbfML6ApBPnKdIW4EtR4MVibOpRewpKblU3YGpKrhfZ43w
	XRLfxTntLW1/59xVk04Hw==
X-ME-Sender: <xms:6iCfadJxwAyGGlozaFjjCLE3xt5QgoLifOv7Qlxdze7bpxwGciI8gQ>
    <xme:6iCfaRUzPSCFa63Fqk0o2EytXhednUOZ6K0cbSpS-kgIh771cAGUUj_QoarHGROqb
    w7sMGh7NPVc5nh5AZV2u4WkWIVGNmxXUDNyFJsl0JVoag-HjA>
X-ME-Received: <xmr:6iCfaRRgyoxWwurTh8l2hnvu0R93fn81SUw0rJ3PKRuANmVlRJISswAUtMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdelue
    dtkefhvdduheduteekveehieevhfetjeevvdfgkeekkeelhfelffegvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdduledrshhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrd
    ifvghishhsshgthhhuhheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhihsehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsvghnseguvggtrgguvghnthdroh
    hrghdruhhk
X-ME-Proxy: <xmx:6iCfaZBmZRH8g40l0r-hbDnsrKIj-mrqEhBM6pd1MsTtW5YK6F8W8A>
    <xmx:6iCfaQJPYOYf4msVVuANWYg7eV-oHIggO14GgXbnppVMCV4jMOCYyQ>
    <xmx:6iCfacBCuibwXn4JyTTKROx-zc_gU7aWe1eTsDGBRFn3dc73x9qEuw>
    <xmx:6iCfadsGEq7jBH87VhcKusBiUrUa4kvUzOHCx1EkO92maRdGNcldSg>
    <xmx:6yCfaWwVULL48y38vvHQrMYy71vNvOjzV5u8s6PFuC9JvOEyWO_GFD96>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 11:18:49 -0500 (EST)
Date: Wed, 25 Feb 2026 08:18:41 -0800
From: Greg KH <greg@kroah.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 5.10.y 5.15.y 6.1.y 6.6.y 6.12.y 6.18.y 6.19.y] ARM:
 clean up the memset64() C wrapper
Message-ID: <2026022546-dedicator-bonus-5923@gregkh>
References: <20260225-arm-memset64-stable-v1-1-f453c4933ca0@linutronix.de>
 <2026022546-sloping-proactive-d4f7@gregkh>
 <20260225160327-91efd064-656c-409c-a1e1-aa8433a3ba6e@linutronix.de>
 <2026022556-poise-retrial-2090@gregkh>
 <20260225165739-ef83ad77-eade-4fa8-bc6b-eb232d1985f5@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225165739-ef83ad77-eade-4fa8-bc6b-eb232d1985f5@linutronix.de>
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
	TAGGED_FROM(0.00)[bounces-219665-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,linux-foundation.org:email,linutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91EDF19A7C0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:03:20PM +0100, Thomas Weiﬂschuh wrote:
> On Wed, Feb 25, 2026 at 07:14:09AM -0800, Greg KH wrote:
> > On Wed, Feb 25, 2026 at 04:08:23PM +0100, Thomas Weiﬂschuh wrote:
> > > On Wed, Feb 25, 2026 at 06:36:13AM -0800, Greg KH wrote:
> > > > On Wed, Feb 25, 2026 at 12:35:09PM +0100, Thomas Weiﬂschuh wrote:
> > > > > [ Upstream commit b52343d1cb47bb27ca32a3f4952cc2fd3cd165bf ]
> > > > > 
> > > > > The current logic to split the 64-bit argument into its 32-bit halves is
> > > > > byte-order specific and a bit clunky.  Use a union instead which is
> > > > > easier to read and works in all cases.
> > > > > 
> > > > > GCC still generates the same machine code.
> > > > > 
> > > > > While at it, rename the arguments of the __memset64() prototype to
> > > > > actually reflect their semantics.
> > > > > 
> > > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Reported-by: Ben Hutchings <ben@decadent.org.uk> # for -stable
> > > > > Link: https://lore.kernel.org/all/1a11526ae3d8664f705b541b8d6ea57b847b49a8.camel@decadent.org.uk/
> > > > > Suggested-by: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/ # for -stable
> > > > > Link: https://lore.kernel.org/all/aZonkWMwpbFhzDJq@casper.infradead.org/
> > > > > ---
> > > > > Hi stable team,
> > > > > 
> > > > > unfortunately the backports of commit 23ea2a4c7232 ("ARM: 9468/1: fix
> > > > > memset64() on big-endian") does not work on 5.10 and 5.15 as
> > > > > CONFIG_CPU_LITTLE_ENDIAN does not exist there, effectively breaking memset64()
> > > > > on little-endian. Please use this variant instead which always works.
> > > > > For consistency I prefer to have it backported to all versions.
> > > > > ---
> > > > >  arch/arm/include/asm/string.h | 14 +++++++++-----
> > > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
> > > > > index b5ad23acb303..369781ec5511 100644
> > > > > --- a/arch/arm/include/asm/string.h
> > > > > +++ b/arch/arm/include/asm/string.h
> > > > > @@ -33,13 +33,17 @@ static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
> > > > >  }
> > > > >  
> > > > >  #define __HAVE_ARCH_MEMSET64
> > > > > -extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
> > > > > +extern void *__memset64(uint64_t *, uint32_t first, __kernel_size_t, uint32_t second);
> > > > >  static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
> > > > >  {
> > > > > -	if (IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN))
> > > > > -		return __memset64(p, v, n * 8, v >> 32);
> > > > > -	else
> > > > > -		return __memset64(p, v >> 32, n * 8, v);
> > > > > +	union {
> > > > > +		uint64_t val;
> > > > > +		struct {
> > > > > +			uint32_t first, second;
> > > > > +		};
> > > > > +	} word = { .val = v };
> > > > > +
> > > > > +	return __memset64(p, word.first, n * 8, word.second);
> > > > >  }
> > > > >  
> > > > >  #endif
> > > > > 
> > > > > ---
> > > > 
> > > > I don't understand, why is this patch needed at all?  What issue is it
> > > > fixing to require this?
> > > 
> > > memset64() was broken on ARM big-endian. It was fixed in commit 23ea2a4c7232
> > > ("ARM: 9468/1: fix memset64() on big-endian"). That fix was marked with a Fixes:
> > > tag and was backported to all stable kernels. However that fix relies on the
> > > kconfig symbol CONFIG_CPU_LITTLE_ENDIAN (as shown in the diff above).
> > > That kconfig symbol does not exist on 5.10 and 5.15. So now memset64() is
> > > broken on ARM little-endian on those branches.
> > 
> > So on ALL branches?  When did that config option get added?
> 
> It got added in commit 5d6f52671e76 ("ARM: rework endianess selection"),
> released as part of v5.19.
> So only 5.10.y and 5.15.y got broken by "ARM: 9468/1: fix memset64() on
> big-endian".

Ah, ok, that makes more sense.  You can see how I would be confused
given that you asked this to be backported to other newer kernels too
(which is what we should do, just confusion on my side where things were
broken.)

> > > The proposed works always, without requiring kconfig options.
> > > The Fixes: tag target would differ between the stable branches,
> > > so I left it out.
> > 
> > A fixes: for commit 23ea2a4c7232 should be correct, right?
> 
> Somewhat. The original commit 23ea2a4c7232 was not broken, only some of
> its backports. But to keep the stable process happy let's use that.

Fair enough, I'll queue this up for the next round, thanks for the
explaination.

greg k-h

