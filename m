Return-Path: <stable+bounces-160215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A264AF9793
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384BE1CA43F3
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD72309DA3;
	Fri,  4 Jul 2025 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="H/Urj6gs"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B83074B4
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645317; cv=none; b=W1hbjiVKkf+jtpBQL1oFr5eK72QA7D0V9uDg7Qf+sOQJo8f2VRrsHJuW/cBjkjt/4mh4tMHpTFpgjiDJWC8GvBJaH2pbXsLbqlDSm6UDcU0x84meqVtHvnYdDsJQcWeykKJO1cVTq6I1i2jfwnwGuR2Srqy5hHbhNuI727UTWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645317; c=relaxed/simple;
	bh=IQSgTvu22z4jTaDwUlpFakllNJA2GFU2ZRgOrcqMBtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5H+fUI4xTuctNb0VvYax6ePCev/okC2pGp18REEUgi6cG2kER9DjxAAk4/y9Rjhx3o0mIIgjSQfix6JwCQrNX6hI4HQ12V7zZk/98hyPFvpkHBL1WVUuBABLHEq7fUjciExehoJQ72vj0v0HUnzMuC/FCLIQupi/T8/91mU5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=H/Urj6gs; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DF2E61C00AB; Fri,  4 Jul 2025 18:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1751645311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s9iZagXbgeik5aaC+851EKPeAc4Tqrh9L/My33iJMYY=;
	b=H/Urj6gsjU5qY8q0XrsdPU31uI6Q2hUx6ukRIUyEBSgHLNpdeB9ysDNH7KXpOj94YL/KwM
	zzBVMP6MaRZ6bZPqnFjpOwO2thfHF3/AAj+YGw7WQsPZih5xWBju/WREsyVdRikyuVEby3
	hPGarU7bZQvaW6gzfe9FZyjuLPt6Plw=
Date: Fri, 4 Jul 2025 18:08:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Tobias Deiminger <tobias.deiminger@linutronix.de>,
	Sven Schuchmann <schuchmann@schleissheimer.de>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 007/132] leds: multicolor: Fix intensity setting
 while SW blinking
Message-ID: <aGf8fwdvCgr4jVjr@duo.ucw.cz>
References: <20250703143939.370927276@linuxfoundation.org>
 <20250703143939.681590816@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6/9YvccF99rIB7pV"
Content-Disposition: inline
In-Reply-To: <20250703143939.681590816@linuxfoundation.org>


--6/9YvccF99rIB7pV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-07-03 16:41:36, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.

Let's not do that. Blinking at wrong intensity is not nearly
significant enough bug to risk regressions.

And please stop using bots for patch selection.
							Pavel

> ------------------
>=20
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>=20
> [ Upstream commit e35ca991a777ef513040cbb36bc8245a031a2633 ]
>=20
> When writing to the multi_intensity file, don't unconditionally call
> led_set_brightness. By only doing this if blinking is inactive we
> prevent blinking from stopping if the blinking is in its off phase while
> the file is written.
>=20
> Instead, if blinking is active, the changed intensity values are applied
> upon the next blink. This is consistent with changing the brightness on
> monochrome LEDs with active blinking.
>=20
> Suggested-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Tobias Deiminger <tobias.deiminger@linutronix.de>
> Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> Link: https://lore.kernel.org/r/20250404184043.227116-1-sven@svenschwerme=
r.de
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/leds/led-class-multicolor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class=
-multicolor.c
> index ec62a48116135..e0785935f4ba6 100644
> --- a/drivers/leds/led-class-multicolor.c
> +++ b/drivers/leds/led-class-multicolor.c
> @@ -61,7 +61,8 @@ static ssize_t multi_intensity_store(struct device *dev,
>  	for (i =3D 0; i < mcled_cdev->num_colors; i++)
>  		mcled_cdev->subled_info[i].intensity =3D intensity_value[i];
> =20
> -	led_set_brightness(led_cdev, led_cdev->brightness);
> +	if (!test_bit(LED_BLINK_SW, &led_cdev->work_flags))
> +		led_set_brightness(led_cdev, led_cdev->brightness);
>  	ret =3D size;
>  err_out:
>  	mutex_unlock(&led_cdev->led_access);

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--6/9YvccF99rIB7pV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGf8fwAKCRAw5/Bqldv6
8hX2AJ9MFM0JXfD3C+Tna4T1SuREtpYTYgCfUtT2BtwLhVE6Q59HSDMRwkb3DIs=
=nzeT
-----END PGP SIGNATURE-----

--6/9YvccF99rIB7pV--

