Return-Path: <stable+bounces-176862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FDDB3E640
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207E72048FE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7185338F44;
	Mon,  1 Sep 2025 13:55:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75933EB1F
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734935; cv=none; b=Z/Jf0gvkP6k40+qRKRcsEtNOZapu93qQ2U3Cyw4ZdFwUw49DLH/1ngT/GiJ2G8zG9F38+8KOhqHFAvvcFg32VeyZTGsbANPoX5yuEeDpRaF/YdN+krRGb2BDk/Eo6qb0fv58wTM4guIWkwfJNyNH3mV5WXXJ7161posZMOjPSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734935; c=relaxed/simple;
	bh=+QoZ/3c/1Bc1Z/BiPyb5oXz573jSG0GSpmG13NzK1AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ie10Ql0DJDQWmWJ36/N1/Vi6t1ntvvAUeJVn1ehXrR/9WqC/HVf/rmc8njAyepf/DWacz1SxiT/0RDQlasl9jwe1+k5gOpBcmr0GzWYLucxd1Oe9DAew184DLURnb/nFCbRZgR4ajZvstwqm7gdc4Om5nMGroPlyQCRRKTfnRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [192.168.0.1] (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9674933D9AD;
	Mon, 01 Sep 2025 13:55:32 +0000 (UTC)
Message-ID: <6369adc8dee031617e5561e56b6e48c5edbe1f03.camel@gentoo.org>
Subject: Re: [PATCH linux-5.10.y 1/5] ASoC: Intel: bxt_da7219_max98357a:
 shrink platform_id below 20 characters
From: =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Date: Mon, 01 Sep 2025 15:55:29 +0200
In-Reply-To: <2025090101-exert-deceased-3071@gregkh>
References: <2025082909-plutonium-freestyle-5283@gregkh>
	 <20250901095440.39935-1-mgorny@gentoo.org>
	 <2025090101-exert-deceased-3071@gregkh>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-fG4dyd2jOJH0/ftbHZRu"
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-fG4dyd2jOJH0/ftbHZRu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-09-01 at 15:25 +0200, Greg KH wrote:
> On Mon, Sep 01, 2025 at 11:54:36AM +0200, Micha=C5=82 G=C3=B3rny wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >=20
> > commit 24e46fb811e991f56d5694b10ae7ceb8d2b8c846 upstream.
> >=20
> > The excessive platform id lengths are causing out-of-buffer reads
> > in depmod, e.g.:
> >=20
> > depmod: FATAL: Module index: bad character '=EF=BF=BD'=3D0x80 - only 7-=
bit ASCII is supported:
> > platform:jsl_rt5682_max98360ax=EF=BF=BD
> >=20
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.c=
om>
> > Link: https://lore.kernel.org/r/20210511213707.32958-5-pierre-louis.bos=
sart@linux.intel.com
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
>=20
> This commit text does not match the upstream commit text at all :(
>=20
> Same for others in this series, please fix.

I'm sorry, I've misread the instructions as telling me to describe why I
believe this deserves to be backported.  It would be really helpful if
they linked to some good examples.  Should I also keep the original
Reviewed-by lines?

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-fG4dyd2jOJH0/ftbHZRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFGBAABCgAwFiEEx2qEUJQJjSjMiybFY5ra4jKeJA4FAmi1pdESHG1nb3JueUBn
ZW50b28ub3JnAAoJEGOa2uIyniQOLKgH/1oBGOsEra3bahFfaCxSySc91+9RMifa
xqhEhNDVrnZLFL3Yj/p5yemChKZfgwjQhxJYpiH7y5WU8+N8luvUoXPCq1DUqO50
LHI/Q89PZe61At6BfzPTdNjk+6akGB1HNXUHL6Ab8v0rHYQRz+FnDXb5GUJczb4T
4cifNNx9sXtOVd/MN60IebDsQ5q/hxUf1NFSTPIdG+Usc+WevjZEvqnePWSV5zVN
qrakWZ/Ol7lVgtd4Dyacz56edklYKRkBjbNXz074ZApBAX6yfyCOjlvKceWXUllj
c/0GaWMkUahMGipNJJfJmsOAyfItWp7RacR6LU7Vj3uxDH0ZIv7bzwg=
=CA94
-----END PGP SIGNATURE-----

--=-fG4dyd2jOJH0/ftbHZRu--

