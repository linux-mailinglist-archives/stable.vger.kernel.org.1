Return-Path: <stable+bounces-161398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A3DAFE318
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A1E480BAF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3D22DA0B;
	Wed,  9 Jul 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi5pSZnP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75127FB12;
	Wed,  9 Jul 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050828; cv=none; b=PwU75FiSgphSmUDojt8UiHorvGXtnjpECjGLBCSuO5H7VCXUrrh5gM2FwKh3MjXe6B6i9Nn+YWrwF5a4Q3AIpaQciG0usAtKhO6QBRNMHuCV8bbEa9OGxIv7aaxh0Go0O+hTfnhsOfUpeUjhEBOlfuf0S8URmGCveLoyylEP5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050828; c=relaxed/simple;
	bh=lFZ/3J/dfgojIoxW3tybEnI4LM5cOKI50TuFe38pSHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejVnWAJFRnswO8CYSEtsjXBSabUn7kpRnq+qM60+EhGoSsfF0pRnTb1iBToySukCDmE+O630TxXjDCmmXV6zeJS4QQZhybZGcd5rQ7TXptxsr939WmfvMnRUzLaVrq+aDmpD8dsB+DENzSqoe/pL82fUK9UYUsEB5Nwt1o3kU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi5pSZnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F89BC4CEF0;
	Wed,  9 Jul 2025 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050827;
	bh=lFZ/3J/dfgojIoxW3tybEnI4LM5cOKI50TuFe38pSHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oi5pSZnPgKonq5oj4XxNNVl8vhvp0/A+VMaa8hzpXsCTEVYwDZKNWVlN7Y5r1XeFg
	 SWfHGzdVOwhqeo+9UZdibzauHwVyxX+Rtg4PEM2KCYnTDcIpQdt3VOTUxjj0Y8+mZK
	 hDCyH4qY1d7z7ZArIiykWxI76nGNlurJTLT23ZkPcFaKkquB2y+mwpcH5TVG39go/S
	 KObwOmkJ9upnn9bOgDYc6HurDBskGzAsVKMhiTmedz3ne6FVvsadQTCbHBFk1rDQvs
	 F74mcFbSEkl+3pXVZt58Tjp8/0p7KjYblGTtoPB72YOCwcDohdccd3g5ttrjqUo6XE
	 SsSyd202j1TmA==
Date: Wed, 9 Jul 2025 09:47:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
Message-ID: <aG4sh87DTt6LY6TZ@finisterre.sirena.org.uk>
References: <20250708162236.549307806@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5L2s3+A3smagnZMr"
Content-Disposition: inline
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
X-Cookie: Do not cut switchbacks.


--5L2s3+A3smagnZMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2025 at 06:20:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--5L2s3+A3smagnZMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuLIYACgkQJNaLcl1U
h9A5ewf/XmKVeZCBXUxBXex6/F6Pb9upcVgaEQLAqPs/6/KS89iy9hMgx7nq4MWo
b4jDaQK3QYCyANX//ah5SsyJZ3S5YRhlMnlCDldY2XEOcaTv9Ew3vext2r053TfW
y96V8woK7StTZ9iJO4MvqqT+1bXUQPviVbFX3NZCOPhazpi48I5rXUPxDi7HE7GW
B/++VyhRVBKhmiL7PUuqHNpoBUhFvsY2p0pk2AQs1Kfejy9miw9b/pNQmsZvw1ef
r7eM2M1ltgCPdprQIuz+va3yreLJjE3dEpr1ZibexW1XaI1NEsEJPgmBTKsFLhQ0
lsjWXVihgaTi2UMU26hb3wmY2yxHFw==
=Ki7l
-----END PGP SIGNATURE-----

--5L2s3+A3smagnZMr--

