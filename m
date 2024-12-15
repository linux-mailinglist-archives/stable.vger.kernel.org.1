Return-Path: <stable+bounces-104153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8731A9F16DF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77667A206E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D72190692;
	Fri, 13 Dec 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bGTeovHB"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF51F03C3;
	Fri, 13 Dec 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119694; cv=none; b=oEQ71ajwjW8Mwn/IKd3525VUvMLrc3c9ixBSOb5GlXF0NRPHGbJeRiDJt3m3aSz+cEvdNPlz2frHTaiW1Zj5iLoftEpojr/arDFMJwXl6vM/XPxbHJTBhe3SeRmiG1kqRG56j/NVcN0mVtLnddWFN9FxjpLjl3/ufIAoOVwv3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119694; c=relaxed/simple;
	bh=aKftA/otGxXwdrWEBYoOZyWvfEYIZrF3+hSJqJ7lYjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBuGtYw8P+vJLq0F88PbbNWCaM7SbWEs+xQFLJUptoGVE0AzJhIch4s56lRD85SWlRrE9K0TvM/r9a6qIOXVrAE/MGN5Y10GkehpOAOsbnUGfxqQJFPVyn8HROicAvntgWTEMvHdIrySLi49OhEyAFVXOymofRsaUGUN5iIyqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bGTeovHB; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5389103B8FD5;
	Fri, 13 Dec 2024 20:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734119682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQ4KjSOUVZjpTZJ0BLU/PeRbxNzWD1JnPkg/p1sezsg=;
	b=bGTeovHBV4bp6lDEBiQ/5JUwBddIsOIAwp09pgBCD7dztpTF0/wF0jtwnhUqdNVi3XN/JC
	9PwPnxwddP/fx843xIP4RCOTkdN81gLPPeyT9scC0GLh1R5IIY6SC5/QBVE//aktq/ycJh
	Dc4E9rg/AzW/Ss1QwjEpj8vR0fg1YsDgUpTBcXNVBJWHW3JVP39MMJGKDDTG69YN7Cw2QF
	UtSysUF0sYm/Pmjqg0CwAa9RZGxSebBeI9Q7JCDvhn/B/9bVv52H4GnCRNYI6r1bP5Kb2I
	xuBgXWd/byv3ZHzvB7FxHtmeQKxA+hhE4sBxfzbW40cx5T7zrqT9SGYybW4ULQ==
Date: Fri, 13 Dec 2024 20:54:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
Message-ID: <Z1yQ/VnuE0Nc92GI@duo.ucw.cz>
References: <20241213145847.112340475@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XFKh9kTVForwojN"
Content-Disposition: inline
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--0XFKh9kTVForwojN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compile problem from -rc1 seems to be fixed.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0XFKh9kTVForwojN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1yQ/QAKCRAw5/Bqldv6
8jZAAJ9tIAdbFQpc7yk9QyJd7AmTI4MNDgCfRr4h008oMPJXLT7890Jb+2A6RO8=
=/RHO
-----END PGP SIGNATURE-----

--0XFKh9kTVForwojN--

