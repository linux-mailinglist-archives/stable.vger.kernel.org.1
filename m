Return-Path: <stable+bounces-52054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A8907438
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDF31F23318
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706CBE4E;
	Thu, 13 Jun 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nMQjHec/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED402AEE9
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286482; cv=none; b=Z3roXAgdtYcHTJMofFvFto3l0Sif91OzmJO4b2I4Qpaii1u7FAAiJqm5w79KXS1Lcvzpvf1kkpRvkn7002FSqHMqoVud4tLrFHE5iLDfwwsUmyNDxoCALq1WYycsZo/AMC4TpGRncyX30jqY7ar6ZgBOtfwYkYWv9DZhVNfs/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286482; c=relaxed/simple;
	bh=b/QKYuj0aGjqaFLVkAV7iwiu/KlRM8jpvIQIfLg3oMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n80IVmnKWYCWrLN7hFFTBuoBIOYMW98Cvs2l767LfoCXiLDdQRr6AIDrAI+tgQM8U9cDkZO4M+dCUIEq3e9i8hqZSeHAfYW1VjDFd+9sHwwPYoUMtctopr8uACjylpr0HfmNYVrzBSXDoKvpGO0/PSdcDLC+NsP74m1Qj1Lee0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nMQjHec/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso144717966b.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718286478; x=1718891278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/EpMHmp6/gi8XMOpoGMqTGSu1rQ5PudN+98VU5FEa4=;
        b=nMQjHec/8Wag02ir/YEKcjwak9b9qB6yn+ZjAYQ2LWd2txdtwVHmh2ZEanRcSd9e3D
         BCBZn5/tiHwqIsQlKPlJiGMm3+TldyBkSLengShYmiSA/v6kM7jEV6P5NQqrlLysuUnM
         Bn1w6/vl1xpRN9BWM4q5IdewAMhxmMcpJlObOkkNq+qpBkUO59reuH0xRYM20g3qPyIY
         fIJCs4yQSQVRLxSE9dpQHNoD2bHebOfOl7zyDmgJjF1lYsRJPleG43t67P4uhRIptxXa
         dM96TRdAMmo9RSqDvrG3LzP70b9V08GFfTYfpZNDrDAKgcwojYTdc8VcT9sIqQ3KEYqD
         TDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286478; x=1718891278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/EpMHmp6/gi8XMOpoGMqTGSu1rQ5PudN+98VU5FEa4=;
        b=vJUCis5KjfYWRhCtQ6aBD/RPr5tFyssntiblBe8xR741i01OeurMR5NH7Rx2K17urR
         nN8B7dQIjQN3xr6fG9/yyaXkYQ6hdoBxnDpVk+Hpa4sLQiQi9Awt80TquwK+ez8LmmNF
         NiZexXQ1ZAMpAnZo05bgisH8OGPH10hsdtWZSpeIipddSmjynXUmZbmilEPax29YzKR6
         eP0d/xV9dr+Yhl63iWQRhioyXdL/vZk7zEV0F/2EiKO5+ydKDdoj6Adj+GbnCvlJs4yT
         YYBoOg7ukoFNX3GeNjnenZw/hIULzVNmikwXrtATpopwtiTSuIiuQaNyg618R9fPNTLR
         81Og==
X-Gm-Message-State: AOJu0Yx7c+hNk/3vCG3SrGtzMOd7m932WFMWL2agKGqeYaPnyZXnfGff
	FihgWLy4gck8IRmKWbboOQDJaTkrdkr4QyO2XUxBJOi+c7J8eIOGKFr1xNWaz5g=
X-Google-Smtp-Source: AGHT+IHNH/JHMVoja0mh1F3VI8u2EQ9fz8cIMoTyPK/ffv8FczpHzTih9boDIqrWDNv4DeOfIcggLg==
X-Received: by 2002:a17:906:fe0b:b0:a6f:1e97:b177 with SMTP id a640c23a62f3a-a6f48025b0amr445303966b.64.1718286477634;
        Thu, 13 Jun 2024 06:47:57 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f600cde92sm3763966b.205.2024.06.13.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:47:57 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:47:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH 6.1.y] mmc: davinci: Don't strip remove function when
 driver is builtin
Message-ID: <zawd5ojgnej45qvzjwntvhyiqmuzhzcm4lxu7npwv4apdcbas3@kwxsenvhisjq>
References: <2024061227-zit-rupture-640c@gregkh>
 <20240613055540.2284309-2-u.kleine-koenig@baylibre.com>
 <2024061322-sliceable-pucker-418c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ruswkyno3fxawiki"
Content-Disposition: inline
In-Reply-To: <2024061322-sliceable-pucker-418c@gregkh>


--ruswkyno3fxawiki
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Thu, Jun 13, 2024 at 10:32:35AM +0200, Greg KH wrote:
> On Thu, Jun 13, 2024 at 07:55:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Using __exit for the remove function results in the remove callback bei=
ng
> > discarded with CONFIG_MMC_DAVINCI=3Dy. When such a device gets unbound =
(e.g.
> > using sysfs or hotplug), the driver is just removed without the cleanup
> > being performed. This results in resource leaks. Fix it by compiling in=
 the
> > remove callback unconditionally.
> >=20
> > This also fixes a W=3D1 modpost warning:
> >=20
> > WARNING: modpost: drivers/mmc/host/davinci_mmc: section mismatch in
> > reference: davinci_mmcsd_driver+0x10 (section: .data) ->
> > davinci_mmcsd_remove (section: .exit.text)
> >=20
> > Fixes: b4cff4549b7a ("DaVinci: MMC: MMC/SD controller driver for DaVinc=
i family")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/20240324114017.231936-2-u.kleine-koenig=
@pengutronix.de
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > [ukleinek: Backport to v6.1.x]
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/mmc/host/davinci_mmc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> What is the git id of this commit in Linus's tree?

It's 55c421b364482b61c4c45313a535e61ed5ae4ea3.

Hmm, I was about to blame your instruction about not making me mention
that, but I think that would be wrong, as it included git cherry-pick
-x. Either the -x didn't make it into my cut-n-paste buffer or I dropped
that reference by mistake. Sorry, I will try to remember to include it
for future submissions.

Best regards
Uwe

--ruswkyno3fxawiki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZq+HwACgkQj4D7WH0S
/k64awf/Xjl9y1tbQfeeBulvRpDoAf++LjJodti8R3jbaQxOI71Ues2QZ074Gs8d
S+AE+vEWlW+DA6dco07gWmEFLdKeXDDcEugnZFtMuPKdOpfTXR8LQaS/otAt+sA1
nsqYv2Syri1IYxu5ZP3YtbBBz6gUDM5ZnBTCxpSxtbq9+3+30OHNSO18d9tFL8cr
xxufGvRIVdddqUNBTifMXyH+aRbQwxPKnkdLojJtFbaJO7P9isz3+G5T4F5rxiAq
M2qLzc0W5IV5ihZjSAeAaPT+mO+ZAg28J2yhed9VdkgbZ8grsuUGIyjsw5zztBzD
uQFGmYrdk5tFnb/t++V9f2P3d5oNeQ==
=J33e
-----END PGP SIGNATURE-----

--ruswkyno3fxawiki--

