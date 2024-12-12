Return-Path: <stable+bounces-103933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650BB9EFC8A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 20:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D3928AB86
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F94183CD9;
	Thu, 12 Dec 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TCh4l4Qc"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AD722611;
	Thu, 12 Dec 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032055; cv=none; b=RgMoY8dmzUoFvfhIUF5XfC/6sqZXtsWcLATOrmhlYmDPufzPTdBPU0ibUZ8wMX3VV2BkjlShf4KaQ5/YON6HS09mle/2ccz6fkfId3ATNJuIcpbhYe2owVlextXi8ZVkIugcOfaST7pQraS1/b8GsEMSJSxemhe+HqWF8XCxHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032055; c=relaxed/simple;
	bh=hR2aHX6iduIH4HEz94GvOPpN8FCi1xvTaAhMX30cTXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhNOgT0MoNLRk7qncl4mq2zAtFMg8u7IJrYZSQo+dDbpOcUCh5jnq2ampd/JLzb8eOmmzXTqKeyfLtRccXaVKNvAyEOmMZKbYlm3AmBmoUpPhJkzUHX6vkNudQZl7WpE6G4twPYfHyz5jMNjlFMe+KNBROtQC4rFJzObuS4XSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TCh4l4Qc; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6ADB510485596;
	Thu, 12 Dec 2024 20:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734032044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpTFBO1ExhIv3n22Yk/fm+v3aff/PUI/VG7AXOrSz6U=;
	b=TCh4l4QcqRVziRuOy34IAXZonv66oz6MByYkOMq0/nfRzqEMNm10ZlMlJxdYBRCTyF73jB
	cD7kIEjOTYov9k3u1lu+Fhc3iDxoExEeWyEwpWQd5gTaBmrMv1PzMBTQm1SOQI0eayi9kK
	wsrlbWyd/ym66YZOqYTKBgpctJ/9H/X3Eb2cLsCBfW47WCgoaYIG5PHlRAXA81Z8gNUmQC
	JQc6HwDO6KXk5NMQKED1xZJqY24r/LdrLW8SUj9/wVhOMH5hTJrs9ZSMzMtTem157njPda
	E8ps7/Y0ndb0h82a40Tpsd18Zx1Y6vz9yn1ED8vqAqi/mRM+qvXa9qvaLWQFjw==
Date: Thu, 12 Dec 2024 20:33:59 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 000/321] 5.4.287-rc1 review
Message-ID: <Z1s6p2QR+PwcnNYV@duo.ucw.cz>
References: <20241212144229.291682835@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OytnDsTlQTgfYOum"
Content-Disposition: inline
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--OytnDsTlQTgfYOum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.4.287 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We are getting build failures here on arm_v7:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
586057341
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/862548=
6171

drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:173:2: error: 'DRM_GEM_CMA_DRIVER=
_OPS' undeclared here (not in a function); did you mean 'DRM_GEM_CMA_VMAP_D=
RIVER_OPS'?
6367
  173 |  DRM_GEM_CMA_DRIVER_OPS,
6368
      |  ^~~~~~~~~~~~~~~~~~~~~~
6369
      |  DRM_GEM_CMA_VMAP_DRIVER_OPS
6370
make[4]: *** [scripts/Makefile.build:262: drivers/gpu/drm/fsl-dcu/fsl_dcu_d=
rm_drv.o] Error 1
6371
make[3]: *** [scripts/Makefile.build:497: drivers/gpu/drm/fsl-dcu] Error 2
6372
make[3]: *** Waiting for unfinished jobs....
6373

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OytnDsTlQTgfYOum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1s6pwAKCRAw5/Bqldv6
8uDVAKCQMr06BQihfqDvQF5/RGSNoCMGhQCeL/PJOcUcb9x7ASANZoW2cUeJM24=
=yl5D
-----END PGP SIGNATURE-----

--OytnDsTlQTgfYOum--

