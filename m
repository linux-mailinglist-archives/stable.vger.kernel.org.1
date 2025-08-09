Return-Path: <stable+bounces-166906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B559AB1F3D4
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 11:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6A304E0593
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA6C1EB1AA;
	Sat,  9 Aug 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju4mBHJj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AEE2475C3;
	Sat,  9 Aug 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732727; cv=none; b=d8UaExrhYvOQGmF8IMRSd7n4EtBqMn6Q5G21P/m0oWEd1OR+R/KSqcN7foSVY0exBNq7vhWEzDfvplt4HGMD7JMH/Nbi0DrgqHVlyIW80njbjxp4iM+vwrkdwNxxMdvopDEtulKlrbjdaIPiqYjGCr+4Hb5MGyfexnKnkin0lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732727; c=relaxed/simple;
	bh=/Vl83yoKnuPARw45R+Y9vfw3LJkmk1HmLQW4Ee12BGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfEU/l9iaThgpvr9LI1Xy/yWdxYon1BGfAOwerdeZESeS+2p0qvThoML7nZRHcolZV3VFUu3HxYtHFLfP2o9O2uUNi/YqRuRo8NozQJ1uZbX9J7zvY895pYkh/+EsGcKS6IYsMcX4+3PeCG6SK9VJQQedkhS9I22Q+EkBkM1R+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju4mBHJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32CAC4CEE7;
	Sat,  9 Aug 2025 09:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754732727;
	bh=/Vl83yoKnuPARw45R+Y9vfw3LJkmk1HmLQW4Ee12BGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju4mBHJjyH6oXbzKRHbKSoBxFSXHyUrYEy+0d9Lp/FyStBfsuyMdwjWsXmatwRoO4
	 rjHNWtBnGH5ur2UimAt+2sir35xAI8FEh125T50waESZ+GB8HqaVWtgy622YhZRyPi
	 2We74GkRqYyprGriC3+ymrjEQ18ikGRQ7ztcDGMEzElPc3zPgd0o2hzMsUgEHfqAcq
	 UdBYi1X0ifv5jl2Nvl4MeC5WkznD6HU2QStBUtvOeGtIAO06BYNR+XvSxjR/Zn0EnD
	 csHqt0LGpkboqR8sIJiBqAIerJ/teJ1n9SkrJ1JvJiT8UhqCDIZwwgvCKSSEGrk2GY
	 4wKsOv21MCj0w==
Date: Sat, 9 Aug 2025 11:45:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, nicolas.frattaroli@collabora.com, 
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
Message-ID: <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>
References: <20250808223033.1417018-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uglxw76tpyknamt3"
Content-Disposition: inline
In-Reply-To: <20250808223033.1417018-1-sashal@kernel.org>


--uglxw76tpyknamt3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
MIME-Version: 1.0

Hello Sasha,

On Fri, Aug 08, 2025 at 06:30:33PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     pwm: rockchip: Round period/duty down on apply, up on get
>=20
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      pwm-rockchip-round-period-duty-down-on-apply-up-on-g.patch
> and it can be found in the queue-6.16 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit 51144efa3159cd95ab37e786c982822a060d7d1a
> Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Date:   Mon Jun 16 17:14:17 2025 +0200
>=20
>     pwm: rockchip: Round period/duty down on apply, up on get
>    =20
>     [ Upstream commit 0b4d1abe5ca568c5b7f667345ec2b5ad0fb2e54b ]
>    =20
>     With CONFIG_PWM_DEBUG=3Dy, the rockchip PWM driver produces warnings =
like
>     this:
>    =20
>       rockchip-pwm fd8b0010.pwm: .apply is supposed to round down
>       duty_cycle (requested: 23529/50000, applied: 23542/50000)
>    =20
>     This is because the driver chooses ROUND_CLOSEST for purported
>     idempotency reasons. However, it's possible to keep idempotency while
>     always rounding down in .apply().
>    =20
>     Do this by making .get_state() always round up, and making .apply()
>     always round down. This is done with u64 maths, and setting both peri=
od
>     and duty to U32_MAX (the biggest the hardware can support) if they wo=
uld
>     exceed their 32 bits confines.
>    =20
>     Fixes: 12f9ce4a5198 ("pwm: rockchip: Fix period and duty cycle approx=
imation")
>     Fixes: 1ebb74cf3537 ("pwm: rockchip: Add support for hardware readout=
")
>     Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>     Link: https://lore.kernel.org/r/20250616-rockchip-pwm-rounding-fix-v2=
-1-a9c65acad7b6@collabora.com
>     Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

while the new code makes the driver match the PWM rules now, I'd be
conservative and not backport that patch because while I consider it a
(very minor) fix that's a change in behaviour and maybe people depend on
that old behaviour. So let's not break our user's workflows and reserve
that for a major release. Please drop this patch from your queue.

Best regards
Uwe

--uglxw76tpyknamt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiXGK8ACgkQj4D7WH0S
/k4naggAuTzi3BeVxpnkloLgqqqi9PN6USc4hfP1vsI6QfVCNhMWEWKcIzCJ4qcs
VEMAIxEcqom+2WAqB3C6ff+XQGkP36OwLllt58itJ2owfN9ViTKtLTLd0f6yDryM
F6BpOTYMPh1KMBMigVkzqK2+a7wjSbhXYCDzJDODr7IyfY7puV2LxwF2ES7MImXP
xHXQAuNOUfQGkffECvPtHCrlt3RgmIdvn4SFesMHPRD+EPNmFSipt9Jy4ruUAIrV
vg+9oykiCywLGPctGZGFYuOz0Bpr79EQtMjUnyZxWWR7ZNnsd/paP4JaosBvdqN6
rT3uvJ5V7LZgDscTHZDBvdRuVNz7ag==
=L/P2
-----END PGP SIGNATURE-----

--uglxw76tpyknamt3--

