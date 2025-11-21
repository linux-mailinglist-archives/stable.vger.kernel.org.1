Return-Path: <stable+bounces-196188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72547C79CED
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96C5A34EA65
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4039350A14;
	Fri, 21 Nov 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Dni7XxGn"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC897342CA7;
	Fri, 21 Nov 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732806; cv=none; b=Eg//7dI6qnmQieVUh7TgNP+qCDn3UI7UBEoknzXsnxZ0KRsmqFsyTeUhVzOluTO+YZK77Hl2FdrFKJP1D0DAADeW+PNEZJLuFyI+EEQ0VQiLWW8/OxZPeskV6vZy+t3KCKVmti7Ay/bjs/pD15CC10g73CRy2eUmPq6QbRbmE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732806; c=relaxed/simple;
	bh=UKOcKhyxpboYVq8QwId3CcYWPcr0ojqzhpWjY3RPQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i93lvlvv6nbX4vBoFi4V5Xd1FHTvAS2VJeVug3Ra1HFBd+NJ1KnLt6NDjZsb96Kgk29khgGZJraBVl9cLyZ2bti+Q0eOcbiqm857FPZPuAT/BheNRE8TPcGFP+JhR8NhlAKYZgaVTbHaP9Utv7mhvdCWjG/KYFzNM8xhd0WctFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Dni7XxGn; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA0F101E0E74;
	Fri, 21 Nov 2025 14:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763732794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0hOQTMzGD21rj0ucRgP6e8Z9rKjJXzdNoulIFUlbaaA=;
	b=Dni7XxGnpDCLpfxWtMBXLr7W9XcHhrmLjA6CrmIUqCmlP/2fDAPlztyucAIGI0T0ssnleQ
	yZzuzNeL/9vZmBal5kbLwd/vjVwyijBLdYspCB5Y0xdIt/4UQ4rqWVtGVvg5httxSA8BrV
	ee0eFQmVfjE0+qzWQro55ARvxh/eI/8zLS3jd6KBop5uH0ia9GiF6Fa/JWmSPfP4fYGjvB
	wOVBinTYqHs+RFDcJy1wwAPDcTIPYBqqhnaRKA1bewolxcYZWoj/R6aiwz2fdmmt86MMyc
	+ONLxC8xyI7wqjZvInmPR0VRdgHTH5SZ1MBhSOQn69/4zt+vA+zRFkFeRT0S3w==
Date: Fri, 21 Nov 2025 14:46:29 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
Message-ID: <aSBtNeRr7NBjWHep@duo.ucw.cz>
References: <20251121130143.857798067@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xxqhi70gSUAyMCZi"
Content-Disposition: inline
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Xxqhi70gSUAyMCZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.59 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I have successful test result, but I am not sure it matches the
release. Please quote git hashes to make this easier.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
170546623

Linux 6.12.59-rc1 (bba98f3faf27)
Passed
 cip-ci created pipeline for commit eac30293 =EF=BF=BC 19 hours ago, finish=
ed 18 hours ago

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Xxqhi70gSUAyMCZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSBtNQAKCRAw5/Bqldv6
8rxdAKCxc2bB0bOtSH1epsBnuM18Fwr2hwCgroERBsZMS0ADFGeGOf0cykBSbpg=
=Wn9x
-----END PGP SIGNATURE-----

--Xxqhi70gSUAyMCZi--

