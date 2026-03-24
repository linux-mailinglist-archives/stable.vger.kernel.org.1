Return-Path: <stable+bounces-230159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKLqCceSwmkXfAQAu9opvQ
	(envelope-from <stable+bounces-230159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:33:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B93097FE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AA21301CC42
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9323F87FF;
	Tue, 24 Mar 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4mFwRfo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E32253FC;
	Tue, 24 Mar 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358640; cv=none; b=ng5s7TA0B1K9nAqlOQ54B5mdwy/arVSDo1yxJexelR3XEnUEoYjRzkfwQwehQOseFED/aL29zYijUgw7Kn2S1xhoKuETM8fxAGPj0Yyg3RwtKD/GaJR7IxlEsoeKiPEKOxjQch9eaoQrjyMMlay8O88D2COQOFhatbdIrejuN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358640; c=relaxed/simple;
	bh=dIlPuMkEtdkzx4Tf631fAb/XXTgkrwfxjpJpG5MsApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEXmd/DZ9qFMi5xtw6gf40CO6GSuTBUkw90hp2/Crpaa/RwGaTdh5gCTm9/C+W9fAXRMn2t/W/25MpSpli+BelUQgUABjRkrNO0meuYVyuezHavK9bCa5CD1nSBpBSXUMdjt4mrbsn2et2c5G2CeV6RGviFkvkQ07rw6oDoK+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4mFwRfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C03AC19424;
	Tue, 24 Mar 2026 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774358640;
	bh=dIlPuMkEtdkzx4Tf631fAb/XXTgkrwfxjpJpG5MsApo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4mFwRfo/ENeILxkEItAH0GW88CPkoWgJfbgR3g9mYO/BkN1D65MCC3AFQfdjwf71
	 kA1RgVy9qDXHfv6gB28DYJtjy0jFQ6rkjg/0+K459S66f0yMkRD9OKyuWl9eZYdnL+
	 4WaT1RURteeYGGT3nBvZ5awuxGTvTkP+wfMFKc2m3pGiGOkotvFX3T3ZJved5fv3Pt
	 3qrFouIfZ6iipjYrg+kQimDKE1BkfqKKUtXrVv0o/tZzlxgjH+GlCTLTzm2SsQZPlD
	 yLq4YhzA172o5F8vXPORNbPrnOtLLfn8QKmM2uORmRDlJ3bOHbw4IPrSagBse4Awk8
	 M0q5xmLdfYPtg==
Date: Tue, 24 Mar 2026 13:23:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH] spi: fix resource leaks on device setup failure
Message-ID: <542cbea1-ed9f-4ba7-a906-7ec1e58c241c@sirena.org.uk>
References: <20260324103042.980740-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AkxKd6dYyF5Cp6s3"
Content-Disposition: inline
In-Reply-To: <20260324103042.980740-1-johan@kernel.org>
X-Cookie: Forest fires cause Smokey Bears.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230159-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 1E1B93097FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--AkxKd6dYyF5Cp6s3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2026 at 11:30:42AM +0100, Johan Hovold wrote:

> Make sure to call controller cleanup() on late device setup failures to
> avoid leaking resources allocated by setup().

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4091,7 +4091,7 @@ int spi_setup(struct spi_device *spi)

This is specifically setup().  This is called repeatedly at runtime,
it's not part of the device registration flow like the issues that were
addressed by the commit you tagged as a fix.  Can you be more specific
about the leak you're trying to fix here?

> +err_cleanup:
> +       if (spi->controller->cleanup)
> +               spi->controller->cleanup(spi);

spi_cleanup()

--AkxKd6dYyF5Cp6s3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnCkGsACgkQJNaLcl1U
h9CpOwf/ebvValJCCRaRJx4RBmEI1jRIo/Jcb1Ek8399efSB89kDkQXE551UiJG/
TWXp70JHjoSZoTR1YZPm3abcECMObHh+PFoMCdkB9UaBOnfRfdMMBAgFKJmF+lWn
6C0yExz2eGD8aVtWglxob92xczz2wd19oA6FeJfDV3w8B4avVIjImN5lahyrGHzD
H5sdSqrQBlcwBhahl6rT57A8mkZYHNUMFF1ergM5Vsl3cCP9n3uTHClqcX0jyIVN
an1Cf0p4ko66nAlI1a3YHwjBenhG9u7MvsI9IL7UYEndeKmV1RNj6vJagol1E+vv
zFKEdIkwOWW4r0NyWXNAlqxAT6pqTA==
=ToDA
-----END PGP SIGNATURE-----

--AkxKd6dYyF5Cp6s3--

