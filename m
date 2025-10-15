Return-Path: <stable+bounces-185822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D5DBDEC0A
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18616407229
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9C20E6E1;
	Wed, 15 Oct 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tWVdwD3B"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9B1F4CBE;
	Wed, 15 Oct 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534850; cv=none; b=fbSNlotagCKpNUud9uevvMVS24QtoF7jyxJA59diS1BMvn8Ni/dqTgwi2UgKLTHwI7g1hpLbWkgofwzwNToO9HpwToqWJqZ3QDIHeGyglpdiFTTJGPjh7MPfAWcV6rwPvaYV5AvcD3OaWSj5Xys+mtbv44RjGZwMK3JiRlfzGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534850; c=relaxed/simple;
	bh=kTXZnSO2pGG9Yfrfg2dDvXGwy2AWU+E8hqGmsSKEt1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8MXpwZBCth0j42NC0s+Af+eoRtCCHy1ISgGV9YY9YUn0J482yO39tdb0c2Z+/TioDkata//cECiqvDq4ir8F/SLtUQKG5FrCkhPfUiLYms2cKUpN4rVS7TAPL8E/au8KsGaDsfroOxIL1efypbtVT3aiBs708g8Ep/E1SUVC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tWVdwD3B; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=EFu78uXLNhhYEH7SVSyRI1WHuG5g54Ao3mQfyxG+tcA=; b=tWVdwD3BvmoVph276K/6AP4+qH
	FOgl0YNA7jJdbhOWcHJU/rnlh1YeNzgB9WF4tJPvuZKylLCkTWCzzR5K/D0I8cpazCXWYylTCdo7Z
	CJYaFUS7GccbUgcRUhX4T9cy/WFZ6RiFo6LexaXZpK6XVNPlissl69o1kRlu7mI8qYHBuKZ/5Rdya
	4BAA8eEnVsoY8kve7J9ddgxVXZbwAWfyUZIiEIvXV/ib2DyzjHnNWKJIvC34fzk0KH4N2bjYtWdvX
	GCb9B0oBFseQS66XDAw8YFoR+YhZJXBi1kUgasdPvWT17hTspcUsJFwPHgfcXGc/d1NGMro/KJFIu
	MairWdyQ==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v91X6-0007hd-Ux; Wed, 15 Oct 2025 15:27:12 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, zhangqing@rock-chips.com,
 sebastian.reichel@collabora.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when setting
 dclk_vop2_src
Date: Wed, 15 Oct 2025 15:27:12 +0200
Message-ID: <2749454.BddDVKsqQX@diego>
In-Reply-To: <6677ebf9-50bd-4df0-806c-9698f2256a8d@cherry.de>
References:
 <20251008133135.3745785-1-heiko@sntech.de>
 <6677ebf9-50bd-4df0-806c-9698f2256a8d@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 15. Oktober 2025, 14:58:46 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Quentin Schulz:
> Hi Heiko,
>=20
> On 10/8/25 3:31 PM, Heiko Stuebner wrote:
> > dclk_vop2_src currently has CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPAR=
ENT
> > flags set, which is vastly different than dclk_vop0_src or dclk_vop1_sr=
c,
> > which have none of those.
> >=20
> > With these flags in dclk_vop2_src, actually setting the clock then resu=
lts
> > in a lot of other peripherals breaking, because setting the rate results
> > in the PLL source getting changed:
> >=20
> > [   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 to =
152840000
> > [   15.155017] clk_change_rate: setting rate for pll_gpll to 1680000000
> > [ clk adjusting every gpll user ]
> >=20
> > This includes possibly the other vops, i2s, spdif and even the uarts.
> > Among other possible things, this breaks the uart console on a board
> > I use. Sometimes it recovers later on, but there will be a big block
>=20
> I can reproduce on the same board as yours and this fixes the issue=20
> indeed (note I can only reproduce for now when display the modetest=20
> pattern, otherwise after boot the console seems fine to me).

I boot into a Debian rootfs with fbcon on my system, and the serial
console produces garbled output when the vop adjusts the clock

Sometimes it recovers after a bit, but other times it doesn't

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w/=20
> DP carrierboard

Thanks for testing
Heiko



