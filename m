Return-Path: <stable+bounces-189914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383DC0BFBB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0DA84F1145
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D724C077;
	Mon, 27 Oct 2025 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8PXUAbH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78214A00
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547353; cv=none; b=gqMSU2nHp//JMpk6NGAWvCGKv7rqsqrlz7DHIWuNQI8tnJ4xcXykwuB3ibG+DHpOYGoUAeOMYKKeW7XoDupSl8HjbIf0HZJfeHe0vv1rXi8bbFv2lLb8NXV6Kg8gbvu//66AQas4BTe1d7Mw4vWHoECUFeIhMiG1Laeribi8gG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547353; c=relaxed/simple;
	bh=f7jIqAJgHPUb6VNIzygKBH98nH0FYRtOXPNOFoxLrLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+cNE1rmaD3hWFj870f+9/MIQ4i941tTXJrzqH8uI3m3VnlE6qfKyw7Tgk6ZLeKQQjOkYjxyR3XUZ8WhgUo5Jozi3eyYDrmJk+ZplFy7+Zm8k29Kyv/XHo+DREtvbeUPC6f1ML/a8m1smqwONbQDcLTCJVgIPvVxuza3klECe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8PXUAbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE7DC4CEF1;
	Mon, 27 Oct 2025 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761547352;
	bh=f7jIqAJgHPUb6VNIzygKBH98nH0FYRtOXPNOFoxLrLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8PXUAbHoDQXHnOZ8PiEzM+EJ4AySC68qH3taJUrSxQmBHFUOyyK/nCrB1yxTuopy
	 INKMltIKbrqp3hDq4BVPurZBB7M58WR2sKlwDRcrNzZXO8xSUME4Sin829YXRDPWui
	 qHeB7OtaOeHQRmcFBg73uI6ibfo4tDg425S4aaLrVYzQz9NgVNlVHDpl9L7Jby22Hm
	 k2SutaGqIOINWJk7um0Mr287eV0RaEZIhmIQoNXo8xVpaE8m/wbOLPFymfyW91fZez
	 Z9u5keTVlIUOICCMDC2vimzhJ8Xv2H65UpSOYT1cInuR3PB6fvqbN3hGEYZXXMaXJr
	 wuBYgNnoOWV2Q==
Date: Mon, 27 Oct 2025 15:42:28 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.6.y] gpio: idio-16: Define fixed direction of the GPIO
 lines
Message-ID: <aP8UVGvmODyqdW3N@emerald>
References: <2025102619-plaster-sitting-ed2e@gregkh>
 <N8Hj-zRacZQc6SSWrj2lLT1upcInj9PrAH81Xc2M4mozVsSUj92ofp9fJOsPqS22yl_CdmdkM1Phj5z86hNpdg==@protonmail.internalid>
 <20251026152950.44505-1-wbg@kernel.org>
 <aP5BSHnMw3Bn10vD@emerald>
 <jXPR4dQsh04ClP5pk3uNYps-wEvi2FsoUw6IcezWxRSh2JbzBUACiJ6pXehpnByYST2ZuNiG6K4m4eQhGm6GEg==@protonmail.internalid>
 <2025102747-harmonics-dollop-f225@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cJCQFktvzoIoynOe"
Content-Disposition: inline
In-Reply-To: <2025102747-harmonics-dollop-f225@gregkh>


--cJCQFktvzoIoynOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 07:32:03AM +0100, Greg KH wrote:
> On Mon, Oct 27, 2025 at 12:42:00AM +0900, William Breathitt Gray wrote:
> > On Mon, Oct 27, 2025 at 12:29:43AM +0900, William Breathitt Gray wrote:
> > > The direction of the IDIO-16 GPIO lines is fixed with the first 16 li=
nes
> > > as output and the remaining 16 lines as input. Set the gpio_config
> > > fixed_direction_output member to represent the fixed direction of the
> > > GPIO lines.
> > >
> > > Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> > > Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6b=
f@nutanix.com
> > > Suggested-by: Michael Walle <mwalle@kernel.org>
> > > Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fix=
ed_direction_output configuration parameter
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Link: https://lore.kernel.org/r/20251020-fix-gpio-idio-16-regmap-v2-3=
-ebeb50e93c33@kernel.org
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > (cherry picked from commit 2ba5772e530f73eb847fb96ce6c4017894869552)
> > > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> >
> > Sorry, I didn't mean to send this. I don't think this will compile
> > without backporting the dependencies.
>=20
> No it will not, and the sha1 given for the dependency is not correct :(

You're right, the sha1 doesn't match upstream. The correct upstream
commit is 00aaae60faf554c27c95e93d47f200a93ff266ef.

William Breathitt Gray

--cJCQFktvzoIoynOe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaP8UVAAKCRC1SFbKvhIj
K7IEAP0Wivk4Vewakz3+W+4vgIwT/id7cGn7SaIYaDI6t3ijmQEA+zuQ3+6JYbV2
ch3SuqC9TQ2wmj6K98CG0M5yJO8gWAY=
=AGxR
-----END PGP SIGNATURE-----

--cJCQFktvzoIoynOe--

