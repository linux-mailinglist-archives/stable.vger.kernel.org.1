Return-Path: <stable+bounces-69478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B095669A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DA31C21901
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988715D5DE;
	Mon, 19 Aug 2024 09:16:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388F15B992;
	Mon, 19 Aug 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058988; cv=none; b=TzEy8mNV1MS4MJ3LyABf6Ybha1B0ESjRjuUXhD8XKo2dCEas0BQp0JTb4X0T8ZuRtsxgHKOrDkksvx1bWOjVZuYkEqjucs7ZFgysOahzcWb+UxdZ1eDaFAeD6Rx9f85MiL2RylDIPx1B04iOybbSJ/wi2WYK68/TOGDR0Vdv8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058988; c=relaxed/simple;
	bh=7LI0SJF9fUnq9VtRnpdBOruehQHNpHPmabhPuuydx50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUkwT5f2Tq7CdndA/QjN63sBUzAZjkm037wYJ7ckpkozMsGQfeu0baPMbpwtn+m9DgbDG93p1hMPfmrRq/xI8vYtjCUzxrZEvno78yrnyNfx34G54wLWtIKJqQiTxM/33MdmULWFJjE0bCfjA7zsrWmM2oVZn2X7+BpUk8CM4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5A11F1C00A9; Mon, 19 Aug 2024 11:16:19 +0200 (CEST)
Date: Mon, 19 Aug 2024 11:16:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris.Paterson2@renesas.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc3 review
Message-ID: <ZsMNYtjBBUE5Ehqy@duo.ucw.cz>
References: <20240817085406.129098889@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="luEX0Q4HZkFyaJri"
Content-Disposition: inline
In-Reply-To: <20240817085406.129098889@linuxfoundation.org>


--luEX0Q4HZkFyaJri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This one fails our testing.

https://lava.ciplatform.org/scheduler/job/1181715

[    0.493440] ThumbEE CPU extension supported.
[    0.493646] Registering SWP/SWPB emulation handler
[    0.515073] clk: Disabling unused clocks
login-action timed out after 119 seconds
end: 2.2.1 login-action (duration 00:01:59) [common]

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/761048=
4202

Failure does not go away with retries.

Now... I believe I seen similar failures before, but those did go away
with retries. I guess I'll need help of our Q/A team here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--luEX0Q4HZkFyaJri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZsMNYgAKCRAw5/Bqldv6
8skTAKCKBiy2rq2h23lZ0UG+sn/JFoM6iQCfbc41puHQ5YucRhJGHoINPIptKDg=
=tgzx
-----END PGP SIGNATURE-----

--luEX0Q4HZkFyaJri--

