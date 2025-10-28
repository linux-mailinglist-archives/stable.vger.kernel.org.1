Return-Path: <stable+bounces-191403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B5C136C7
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA71E1A23776
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD418C031;
	Tue, 28 Oct 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PAzvGGM0"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA635824BD;
	Tue, 28 Oct 2025 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761638616; cv=none; b=hqC1r9vR+rotoQzv2zFRORx+RrssWpFgYbc9ZtxAlnVll/1nve2xH15K9sOva2GT7rLB+kUxBx1JXyG9jlFHYHxBolu3lw0p0t/PYujmBAL8qeTPoX7z2n3H1sqFJ2qo7+B51VMvwvE8JbXrtBoO6OpNJinGnBKotLtfxZnVVmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761638616; c=relaxed/simple;
	bh=sRu0gc4hFVN6uxisUHK0oxZccmywB9LffLs51iOrXmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtzsFBwpDL8h6GxdNRgTSxGZBzTZymBOUaOnt+52SymJalgdaCTLRkyif5V/eSR1XPKSzLOp5rFduBbr1FYRdJuZ0Itn+A2kQ8LOCZmkj0Qios/Kcut4OnSGa63eS4mWzpXdfZLemiANPlVqOpesbVMNbgPCAiJBQC9EQSJVb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PAzvGGM0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B8581038C10B;
	Tue, 28 Oct 2025 09:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761638609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/Se0KlxaomiyVyqm8VUB1otynkAPIQ0uLFpFROwjL2k=;
	b=PAzvGGM01x15Oa0Xgq8f2ZmVg+y68cK6s5WGU60tjtXMBAKQcDkSeqXAV/DdbEBG7HdVoK
	3+rZMgFbR5X/+440F7C8BQJsYIBeVe/tSSTl17fmHi8maEvbqPReAuufrZWMjFZANljUi9
	anUx26MocHF2oeMZ/WaFlQNCG54QycfQni3946BqE8HTwNWBwTYEANkw3/9NbWmyfy312X
	vc+1GOpq53NcGkO0BJKjfcZ9lmPnaA+04C7Lwyk7Sg34CNrDZtr9RSE4+tYEXqcaQW1a2e
	8IJqFUjU19E4riAXImZMjS9Q34ZyCtjasVVDz4FbsdV+16mP4tARyDA5pvgxFw==
Date: Tue, 28 Oct 2025 09:03:23 +0100
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
Subject: Re: [PATCH 5.10 000/332] 5.10.246-rc1 review
Message-ID: <aQB4yznImF+00KSo@duo.ucw.cz>
References: <20251027183524.611456697@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8ayJbXm0U9M7UpT"
Content-Disposition: inline
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--n8ayJbXm0U9M7UpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.246 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I'm seeing failures on risc-v:

arch/riscv/kernel/cpu.c: In function 'riscv_of_processor_hartid':
2246
arch/riscv/kernel/cpu.c:24:26: error: implicit declaration of function 'of_=
get_cpu_hwid'; did you mean 'of_get_cpu_node'? [-Werror=3Dimplicit-function=
-declaration]
2247
   24 |  *hart =3D (unsigned long) of_get_cpu_hwid(node, 0);
2248
      |                          ^~~~~~~~~~~~~~~
2249
      |                          of_get_cpu_node
2250
arch/riscv/kernel/cpufeature.c: In function 'riscv_fill_hwcap':
2251
arch/riscv/kernel/cpufeature.c:107:16: warning: unused variable 'ext_end' [=
-Wunused-variable]
2252
  107 |    const char *ext_end =3D isa;
2253
      |                ^~~~~~~
2254
cc1: some warnings being treated as errors
2255
make[2]: *** [scripts/Makefile.build:286: arch/riscv/kernel/cpu.o] Error 1
2256
make[2]: *** Waiting for unfinished jobs....

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/118706=
47387
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
123716079

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8ayJbXm0U9M7UpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQB4ywAKCRAw5/Bqldv6
8j6vAKCExbzfJKaze14HOxo1O+2CL2utqACgv2wgbi6coK9tB7yyzpRlYNBlzWk=
=XvfS
-----END PGP SIGNATURE-----

--n8ayJbXm0U9M7UpT--

