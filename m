Return-Path: <stable+bounces-200013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B368CA3943
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 13:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 029EF3007A20
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592B2E975F;
	Thu,  4 Dec 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXu6AbtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1192C0275;
	Thu,  4 Dec 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850656; cv=none; b=kfTtGVIl0CKCkbhS58WrP1mOrlCm8I1AJ3Ykmgh9//5g5bHDFXJU2SORPnABX0S6naVsu9jYbLVt1XTd8nAQagP2D/e8E3L5rci1s4iy1reTQtsmhibdJbhSxh7KPibrWAab7CgzVWwpvO9vsGrNXPgbtAFFrjtBUek1KEBnMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850656; c=relaxed/simple;
	bh=1ZKnA6Cr7o2SML9ZYVMc/8pxRsW11gxSTVTzQo92YCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i95Va/h03Np4rdMDfu0u+9++H+0lpLnilHImgkWs7URiJ6N+fTOZcaozQQK4drfLJae2wVJwBJJTbtCS7kytQI36JegIykoIaT1k5TwYn3tFbTQ/GW4y4aXUVvmnYWCGc7w4RwUip4N9glcncmrzyvzjCuDBmsNjSxnpNnO6UpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXu6AbtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27549C4CEFB;
	Thu,  4 Dec 2025 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764850655;
	bh=1ZKnA6Cr7o2SML9ZYVMc/8pxRsW11gxSTVTzQo92YCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXu6AbtDGOMWFMRIXJniHoA6YbL53i3jzbt1J0zpxslHx8M973WXxiWMLV7iu3i0+
	 IWtj+yvWzhBskJcCqcc8KAEltjHVCXPsNM7isSVZ3Q5ZgC2S08ARnf/8ZOJrJb62TU
	 NsZwsC7+QdEImqy5ZBnVBgp0KhgWc2I61I44F4pHNxZLsm8HcUXQ7I9o0jSOCPJXRA
	 x1jLL2XBq61MHcvCQfobsztWeq6bHOYj/SsfnoBgppl4pMVqIHExivPISgn96ijSf/
	 JZoH7ETGLUtLPXMlBkfG3QjlTkJ4mTQWs+dYMGzbLdSaEVr4JatbN694FJ4adTDtKd
	 R9oKV5R/3QYrg==
Date: Thu, 4 Dec 2025 12:17:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/300] 5.10.247-rc1 review
Message-ID: <4d8f4970-2542-4c21-a9cb-80fe88611bd8@sirena.org.uk>
References: <20251203152400.447697997@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8xsXm5EckQWymCGH"
Content-Disposition: inline
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
X-Cookie: volcano, n.:


--8xsXm5EckQWymCGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2025 at 04:23:24PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.247 release.
> There are 300 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--8xsXm5EckQWymCGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkxe9gACgkQJNaLcl1U
h9CboQf/e10bzJIfRfMB+bBVRkt2GAnmseAe8aalSFjTsMI+4rudbVoCU/fuJG1z
vM7M/QTZgOQe8dljyCeHW4ayjah2KrRMNpxczvPzoDlAtZRpE/ibqntycgDfcaCS
PDH/TmrhzyQStQAu6si8C995JXMhEYzTQfDKp0P16HWVkz5exn66lyoLxQZse43b
Hhfx0Nd5HDVVW1U9IqpL+xZoOcuebUJkNuHYmidYJ5mFXsz+3E/lhaMQ9gttg+vJ
U8EvKTtStszMPKeYA77OZ3nJ+MgiC6DINdRJsbalmzZqzgKyGN3lnT8/W0chSe39
I4iyJgsfuo/xlQBcV2pDKDqu/+LtVQ==
=O1Yy
-----END PGP SIGNATURE-----

--8xsXm5EckQWymCGH--

