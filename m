Return-Path: <stable+bounces-154746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE58ADFF2C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F731884211
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 07:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66D2376FC;
	Thu, 19 Jun 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iML+QxZQ"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CF231837;
	Thu, 19 Jun 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319628; cv=none; b=qtIMs7jLKrwIC4fB14zZHuhoGlkXOPuafSxqi2fUo+2Ail8MSM5pPiEaXwE2YeTMH1JsecX1ttRhoPlqAttU/YLrQFbEDKR4c3BDiX86WyISXe5Vm6oA4Xw4odZTtv/fbuPbhdwivksZiNToTq2hkDxkSGPyncZCZ05S95XHs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319628; c=relaxed/simple;
	bh=o4exH4E8+qqhEgqJNfi41hAjOFkspOgxrwQT8MJJ7ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSmWVH3f7kykVKmhNiqCny0sB4rAq7/y1a7tRgiTIKoDb5kXX92fgJjaokDrJofVoyfwbq8wkhpJfqDhHS/nRC+XuvOhj3CrJlMnBFM42ESpGNjaN/s2GItPR1eHI+xeGz3fYEpBBVg1qjnlaXsL4ZN+dvHh7y9y65qR/+dByyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iML+QxZQ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06D2210244BE6;
	Thu, 19 Jun 2025 09:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750319623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=z2cL7tSpa9FWCMqEbSAlMhSH8wnWreVFxWb6XHnKWUI=;
	b=iML+QxZQEHrDuPW9TgVLWJL8YxDgR31LulD2riSFCe+y2M6BGtdgb/LtfjBauQ2AySyzLJ
	rYr5I6MBwtAX8IDxzB2cSazMb00LaQaOvPhGcvdf8sbXeOA6fFyBi3n1y4bMjg5VtXgeSM
	4jVD7C+kybNB2WB8emo+xeuSQibRUtv7+3UULHoUGleIx/CbhPjYbzn9iDTFk0AQphmxN7
	n+uNAsaySc6rYOl8tdMsj9HJ8hpGaxpZUiCQfP21yCeiehQal4oh3fxxK0/TS7Pt2dYGGL
	wx0ySIrzRwkAwlliYFcivOOK9VZQYN16RlDwuG7V1dSRU52lw+XzYeoVuviggg==
Date: Thu, 19 Jun 2025 09:53:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/356] 6.6.94-rc1 review
Message-ID: <aFPB/MIgbcZGzw6R@duo.ucw.cz>
References: <20250617152338.212798615@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jk/3YVTjEdKtuW4i"
Content-Disposition: inline
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Jk/3YVTjEdKtuW4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.94 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Jk/3YVTjEdKtuW4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFPB/AAKCRAw5/Bqldv6
8nnNAJ4hooTeyCok6rsXhIgwBxYX6UiLfwCfWTGGMuN+JxC8hRjyyKExI1C40rs=
=SDrq
-----END PGP SIGNATURE-----

--Jk/3YVTjEdKtuW4i--

