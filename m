Return-Path: <stable+bounces-189981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B237C0E01E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E28F84F921A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF92C235B;
	Mon, 27 Oct 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="hynv0x2d"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438828853A;
	Mon, 27 Oct 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571248; cv=pass; b=o6/I924+91KwPjlf2WFTn4uZGQ9uZ7wfQDJFPmPQHOV6C96Y0XPlNOLwqSrG94xdt9pkIjQCNoehiQHES6XpG/SRBWeZ6EULcRadnZbiwp6XRlhu5lEeZzM534D8y3hKq1MmmsWhh2u5Si6IgjNx9UEQ32fCT1mXzx5K385KdOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571248; c=relaxed/simple;
	bh=5txGfbTK/lJoBk2qelxH7eykCHfeYquItBjY1BiZINU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b566Z18+zloXwp5C2e0kPc0f3GqiDuHWR+EEwu+l8rC5d/YUSS99v0u1q4ZDCCGzTqnMHShi07Iqebmj63TMS3sM332XE/B7/ENbsMt8Mqom9TBDNRkit3Z5BqN2Ge0CrPLTW1nvvWa/9DM+/2miHZQa2zv0kN1uRucDL+W8bQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=hynv0x2d; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761571224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Asloh+xn+knVNYl9BHFuXQ4FNT/zWj6LaO2R6Alg4JGqgAfAFe3irG7u6St8zFeznz7lbtasssruZADw6vBqNEi6WY458LX9tM/KtPGNWOJ4XC4Q6aEZU1WGhNZcROIo80iU3C3RYQa7TfvNyzVvnfQm5r10jrfeAyAPAXi17bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761571224; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3fBwlxqF1rMthy0kfk2jdGLzMVHGBv5ddKjWRByDHHw=; 
	b=T38z2Dd22vCdc82ezGP2rK9ar1EGYu+6WE/xztT6zw4Z6dYM+ReniX1j9iP43+Wy7sMxPEf7oLoffFmhzrxWDhYz9XbuanwNbXkEagS9YozakkzrL4UXZnLtkrjcxn43fQMRNbB91wc6B9yG6CUgfYmDc4EW2OClmj1+nh6Rgoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761571224;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=3fBwlxqF1rMthy0kfk2jdGLzMVHGBv5ddKjWRByDHHw=;
	b=hynv0x2dC17SoDNCyeTypjQ1ySmLQnPXS/ZK6AtDaw5TYJHK0OGF9OTJrHSYBCWb
	kV0t6zcc5sq5KFytwYI17Z2h7+1ZyFYAdZQb8Hfubn6qwbXMQ+MHURMDmWVSFGG9hcK
	WcLhVH962QXQ7pWTTU0YxbfoFRGc7ijmjSD4yo9o=
Received: by mx.zohomail.com with SMTPS id 1761571221990644.5175832769804;
	Mon, 27 Oct 2025 06:20:21 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E09E3180E8B; Mon, 27 Oct 2025 14:20:15 +0100 (CET)
Date: Mon, 27 Oct 2025 14:20:15 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Quentin Schulz <quentin.schulz@cherry.de>, mturquette@baylibre.com, sboyd@kernel.org, 
	zhangqing@rock-chips.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
Message-ID: <w3ttg7rmkut44gbys7m7rcwvsa67d4bqyez5fie3cxgbtjs6ib@pyelryb6gth2>
References: <20251008133135.3745785-1-heiko@sntech.de>
 <2749454.BddDVKsqQX@diego>
 <eumxn7lvp34si2gik33hcavcrsstqqoxixiznjbertxars7zcx@xsycorjhj3id>
 <4856104.usQuhbGJ8B@phil>
 <j6ondk5xnwbm36isdoni5vtdq5mf5ak4kp63ratqlnpwsgrqj2@paw5lzwqa2ze>
 <7fb0eadb.1d09.19a23686d5a.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kppsckzt35vuaz7b"
Content-Disposition: inline
In-Reply-To: <7fb0eadb.1d09.19a23686d5a.Coremail.andyshrk@163.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/261.561.22
X-ZohoMailClient: External


--kppsckzt35vuaz7b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
MIME-Version: 1.0

Hi,

On Mon, Oct 27, 2025 at 10:03:57AM +0800, Andy Yan wrote:
> At 2025-10-21 00:00:59, "Sebastian Reichel" <sebastian.reichel@collabora.=
com> wrote:
> >On Mon, Oct 20, 2025 at 02:49:10PM +0200, Heiko Stuebner wrote:
> >> Am Donnerstag, 16. Oktober 2025, 00:57:15 Mitteleurop=C3=A4ische Somme=
rzeit schrieb Sebastian Reichel:
> >> > On Wed, Oct 15, 2025 at 03:27:12PM +0200, Heiko St=C3=BCbner wrote:
> >> > > Am Mittwoch, 15. Oktober 2025, 14:58:46 Mitteleurop=C3=A4ische Som=
merzeit schrieb Quentin Schulz:
> >> > > > On 10/8/25 3:31 PM, Heiko Stuebner wrote:
> >> > > > > dclk_vop2_src currently has CLK_SET_RATE_PARENT | CLK_SET_RATE=
_NO_REPARENT
> >> > > > > flags set, which is vastly different than dclk_vop0_src or dcl=
k_vop1_src,
> >> > > > > which have none of those.
> >> > > > >=20
> >> > > > > With these flags in dclk_vop2_src, actually setting the clock =
then results
> >> > > > > in a lot of other peripherals breaking, because setting the ra=
te results
> >> > > > > in the PLL source getting changed:
> >> > > > >=20
> >> > > > > [   14.898718] clk_core_set_rate_nolock: setting rate for dclk=
_vop2 to 152840000
> >> > > > > [   15.155017] clk_change_rate: setting rate for pll_gpll to 1=
680000000
> >> > > > > [ clk adjusting every gpll user ]
> >> > > > >=20
> >> > > > > This includes possibly the other vops, i2s, spdif and even the=
 uarts.
> >> > > > > Among other possible things, this breaks the uart console on a=
 board
> >> > > > > I use. Sometimes it recovers later on, but there will be a big=
 block
> >> > > >=20
> >> > > > I can reproduce on the same board as yours and this fixes the is=
sue=20
> >> > > > indeed (note I can only reproduce for now when display the modet=
est=20
> >> > > > pattern, otherwise after boot the console seems fine to me).
> >> > >=20
> >> > > I boot into a Debian rootfs with fbcon on my system, and the serial
> >> > > console produces garbled output when the vop adjusts the clock
> >> > >=20
> >> > > Sometimes it recovers after a bit, but other times it doesn't
> >> > >=20
> >> > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> > > > Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Ti=
ger w/DP carrierboard
> >> >=20
> >> > I'm pretty sure I've seen this while playing with USB-C DP AltMode
> >> > on Rock 5B. So far I had no time to investigate further.
> >> >=20
> >> > What I'm missing in the commit message is the impact on VOP. Also
> >> > it might be a good idea to have Andy in Cc, so I've added him.
> >>=20
> >> Hmm, it brings VP2 in line with the other two VPs, only VP2 had this
> >> special setting - even right from the start, so it could very well
> >> have been left there accidentially during submission.
> >
> >I did the initial upstream submission based on downstream (the TRM
> >is quite bad regading describing the clock trees, so not much
> >validation has been done by me). The old vendor kernel tree had it
> >like this, but that also changed a bit over time afterwards and no
> >longer has any special handling for VP2. OTOH it does set
> >CLK_SET_RATE_NO_REPARENT for all dclk_vop<number>_src, which you
> >are now removing for VP2.
> >
> >FWIW these are the two flags:
> >
> >#define CLK_SET_RATE_PARENT     BIT(2) /* propagate rate change up one l=
evel */
> >#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate chang=
e */
> >
> >So by removing CLK_SET_RATE_NO_REPARENT you are allowing dclk_vop2_src
> >to be switched to a different PLL when a different rate is being
> >requested. That change is completley unrelated to the bug you are
> >seeing right now?
> >
> >> So in the end VP2 will have to deal with this, because when the VP
> >> causes a rate change in the GPLL, this changes so many clocks of
> >> other possibly running devices. Not only the uart, but also emmc
> >> and many more. And all those devices do not like if their clock gets
> >> changed under them I think.
> >
> >It's certainly weird, that VP2 was (and still is in upstream) handled
> >special. Note that GPLL being changed is not really necessary.
> >dclk_vop2_src parent can be GPLL, CPLL, V0PLL or AUPLL. Effects on
> >other hardware IP very much depends on the parent setup. What I try
> >to understand is if there is also a bug in the rockchipdrm driver
> >and/or if removing CLK_SET_RATE_NO_REPARENT is a good idea. That's
> >why I hoped Andy could chime in and provide some background :)
>=20
> The main limitation is that there are not enough PLLs on the SoC
> to be used for the display side. In our downstream code
> implementation, we usually exclusively assign V0PLL to a certain
> VP. Other VPs generally need to share the PLL with other
> peripherals , or use the HDMI PHY PLL.
>=20
> For GPLL and CPLL,  they will be set to a fixed frequency during
> the system startup stage, and they should not be modified again as
> these two PLL always shared by other peripherals.
>=20
> When shared with other peripherals,  we can not do
> CLK_SET_RATE_PARENT,. However, when we need a relatively precise
> frequency in certain scenarios, such as driving an eDP or DSI
> panel=EF=BC=88see what we do for eDP on rk3588s-evb1-v10.dts and
> rk3588-coolpi-cm5-genbook.dts =EF=BC=89, we tend to use V0PLL. But since
> V0PLL does not proper initializated at system startup, we then
> need CLK_SET_RATE_PARENT. This does indeed seem to be a
> contradiction.

I suppose for eDP and DSI, which are more or less fixed, it would
be possible to assign a board specific fixed frequency like this
and get the frequency initialized without relying on VOP setting
the PLL rate via CLK_SET_RATE_PARENT from the driver:

&vop {
    assigned-clocks =3D <&cru DCLK_VOP2_SRC>, <&cru PLL_V0PLL>;
    assigned-clock-parents =3D <&cru PLL_V0PLL>;
    assigned-clock-rates =3D <0>, <1337>;
};

Greetings,

-- Sebastian

--kppsckzt35vuaz7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmj/cYwACgkQ2O7X88g7
+pqeExAAopKE8fQlZFA9f5GoOW/acdzUtKRTxdt/L8XQdwB+pJ0uky/rYvk6m4q/
eeSP4wJ9fLwCOt9clKNaaKqcD3gYZfXrnUKtC4ya6R7p0rXi/okSZw/Fu+PZPQOm
F5eWlZpfJRph+b8v+qF0+uo8XFreZom+KDoIHdm94fp9Ow35p1+zTHNNAxmWuNRZ
HKTvgm0mw4MbDCjqkAqzRhhVNW4X6L3A2CZUsRppUDNApecM/DqUSW5z/SgR8qKM
3hNcZ83/qLWgmBWugp1lD2lijRsXYJkvquC0QVcrNfbna86hI80SEly3/Hvzo5gm
vHieEuKjPWtMqHsR3T+vavhS572tQBLPfB7WoV9gdT5pDcU3fRK9NyF+bjfVtl2i
D8hoIfzXJon2o409APanLUpioyxvJL30pTs8rzsS2jlj81oasv3Xaj8fAEi+hhQ8
p1qJFGi1AgMAtEaNuy6iftpGmaYYelHxwNkSXePaoKVG7DI9hK+e58zop7+KNsHQ
eR6Rq713wT2d4cQuQcR3GDCR1KD8+otrpAkRFHfXWuoe2jWiG7O2AxYGHmZewzEz
sYhf7UGdgHzs53ElculKFlH6N/j+7xZHxT9XL5d2C2xTcwZcE/aoKXmSBGc9KaMn
1idkp+olhSDElrlx2R+qjg4mN/7xIjuf19yLm7BUmblRo7umtXI=
=ErWp
-----END PGP SIGNATURE-----

--kppsckzt35vuaz7b--

