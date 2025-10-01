Return-Path: <stable+bounces-182919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F937BAFF78
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 12:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2F17ACAE9
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F82BE649;
	Wed,  1 Oct 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRugU17R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52212BE04F;
	Wed,  1 Oct 2025 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313695; cv=none; b=JjRk8bud5rZlwNOxnmyF0Mers6LyKXujFXPt+52bUAsgRT2vyWFpcKHbmbJAPibK8R2pI6NjYmjuc84AVUPSMAy9ID3P7xCYlD749N25J8jVvB9V1lzkX6215eqfFQkUyHZTKPSg733F8/tT1x/bqq0DpC0indfCmrC289Q70dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313695; c=relaxed/simple;
	bh=6SYYbnb/HrlytJeZNKyvASmq3dCYOigIZCMa4EGljFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXnfCEZdLU6jYIY/fojkY7FNclUgNkVx8W7LFi8bvM8x0bgoVkD+HtwfNoqTOmDtPjpy/ThlmKCkYf6QaVIuDJrYTrgFNK2vwT307HZtQhh+K/ziuCK4cqhyCa4bDPUmZRPmTyM2U5X66uQ0a4Hp4v68BQYFUBNOIOeY2ChmmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRugU17R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13571C4CEF4;
	Wed,  1 Oct 2025 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759313694;
	bh=6SYYbnb/HrlytJeZNKyvASmq3dCYOigIZCMa4EGljFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRugU17R8WioAuhodM+l8GTuTV07Cr0cxcz3MQmYuFsAcECS/b+wNnVb9Fk1/IsQj
	 jqWk8Uw3D4TSifSysxr41ZhF/qki3K7dRmhaHyiYBOVjJsmf93SVhA+koZ1AkiG2ob
	 S9LZfa9Awl3fVmlgDaILteE5G/hlXREb9j2okH0vJikw41ntI1IKhWj68OMzXvZRaj
	 QliNXYNV+1FZEj+F4milGZbChKRkWDO7LMzQkqjkn6qHfc7zAdDOSKUembxeQ7SzKq
	 lJPuiC/J+KMTri4fmX4YDOtfgr28eTkohkDqQRg6LUANyh/iX5y6jJP+QBvPSObvrj
	 BQxAxwROdKJ8Q==
Date: Wed, 1 Oct 2025 11:14:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
Message-ID: <aNz_G1dc-2VEgYlI@finisterre.sirena.org.uk>
References: <20250930143821.852512002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="83r6OXVyehdPp7x5"
Content-Disposition: inline
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
X-Cookie: If in doubt, mumble.


--83r6OXVyehdPp7x5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2025 at 04:47:14PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--83r6OXVyehdPp7x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjc/xoACgkQJNaLcl1U
h9AlGQf8DaZXAU3mx897WcJISsrhdyLz9lla3PW4XJQuaKG58KK4H/uyRrfsvTKS
iH2hff3ITNhTUtlNcDK+VKDrdWfIaeGjL88f5CquSjWmBEOtZqL07PvYOSBKnkBk
DP8ZhfkI10jo+S6xNaRjXNXX212AT2BJ0Hydfa9pNAEWSZUgXFnj+KGaa6wEkHcW
h37O4asLgMLG2qlmNzNLpAjKcwfnWJdXa/iIvzy5WspuGRv+qvHr2ooBPry0EI3t
WoZkVCSkI3Tdj4FAJTSWKm0YhQlPzOCxEn9TDjKQHPOKYP0PrMW1Nd5j9W2N8dUX
KxsLycywb3pu5bl42oFDxbD1mpr9SQ==
=3zjf
-----END PGP SIGNATURE-----

--83r6OXVyehdPp7x5--

