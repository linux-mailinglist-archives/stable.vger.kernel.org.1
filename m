Return-Path: <stable+bounces-188055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24EBF1525
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9100018A5646
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E430149A;
	Mon, 20 Oct 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="t8qVnE7A"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510F231C9F;
	Mon, 20 Oct 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964559; cv=none; b=mm7aNW5eIVmCp86ao7/wm0Tr/PSmy2u0o31BaqQbkjL5fDjQ1kR1eLpPTldaCvPfUCJeZveIqcWOAvP58by4BCKrvuDb/6vRx0v929C8GwlODD0rwtPZ3efBx3g0+LrTL5o1KXU7IA9O3JQtGS32PdVnNQuc+RDJYnd/2UxRywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964559; c=relaxed/simple;
	bh=NOmJCRXZ6eAE3GfRXQ9ruS3iOj3qkQe52V3Hs6U/CVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq9/CXFcOfeft5Ut/dUIsPqdmrLBZOyuivCl3NzuBa35dyHkBu5GzrqMN9KVg37NjITjLxBXWcVC7JoPWfewMl5M9R2vpf88WpPyRdX7TGA2WPGS8yVlqWchjw6hMmQWiQlkRTds3wRHKVHp8u2WohDz7xi6sd7au3lOi/behho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=t8qVnE7A; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=LT8UUy5Ej3UyVlJPtvk5iRBgSEzEU437pG46R+ymarY=; b=t8qVnE7A5m3NrSDtXnEhrdx7oQ
	GuDvt4aKjvYuD5KxLgHuTFwBuvqYZ9xOEN2q90ikgdkzDwTlxrWocmflwGb5z0hRiDqz9U42cRdsY
	R8CSpzsS/ZEJtBp9gv3OYLvpTjZMxMaIUK+4C0w00Uz9daMN2Di6EUosKmxapNblnFB+X/NiLGc/H
	qCxsAPlLyz8ZGipQgIaxh/OqFIgkbxHGGI1KOrRG0N2mGDV9aM65nPqC6jOiIIRLiC5/98VpfpckX
	P1il/ZXHNeecX9PH6kATylv9hWtIsXJuHTmAwj06x1g80o9a9JnAmL0h55UKbHb/Sp9kzBIIq5MPE
	z47iTySw==;
Received: from [141.76.253.240] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vApK3-0001CH-4r; Mon, 20 Oct 2025 14:49:11 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, mturquette@baylibre.com,
 sboyd@kernel.org, zhangqing@rock-chips.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andy Yan <andy.yan@rock-chips.com>
Subject:
 Re: [PATCH] clk: rockchip: rk3588: Don't change PLL rates when setting
 dclk_vop2_src
Date: Mon, 20 Oct 2025 14:49:10 +0200
Message-ID: <4856104.usQuhbGJ8B@phil>
In-Reply-To: <eumxn7lvp34si2gik33hcavcrsstqqoxixiznjbertxars7zcx@xsycorjhj3id>
References:
 <20251008133135.3745785-1-heiko@sntech.de> <2749454.BddDVKsqQX@diego>
 <eumxn7lvp34si2gik33hcavcrsstqqoxixiznjbertxars7zcx@xsycorjhj3id>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 16. Oktober 2025, 00:57:15 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Sebastian Reichel:
> Hi,
>=20
> On Wed, Oct 15, 2025 at 03:27:12PM +0200, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 15. Oktober 2025, 14:58:46 Mitteleurop=C3=A4ische Sommerze=
it schrieb Quentin Schulz:
> > > Hi Heiko,
> > >=20
> > > On 10/8/25 3:31 PM, Heiko Stuebner wrote:
> > > > dclk_vop2_src currently has CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_R=
EPARENT
> > > > flags set, which is vastly different than dclk_vop0_src or dclk_vop=
1_src,
> > > > which have none of those.
> > > >=20
> > > > With these flags in dclk_vop2_src, actually setting the clock then =
results
> > > > in a lot of other peripherals breaking, because setting the rate re=
sults
> > > > in the PLL source getting changed:
> > > >=20
> > > > [   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2=
 to 152840000
> > > > [   15.155017] clk_change_rate: setting rate for pll_gpll to 168000=
0000
> > > > [ clk adjusting every gpll user ]
> > > >=20
> > > > This includes possibly the other vops, i2s, spdif and even the uart=
s.
> > > > Among other possible things, this breaks the uart console on a board
> > > > I use. Sometimes it recovers later on, but there will be a big block
> > >=20
> > > I can reproduce on the same board as yours and this fixes the issue=20
> > > indeed (note I can only reproduce for now when display the modetest=20
> > > pattern, otherwise after boot the console seems fine to me).
> >=20
> > I boot into a Debian rootfs with fbcon on my system, and the serial
> > console produces garbled output when the vop adjusts the clock
> >=20
> > Sometimes it recovers after a bit, but other times it doesn't
> >=20
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w=
/DP carrierboard
>=20
> I'm pretty sure I've seen this while playing with USB-C DP AltMode
> on Rock 5B. So far I had no time to investigate further.
>=20
> What I'm missing in the commit message is the impact on VOP. Also
> it might be a good idea to have Andy in Cc, so I've added him.

Hmm, it brings VP2 in line with the other two VPs, only VP2 had this
special setting - even right from the start, so it could very well
have been left there accidentially during submission.

So in the end VP2 will have to deal with this, because when the VP
causes a rate change in the GPLL, this changes so many clocks of
other possibly running devices. Not only the uart, but also emmc
and many more. And all those devices do not like if their clock gets
changed under them I think.


Heiko



