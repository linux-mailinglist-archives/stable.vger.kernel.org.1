Return-Path: <stable+bounces-220045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPCOOciBommS3gQAu9opvQ
	(envelope-from <stable+bounces-220045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:48:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F721C0778
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 06:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CC86305271B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77327FD52;
	Sat, 28 Feb 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbD47ktT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126FB22B8C5
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772257734; cv=none; b=giqLXjJuJdruYV1kk7LGm8IZszHLAn0Go0CKcfFl2NRu8LHF6DwaLxQTnRX5Oeqcv0yiZLiY8geru2S0k9NuYjt2S9UBIcsnMAxaZMd4g/Jqwd6KgQvHlQ4ZBfNFq+weXO9G95P8QDNZh7+a79u76CmtwxdVLk/N+hEt3AMuskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772257734; c=relaxed/simple;
	bh=YQAdqqBUqJsZSxm0fNFIK3JU64R4cprvHv7/i1rGlPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TumCBURr+nFvjlbgAd/Qcrj89kFZ9fdz2tgXGP0KmTzWSN4AdFNvyQnDMBUdXsp4WzIveK6r8QSxR0BEtHx5NPt/KhkVBJI2SFqzGccaAFADLOOaA+n3XEHgbgweEg6sARl5SqvNH/RGn04PbBI2Cbb6niWJLX/ZGqmME9KbyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbD47ktT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E920DC116D0;
	Sat, 28 Feb 2026 05:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772257733;
	bh=YQAdqqBUqJsZSxm0fNFIK3JU64R4cprvHv7/i1rGlPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbD47ktTntv8tV/L+yB0a9D+VjHvefKkT3EfxDeUYTclExlL6DRRC0FHN25mTUtnb
	 r6yvYAkJCyA6hmVB6b1IvBikB/G6QsoOMBPBI7AEC8u0Bcs8flyl3HhgWD+XpfmgZf
	 B6eH5JJOyBDt/NvzT06AFS9X3nYRgJQWOa8L6qFdVxfj0KVFjPM9oPmfgBQaafwpEO
	 wg2ruWpFXd2Fmb2l5ZZTqvqbYTX5T9M0nEiWBQWGGv2SWBFHBWJ0Kuv91EJjusTiY+
	 Xc08Xc39cZe+qx4ttRD6Kt01ywyky0YcBh4HgT8RC+Hpl7Z8oS+1CeywHtTHgorNoY
	 4D3oTaRf+jITQ==
Date: Fri, 27 Feb 2026 22:48:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rainer Fiebig <jrf@mailbox.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	jpoimboe@kernel.org
Subject: Re: 6.18.14: VirtualBox modules don't build anymore; bisected
Message-ID: <20260228054850.GA2321895@ax162>
References: <62d12399-76e5-3d40-126a-7490b4795b17@mailbox.org>
 <2026022741-mahogany-coveted-acfa@gregkh>
 <adc83809-3eea-2bbd-c162-48662acab5ed@mailbox.org>
 <2026022738-tricky-popper-c70e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026022738-tricky-popper-c70e@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220045-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61F721C0778
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 08:29:05PM -0500, Greg KH wrote:
> On Sat, Feb 28, 2026 at 12:30:29AM +0100, Rainer Fiebig wrote:
> > Am 27.02.26 um 21:12 schrieb Greg KH:
> > > On Fri, Feb 27, 2026 at 04:33:34PM +0100, Rainer Fiebig wrote:
> > >> In case this hasn't been reported already: with 6.18.14 the
> > >> VirtualBox-7.1.16 modules won't build during the boot process, as they
> > >> usually do.  Bisecting between 6.18.13/14 led to this:
> > >>
> > >> f056c340b73962ebaffe93997b582bdf16dc6270 is the first bad commit
> > >> commit f056c340b73962ebaffe93997b582bdf16dc6270 (HEAD)
> > >> Author: Josh Poimboeuf <jpoimboe@kernel.org>
> > >> Date:   Tue Feb 10 13:45:22 2026 -0800
> > >>
> > >>     kbuild: Add objtool to top-level clean target
> > >>
> > >>     [ Upstream commit 68b4fe32d73789dea23e356f468de67c8367ef8f ]
> > >>
> > >>     Objtool is an integral part of the build, make sure it gets cleaned
> > >>     by "make clean" and "make mrproper".
> > >> [...]
> > >>
> > >>
> > >> The script I use for building my kernels includes "make mrproper" before
> > >> compiling and "make clean" after the kernel and modules have been
> > >> installed.
> > >>
> > >> Perhaps it would be more appropriate to report this to the
> > >> VirtualBox-devs but I won't do that because the registration procedure
> > >> asks for too many private data.
> > > 
> > > We obviously can not do anything about external modules, so if you rely
> > > on these, you are going to have to work with them on this, sorry.
> > 
> > Alright, tough luck.  But that a patch-release of an LTS-kernel breaks
> > VirtualBox is really a first - at least as far as I can remember.
> 
> Then they have gotten really lucky :)

I think this is firmly a Kbuild bug, as we broke the contract of
'make clean' leaving around enough to build external modules:

  https://lore.kernel.org/20260227-avoid-objtool-binary-removal-clean-v1-1-122f3e55eae9@kernel.org/

Kbuild is what runs objtool, not the external module itself. I don't
care much for external modules but this does not appear to be something
they have done or relied on.

Cheers,
Nathan

