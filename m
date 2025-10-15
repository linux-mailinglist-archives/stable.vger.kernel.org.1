Return-Path: <stable+bounces-185867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C2BE0FC7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 00:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0427519C7895
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477B3164B0;
	Wed, 15 Oct 2025 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="fUy67HWt"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5B3161B9;
	Wed, 15 Oct 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569072; cv=pass; b=std6lnq68zCKwo10Ib5VpWN24EuBvcxXGtjEh8uZAZMY4o89jjILf7rHbMV8LiOat8jl0jIs0h9xXZCqNrGswOES6Haa3YFIvopJNH6J2GIf7ow2CDok2w2Rj+C5rVaQnoSHCTHGol7zB7yUHKyoJq/KjGeMOPO9frMZTMeQNcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569072; c=relaxed/simple;
	bh=WlJ9M21iJkXj8rRFkUa8SPz9wuFl8vn2L9ckrDhUHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvxV3/sgA+7NKkuXxtqqJUoiwa9HgvSRywPNk/nrkZXJLmna9TstQsgzHQ6ojUQw8IIk/FXKuadZpEDDj/3itn0kkXu+fqQDV8rQMeF53X/Pqx1BsG/gfLZIXY46sGKiCMs9XFXD4F9rGQB14I5t8y2jXd3Xzz/Z2262ps/R75w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=fUy67HWt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760569050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GUB2FVD69r/C01TsJxSij78wbWAgk4fStSZLc+yMKt9QZnxEXzfsrQiBxTuHERQstCf7itkNtro0ijH0FFENa1LcaIJnw/RQ8gvh3tM4nklpRji2BI2uCQsvNSQKCCEWidgthRQ/xMJAfYgBj0bctYil9ihVt1X8zjc5YwY2el8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760569050; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8hp4rymi/w615rS86fSx8eu95VzsthQfrxaFKltfQSA=; 
	b=F6efgJMTyhdEKP5OOmHpd08VBn461J90YfwLnoLuDMI80vhNMk2/pQ8WzwPubMXgvyS9nNMi7IW2JeXo8t11OpYVcwLnxxaeS/own8po3F/+ozBfzJco3u9qNBM0EwuK6cdqgiIoXQPnhmozdSH9ANVI4Hw/jwvv2gk3XrCnTR0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760569050;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=8hp4rymi/w615rS86fSx8eu95VzsthQfrxaFKltfQSA=;
	b=fUy67HWtPlTYQoadjcOVmkQ3gCyUYgPxPJzhOm7QiXAQbNxwAdcmRwaaLmK6aCSS
	UrHsTOYABL5QjHW7JHcHCgUDJDfdvz+mmvRScevB3Kl4cMBL1owRCSrAmJa5At6YvnG
	IN+P4Pe7l0Oh8dx296uW7EtAATDDPldJhrVTEs00=
Received: by mx.zohomail.com with SMTPS id 1760569047390251.2858506578142;
	Wed, 15 Oct 2025 15:57:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 7A320184DBC; Thu, 16 Oct 2025 00:57:15 +0200 (CEST)
Date: Thu, 16 Oct 2025 00:57:15 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, mturquette@baylibre.com, 
	sboyd@kernel.org, zhangqing@rock-chips.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
Message-ID: <eumxn7lvp34si2gik33hcavcrsstqqoxixiznjbertxars7zcx@xsycorjhj3id>
References: <20251008133135.3745785-1-heiko@sntech.de>
 <6677ebf9-50bd-4df0-806c-9698f2256a8d@cherry.de>
 <2749454.BddDVKsqQX@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwgcdh6ni2fyyeru"
Content-Disposition: inline
In-Reply-To: <2749454.BddDVKsqQX@diego>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/260.518.91
X-ZohoMailClient: External


--fwgcdh6ni2fyyeru
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
MIME-Version: 1.0

Hi,

On Wed, Oct 15, 2025 at 03:27:12PM +0200, Heiko St=FCbner wrote:
> Am Mittwoch, 15. Oktober 2025, 14:58:46 Mitteleurop=E4ische Sommerzeit sc=
hrieb Quentin Schulz:
> > Hi Heiko,
> >=20
> > On 10/8/25 3:31 PM, Heiko Stuebner wrote:
> > > dclk_vop2_src currently has CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REP=
ARENT
> > > flags set, which is vastly different than dclk_vop0_src or dclk_vop1_=
src,
> > > which have none of those.
> > >=20
> > > With these flags in dclk_vop2_src, actually setting the clock then re=
sults
> > > in a lot of other peripherals breaking, because setting the rate resu=
lts
> > > in the PLL source getting changed:
> > >=20
> > > [   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 t=
o 152840000
> > > [   15.155017] clk_change_rate: setting rate for pll_gpll to 16800000=
00
> > > [ clk adjusting every gpll user ]
> > >=20
> > > This includes possibly the other vops, i2s, spdif and even the uarts.
> > > Among other possible things, this breaks the uart console on a board
> > > I use. Sometimes it recovers later on, but there will be a big block
> >=20
> > I can reproduce on the same board as yours and this fixes the issue=20
> > indeed (note I can only reproduce for now when display the modetest=20
> > pattern, otherwise after boot the console seems fine to me).
>=20
> I boot into a Debian rootfs with fbcon on my system, and the serial
> console produces garbled output when the vop adjusts the clock
>=20
> Sometimes it recovers after a bit, but other times it doesn't
>=20
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w/D=
P carrierboard

I'm pretty sure I've seen this while playing with USB-C DP AltMode
on Rock 5B. So far I had no time to investigate further.

What I'm missing in the commit message is the impact on VOP. Also
it might be a good idea to have Andy in Cc, so I've added him.

Greetings,

-- Sebastian

--fwgcdh6ni2fyyeru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjwJsgACgkQ2O7X88g7
+pq1kg//XaEftjAulYritpGVJ9ktfx9Y37CPdTrs+MBY0C3e9t9e0jf9WPWkREY3
Dc/cX8SmQzSsVqvEfS06mxZwZ1d8Gz/4Q/XrqwKZZusoFz/gvKzOSMqd6knBBMKc
9U2zLzjgXmzg4BSH/mVhp1gDEk++djQzknyzb6giTwft4Mgdo7q6Ft1OUoxtfOuc
q5X+gS/QHLkehiu4eQMc02QQqa+abOYZhcZsRmH1rxDmYLoCfuADqWrTrS1RbtwG
Ln8n9/0XCxzQZG8a28IndGwkm5jVr74TldJdT16Z2UKaIT3c96sSL7ot7dE7pd5t
WP05P6HqQCiEpqKmlOEpGBsmwUmpThN3QmNVzKSsjUuyXwkcZNHp2MT6RzmiDUzn
HGuXTIl84Bj/fO7/67VEbvstO6sUDC74Wkri34I6QRoXBmlWRE9aijsB6arOqgC5
i106vm3KrV5auXKX4qRylzW+v8BIvxCFd2rXLCnUOZXSw4MXFyFwxlq0R8bPPVNj
GmpsIBC4QA60H4SPr7v2G1tua7TWurLa+lPiyZW0zqImbqZopzzNG3+/HgfnoXg7
SvNI3LYzN1hnY64brkZeLpc41ckQEg9nxRHrr6uP16N7HI65n8Bw6Bt478p1NFMs
zcgTuKGwzO2xSvNRMT2N+iflMikysLHQ8zqssgGFtbMur0vgPvM=
=+w2d
-----END PGP SIGNATURE-----

--fwgcdh6ni2fyyeru--

