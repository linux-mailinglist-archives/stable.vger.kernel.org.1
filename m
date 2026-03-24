Return-Path: <stable+bounces-230174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADUpEBicwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:13:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC2309FE3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5152330275C1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4290381B0D;
	Tue, 24 Mar 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLh1aBNY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673053FBEC6;
	Tue, 24 Mar 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361601; cv=none; b=Q/lgW68r1kYqmpqJDXPr+YtogI3zLgvU57hWEwTkTziyWajAyGg/uUBUzkQBAAuFoa9UrDnrTDYXVGqPWf4gpiAkWBsj5UHTfLNQM2f+iT/piaGU9tEjglPYYV3ZFRsvfoQCV8b1TSQA8Br03v4J8Dqx/tepbMNwh6CRY2uFdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361601; c=relaxed/simple;
	bh=pSKSv1Dovqj1EpV7/Yf6AWFU1SElqI0uW71XMJfafd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8hcI3GkqctyGrryM5BMlG6ewwAG5Rxu+vUFoDHuyowVkX3wUQV+L/3ZAJ16tPXdqK9pJaGP7j4G/hehPl74wvTQu7TD3k1Ulrh/eNg6L+cwXvqpTa2dHZg0JCIV9nVd5jpjegJrrctu2lA3AXtQOsDoElOVhsIP26qiIXATkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLh1aBNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E6DC19424;
	Tue, 24 Mar 2026 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774361601;
	bh=pSKSv1Dovqj1EpV7/Yf6AWFU1SElqI0uW71XMJfafd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLh1aBNYBP77mjpsDcbxiO3oVSFPbX8TA+ehXhMxNGxwr9bpwSg3HME9tRZqJ35pu
	 esgeqr9Kb0w/zDacShSgRcI+pLceF0j/p17J+LHNJ0RiDP7K7axNblhTvH5f/6WyvH
	 YAKR1qvLZqiXCTOsxCihRZZahZ1SF7NBNhKzkgJcxlIwzL+U925WnEE0gFkMy5Kuz+
	 w/bEhVL+u73+SlJu8AFkcVgfSTdeOBILO2R1o90nQC40SnFzPLqU0k6FiQGyTOeqNd
	 uJz2j2bb1QM8o/6/mkmxT8SH3A/Laqu2VmKw4rLnKXRjmJinvNk7RFIeGvUyR4mr74
	 z4rINfOoJOLyQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w52VS-00000004Cgc-22Jo;
	Tue, 24 Mar 2026 15:13:18 +0100
Date: Tue, 24 Mar 2026 15:13:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>
Subject: Re: [PATCH] spi: fix resource leaks on device setup failure
Message-ID: <acKb_jjoGBimP4CK@hovoldconsulting.com>
References: <20260324103042.980740-1-johan@kernel.org>
 <542cbea1-ed9f-4ba7-a906-7ec1e58c241c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PawQDfS5MijQ1QTl"
Content-Disposition: inline
In-Reply-To: <542cbea1-ed9f-4ba7-a906-7ec1e58c241c@sirena.org.uk>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230174-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 06EC2309FE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--PawQDfS5MijQ1QTl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 01:23:56PM +0000, Mark Brown wrote:
> On Tue, Mar 24, 2026 at 11:30:42AM +0100, Johan Hovold wrote:
>=20
> > Make sure to call controller cleanup() on late device setup failures to
> > avoid leaking resources allocated by setup().
>=20
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -4091,7 +4091,7 @@ int spi_setup(struct spi_device *spi)
>=20
> This is specifically setup().  This is called repeatedly at runtime,
> it's not part of the device registration flow like the issues that were
> addressed by the commit you tagged as a fix.  Can you be more specific
> about the leak you're trying to fix here?

It's when spi_add_device() device fails in spi_setup() that cleanup()
may no longer be called.

	spi_add_device()
	  __spi_add_device()
	    spi_setup()
	      controller->setup()
	      return -<errno>;

And there are drivers that allocate memory in the controller->setup()
callback which is released in ->cleanup() (e.g. atmel_spi_setup() and
atmel_spi_cleanup()).

=46rom a quick look at some of the drivers it did not seem limited to
memory allocations.

But I see now that not all of them can handle cleanup() being called
more than once, which could indeed happen if a later call to spi_setup()
fails after the device has been added.

We could set a flag to track whether setup() has ever been called
successfully, or make sure that cleanup() can be called more than once
for all drivers.

> > +err_cleanup:
> > +       if (spi->controller->cleanup)
> > +               spi->controller->cleanup(spi);
>=20
> spi_cleanup()

I open-coded as I'm matching the call to ->setup() inside spi_setup()
with ->cleanup() (i.e. not spi_setup() with spi_cleanup()).

Johan

--PawQDfS5MijQ1QTl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacKb+xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQg3LAEAoa2qPDOpkO+AuQlh1pgz
Qe7hB+gB80YkCEj/g44sj6MA/RdH26D7IxQn83pemLX+SQNOrpHA7BLc3JfcyOsM
euYF
=1Z9M
-----END PGP SIGNATURE-----

--PawQDfS5MijQ1QTl--

