Return-Path: <stable+bounces-233554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMNaH27g1GmsyQcAu9opvQ
	(envelope-from <stable+bounces-233554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:46:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B83AD20B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C273098478
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C043A9DAB;
	Tue,  7 Apr 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kpc0nISb"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8663A4511;
	Tue,  7 Apr 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558523; cv=pass; b=SWPCOpLvXq3mhmfw9vTp1rtSxI5wXmzsdQ0YlYVC8Axt1RSGl0+CocB/HxtvMCQ0k7297KAvFmsSXCM3tjCqHnn2/Dwv/gYqVEHtHDwRYjAxUGE2gkHHtEqs4ImdH/Cp9x5Qvt/S0jKzehFau6J4EpKWHP4wNFT1jTgshf4+r3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558523; c=relaxed/simple;
	bh=kAJURncyoURgTHurSGkAm88RgoVHTJqGrQQ2rzzd8+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icTsODhaIBl9+aStPKb3EG7coz1gMlczhboUeSbr9n4h1uY/INTPOpd6g5Ogxwrp1Pdo1d7QBKjdKW5OWUP3wvCEBIlNWAF+IkMr0Sg6CbZqYv5+g8+9OmWlt1Y3y7jH6mA2hNwLKZSRuCv4gCQQoRb7FqiDVOpv6mvop3QVcLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kpc0nISb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1775558514; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WNfK0iEk5C3li8Wot4gn+zZPtYkqv2rIwmA1NiIgwesuUV6UwgGv+KdUv9ap+PaP3pNDfjmvnLqLYBBuxaT6DFwOtNkdeGwcBgAPfVk46ArCQg72niMXI3NI29NaBLCNZnEFmPZWAdglgRdJH/BGGrwfWKuO8mXa4chDk2TVt78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775558514; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=577Jv7VoyEZm5YBAqLL+VK/JqHJHZfQ0FUqdjs3mDWM=; 
	b=NZrDsgDUXActm/VEVJGTA5rMDScA4SdRTCnTO0UroaTRNXdQ7O6rzk4KpNTS3dfjyuGMi1ArLaM71ID7or1D8TwbFoW+fJfkYCL8h+AFmuAsrory+yG0olS/eYss2w6azu7aU8a3cb64uEN+aJINZISVS7+LAGR10t+Bo5mGKbA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775558514;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=577Jv7VoyEZm5YBAqLL+VK/JqHJHZfQ0FUqdjs3mDWM=;
	b=kpc0nISb5FPwFvFA1IvqEWpmgEzTF1QW++k5mOCheRP6kC+zIR95Tql/UU6Od4hK
	IbmSIdiHUqU7JqiE+Tpjpg3zpEhoBAGgXhqDWkFyQIoqXHjIIkiZriWeBQNLYXWZWLL
	JAe6SMz0qW4pP0CjGfkZNAzqmtXsA+7GXC+Cbkm0=
Received: by mx.zohomail.com with SMTPS id 1775558511975143.5567298866806;
	Tue, 7 Apr 2026 03:41:51 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 985E71824E2; Tue, 07 Apr 2026 12:41:48 +0200 (CEST)
Date: Tue, 7 Apr 2026 12:41:48 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: rk808: fix OF node reference imbalance
Message-ID: <adTeqwMu2f_lkQhG@venus>
References: <20260407094156.2573027-1-johan@kernel.org>
 <20260407094156.2573027-3-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ddzwxc34jg6x4i7v"
Content-Disposition: inline
In-Reply-To: <20260407094156.2573027-3-johan@kernel.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/275.535.27
X-ZohoMailClient: External
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233554-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,chromium.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:dkim,collabora.com:email]
X-Rspamd-Queue-Id: D41B83AD20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ddzwxc34jg6x4i7v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] regulator: rk808: fix OF node reference imbalance
MIME-Version: 1.0

Hi,

On Tue, Apr 07, 2026 at 11:41:56AM +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>=20
> Fix this by using the intended helper for reusing OF nodes.
>=20
> Fixes: 5111c931f36c ("regulator: rk808: cleanup parent device usage")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/regulator/rk808-regulator.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk80=
8-regulator.c
> index e66408f23bb6..1e956153427e 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -2114,8 +2114,7 @@ static int rk808_regulator_probe(struct platform_de=
vice *pdev)
>  	struct regmap *regmap;
>  	int ret, i, nregulators;
> =20
> -	pdev->dev.of_node =3D pdev->dev.parent->of_node;
> -	pdev->dev.of_node_reused =3D true;
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> =20
>  	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!regmap)
> --=20
> 2.52.0
>=20

--ddzwxc34jg6x4i7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnU32QACgkQ2O7X88g7
+poNCw//bRA5dqjnZTtctHd9INvEUjrLC95TIqWpaHm0wYL9yEKEkrhb3a2Oh6t3
M0j1D2FDniyuoMu/feOS4W4VrPCNzGQobE7Ve9xOFL34W6BR3MVTrxzkGpg5T/e9
fdaBmfqr7EWiE6uS7uRGoDn50DGV0aj0Ib/Nl3635NZ4QD5kSHk2URi73CSEVWl+
fH7HOuhTRcquOQ7hFEQv3MFuonU+Yqda4+PAa6tOlVHlOAmAitrT/g7FNWuk8PuB
5oxP1/UeWaRMSYFzxNuti5l1TuN1yzJWtTbumj9fN66t7jTSETb0EeI+vCkMoDRU
/scyTQXFBAv3RinHUTFrc2vFCov8ui/oYWG9rYL3HE1wHfrfyr4Pjc0dmFQDKnMi
qBusgPPIl+I10ZNrLWAJNXyGGlR1LkxYTuUWf/Z/9EnKfLxHlUrFcsut6mJALwOE
buszeJBZDm7bep93zIUy0SXcB6y/yWvFSWQS1ZIr56IQ1CFyEnORvr0IWAUv4FR6
s9xnjUP7VPnd3f9syW1ikaiRuOqVCWl+xrdZ6c6vDFCD4pk26nBqUV/D/Gvh8OxH
0tqnUHXdiz/iTDfpTgnSLEaMAIJa5rXcU/vlnBk9+hEvyiDG0daZIV8FXH3wvwRZ
+qbtOaneByjkGFZbwHySmX8PAknBhSLDjAMYfDs+o6Ey/TS55RA=
=j65m
-----END PGP SIGNATURE-----

--ddzwxc34jg6x4i7v--

