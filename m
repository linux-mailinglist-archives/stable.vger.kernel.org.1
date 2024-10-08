Return-Path: <stable+bounces-83014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F73F99500B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F0AB25CE3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B191DF973;
	Tue,  8 Oct 2024 13:29:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAF1DF75E;
	Tue,  8 Oct 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394191; cv=none; b=fmPHInIdeMqZ38FAJ+SqDRBXl9h5Hpsf0FeYKKPYbtjY2Ggz1zuF1Z1mlpueFUkJe2j4viPaJrM47im2mNxFiasira8vPdyGR1tR3m6t0sjkpEgoFOWXWlQf9QsdDidtRptVhMbk4yYZ1LC04lO7XesH+EARGg38n1sBA2hWMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394191; c=relaxed/simple;
	bh=L8DzXMlm3jzBQIh4QzhAtXX979ucl9/0Ss8d1xS27iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtO19aDtx4a944hTCijIi55G79Mt7pE6qrd7342Ao5UCIHyJSsu83TIDE+282G1AcyoCVrMnQNapJ1/j7bjbCPLsGsybUqmX/hAMe9pCXuURSjsgRze/IDPOzJ07vSIRg6iDP74ow64j2ZjAesS+5z9YDwRnSXP8vEN2Tu3zQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0DC971C006B; Tue,  8 Oct 2024 15:29:47 +0200 (CEST)
Date: Tue, 8 Oct 2024 15:29:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
Message-ID: <ZwUzyi7A/UG4pr3P@duo.ucw.cz>
References: <20241008115702.214071228@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tEeg0s4Zab9rwdZ"
Content-Disposition: inline
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>


--6tEeg0s4Zab9rwdZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Trees are 4 hours and 16 hours old. Linux 6.11.3-rc1 (5a1a1f7c8ef8) /
Linux 6.6.55-rc1 (0b955ce7bd7b). You didn't quote sha1 hashes, so I
have no easy way to check pipelines match the announcement.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6tEeg0s4Zab9rwdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUzygAKCRAw5/Bqldv6
8m4QAJ4hEwV0vLwN3cv+h6wX5MjLmxbIiQCfTzXS4d9dSswpLq+vE+zCqG1j5Bc=
=OGMx
-----END PGP SIGNATURE-----

--6tEeg0s4Zab9rwdZ--

