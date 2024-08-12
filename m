Return-Path: <stable+bounces-67387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5C894F8A0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 22:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0A8B2214C
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2E19B3E2;
	Mon, 12 Aug 2024 20:54:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB719884C;
	Mon, 12 Aug 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496045; cv=none; b=J6tze2aHtoZ7L6BHv6dvtYnJ+9TSEs3ZytXl41RX4+cF1KntYnkjMCMwn7szFeAzmwJ9/DtWEyohCVDzGS6OnuSWqK8x3G2d9XkpFPEWJR45Ga+ue4dnPlDNuw3sJSt7c12GCA1kXMBmt0hy8P6UPQaA1KrysRaXTDhaY8NTCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496045; c=relaxed/simple;
	bh=tVJnW/HDo4hPUZ72MK9zQCOYRnYRrZDhd76yH2rKY6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihC/n3kN7t6dHY7LQU4iC91wpZMcXNDmJKGiSrMQAIrqalS33vZT74OHSJB70Ql0FprrDZiSNoxIcJlBhdt+T8hmnP8WnJERMcTbx/FtL0NsSZEaBpERM1MDVMO+6eZBIXBM7WD0DDG+rIrWNhqKgL0CM+KeBNsZK79aiTwTxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 584A11C0099; Mon, 12 Aug 2024 22:53:56 +0200 (CEST)
Date: Mon, 12 Aug 2024 22:53:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/150] 6.1.105-rc1 review
Message-ID: <Zrp2Y89TvO5mcOIW@duo.ucw.cz>
References: <20240812160125.139701076@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+cldvk8K27Z+gG7m"
Content-Disposition: inline
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>


--+cldvk8K27Z+gG7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.105 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+cldvk8K27Z+gG7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrp2YwAKCRAw5/Bqldv6
8iljAJ9J7Ltt8yWAtnSuba266TUgIuL0lQCeNPXceVONV2c15lUZpl3aAun5es8=
=jo7I
-----END PGP SIGNATURE-----

--+cldvk8K27Z+gG7m--

