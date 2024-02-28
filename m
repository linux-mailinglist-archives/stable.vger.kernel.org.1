Return-Path: <stable+bounces-25378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D786B251
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D761F225A0
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6915A4AE;
	Wed, 28 Feb 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQXv2XrB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74673511;
	Wed, 28 Feb 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131889; cv=none; b=ZqnC1qIxGbGuKhoo9wgMejau9FiqY6NiYzXYktqdZ8JilZW2jM1gNGElmKRBxtjD93/K8Y4YzI/eI3D/Ia5G+ZrWoDFhnAb8Ur02K5OJ6c+Saz81iK/gQA/EW7w7eQreCxH4pE6XdFN7SVUPBq39f5Ex2tsxRd/8Pp0sedEDu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131889; c=relaxed/simple;
	bh=b1t2Ov68Unjn/w42f81WQh81RyBel4D/DtuQMcGzhGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKX6+NhDgOrjz9QS3ctI7s9hGCOyLAo4E9qBgQTvS3BnfwX6RQhWjC9IW0R/Ap+5rm+Nes52qVK2cV4pVXMdkSuo7qG+RG/c4WFRQkSC2SsO+0FaKzctxoDnDn5TOeGlx4zp4ZriQJCxCPG/VJzG1dSzj38PuTfxC+qwqe6YhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQXv2XrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69040C433F1;
	Wed, 28 Feb 2024 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709131888;
	bh=b1t2Ov68Unjn/w42f81WQh81RyBel4D/DtuQMcGzhGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQXv2XrBn0vNqRY10X2lfcCVh19WVDrRvxMQQZ8ido/rj6gD6INmTE/88nfSl8fxK
	 DCATftTgbSzw8f0otRmEFCev1FLdpJ5Jzj4L3cywqm+EQrXXKkPmRVNMBM+CBPn929
	 g3knjSQEwvwc+Ujl26E3Ihl1UMbb8p374lUpaFxr16sTO+vNynOwlw3ZMh+SiUN1Ra
	 cbGSG7Bili8AOXdpm3FdKV3BFZPetT6Q9aHLK3tYhU3L9AnNb9GBkkrERDGGa9f/KF
	 RPsX3/BxBV4Uyx20Ozjkdv0HParPxrCiE9ciueFqaZGjcoiY/kiWEl6mbvx0jgiHhb
	 qEdYN5aYOD9aQ==
Date: Wed, 28 Feb 2024 14:51:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
Message-ID: <20240228-humpback-onyx-041762cab79a@spud>
References: <20240227131610.391465389@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lw5SBkz6rLQ/FP77"
Content-Disposition: inline
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>


--Lw5SBkz6rLQ/FP77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2024 at 02:24:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Lw5SBkz6rLQ/FP77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd9IVQAKCRB4tDGHoIJi
0lNXAQC42ZMhRlN/IyjSHR2CTE0MOIU3dbuoR5qf0MASOFd6ewD/U7/idOHzLAnz
UFJz7JF1pyep3JXl6dYQmxoGOt+RVwE=
=ZeYL
-----END PGP SIGNATURE-----

--Lw5SBkz6rLQ/FP77--

