Return-Path: <stable+bounces-128293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE86AA7BC40
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5EB17BC8C
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A21D86F6;
	Fri,  4 Apr 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTyLFmgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D01B413D;
	Fri,  4 Apr 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768232; cv=none; b=tRQAPxmCxWsQf4ilKSHX0E7zanaJjmK80ZSejxmOV69tazD5JFSRL2EZ4nQLc414xsU2JeEMv1SEZtXYMn1G5pme39l/ILH34vkgx7XCjvV1PHqioOnR8WnFQ7ODHXjXenr6JUHIMjfalPy+IHBNB9dJDy1N0k3megd0OsSTq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768232; c=relaxed/simple;
	bh=ZI5wJ8BR09ARuliN4nqM+CrGGKh5oUrZXe8E0m9FvAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv58UiQmqWrfPcv4/PpFGVmLXYWNHscaBJ2e7Ckyse/eyUkMqxAakzRiZtMHt01hBwvX8j42dU23Ydmke/q4CQQ8/dT5Rf8b7hRtWB1lk+jokImiqTTEl+ps2e9z+173yBSKMjo2I+VgpcPrzcgTwFPN8zUwqh0qYxm7ERfhS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTyLFmgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BFEC4CEE9;
	Fri,  4 Apr 2025 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743768231;
	bh=ZI5wJ8BR09ARuliN4nqM+CrGGKh5oUrZXe8E0m9FvAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTyLFmgEBT+07sTu/+fvK57Y/imkAZm/ujiX+INZF0ClaZTloQ4GLlKVrMI/YH5Uz
	 jwBqyG2SGn/4pvyHqiifFi2YbwGACAqN/p4IEL9K6Zbf1ImdXzQumySkOHEd+u4O1L
	 E523QpgGbHOqpl5q1cffFajofL6di8LiipOsDx2zYhsbFlLB/tBuyxW2y4DbihGQLa
	 SoF1OZ6yey/NjUlEKoGLcKSs29umj7z8BlBl3+/sPLN6/rRDqE8ewvpynFPfCnRBhv
	 /F4kERpX0DZYsh+s0b5Pk1FzubJvaUkxiegPRDwLjz5EROqPPpKgonTDtNQobmaV52
	 mSfu5MtuCIKqQ==
Date: Fri, 4 Apr 2025 13:03:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.12 00/22] 6.12.22-rc1 review
Message-ID: <de860da4-89aa-44b8-9235-2de83db7678c@sirena.org.uk>
References: <20250403151622.055059925@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2KoyYZXN9BOREGI3"
Content-Disposition: inline
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
X-Cookie: You will soon forget this.


--2KoyYZXN9BOREGI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 04:20:10PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.22 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--2KoyYZXN9BOREGI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfvyqAACgkQJNaLcl1U
h9AL3gf9EjDWknAgsVsrT6MMC018ljOI58ROK1wFOgc5k3d3pu7LHE3yz2+TpKbk
HHjO7d5IRiYA2iDwVJASxXqRCu7uKmW3XPRaExVhsmW7EiLlwzpd5qKCIpzgIK2r
UrSyv03K8iYsRV57XqwCH1NTyWmc+mgA/DTjMZPQ2Vt7EMjzPilquoU3YqunTOQf
mRp0Bfq30lyiDy/QY2IvGTuoU/vvB7FS0oLjmHhM5L4e0K0nZIdoMzykSPGFigs5
wacgf4rZfV1Oumeq41o8wfRHQmfc7RSivsBbGYSGXufmIuVHNMIO357DkjFY3y+b
QhXFEbOEFgjB7O24ElOMl2w1uZN0aQ==
=4InQ
-----END PGP SIGNATURE-----

--2KoyYZXN9BOREGI3--

