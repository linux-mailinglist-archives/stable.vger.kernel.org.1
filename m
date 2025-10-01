Return-Path: <stable+bounces-182917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6160BAFF60
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ADD189F9C2
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51A29C328;
	Wed,  1 Oct 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOKs+QZc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863F625;
	Wed,  1 Oct 2025 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313635; cv=none; b=Sw6ZwAq4zcvXTmKDqYCOL3Q9FIaI+UR7bKzS34/t1kpJeJ71gnsALKXwJA00KoXQELFH5Rez4pgZZOGE8F26x1SVHF7D9zKuPFPA9PwSh80SF+Ktc4z5AF4sKeHPI7d/TLhuxmhP/fuxWb0oWnlMdaF2NoYnd4eqQmVCjXYYW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313635; c=relaxed/simple;
	bh=ebT97QcbAlpluvEcm1IbGzQYEf6K0wXcpgDDkN6Bw/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6009rqnnzSMcyouNbBSW8KmNfNp0c9Ozfnq/T+ILnNHfiDSmF03CBxay0f/lgZJujhlNPQGy7hbQsc3S/rDs8YxEZ6dA8b+XqJDYrK+PvPeimkW/v3xH+4VF4zzjrnMRnp3+uTAG8WwhIoo8NNWhxyPM00xQvAQpWc7LHSj5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOKs+QZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A574CC4CEF4;
	Wed,  1 Oct 2025 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759313634;
	bh=ebT97QcbAlpluvEcm1IbGzQYEf6K0wXcpgDDkN6Bw/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOKs+QZcfbCrcPAJb/ftymYzmKs8rb742wAgy/CkvIll2KmbZ44edM5+sh6Z0XgWI
	 b24Tlt24MBIxHlmD1NFqi+aFEwSpwHlJ5u8RmaW92IvGhcfbbw0I9H3Q2cUfTt3RtS
	 Mv5u5iAao/AWkuFObQMN7KQTppAGO166MkQTeBvOeo+2YsTaXfhlNLh5utpq2Qbu4j
	 3KzYNK8zImBUjBro3SpEWvoUfflsl1S33a3pz/eTIi+bjsGztQUsXzpyO6afAlGHBC
	 GlgXx33zJvX+uqms0Pyo3PO4e+Eiqnnbb5tXZwbCgkhLU3sXUJpOEhipE6CaFWZc8c
	 xdnuNuI0SjHmg==
Date: Wed, 1 Oct 2025 11:13:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
Message-ID: <aNz-3g8k5W7RiJJy@finisterre.sirena.org.uk>
References: <20250930143831.236060637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2xV1MyFERcMPCof"
Content-Disposition: inline
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
X-Cookie: If in doubt, mumble.


--u2xV1MyFERcMPCof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2025 at 04:45:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--u2xV1MyFERcMPCof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjc/twACgkQJNaLcl1U
h9DWNQf/anqw+XlDzH/a0i3LNjUftdYrEpakGTvnTTE+/hStE27C+Zk7ZGOi6bUH
r263GwI0AnAnZSqW34yEG2mh1FMNYwPbkSv0600tCnfcrT31MsGdtzLF0o2EDxUj
Y2czYMFgiS+ojyGcdorO4J6JMwS4xEzl2F/KP68mregw0RvM4lrPfASIy2R/uhwb
c8Tjfe01Jb+idQtsXeWh3vLOvn/GA8+z9XnT6HYsinP1aG4u7SWkhLnRoiiK3r4p
w27iMVXPMsx3xoCQhJhcUqcK0+hcdZAIPc5a4P/DuYsOMbJI098aukWXAl6UOicH
dfHACtiJc07nGjHJJP10rdxxINkMmw==
=2srT
-----END PGP SIGNATURE-----

--u2xV1MyFERcMPCof--

