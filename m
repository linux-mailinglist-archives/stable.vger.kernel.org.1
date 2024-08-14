Return-Path: <stable+bounces-67629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AE9518DA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3321C2138C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50B1AD9ED;
	Wed, 14 Aug 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIOyxwbf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B823D552;
	Wed, 14 Aug 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631610; cv=none; b=dmGIueS1Xd8VS9BxzXuji5fVpXbCOMSOX0Up+zW4pO/pC/uTus59VkaKXnoyA4bE4HuNiWzJjk2jP0sn2Gar0VKkbhmnCK3jJxSkfOqc0fumcInS3LGvCkM6gxX4lc1rl5koU5CXjGXlES7eKOvfpsQwyVGncgmpbqNSAZGvEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631610; c=relaxed/simple;
	bh=KpPZgmHtH/1QMwBxAjeLq+Z4Flu+D6NzLewjyw97fjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t44uflWzFHC787QGWx1EyQLi58yMjPX4BqtFTZLa6hT3Cny2NKFgUEnSVQNPgiHRD4Bf9IpIQJltexRf1AdimLFeW5USSbOrmcwN7gqhk6wCoOj0gY1K/5q0/vg+5OwhXKbYg1mQxyzmG6inZ2v7a6mR8yHTEMuKSvZxMVWvuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIOyxwbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D5C32786;
	Wed, 14 Aug 2024 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723631609;
	bh=KpPZgmHtH/1QMwBxAjeLq+Z4Flu+D6NzLewjyw97fjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIOyxwbfv56q4xNyWm9Y0/+kYJlFBDXXn01sT/qSWopRKDfyPzjiiGam0l1ST408Y
	 tpwRAyeYiU8y23EvPkhCxNt22mKpJWgLmL+HVY+MFw+cNgNFzoXOoGf7zTwhBYyl0x
	 ASWUnLOCOxqhf/Z/KJmpl872A9XUqj2L8gz2IltLdb8sn1Lsw9alkagzFk+AOiFoeg
	 amLdXDGVmVtnjBr6w9WJ6DlIPE3oJwHBKbkywpEOLVBKi51pYGkSR7Y+CgPljVgaAg
	 3cOLQrrtEAqfiRx9tPBFjN8paWKzCeQML6jyjK4tH1WJuzyFz7wOI00jq2c4lLp920
	 09bLRiuHqeA5A==
Date: Wed, 14 Aug 2024 11:33:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <e7b0597c-72d8-4cb6-bcec-19e29c1b864e@sirena.org.uk>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
 <210a825d-ace3-4873-ba72-2c15347f9812@linux.intel.com>
 <2024081225-finally-grandma-011d@gregkh>
 <20240812103842.p7mcx7iyb5oyj7ly@altlinux.org>
 <2024081227-wrangle-overlabor-cf31@gregkh>
 <53ab1511-b79c-4378-b2b5-ea9e19e8f65b@linux.intel.com>
 <20240814000053.posrfbgoic2yzpsk@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8cRzxVvx8vzJbx5"
Content-Disposition: inline
In-Reply-To: <20240814000053.posrfbgoic2yzpsk@altlinux.org>
X-Cookie: The second best policy is dishonesty.


--A8cRzxVvx8vzJbx5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 03:00:53AM +0300, Vitaly Chikunov wrote:
> On Tue, Aug 13, 2024 at 04:42:04PM +0200, Amadeusz S=C5=82awi=C5=84ski wr=
ote:

> > Should this be cherry-pick of both (they should apply cleanly):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/sound/soc/soc-topology.c?id=3De0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/sound/soc/soc-topology.c?id=3D0298f51652be47b79780833e0b63194e1231fa34
> > or just the second one adjusted to apply for stable trees?

> I think having commit with memory corruption fix is more important to
> stable kernels than not having the code cleanup commit. So, I would
> suggest stable policy to be changed a bit, and minor commits like this
> code cleanup, be allowed in stable if they are dependence of bug fixing
> commits.

> Additionally, these neutral commits just make stable trees become closer
> to mainline trees (which allows more bug fix commits to be applied
> cleanly).

The reason I nacked the cleanup commit was just that there was no
indication that it was a dependency or anything, it just looked like
standard stuff with not reviewing bot output.

--A8cRzxVvx8vzJbx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma8h/IACgkQJNaLcl1U
h9DnQQf/TKq4Vc8SiV/EVDnt3MX1aX8RSRj02uCVscH5YRFRhBZJtQouANZy90Hm
igbypwI3awsWw/rrq8OnSLz2LY118/SIYIlJ3Ha6pgrnUoJd4xTsOCLOBN24SyaS
+nXeD6jFATJpR9JmqhVkM2jqrK9dbtWpRt/f9OxZW2AzRU+EVRdvTLYooUI3WzOD
rhVIC1NCVhLOOWbwr9RHpz6iTUMgJpnFu3lgp/dfJ6cTNN8ZPTgtb1FJGJbDDfkH
2qntUSTLYMix3C52VfaPAlrDj+8foF81PXQx1XnDfWyrQ90AdIZNoLZiFjOdh31t
LEN4cmQnh10Ath7r3PLvvrdR+OK5Sw==
=SCAF
-----END PGP SIGNATURE-----

--A8cRzxVvx8vzJbx5--

