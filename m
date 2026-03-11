Return-Path: <stable+bounces-224646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OyWLrEWsWnpqgIAu9opvQ
	(envelope-from <stable+bounces-224646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:16:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25325D830
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 08:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C1932B3DFF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD9389446;
	Wed, 11 Mar 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="X8KVSVaB"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BD38838B;
	Wed, 11 Mar 2026 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212920; cv=pass; b=ltCiaioG5NeCmUWpRMy+b4zaLJwp46wqyi/Pdl/9iYOz2zg1bzenIV4pJHDi5qoJhA3y1HBQPN7+1NNkqfY7i/pPAc0gylKSaemhV4+SV4YwykvSnuNxSu/vi7hfFwxnOnk5Di2/77f+S36Yx/+Wo6B9wSCBksTKNxyvrvc6p0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212920; c=relaxed/simple;
	bh=b19OJUdc+peetZN8MrZd6KnNEJM5xBFPAsQwDYPC/Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsMWy/w5CzPeOBSwIWVcDzREFzppAU7zn4R9B9F5fsFSfVijC5c9UWPhgQrDbyKqXZQY9yPh4HNSeAWSpO24e6y+flcqc06BtY/vjfMDbGvKUeSYlRyDkZ8piAfFjikQbws97/9EU7JfQAl4aKpsi7PKB2OQwvGlzZqo7LvCdoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=X8KVSVaB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1773212907; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aCXTokr4EDNW8u2al7QG22pupcRkju8K3QP/a3ByOSYHd60dlGEuG8vfRJTgLWr3GELNlKuVzD7MqmDwJyjsUmyriEBOEMIOcwAeK4z5x+CyNU1RrgMW3D1UgXOJgkaFEdvJzifBWIIxAHEN5AgyiuiQNApXGXWYvYS9CA/9GA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773212907; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RTdR+D4GhGsibmGnpvqFGWz9IA1zBW5Nj3eCi1PCPgY=; 
	b=BkXR2EDoBoPKgPzX02QnyyehNXLfommNtQyuRoslyl9aldDyz1xqesUYvB7tQUijAaPCAx+WF8YX4d7axhTHoHmsT/o/ttwl5wuRF666XBWNSQMBvWvJiaBezIZ8EIUIz3+jzvulrEkeS9QomdHCqVf00CLjo9YIEM38XdPX4bI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773212907;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=RTdR+D4GhGsibmGnpvqFGWz9IA1zBW5Nj3eCi1PCPgY=;
	b=X8KVSVaBpAc3edEKGOVetX50QJ7q4x7XfdjCr4n5a6VOGhEX7T3I1Ibf3PzpbbCw
	nkRKSkOexU6+Ww5J9J8OL2OATlvvwOHfiH2OdxD98mcwnqkz5pbMZM78/rm+fBP/hhp
	NNiNQ+uozUBSelOY2fXicar1CP8+DjUMTO612d1I=
Received: by mx.zohomail.com with SMTPS id 1773212904531201.5143077785866;
	Wed, 11 Mar 2026 00:08:24 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 850C2180598; Wed, 11 Mar 2026 08:08:17 +0100 (CET)
Date: Wed, 11 Mar 2026 08:08:17 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Message-ID: <abEUxeKLiowObPyL@venus>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
 <20260310-bq25792-v3-5-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrjbboz7ivwrdkum"
Content-Disposition: inline
In-Reply-To: <20260310-bq25792-v3-5-02f8e232d63b@flipper.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.1.0.1.4.3/273.195.15
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 5D25325D830
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224646-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,flipper.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--qrjbboz7ivwrdkum
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
MIME-Version: 1.0

Hi,

On Tue, Mar 10, 2026 at 01:28:29PM +0400, Alexey Charkov wrote:
> The minimal system voltage (VSYSMIN) is meant to protect the battery from
> dangerous over-discharge. When the device tree provides a value for the
> minimum design voltage of the battery, the user should not be allowed to
> set a lower VSYSMIN, as that would defeat the purpose of this protection.
>=20
> Flip the clamping logic when setting VSYSMIN to ensure that battery design
> voltage is respected.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX cha=
rger")
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq257xx_charger.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/suppl=
y/bq257xx_charger.c
> index 02c7d8b61e82..7ca4ae610902 100644
> --- a/drivers/power/supply/bq257xx_charger.c
> +++ b/drivers/power/supply/bq257xx_charger.c
> @@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *p=
data, int *intval)
>   * @vsys: voltage value to set in uV.
>   *
>   * This function takes a requested minimum system voltage value, clamps
> - * it between the minimum supported value by the charger and a user
> - * defined minimum system value, and then writes the value to the
> - * appropriate register.
> + * it between the user defined minimum system value and the maximum supp=
orted
> + * value by the charger, and then writes the value to the appropriate re=
gister.
>   *
>   * Return: Returns 0 on success or error if an error occurs.
>   */
> @@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *p=
data, int vsys)
>  	unsigned int reg;
>  	int vsys_min =3D pdata->vsys_min;
> =20
> -	vsys =3D clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
> +	vsys =3D clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
>  	reg =3D ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
>  	reg =3D FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
> =20
>=20
> --=20
> 2.52.0
>=20
>=20

--qrjbboz7ivwrdkum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmxFN4ACgkQ2O7X88g7
+pqvcQ/7BxTt3z3BJknB92Gdrat2mFE2vC4Anuc74X+sB2PGI0UE+H0ygDJZt0NO
wheMwR26VfxzfBY58YHzbBmWBIzxsJ0JjjjGulCQEqpo6qkXfuC6zrX4yrgjgtp+
PzDQ7awxcSz8KAx63ZQUpGYxp/ZVeORBpeQpj9fTKZvOfyY4/oJ42OLn6M+IqC2b
l9wYybG9kk/zEHb+wwuKuOvP7Gk6RmfrkovYpkk5eojKHbbWJYvPorW4+YJkfOv7
lKQom+aRLokE7tF9c6ABuPip6ZikVEtDTjOGIMt3pfMHbVj6Lc83QXQqlQM9f07+
UNKQllrjMeBqYv42oy+1L3t5VDv9dfHj9SxgTehjtIrlwY6p0gajEAdgghaI6Fiv
je23WMSVgaTBdcYUu3lkXcEHhU2HUhjYlhD8yBS7BZs2uMYlauSr9I9Y0RwwqvY4
crYWu0MiK9eLf2TPU+TIXJrVpBYxWuq3TCvSeid3FgTRc44/HELNognkF3HGeja6
Q9OTsEfzg/oIrE1kbRh2AtX8e9BTdR6oeaumPTTaPnqdG4pKCa6Ez8xjhgUrRhsk
Mbaw8nfxBAdeEIK6oSg6ygcX/CHzcVzlWxHH25cc9zRVm1PKWfAYC7sGoPgaIhA2
R3sC52LNxWG8cx6lm1XNg7n4qzn965oLQGhOe5aTfiFEZqYHE0Q=
=ZmPz
-----END PGP SIGNATURE-----

--qrjbboz7ivwrdkum--

