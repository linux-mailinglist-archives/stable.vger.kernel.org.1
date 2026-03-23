Return-Path: <stable+bounces-228188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJfzCVVLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10522F413B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30503318F5F7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA83B2FEC;
	Mon, 23 Mar 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUXWOahi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC93B2FE3;
	Mon, 23 Mar 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274392; cv=none; b=rJjiQbrRRvDr/QGTDbMVrpCoQzbpuJaRDPWJwnD/HSA0gKX74m0GQHy5E97/dHHrtnoTYduXpj+Vx49GCic6+S5t2bPGLeMFUtFZIZGQ8gZj3GHZbsW2fJ5qdTU7jyTCefxlfMundu+cWmSEANqfBucHYQV90tPpcNF9JUPyJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274392; c=relaxed/simple;
	bh=qfaJPcTX77P50honumdvtbvC4o0DJx2hkKyHdZsXzTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIYcZ7Bl8Z0M2GqPn80CgZgMLHjRJF6d5zEEyUgIHASHCjuu5l+6pyE8g9Uxxb5M7s2zPy2bTOzFkBlsFPF5WtO0EJlvDA+6kB4og8HmHpkXDWpShBwxUKzNtthE4r8CLv+Gcnx7kih/c0m3ohXVRQPIz3JJD1MVWCRIXmaRhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUXWOahi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F6EC2BC9E;
	Mon, 23 Mar 2026 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274392;
	bh=qfaJPcTX77P50honumdvtbvC4o0DJx2hkKyHdZsXzTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUXWOahiotCOexAWqwMx1xmtmRUXRKlFieRloAcWMX1nzbTuRJGbe9fTHnieFpDV4
	 hZpTKLDoeqGjAwGoEvkLxTxnBBstmpEbxHERmQHO4P3G4oo76QYuYQ7HcigI0/YwcZ
	 C686etZd4Fd4FDus+iLGR+ZP7zS309eoZzIAy8oEhheEKRAHsMcVMsHICw0BJ6PlfI
	 KkMEY3dn+dBapORdXhFBRwDFL0VYGWXfIkAACrVxrK6pHtRUsmQ46hCyilHxcKVkFO
	 NMR0KH0VVBQca4e4IEhwx1h8DFPZ2r4ZaQYEdkB/GnskXEi6+BL8pZ37lC1g4BckIw
	 khV2eKde94wYA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4for-00000003aId-2OvU;
	Mon, 23 Mar 2026 14:59:49 +0100
Date: Mon, 23 Mar 2026 14:59:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <acFHVTsDIbQm6GG6@hovoldconsulting.com>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
 <acEh6KiKMfBehoZO@hovoldconsulting.com>
 <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmheixEO6Qo7xv6g"
Content-Disposition: inline
In-Reply-To: <20260323-dangerous-brown-polecat-a4988f-mkl@pengutronix.de>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-228188-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: A10522F413B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cmheixEO6Qo7xv6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:57:42PM +0100, Marc Kleine-Budde wrote:
> On 23.03.2026 12:20:08, Johan Hovold wrote:
> > On Mon, Mar 23, 2026 at 12:00:59PM +0100, Marc Kleine-Budde wrote:
> > > On 23.03.2026 11:49:44, Johan Hovold wrote:
> > > > The SPI subsystem frees the controller and any subsystem allocated
> > > > driver data as part of deregistration (unless the allocation is dev=
ice
> > > > managed).
> > > >
> > > > Take another reference before deregistering the controller so that =
the
> > > > driver data is not freed until the driver is done with it.
> > >
> > > Would re-ordering the spi_imx_remove() function be an alternative fix?
> > > I.e. call spi_unregister_controller() last?
> >
> > No, the controller needs to be deregistered before disabling clocks and
> > releasing other resources.
>=20
> I see. So the API is a bit strange to use:
>=20
> Allocate with spi_alloc_host(), free with spi_controller_put() before
> spi_register_controller(), the free with spi_unregister_controller()
> afterwards.
>
> But spi_unregister_controller() shuts down the SPI interface _and_ frees
> the memory. Which is the culprit here.

Indeed, it's a known issue with the SPI API. See for example:

	68b892f1fdc4 ("spi: document odd controller reference handling")
	5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
	f0c35a024cce ("spi: fix misleading controller deregistration kernel-doc")

> Would using devm_spi_alloc_host() be an option here?

It can also be used, but that's more intrusive so I did that as a
follow-on cleanup to the fix (see patch 2/5).

Johan

--cmheixEO6Qo7xv6g
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacFHThsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQiczgEAgFAtXQwuMDPEX+tSENHm
cTTnkpGjWt3fAIBRygsEH1MBAKgFuollphgJ2NGAem3qc6lwPoVExuyElb8lP2cg
2JML
=AxEu
-----END PGP SIGNATURE-----

--cmheixEO6Qo7xv6g--

