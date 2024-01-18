Return-Path: <stable+bounces-12202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E5831E4D
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049681F21D4D
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34C2C845;
	Thu, 18 Jan 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIZqEuFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF52C841;
	Thu, 18 Jan 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598514; cv=none; b=ZcqwboHyU9VcoQ3FMBpEo7Y7HWE9MJKrmIiAgdZJMKdg6rVHLub8Ie5KY05dzvrnardmJri7iATX6CH9NqIj2aFXpOQg+bObqmzuXnclEEPPcp30zpD3QwpoGMi1QC4HuIseUFJlcrAaoz/BQR81jB0kZRmRy7oOVWx/iU5qnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598514; c=relaxed/simple;
	bh=GrPaueWFVuj2nIlhecpLM8yjOxes4LcyBFVyKWotBuU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=LUcmz7vH4lFPP5q71PE8cy2AwTaDJD55QWfRYkm3A/eZf6eA0hQm6ALPFnMVUAC4elaOcjgDqCR4CTdV+n+3IqDu3OEwlWWt5eCdA7FwGtKTZyxeyuGAKt8yOTEXcQPFtS3tO/6dyqNJpS6MI1pqD1vGyypuZqQe2uk7BoC/ZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIZqEuFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D6BC433F1;
	Thu, 18 Jan 2024 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598513;
	bh=GrPaueWFVuj2nIlhecpLM8yjOxes4LcyBFVyKWotBuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIZqEuFMwThZFV05+1B5orwhq1cMrqpeVflPrts+sYmnqaeg/k9K95cOK5eBQa+L2
	 20ZTDyndZtl4XwGiJq1b0cuOsg/iyIM/wVd8aMi6v8hdU0HA6YQUZ8reepERXH7HbS
	 X6sPtErW1wEWKlZPmr5LVOdvEwuZ03DngA03VRf5XRnfGomBdUSrOeBTkpP/W08/XJ
	 8CwxrvjmCk7w146GTFJgmyCkl2oMa99gVFxn36cO4Vj14hi4wq30cFc8Q8/IPILKQ/
	 fzbKhx0tPhcWBPabKjRk8CzNI1W9rkL0XgRf3kec4GyOVXnJd65j1XmQpZhEd1dgV+
	 CsPiKqj2y/Z0g==
Date: Thu, 18 Jan 2024 17:21:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Message-ID: <dc33e198-e202-4287-960b-7826fb0b455c@sirena.org.uk>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+L9BHQTIa1dUbroA"
Content-Disposition: inline
In-Reply-To: <20240118165811.13672-3-johan+linaro@kernel.org>
X-Cookie: FEELINGS are cascading over me!!!


--+L9BHQTIa1dUbroA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:58:08PM +0100, Johan Hovold wrote:
> The default PA gain is set to a pretty high level of 15 dB. Initialise
> the register to the minimum -3 dB level instead.
>=20
> This is specifically needed to allow machine drivers to use the lowest
> level as a volume limit.

> @@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] =3D {
>  	{ WSA883X_WAVG_PER_6_7, 0x88 },
>  	{ WSA883X_WAVG_STA, 0x00 },
>  	{ WSA883X_DRE_CTL_0, 0x70 },
> -	{ WSA883X_DRE_CTL_1, 0x08 },
> +	{ WSA883X_DRE_CTL_1, 0x1e },

This is broken, the register defaults provided to regmap need to
correspond to whatever the hardware default is since for example a
register cache sync will not write back any default values (as they
should already be there in the hardware).  Anything like this would need
to be done by writes during init.

--+L9BHQTIa1dUbroA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpXisACgkQJNaLcl1U
h9B1XQf+MDXMPds6Vj+stJmRI6lY95AnzLcfAg38B7M3jFWq3X5LCz+QUUWei/P7
YygtokKnVOMb6pLwvHNI6s51GZQ5hqbmdFFi9mRmamIDeuYKHaOFmo4VB4WrdWoO
AklL4KvrD+3Ju6e0J4mmPjpNFUbxk6WWIKjJ4T/QOCP3PLk4TIw3sT77QMybapbA
/AgS986AbHbyBeqMmJd32I1uSBdHJW61IzKFikT1w17UNLXJMFBHtfmahwuM0aVu
4XMz+1qCqEoN8Oale+5AwJZ4ZtY/tGasp0cTClrIjnCdDO7nsjkEdVY9ZLEnOWg3
BH0YNeBArVibIrpeedgdNqcchmbTew==
=7PAi
-----END PGP SIGNATURE-----

--+L9BHQTIa1dUbroA--

