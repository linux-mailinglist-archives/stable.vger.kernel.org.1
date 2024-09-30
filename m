Return-Path: <stable+bounces-78232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D5989D03
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085791F235FE
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6417C21B;
	Mon, 30 Sep 2024 08:41:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB73FB0E;
	Mon, 30 Sep 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685698; cv=none; b=MxLpLZF+vRmazbIXHHVSR4z0uszNfaP33KK5LHzhSb3BHA+PK0C94hMxQUqnUsQtgPlR8WBOTHsrtyV4JbBxxrCnFfFyuzZpkfuo4OYyB47Jdw3ZEdPmr9+gtm/yAiklJ1kusM/gFOFiFF/7nRtZdtxj+1jxOYCquhUXJraLnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685698; c=relaxed/simple;
	bh=I1OyjibLq9x+XnvGzq74awCAETdc9xD5TNs85H7oChw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah+I3pAWq718XhcfLkKUvF8+uZiToouqtHkq0bLe8P0qRhLcKYSW6glNyJhGRmAiClH4qeg8tRO2XgC1ubglTEtd2YN+86uE/4MwvsPdUe6MQE99OWYxcFu7ervxDcQk1oGFmqarn/QkDWiuh9nAFuMDFz96/xhykwt+gwrT78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E77211C00A9; Mon, 30 Sep 2024 10:41:34 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:41:34 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
Message-ID: <ZvpkPg0bGzbl4ICW@duo.ucw.cz>
References: <20240927121719.897851549@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QB9q8GTrqzcZ66Q5"
Content-Disposition: inline
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>


--QB9q8GTrqzcZ66Q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.112 release.
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
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QB9q8GTrqzcZ66Q5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvpkPgAKCRAw5/Bqldv6
8nL3AJ9LpMNxurEoBMShVWnI5QkT/A2ohACeMN2uRLRCjgXCDLZiVXrPFwbj6RQ=
=8v7l
-----END PGP SIGNATURE-----

--QB9q8GTrqzcZ66Q5--

