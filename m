Return-Path: <stable+bounces-46469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7008D0598
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B4F1C21414
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0915EFD9;
	Mon, 27 May 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe4kgmTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EE15EFAE;
	Mon, 27 May 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821687; cv=none; b=VzCUEHGe5HVKm+VKjlHXY8kprTw1OoBfKeOAw/ozmnGMdnGn4mIdOb4QgXRJ6Yjd7f6zU8UaQ0KOOw1iTX1GWyP0AilUPctPSiNGJFolzjBaazAlg/P7ynX4a2vmGhSIdFfWFLHkbf8Ti108/oSQuCK9HdRobMtu6M3YmEhBr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821687; c=relaxed/simple;
	bh=4xj/rMp795VJ8/WUQaQhFExsGLZLPZOia5IoxkqhSvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0bEn7n33a3o+lUkn3DSpLHQP0WLASirS2ce0IounSoEip+ZcokJIhulztA2JwRYRVLPCDDfC/V2K6P/M4XfOdgfNv1wJaBovsa8nuPD+NCnpov+jMnox7GjMZ9+JmdurG+tAgPTk5Ly5ivLCiHVruCJiEbEMmrMc0RVywRVCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe4kgmTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2384C2BBFC;
	Mon, 27 May 2024 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716821687;
	bh=4xj/rMp795VJ8/WUQaQhFExsGLZLPZOia5IoxkqhSvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oe4kgmTIPvDetWrECerAh6AODF0QPzEu8znSjprVX/Qw234hajLABOpEpu7tA11gr
	 oAkctYszlt1OxW/ILDSrC7IaiH81bc5xbi0mfTMN35fheBO/pUGryGfcU4dFzF66hQ
	 7+ipQdSi6ipXbIBjFexRuX0U5iDHbRVI4hACoqdqX7/pTg3avV7sfDVRlX21yjY6SY
	 WWRxSmt3ZC3pW29dSnDGskA/zMWAtgreerkJJ3gvitTOVIEkhDnaYbK4OGYInV3MT3
	 cYclWCuJK+5fIa7T0KP+RQhHPaJFHRGI0JjJVY8IWv75aMW5QBe4uOIA5ivqX5p8zf
	 LrEnR58Sn9j2Q==
Date: Mon, 27 May 2024 16:54:41 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Eric Woudstra
 <ericwouds@gmail.com>, Russell King <rmk+kernel@armlinux.org.uk>, "David S
 . Miller" <davem@davemloft.net>, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 12/35] net: sfp: add quirk for another
 multigig RollBall transceiver
Message-ID: <20240527165441.2c5516c9@dellmb>
In-Reply-To: <20240527141214.3844331-12-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
	<20240527141214.3844331-12-sashal@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sasha,

This requires the whole series from which it came:

  https://lore.kernel.org/netdev/20240409073016.367771-1-ericwouds@gmail.co=
m/

It was merged in
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc31bd5b6ff6f70f016e66c0617e0b91fd7aafca4

I don't think this can be easily applied to older kernels, the series
has some dependencies.

Marek

On Mon, 27 May 2024 10:11:17 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Marek Beh=C3=BAn <kabel@kernel.org>
>=20
> [ Upstream commit 1c77c721916ae108c2c5865986735bfe92000908 ]
>=20
> Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
> containing 2.5g capable RTL8221B PHY.
>=20
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>=20
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/phy/sfp.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index f75c9eb3958ef..6e7639fc64ddc 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -506,6 +506,7 @@ static const struct sfp_quirk sfp_quirks[] =3D {
>  	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
>  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
> +	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
>  	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
>  	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
>  };


