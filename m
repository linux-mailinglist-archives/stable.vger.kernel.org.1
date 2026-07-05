Return-Path: <stable+bounces-272107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /We8JovXSmr1IQEAu9opvQ
	(envelope-from <stable+bounces-272107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 00:15:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44970B972
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 00:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272107-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272107-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECF07300B615
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45330371873;
	Sun,  5 Jul 2026 22:15:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DE360ECD;
	Sun,  5 Jul 2026 22:15:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289723; cv=none; b=V1DfxF+KLzm/u6T8AX+0veTFjlObtN6y5YgJe97KC7mdhTqP9iz5RkMMrko+bslsHq2wnVtJfZEsPBsmDMFl74AldE8Rfz9nAjD/sVUuD3hVf5GkuySQSrvIysQVdr0gnh11REjvBBg22Gpy96UJCWlr1Pk98J9E0/v9t0snONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289723; c=relaxed/simple;
	bh=VuPMWeB+jZ7arTqsKq82MmjrOhBoG65Evy0rJ6C2ySQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qmxxo71k5eHo9Qa/lRBpJVVjkpYUR/XhQVLPanU6TZZ4ZfIAF1kCt+durBvE4RWNqFHJLkCCzKBYGZE/VZJZKfcmY5GvUngb9JRzdacSNpB0zGFyr4St701HfwPjr5cHlf9iXfz3jcEPlkuf700U56OaDTxqDj1f8f+NoUR+hXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wgV7P-000ECY-0u;
	Sun, 05 Jul 2026 22:15:19 +0000
Received: from ben by deadeye with local (Exim 4.99.3)
	(envelope-from <ben@decadent.org.uk>)
	id 1wgV7N-0000000CXdF-274y;
	Mon, 06 Jul 2026 00:15:17 +0200
Message-ID: <ed0c9af450494df5f7bfd72670754c8e48e1f36d.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 94/96] mmc: renesas_sdhi: Add OF entry for RZ/G2H
 SoC
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Lad Prabhakar	
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Wolfram Sang	
 <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  Ulf Hansson <ulfh@kernel.org>, Sasha Levin
 <sashal@kernel.org>
Date: Mon, 06 Jul 2026 00:15:08 +0200
In-Reply-To: <20260702155110.958322610@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
	 <20260702155110.958322610@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jzIq+SNiHvdsHc6vmhQ8"
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272107-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:wsa+renesas@sang-engineering.com,m:geert+renesas@glider.be,m:ulfh@kernel.org,m:sashal@kernel.org,m:wsa@sang-engineering.com,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[decadent.org.uk];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,renesas.com:email,decadent.org.uk:mid,decadent.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB44970B972


--=-jzIq+SNiHvdsHc6vmhQ8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-02 at 18:20 +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> [ Upstream commit f48ee49726ee4ab545fd2dc644f169c0809b19b3 ]
>=20
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.

But this backport maps it to the generic Gen3 data, so I'm wondering
what the point of it is?

Ben.

[...]
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -119,6 +119,7 @@ static const struct renesas_sdhi_of_data
>  static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] =
=3D {
>  	{ .compatible =3D "renesas,sdhi-r7s9210", .data =3D &of_rza2_compatible=
, },
>  	{ .compatible =3D "renesas,sdhi-mmc-r8a77470", .data =3D &of_rcar_gen3_=
compatible, },
> +	{ .compatible =3D "renesas,sdhi-r8a774e1", .data =3D &of_rcar_gen3_comp=
atible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7795", .data =3D &of_rcar_gen3_compa=
tible, },
>  	{ .compatible =3D "renesas,sdhi-r8a7796", .data =3D &of_rcar_gen3_compa=
tible, },
>  	{ .compatible =3D "renesas,rcar-gen3-sdhi", .data =3D &of_rcar_gen3_com=
patible, },

--=20
Ben Hutchings
Every program is either trivial or else contains at least one bug

--=-jzIq+SNiHvdsHc6vmhQ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmpK120ACgkQ57/I7JWG
EQmG9BAAneHQr/7TsyirIIirMiXIpu587B1303jkBDQaXb+kUhgiTciN2heweZw3
32x7NeMC9aUeBnHENwL9ld9z5QSYbBoFQ3sHzJpgOwipAoWV+kiPD4lqAca8lbtQ
pkanACJ7rIikW8IUZAkxgMxHE/8T779QCtfwzpKOHKmzKUhmi3vNIWpGaF+7uPN6
DbFLP2ObBpmQr+zh6QNazEi53Abva5Bd3admK/XfCLrq186pXy2h/q4L2zjbL5u1
VoRoqkGN5+VIXlU7QakTraJd2tOa1DbJfB5p2HpXGG+nml1oiq3GaK6E5rKqsBup
IAM874yWZgtxFpBjM7TavttrZxrF115+npxUggIq4SEjfOfStfC81W/4B9Dm/KAm
xi80kG8hIdS+YnNZNEcvQAAs9zIhkuqi7inKj70NNDqj8P5LlspfsEavBihHaUF2
GgjxBQ0Y5bzSIXKLl97m/2Va7KossqT/TzNePm5a5LXT5DnG0yTzQ2RXRFn6t+6N
MEUhzcl7T2ezEX9EZCvnDWgmgGqsgotpuyB87KsoMtNGyzEHj9iFmqFKIaMmLsD8
9Ats3hkr9TmblMbgVoCMSMDRZOxoSU1rZuA/PGTCyvK3ptCgNPjhjzOUUQUw4zrz
4AzTorxQeTM4+YGA9QG3x4ZDqDB83YbsAq5dzBAC9z/qelUzw2M=
=ihNG
-----END PGP SIGNATURE-----

--=-jzIq+SNiHvdsHc6vmhQ8--

