Return-Path: <stable+bounces-60471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8839341F9
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61EB1F22423
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146AE186E48;
	Wed, 17 Jul 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzz7/dAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABD1822E1;
	Wed, 17 Jul 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239737; cv=none; b=cL7KQyJgZBH6gT6MP8OofoUM8qZKJCB76xTrOwhDJxFlagC7Ltt/dWa0zvokuExh2HcxoJBelzwUtIzqkoaWvOxKbRFA+qoJ6dg0m8CEJ0P+9gClDqJsNEpYkwKlkLWao55pZndQ9l0FCZ0qZN7YkA9d62Kam///bJK+XmxWjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239737; c=relaxed/simple;
	bh=Bqqrg/UgNrC97YWv5TsS3kATrsImtejKnJTHWx5AlgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h08tkTH/1G9R6x/2rpirtsy1l4l6v8dDYu5VbMKnKCoZlJstTGp2Wod1k76yh9RSjlLCpRlt23YdgFaPqJ2CvIOReJDXz3fEY1JD++hyABvNkhA6S8zGZiwRG6E4Z84BsVWYFM/0M2g6058Gr0sHzZtLUUKOFs4gMqcNiz8KJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzz7/dAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC40EC4AF0C;
	Wed, 17 Jul 2024 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721239737;
	bh=Bqqrg/UgNrC97YWv5TsS3kATrsImtejKnJTHWx5AlgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tzz7/dAC2JEKez2o8LA8BqjQjJ+Tn++pPE/2/O0CHGhvEkSU2Amelm/1DH9Lj1/Rw
	 QzVrwqWvBxh1wyTLW4VySr9SvrNUbumJOlQCXBEbOfy0shfWgctOg0nibDAbDgR25+
	 XuHJUz8qoztwznO/C2jwImFmOXssJMpGQRAl+G+fiIk7kVFhE93AbMb8OhgGF/Fpkv
	 +rSRb1AB6Iaa+MdRDeNP20XRweYL8L2D3OH0YPNu12LyUtFj+T72RqjNSu/i8czszZ
	 eJta6Wd/c6KcXHwqPEoaLOgsIz6io4ks55ZGT/AXj7Poc7hqOg7bx54VxAJGX3Al5U
	 FC3qKpHvMkygg==
Date: Wed, 17 Jul 2024 19:08:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
Message-ID: <bbb93aab-6ecb-4721-874c-bfb13a48db02@sirena.org.uk>
References: <20240717063802.663310305@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xh2mgp32M2LjD+zG"
Content-Disposition: inline
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
X-Cookie: You should go home.


--xh2mgp32M2LjD+zG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2024 at 08:39:51AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--xh2mgp32M2LjD+zG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaYCLIACgkQJNaLcl1U
h9DlBAf+O1IcCeozLy1ubqeIVSwNbb+OFh9IqPqBX5XHVJUMdmoj/YTg+A1IN+16
I2pfNN2bSW6BJDYKrfK/XBW9Wx0LX40b9F+bV7a0l+sG1Cxc/7e+QS4TFlF22NNg
8X7CxJNh3E/mpLDdCGYOxAXFHpgg1mLi6SVPAjYx91IGRA0Gvgc9xpWFQs7JpEFt
2yDyTde1IjtvO43M1H4KbRwOYZokhidG5PXu2Cm78A3VVC/VfHC27ce5KoMIGqFg
uRwsZuJmDrWQMdjvr8wyGd+e/y4dWP2nTG607NE4jL0Trk8RzP7XGlqlW4PDB5us
l3LLZywToTFjsiGldObjSUbKa1UfLw==
=ywIa
-----END PGP SIGNATURE-----

--xh2mgp32M2LjD+zG--

