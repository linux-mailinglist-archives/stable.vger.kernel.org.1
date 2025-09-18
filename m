Return-Path: <stable+bounces-180571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBBB8659D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 20:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1521CC42C5
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877B28DB49;
	Thu, 18 Sep 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0AXdw7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1B26561E;
	Thu, 18 Sep 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218573; cv=none; b=OihDGh68vG04/4vnuPxEnSy9t3MCChHGEuy4/BsjXorHXVfpU05wzC/Z+6g7ElspOgMK9VNt1JpLe/rQSmxTJoZJhvCeM4dn1epU5UWYgbi2escsoKzovEhHuDrYgZM1MlnE8/szMtfiUpxFg1BZ2YSHaQW7BqfOk3Jq8Ct6VdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218573; c=relaxed/simple;
	bh=OVBFI/A7E3Eof5F24XK6skEzpGo5ZMhBrsqslV9FJa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg25XvZvTW60yYLeJbdeKlIAR0YhfoupNJDs9uJDlMILSYsFQqL85rq2hrbLTwbZFkrrxB4NEVLst6vfs6VtpN1QY+0KxIClNFgdoeLe7bjQyllu7/iQqTD07ktXg6F97+7rULUrDK7E2/pogXDFU83hUBbA8h32TO9g2XKKBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0AXdw7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C9C4CEE7;
	Thu, 18 Sep 2025 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218572;
	bh=OVBFI/A7E3Eof5F24XK6skEzpGo5ZMhBrsqslV9FJa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0AXdw7a+vYVnjqSvLnjQ1YoxZRUpOKUBxsYTSjS0mAahSmNH7Wc2nWSVGa29qkwS
	 LJwywxKnLXo/uBPGqVAOGguIOC5NCs31IHpqvHaSfKLJjLme1dgKyPOmc54ToODzXr
	 sn8jJafjqcjIUEWTPXfWkfRKtxeXZc8SNoAOikPwyrmhQ7Go4KS8wi7BjTA7pyS82U
	 fShaddOCn7yrPwV5tPWWEumMsY67AcKT7q6XV/+OFNqSy8wZK2XAQFmDj//WVYFP9G
	 CS+1nx1FoTzTYmZxSgIsy8Yg9NbM/j0beDniyJyIncc0k/UGpud1iuTO8DIetopZky
	 duiXxkd0B+FWQ==
Date: Thu, 18 Sep 2025 19:02:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
Message-ID: <046e1ded-7678-4053-9996-53c10f34108f@sirena.org.uk>
References: <20250917123351.839989757@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C0QOZ5wEtiLR9/O9"
Content-Disposition: inline
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
X-Cookie: Victory uber allies!


--C0QOZ5wEtiLR9/O9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2025 at 02:31:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--C0QOZ5wEtiLR9/O9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjMSUUACgkQJNaLcl1U
h9DZAAf/T/7ItjvI8hVK+J/Yb4R4nkClhJT/trylL0vwJqS+AKgPyPkl/dLjvnZk
wrlUzmpygeKcfGiAxgcYKv5bL+T8aWRYR670LV2CDnnelc8MOjVAxvcmFlIZ+vv/
WbbFA+GZfiDJgIKj+7o1xQCzmxMerMJHoMOnR1Zg4foAUiF1HqaGA+ZrUlu/+z8x
pBnIayfxayrRkv96ZcMm49y6pa3YnayVUZ20I1n60XappMqADsVSCQF1iajAmeFV
U05PzzZVwmDEHxN/BJFXO1LSvpafTt0GqfnlI11Bow+2y/VU/+hZgmokpCRV4fXD
a3U/ohQOPeU1iJnKc/ytAru0G0pO9A==
=Oow/
-----END PGP SIGNATURE-----

--C0QOZ5wEtiLR9/O9--

