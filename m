Return-Path: <stable+bounces-259352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIiNHoVDHGrQLwkAu9opvQ
	(envelope-from <stable+bounces-259352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 16:19:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B380616A81
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 547E930041C9
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DED63368BA;
	Sun, 31 May 2026 14:19:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8F332EA2;
	Sun, 31 May 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237187; cv=none; b=QTuNgNYpi3ZfcS8vR3E4ux6m5sUXF5sikwWojHY+jrNTc+7mZxASqSJrYa0jZkfAS7H66S5rEXWH5cuYHlwNV7lwFqaE5Bf7qDxLOpoaSXmZRqbzublYUVb65cG4zc53/xo6jt+5kvt5cEE7UBn2SE2kI30azlxTqjq7Sc3hdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237187; c=relaxed/simple;
	bh=dEgYalVeKkZqCZ0S/NKEeezREN36klzUlk3U8bynM7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyifNuQSC0dP7xov+WqNzh9/nipfVe/daT8CWa26abxTh5xxfnThGiz2igNjzQVJURnSeMIleX7oj51o4nPAB+UhmeP5g3D0qSK+CyPjVKyKVTqBcj7bXNMvVK70DWkcdZO2puHYZL1I1HjJJ1jEqYlp7F3lMNgkruMU02Dy4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wTh0w-000OHI-1g;
	Sun, 31 May 2026 14:19:42 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wTh0v-0000000FFck-2a3L;
	Sun, 31 May 2026 16:19:41 +0200
Message-ID: <b7871589afa5bc3668b07550b9e8b69b3a6c15dd.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 114/589] arm64: dts: imx8mq-librem5: Dont mark
 buck3 as always on
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Guido =?ISO-8859-1?Q?G=FCnther?=
 <agx@sigxcpu.org>,  Martin Kepplinger <martin.kepplinger@puri.sm>, Shawn
 Guo <shawnguo@kernel.org>, Sasha Levin <sashal@kernel.org>
Date: Sun, 31 May 2026 16:19:34 +0200
In-Reply-To: <20260530160227.753209120@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
	 <20260530160227.753209120@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-hBijeSRhk6/jPsaufnci"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-259352-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sigxcpu.org:email,puri.sm:email]
X-Rspamd-Queue-Id: 1B380616A81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-hBijeSRhk6/jPsaufnci
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 17:59 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Guido G=C3=BCnther <agx@sigxcpu.org>
>=20
> [ Upstream commit 99e71c029213d3cfcc4f39a534c73d1828ffb341 ]
>=20
> With the pmic driver fixed we can now shut off the regulator in the gpc.

But not for all hardware revisions.  We need commit a362b0cc94d4 "arm64:
dts: imx8mq-librem5-r3: Mark buck3 as always on" on top of this.

Ben.

> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 susp=
end voltage up to 0.85V")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi |    1 -
>  1 file changed, 1 deletion(-)
>=20
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -671,7 +671,6 @@
>  				regulator-min-microvolt =3D <700000>;
>  				regulator-max-microvolt =3D <1300000>;
>  				rohm,dvs-run-voltage =3D <900000>;
> -				regulator-always-on;
>  			};
> =20
>  			buck4_reg: BUCK4 {
>=20
>=20

--=20
Ben Hutchings
Time is nature's way of making sure that
everything doesn't happen at once.

--=-hBijeSRhk6/jPsaufnci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmocQ3YACgkQ57/I7JWG
EQlv1g//YJ+MrTZTsbrDpLqKgSEGLlfyacs4IJV8FyEfnRpkKjZsS8fScTk+3bic
F1FMDKEDfnxfNxmdhOYKdBuqPsBg6VZmPrvDVSEdAS4bOYtDwmDgI1g1gdGEIyDZ
whjwxHlLHX0A6RXCGWMwqYe4vswqCwa9u3A4nFpY1RNz7Gx2w2be8SxvKfcwjg+U
Okjn2i4vib7V42kVwrUYYRcbZ7bIWDIzRByIGHL7Jy0HgBxiGB3MkIm93O98Xer5
EEK3SlncZMKS9UteAetfQuv1R1g5RhB9XYMKE/BQtayoWZAClHOxtRKLzNxdA5Up
h9eI5Qp1on3OsNrfM+E4b92zpggWN5L2BQCkcs9vq5iVuRez5m9IJkJddqZ7tb0C
mqi+mrg27fVp+v5M/XpuSGdMASczcflYt+O5J/KRDK1OfrWaP8BFk1ZIi4uN1O+w
Y2DicENIRFFXFh631vEoJ2BSPjahkRj0uCfC57k5SmnVpF65SkmzBjkXiJqFByXf
Zjyvnjck0X7zzgvCu5Q4/uLv9eD81HIUXOdd37j8mUucMCA69Yn2HfoXQaXAxokE
dT51fBs9g2uViseGln4M/rUrMObc5BssSvzZxJ5l8GGhmtDaLdRXXy+hyP327aF6
0z/4sOtTOBLCOnw8uSrpnNp5pl0OowErSWxSoczqN0A0j2ZcE9M=
=IkH9
-----END PGP SIGNATURE-----

--=-hBijeSRhk6/jPsaufnci--

