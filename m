Return-Path: <stable+bounces-189233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC57C06693
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 15:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1931AA48FE
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB631B102;
	Fri, 24 Oct 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oat9dlvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB42836A6;
	Fri, 24 Oct 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311509; cv=none; b=n2vUOB4T4CEziFDGqSgJH04jVHMaVbjEk9QYcNIk2rLLyn8ZXTe1Dn95ZBKXACHBg6iIFlo1XoVC1QlEmnVjhtaAcl57coEgWGWYmTPvSW0dT48zPjEAGaYssPWda/1bj1FdVIHcsP//PTj0TQlRnstv+WSUSeU4tqG2/SluQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311509; c=relaxed/simple;
	bh=NaBsveXjQRWOqHGb2Q/0LYbQS1eVue+6tB7IwmzbeiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D330nDaolZd02vxLsHHRGNll6SR5m594EC2m/qc/dBtNc0OFGDoP7WmaXf3UHTOIyiw5P+/QaSMXcy48rYUYson4sZhRzHLwcvrmZvIxLl446fm6A8KtSxkbHW3YA2xpRcfbug75ndzSU9fNc8l8CnPpIP1yBURrOU1iuv7VCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oat9dlvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAA6C4CEF1;
	Fri, 24 Oct 2025 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761311509;
	bh=NaBsveXjQRWOqHGb2Q/0LYbQS1eVue+6tB7IwmzbeiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oat9dlvrlpAURwV9pOkU1tPofLbUVY5kST8yy9qlUYzgLDzFQ1YtuVGnI4pgjb4MA
	 uSJWD0cGSKePMr4BGRjl8200S5Zkg+WAMZSqWrMEtYPFwKlXUo61uOhbXA/t/Pe+5L
	 lO0fDutzBblw8dypXkGoXdicbV5h0rJndnR8gT1ovS27W0QuHZv8R4bBfMfUJuU500
	 kSaaIKUrWZw9VfuV+L/GEQa4F8ryT9XPOhvw9BqpDCEqOBjHOqzuIND6NX+b4o0bid
	 5R0B8YJm+i4d/q9UTpemzXx3iOjGquK13/BtnjuLOfJyMQDo9IL6Pr4ajEUPwHg6CG
	 Ztt49RFP+4+RA==
Date: Fri, 24 Oct 2025 14:11:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] regmap: irq: Correct documentation of wake_invert flag
Message-ID: <aPt6_lzhFYy5w0l0@finisterre.sirena.org.uk>
References: <20251024082344.2188895-1-shawnguo2@yeah.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z0e0QUtsbVCPkBNG"
Content-Disposition: inline
In-Reply-To: <20251024082344.2188895-1-shawnguo2@yeah.net>
X-Cookie: If in doubt, mumble.


--Z0e0QUtsbVCPkBNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2025 at 04:23:44PM +0800, Shawn Guo wrote:

> Per commit 9442490a0286 ("regmap: irq: Support wake IRQ mask inversion")
> the wake_invert flag is to support enable register, so cleared bits are
> wake disabled.

> - * @wake_invert: Inverted wake register: cleared bits are wake enabled.
> + * @wake_invert: Inverted wake register: cleared bits are wake disabled.

That sounds like what I'd expect for a normal polarity wake register?
I'd expect to set the bit to enable, so inverting that means that
instead we clear the bit which is what the original text says.

--Z0e0QUtsbVCPkBNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj7ev0ACgkQJNaLcl1U
h9C3jgf/VUO7N3HEntffrALaybG9vxd1oKZLcVA9JR3pk+XB+3fAsTA/G0pAjrHq
nIibWKEEmAkhdpL+5EQap5ctSaN7pjwQFagKidpgx5LclGOPtmD5tl4vkcj2li/a
38Iffxx3xKegHORtmQgisbMaJzzkHk3ZesXZe+x0LgGcGbR6rKVrMyApj2GLW/4y
pQkgkiP7c+T2qb8v+AcNdqewwmOsn55x+5KOmBfVdgYIQ4gtFNH+MFPrORltRO5a
DQz7ILgiDGEHBGZqIY7fqXU9P8OLmzvafYLVAP5XTlckMTLvGBk1/0Zd7NQsf9OO
DLJBTbUguw7W9cU7yrYtvpuEkfLLnA==
=W1fF
-----END PGP SIGNATURE-----

--Z0e0QUtsbVCPkBNG--

