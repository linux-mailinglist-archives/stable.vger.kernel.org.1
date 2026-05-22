Return-Path: <stable+bounces-253821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG8TOVKMEGrEZQYAu9opvQ
	(envelope-from <stable+bounces-253821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:03:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC225B7DC7
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECF93014979
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A273D47A0B6;
	Fri, 22 May 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE06t9+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF5425CEE;
	Fri, 22 May 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468866; cv=none; b=LJUmkFXUTSUBV7qICB2ggDx8lCZTPKTsfOsUwK4sjIKu2XbMMIk6a99ihYOsof8XHLB9HAAtYZanAFchZKIz7AiZm6Lk3TlXRWo50D8taRShxrsrn4LZedWvCCcDTyeXoBmXBhaDM5GeqABSW4yEFT7X2A25usYXYqtXZr82FKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468866; c=relaxed/simple;
	bh=BAQBkaJbwUksCFCRdnkv0H9H5clwR/tNu5q8IVW7hvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbzm6vEGyIXuKDEZM2Y56nohOzv0C1m+KtEt7HCFa9yUusjVK3R4jvoszIl4+kpHL7ztpyRZdFhSWHLU0ZULJls3UG1gLmaJt2CIqcxhx42eTk44iYZXj6vzu21M0e/9p8e14LpnYW9ze6r7S1IpkAYyyXsOAbXHNBip7Iw7czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE06t9+E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55341F00A3D;
	Fri, 22 May 2026 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468863;
	bh=XcYjFp3x3nhf41eqAUeiUl4v/jsgL5K+bXT5SclsVso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cE06t9+EApM5cZ8hqeZBvMyquUAdwFNLwBd/pgPMD4DtDaxRpAkJ8+4KJOWVlhEN2
	 IqiMVVaa8tfi+hT+ceLxedykCtt3UAiLaMaRc0V336gvOaIC0UMudkSgkJDTjaQhcR
	 cThdiKLeiXLnwNzq/JFpylLzA77g0DjhsOW+Qi386QnLKbxCGXIGcOpTlSiAlJuQ7l
	 JTt6aCYqfEU3iKMfOz6y4LTD0Ev7qHQOIZCu0ot4ORtJ06hlqihDr4r3X/zDKcavPD
	 ruMumM8yenvRqUSqBZ2yhtkO5jTElnGp3cL4YRSvjxeVURcbgMfQw/FwtvXIntp1K/
	 MeoV1KZrvsg7Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A52DF4008C;
	Fri, 22 May 2026 12:54:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 12:54:22 -0400
X-ME-Sender: <xms:PooQaqChmNc7KEUYHqtYfJ2flPMNJEw8ziOL-9oKcxTGxqSeTzkdvw>
    <xme:PooQam01rEltLrNzr4a0rZDRuZRAa-wefvj4AM6fwPAY7KyP2FjLgVGyW0abWDDR4
    WWxnzxYnRW-iCazAXK2qloRE4lh9B_M8hVjJevy09z6XLYZ2fod8g>
X-ME-Received: <xmr:PooQasQKovnx3iZAKX4kEC8rSoonw-NLeZy4urbAuMFjkmqeohAnxmEzjTcADw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeludettdeigfefhffhhfelveeludeuleduvefhgefgueeitedtleffudegfffg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeeftddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehrih
    gtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegtlhhoph
    gviiesshhushgvrdguvgdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrkheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegsphesrg
    hlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohephhhprgesiiihthhorhdrtghomh
X-ME-Proxy: <xmx:PooQalvDhz3R6-bp69-gUlIq3JEFdi2d--mRH1dOJVdLHQ-SPWl5RA>
    <xmx:PooQas4Mx8s2w4MG5pn1QffllfXpNmAKY0S0kE9FIC2chE0zNu5Gpg>
    <xmx:PooQarY3-TrpvgjjNWyiMSgDpVr6XQG2dOzdXGcf7V2zqsFCbWweEQ>
    <xmx:PooQanhSZz6LraH4gZTgzv7sQ_EwX3SDSOtbPO3iS6uXvpf5E8unWQ>
    <xmx:PooQaubUJhtG_1kyEJp6lYxrZ3xOG7FKKd7PPHsACC67GNarb1pqsgSa>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:54:21 -0400 (EDT)
Date: Fri, 22 May 2026 17:54:19 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "clopez@suse.de" <clopez@suse.de>, 
	"x86@kernel.org" <x86@kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Message-ID: <ahCI-vSYMe3digej@thinkstation>
References: <20260512213719.20974-1-clopez@suse.de>
 <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
 <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253821-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BC225B7DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 03:14:54PM -0700, Dave Hansen wrote:
> On 5/12/26 14:48, Edgecombe, Rick P wrote:
> >> -	regs->ax = args.r12;
> >> -	regs->bx = args.r13;
> >> -	regs->cx = args.r14;
> >> -	regs->dx = args.r15;
> >> +	regs->ax = lower_32_bits(args.r12);
> >> +	regs->bx = lower_32_bits(args.r13);
> >> +	regs->cx = lower_32_bits(args.r14);
> >> +	regs->dx = lower_32_bits(args.r15);
> >>  
> > Can you explain the impact here? Why should the guest fixup what the VMM
> > emulates?
> 
> Oh boy.
> 
> args.r12-15 come from the VMM, right? So the VMM Can put whatever it
> wants in there.
> 
> CPUID (the instruction) is defined to fill in eax/ebx/ecx/edx. Those are
> 32-bit registers so the normal register rules apply: "32-bit operands
> generate a 32-bit result, zero-extended to a 64-bit result in the
> destination general-purpose register."
> 
> So a properly-behaving CPUID implementation will always end up with the
> top 32 bits empty on the four CPUID registers after a CPUID is executed.
> 
> The VMM here obviously might be naughty and might put gunk in
> args.r12/r13/r14/r15 that gets copied to ptregs->ax/bx/cx/dx which are
> 'unsigned long' on 64-bit.
> 
> The end result is that a TDX guest can use CPUID and end up having bits
> set in rax/rbx/rcx/rdx that are architecturally impossible. This patch
> is effectively fixing up the VMM naughtiness before the guest CPUID
> instance can see it.
> 
> Does anybody disagree with any of that?

Not really.

But note that the exposure is minimal as we do not issue hypercalls to
VMM for anything outside of hypervisor range. I am not sure stable@ is
justified, but worth fixing.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

