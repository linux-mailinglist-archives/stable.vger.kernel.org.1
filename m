Return-Path: <stable+bounces-109165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC8DA12BCE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 20:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BE2165C00
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427051D63D5;
	Wed, 15 Jan 2025 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no6Oa3WL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBC14AD17;
	Wed, 15 Jan 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736969822; cv=none; b=ebeqUBf/dFGsnMihBRbE2hgi8jYntKi6qoqpWCBXyL+mJXWGA727ayW1zJf3cWbsITslLIfZqF1tS1Sj0L0qTnSuMpD7zatyRNkQIyGE21n10/so36B9ms/hyAoPWks3fRmAvYWtn3UBv6njB3Zt7xUfVba7clfdu4WAqtynyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736969822; c=relaxed/simple;
	bh=L/hKtDC6NdQnWRvHyrDzMcAKeNJJRI0aRFFPU8V6Sek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvvGEFlkOJAyec3oTeK8bUKpd8WAM9qg/xC1kSzTetThY/zC5gKatsAC9/zrcPLWdCUUqiZghrYPM5aC45newEMP2H91S0AvxVvUXKKZYP8L3y4kXVTIMuUqEsPOodXHfzlUMFqVg5q0RMgsDMxDA7aO9TEweHQkJ76Rh49qBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no6Oa3WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF56CC4CED1;
	Wed, 15 Jan 2025 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736969821;
	bh=L/hKtDC6NdQnWRvHyrDzMcAKeNJJRI0aRFFPU8V6Sek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=no6Oa3WLFz9RAMrvWkWb4tqF2mJvfQxsMGe6VLEwcJXJG9PrG6gRz4QonfjcRlj5w
	 pfIS4jDGReReLNxDSRER6gZangcjTrAReGmp6g3pAM8dFnZdwnUJnV1W2dDCM/xJ+X
	 Kf5Z929v0Uaj+jrpsskAr5uJkuoPQS7E6lyN5IWiF3U00Q5F6skemXyNVXm6tF2ndv
	 Gx1Gf2A6S6UCepfTp3/JGkQttwZW+J8fU/+4iNpVypjBGfhznXHlbxdA7ZqsmAIYVH
	 VtOEYJLCm3+PGSHZ5U9sUP4tj+YTsERHoO5KK/QZwto0gr7LtvJzZ5T7SLA/24VNg/
	 WCmKjLDvHFkmw==
Date: Wed, 15 Jan 2025 19:36:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.6 000/129] 6.6.72-rc1 review
Message-ID: <d8beaa67-7253-4650-bcad-cbc2855c798e@sirena.org.uk>
References: <20250115103554.357917208@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E45xY4Q0jTU51ky3"
Content-Disposition: inline
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
X-Cookie: Phasers locked on target, Captain.


--E45xY4Q0jTU51ky3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2025 at 11:36:15AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.72 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--E45xY4Q0jTU51ky3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeIDlYACgkQJNaLcl1U
h9D7Ygf7BAJ0aDQRpmtDoaYGgih+JoywTIlbIIwPqhTpsR1szxo/XXOTukCL6WhJ
5H9wBuTxX9mgsW9Grb1MzY1uzbJZEno9js+14ZQZHLIRf2Q9uOXCthZFjYOfHXvz
5AtQrZwO4FaTobcGOUL3kGiGke4yOb6TRc0U7Qja6zQcb+6nQ3MEjc3WLWB6X6Qi
nK6+hm+WWO/eHq0KmQIROiyWuS3/jU53cO1k97h+1ItG6vEVdPrzte8kSRf8LDQ/
sb3oeq4j5MSvqRd01NfHPmmt2bjUvNjsRIPhgOx6bagBeWimmfxrxJQER9ayMfNy
lwTXNIW0zKGfBbTlL1Zaa26CagcbaQ==
=TYBV
-----END PGP SIGNATURE-----

--E45xY4Q0jTU51ky3--

