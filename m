Return-Path: <stable+bounces-111755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D1A2372A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D601887F36
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F431B4156;
	Thu, 30 Jan 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P3UfcsLN"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7261DA4E;
	Thu, 30 Jan 2025 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275716; cv=none; b=SGSTeya9P8rvUMR0+YOrX8XDO0n/yteBz02Fp+ki6r1bYrOUOhyVt0KSndJ7jtO3Wlhau+J9L2PXc+iSRRL9X91gG+X6jPCCB3FzuwgyhQL+p6la/h4hGTNfZM6qO4QfY4XsT/KTIruFHyzfrnFPqiXOmV5xnWozGejuME109Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275716; c=relaxed/simple;
	bh=ahPuLNxjtlOhMpISfnh5pC9Pu6neP030ZFLDOa4YgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S11Jcd9JqgtLeRPxZR8+IYD+BrblS+hTxU9NSBNPDfziv3p7Tmi7XQs5Bl3UNiLRXE4O+vIKw8EPJbybK8FzukGgt+Ljw9oC42r53STxFzBJPm0nE0BNwYeMC3+cl/cLEzXclYEGFf8j/+dNfaIeLEXc8l1p4Sa9T/GrKbaB8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P3UfcsLN; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 358FC10382D08;
	Thu, 30 Jan 2025 23:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738275711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvmSG/PROe/hTR/WHkt+rGwnfSK64TBm31u7LBqfUqE=;
	b=P3UfcsLNFklU7AEJDuG6qZ0H/0DOAHCNmKknqh3dntIDpQsIXnLDzLAMk/uzttHKlArfir
	sYk3XHu/mXXVpKbqP+yMo3dow4Dfy2FZ9/R+eERVS/ysBsXfoPPW8T3LQSJZq7utFE8QS6
	W2PLTbljYJjQcV7Ax9mnZJFOrLiirw4QgcgEeDs2BagPo/Mn9hC4m2T3hnxRQsOHrj2ZBf
	z8SZ8OIk2RG/yi3NrMzU/KaX85KS144X65nJUuoDsU1Ccxr39Je3gUxXXUyZ2UaG4wMz2Y
	68c7h1Vzpm+Of39poD6HJ3ReJkiLtev96SRQqQI6UO+YamgwODRr0VYvpr/Vag==
Date: Thu, 30 Jan 2025 23:21:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 00/91] 5.4.290-rc1 review
Message-ID: <Z5v7eE18RSDhRXwl@duo.ucw.cz>
References: <20250130140133.662535583@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3iIR59k7s9Nixgd"
Content-Disposition: inline
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--t3iIR59k7s9Nixgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.4.290 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We hit similar build problems we hit on 5.10.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
648754265

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t3iIR59k7s9Nixgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5v7eAAKCRAw5/Bqldv6
8lROAJ9TRKksMLDabGVro1Cu9kbBRgH34QCgosXWZvVKJtFZM4/09799pl60ET0=
=R++F
-----END PGP SIGNATURE-----

--t3iIR59k7s9Nixgd--

