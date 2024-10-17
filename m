Return-Path: <stable+bounces-86577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A19A1BBC
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315051F22D16
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB017BB03;
	Thu, 17 Oct 2024 07:34:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83C144D21;
	Thu, 17 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150499; cv=none; b=mbINf1rkmthP4ysJMsNWLOWxkPerwS8Gy84khiKsLbRZ2T5h3mLpb30MuWM0fVsEaAYRZZFazmEUt5lbpg+D6kcy8ZlW5LWEHy16IkexboZG8YuiwElnzWUUzLWnLAdoKa2NXk7sVbzZs0iYp+Bj7au2EKaPn+TH8tRepBAXdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150499; c=relaxed/simple;
	bh=XUbV0oCgOYoz7NcUb/PwQakpU+YQNjrval7Oi1EcL3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chGp3q5Rhsq5V1H/fxl2hmTZAPekkEvAQUIX82MO8txf9YCo/yQ1RqY0y74xA8TNntDXdR8NfpLALjC1IEz4s0x7jecmBKBqG0pquNE3jv/3WzNEtmtgjchEI6TPh7dhPl+48cBPTDVXVCY3HysoNW3za2Tr3VCUiB1en1OkI3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 701301C0095; Thu, 17 Oct 2024 09:34:55 +0200 (CEST)
Date: Thu, 17 Oct 2024 09:34:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chris.paterson2@renesas.com, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH 6.11 000/212] 6.11.4-rc2 review
Message-ID: <ZxC+HkGcgdCg5gtE@duo.ucw.cz>
References: <20241015112329.364617631@linuxfoundation.org>
 <Zw+IXqfj5IA1KXj+@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOxLUA0/PC+9647U"
Content-Disposition: inline
In-Reply-To: <Zw+IXqfj5IA1KXj+@duo.ucw.cz>


--TOxLUA0/PC+9647U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> According to our testing, it breaks boot on de0-nano-soc.
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/1497863060
=2E..
> Quick test showed that 5.10-cip kernel still works on that target, so
> it seems to be real issue.

So now it looks like we have misconfigured addresses in
u-boot.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TOxLUA0/PC+9647U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZxC+HgAKCRAw5/Bqldv6
8h/kAKCsJZTT8g90wJln5cBPCyLqdCM3vACcDdykqw0jiHA3q5FUz6c2XTqK0tE=
=QAdR
-----END PGP SIGNATURE-----

--TOxLUA0/PC+9647U--

