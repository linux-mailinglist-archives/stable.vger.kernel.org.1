Return-Path: <stable+bounces-75906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552A975B31
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29976283DCD
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF211BAEDE;
	Wed, 11 Sep 2024 19:59:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49751B29B9;
	Wed, 11 Sep 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084741; cv=none; b=uHOF4klDUPfFuErt2zvXinerylv6Ad6SYiD9aHApoI9C7Vzlz2O5PeYL1gSASC3bxwoLe6nW0A0JhfMQCma4gfGZhyspjkwH2frI0KzBIK+9trJQqAApgm9y8pT24EzF96f2NXIW95Q0V9dxob108fe6cQ/yAaJDO+u+6Emyeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084741; c=relaxed/simple;
	bh=Jx/XbIUPoBAtWeb37ct0nBB8w6KnbOkiVyDtaouvjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6Xji6nKKgm5XoocaaD1Yi/Fjrzfg44MIwCEFbixsfkQkyKdSmToC2WAHVk/CzSDModQ8MseXhWGZ5fGOMecKFZiDEKvfSS/wazR0PPGNYwtjjyf88Ja1fIiX/K9RgToI3/r5V6NjRMbbqnIlk5PR98Qz11/dfeNJxZulBEEpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9915C1C009C; Wed, 11 Sep 2024 21:58:55 +0200 (CEST)
Date: Wed, 11 Sep 2024 21:58:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/185] 5.10.226-rc2 review
Message-ID: <ZuH2fxcX2CktXyKP@duo.ucw.cz>
References: <20240911130529.320360981@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yfdLI14yk+cb+n40"
Content-Disposition: inline
In-Reply-To: <20240911130529.320360981@linuxfoundation.org>


--yfdLI14yk+cb+n40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.226 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yfdLI14yk+cb+n40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZuH2fwAKCRAw5/Bqldv6
8jTxAJ4r7Yj/tsNyhPcyKvOdL6pkMuRvLgCfWFJw2eWqENXg0UQt8gKwYpQBf8I=
=tEwa
-----END PGP SIGNATURE-----

--yfdLI14yk+cb+n40--

