Return-Path: <stable+bounces-94444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE84D9D406A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F57283DD1
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2819E7E0;
	Wed, 20 Nov 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+DaSyWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8219E82A;
	Wed, 20 Nov 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121109; cv=none; b=n1IqpwY+kZHOceAyTGg9qnoWIun/3XuSUa21rV58kQJ8T55TSqkiIj3ur0UqkGuxra1N4dqn8PNG0+S3rQ9tKjFYtKrBxCqJEv8GI+xIrpJvbNJXJwCO2L0/c/1uWALX2T5wQ2VW/Y+mp8zLYPUfvEw5CS5svJOSjfyJjXdbbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121109; c=relaxed/simple;
	bh=goepUeNRf/dhLe9FZnxV0RcEfYTEgS341FBStnR18Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilyDGPVn53LEI32h1ktVIqVqe8yI5Ss2byof3DZnSR0H0xzLjo3kV9PJSt7FIFjoPQ2Bw7MRA6xV2laxdy+VpT4Q32v3zCRzRq8pDAdV3ZMAcHnsRBVncdvwh51gK+U39pLbenIvRqngqB+gIgL2p54c4j12lsDMcQ3wg7dDTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+DaSyWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F0DC4CED2;
	Wed, 20 Nov 2024 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732121109;
	bh=goepUeNRf/dhLe9FZnxV0RcEfYTEgS341FBStnR18Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+DaSyWM2YQTHrqFzfl9WtRLCcpI+o/cp2eHJULvsp0PvC2LtiLFwApfZrRip4JXC
	 RYQKjo5TDVnwEPiXQ0+VwKnvi1DgXS9KGZwkKsahzQe/Y+yLer4spe+jow6/FxHjld
	 Rj43XaMD+aYRwLtP8CZ5wq/V0+fpbikmuMQT2VPoyNOBhPzsqZdiuMdvLLloReMavC
	 5kSYnAMIJsjj2dZbj61GozPpgK0W46sMn5YWmBkjyFyRL0vj7klMJSyEPmUnza0S/a
	 u3d1EzHL/qwM+eKCm+C3TbLlP6twmplQAtQvBPjh1iVOivKAmKLPYSOlms5RUNAQb6
	 aHiQ++50FXMPA==
Date: Wed, 20 Nov 2024 16:45:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
Message-ID: <c8939577-318a-4dbe-8490-174228be896f@sirena.org.uk>
References: <20241120125629.681745345@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UyDIZA+z5bdc3JeX"
Content-Disposition: inline
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
X-Cookie: Place stamp here.


--UyDIZA+z5bdc3JeX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2024 at 01:55:35PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--UyDIZA+z5bdc3JeX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc+EgwACgkQJNaLcl1U
h9D7fQf/dKTOoCa4J3mZe6peeRp5Niv1U7Tf6za5FY4SZY8mLMsPoPQ3c1UCpdTi
fxQzM+Oi/VhqXSiKLVHNg4b9W06Gf2S+eNYpZqqjy8841QdAereR1Lrv0zShFG3v
zoSMihGmhSFM6VsVNs86XmATvE1M6nL0+oiPU1+zcCo8hB7XgWE/DbEGLsUj1lfj
HOKYpc+LUENElzb6Tvyy65vxhLxZaLHQm3E1cJQL0/jLcdnAYiHmqg6LcCA2Hu7p
9Y5WK7vHLz75vi7PnHZtyULzTNIogbc8CwL4EO0NQcTx+Fla5p4MTRlR+sEJnB8k
rIUQcYf4TdkA6I3ZWitlnf9fixExAw==
=VEQx
-----END PGP SIGNATURE-----

--UyDIZA+z5bdc3JeX--

