Return-Path: <stable+bounces-123120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FEBA5A3E9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3B188ED0C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468E23643F;
	Mon, 10 Mar 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxYY+LDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B929236433;
	Mon, 10 Mar 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635551; cv=none; b=OPO6utNzdS8NtUr7JNI7LC9szaM/+4YZoQkPV76kys6yOPQ9jLSKU9KOg2CqFWqd+363wGLNGv3FBtOI50EPs4UccrXI9O1qIgnk8MB/rjd1Lp1VSvhhlOxeQKiOFtrDxZcmtgiHzYOTGrXEfPX7SucvM80phvWLSXx97pTvuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635551; c=relaxed/simple;
	bh=ZAXsVGjflRieIiHtobTSpyzODtXUi+v/WwiVglPS54o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBd5gBkfZ22f9AshpkapX/i5HBcfYvQtaHF+upMmRpz6UPk3mNX4sXq3WGdvYm4MW8R3fP2jctOAE8fGVJy80hIutAoTQ2Df5/vQKo62elT9SfEgqz8+0THMelPiZrPG5DgtyNtnW2TniuMDTzZ9434PYGsFq2LvoI2F+XOFZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxYY+LDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE5CC4CEEC;
	Mon, 10 Mar 2025 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635551;
	bh=ZAXsVGjflRieIiHtobTSpyzODtXUi+v/WwiVglPS54o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxYY+LDe+K++vrFDykz+xjMU/+f4bTWtpkqS/5ZeCAYAf3NXG42mHiCXTMBOkAsli
	 FmIs93i4TIPpTI75XfYzuZXtI013tYwjYENHYXzYNxEn/DXL2O1OwqEniC9oXa2Zt/
	 nY1VCgxUDNcZNucwYTqTcMdvZ2toRX8zqQkQ19Kgw/SfYrERlGvp+r+K5zOvc8qpg/
	 xSDiUHw3Ywb1auNRDY7K3TF9Ds+d/w0/9zPAbIpoJcmAbJHLlov+vVzMCoWNfD4too
	 uaZ6zGMX4bECCHVVystD6NkPtr3q+4z0SHQase1WeH/i+6UHRrlJGuCcPOiBZ0xrF7
	 DM6zm8bpSilJw==
Date: Mon, 10 Mar 2025 19:39:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Eggers <ceggers@gmx.de>
Cc: Christian Eggers <ceggers@arri.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: assert that dummy regulator has been
 probed before using it
Message-ID: <1a64b191-b043-49f7-969c-f807b6a174a3@sirena.org.uk>
References: <20250310163302.15276-1-ceggers@arri.de>
 <20250310163302.15276-2-ceggers@arri.de>
 <3d195bf7-de99-4fe9-87b0-291e156f083c@sirena.org.uk>
 <4945392.OV4Wx5bFTl@zbook-studio-g3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zyPwCjo8UryL+xtv"
Content-Disposition: inline
In-Reply-To: <4945392.OV4Wx5bFTl@zbook-studio-g3>
X-Cookie: Dieters live life in the fasting lane.


--zyPwCjo8UryL+xtv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 07:22:24PM +0100, Christian Eggers wrote:
> Am Montag, 10. M=E4rz 2025, 18:23:02 CET schrieb Mark Brown:

> > > +		BUG_ON(!r);

> > This doesn't actually help anything

> My idea was to help identifying the problem (if it is reintroduced again=
=20
> later).

> > I'd expect this to trigger probe deferral.

> I can check for this tomorrow.  But is it worth to use deferred probing
> for a shared "NOP" driver which doesn't access any hardware?  Or would th=
is=20
> only introduce overhead for nothing?

My concern is that if something goes wrong in production then we've just
escallated the problem, given that there's a clear error handling
mechanism we could use we should take advantage of that rather than
doing something destructive.

--zyPwCjo8UryL+xtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfPP9kACgkQJNaLcl1U
h9Bfugf+O+xcX4eHN8PG3mEb3/U6tFbZGlgv44Rr4MUXX6M7H//FjwBsGrgKhMzG
53Nyu8r1g4W/qk7TiDbCU1khBX7lb9zAF3QvctVY8EoTrNma79C6mjxHe2SxQQrk
pTI0dZZZMhGDqd0lBcBJuDHcJ9NyxigirH3Vw7cze05EedonJcpo/RzYF2pR/nUe
RyZbKGBQhay7qk99HWS0FaOh5Uk6+uH8WHXF1e8QOsAnykdwMV3At224RXaXkIuC
spynkbO7Nz/4RaLRwPVdwYjF62p//XB7Yd0B6O6bIHrIFkJsNcMChF4KyLYg6bSb
/fy2DBwlaO3jBWdQaix3EcvtFOUMyw==
=XyiZ
-----END PGP SIGNATURE-----

--zyPwCjo8UryL+xtv--

