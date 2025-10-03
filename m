Return-Path: <stable+bounces-183161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839CBB602B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24451AE0025
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA98D221282;
	Fri,  3 Oct 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AWSi5fg3"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF91F461D;
	Fri,  3 Oct 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474657; cv=none; b=E7YWGx4xcJSvCaqrxHZOhoB0FUvnM6t9NFO21Nk5BSzf/xqn+lWkWa8WpnukLhAG3/Zt+LZ8nEflZJ5x3swUf8+KsyIXuvanpPWr/AabSimJsz0RwO79PY6SR0FgreX+zbKomamLsFtEuWSgoL8aU+nanOYKp0Abxd+3MXA5mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474657; c=relaxed/simple;
	bh=cQSkDmTbr/IhPSJ+6daEGDKBP3e1wuKRsI+80Y2cjgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuRIZSnQ8qO+ezj15KxDR24CjRNdjUgt67jz0wNPLuGL15KXIoVwsRh9nKMXphwgydjzM5LpLV256sjlGPI/6jhZUWAq91wgqUhjLtVuoGRezndZXPGXDb62lNxcHYX4heLLWSZsqn7j+KSKS+kZhwmgOTELIUZuP0bk046cycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AWSi5fg3; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 435E2101DBBEA;
	Fri,  3 Oct 2025 08:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1759474652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0onxIwW979cy4qz8Z/eSi8rte0/YzrYOiTl1qXPwcX0=;
	b=AWSi5fg3LfIv58IUa73aZ8vm8loeV/EDVuPaAaV4kvmcVyibkKPIhjIgaZ5g4cLnpovqHJ
	ypDxZVG4+TkuHdSvQHhlAEB769jeZ9LKYVQ5twzVC5c2YE+8hJ0BCxXsE3UIgu3cb4g/mN
	4S4xGxdtabPLe2dGcGhVqzQ0tyS4i502oDiOzJjEcfprn8yyXSTigd6EbyaVRlsklDvc+y
	ktggJrAHP1J0KklVrDN0bZyYUUa6pB8WkK9qssfJi0/bh98kOsO1YEC3OZa/CZaHYuUJqP
	YIrUc6perBlLlWZvpsUv3y0Yo1kBCkdm/Nx7GHlMasQTiPWzpuw1CNS1gp32AQ==
Date: Fri, 3 Oct 2025 08:57:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
Message-ID: <aN9z2dxtzj58HLYF@duo.ucw.cz>
References: <20250930143820.537407601@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V96TjXExK4Tqjc12"
Content-Disposition: inline
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--V96TjXExK4Tqjc12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--V96TjXExK4Tqjc12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaN9z2QAKCRAw5/Bqldv6
8tdOAJ49XffwP/HoAw0bAOeuDnfpNDVZMgCgknPoy3az+Z4qxN+1qsrVM6ob3lw=
=0u4i
-----END PGP SIGNATURE-----

--V96TjXExK4Tqjc12--

