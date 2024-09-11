Return-Path: <stable+bounces-75853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CC9757A4
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E941C25EF4
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17281B29CA;
	Wed, 11 Sep 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O53vvKAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED61A3021;
	Wed, 11 Sep 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069960; cv=none; b=XCk9prNel3Qe3dWDyXr0UnUK7KI4rl50966zawUykHhaSJh763SlXkFKdBNBOr+dP4pMrWOoo4ozSqeOkZZ7agsKAjyqMxDpiK8K+0plSJCF0lwJbjzPOayp6fR6zdBpL9NSvTnHjWFO5uPD7Q6pKj3Lp9b8KPbq0yOQ8LWReeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069960; c=relaxed/simple;
	bh=EaRo3nIvBeULRRnHqzUQ05tQMRJjg5ALvOAHP3Y91Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEw9Nth+L713nkl1c9jVpJ60ipZsin3k2nzg2nLY3ai36+oXNu18T20/zpDGFEz5bnlttU7c6BQ+JYdNUTL5DBc3X4mY1+pzb2jHX19gs33W6/h4Z6ZOW6FqKPgu2fSsn7bsBLIEdYIHfzKkrvxgp/58eL3vXUWj9rC9zYIXI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O53vvKAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B5FC4CED0;
	Wed, 11 Sep 2024 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726069959;
	bh=EaRo3nIvBeULRRnHqzUQ05tQMRJjg5ALvOAHP3Y91Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O53vvKADVc2odhiedKGSyCanEhIgja3ljEd9a2PgKFVz2pWndZITepiIts4ziDx1J
	 3vQaiVIX9SMnsdq7USKWHNw4CTlX51WtDUbg0nWokkrY6JOQNptxJAibuMydppfz08
	 qwf1cQOhkPD/Q3TwL+scqChMY8uwLCwMw27awSUFEnrBrNyE7sTpF+GvwEtYZiTYn5
	 jotU1ukSAd/CkMYs9Q9xWU/TI1IbI22GFBDkLLDPPLEO/AmSu0HOec7XH+yDnE810R
	 QENQWKkuOOSUtuCRf23z/zGiekAJe1BxlxCyjaFgAxoYvMu6ul46En1jO9AozQ0P3f
	 IHfFsgI9dD48w==
Date: Wed, 11 Sep 2024 16:52:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
Message-ID: <090abdd1-bd82-483e-8d51-fef56c8039ee@sirena.org.uk>
References: <20240911130535.165892968@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ahH29RshIXgcaMP2"
Content-Disposition: inline
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
X-Cookie: No Canadian coins.


--ahH29RshIXgcaMP2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 03:07:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--ahH29RshIXgcaMP2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbhvMAACgkQJNaLcl1U
h9ASrwf/deW7IhEH0alp/BDC60u+MfVsjYsjFvv/Z2BSfgEr9c5wsxj9u2jBzfCD
oUVkf5bv1+JQYiITy6RpqWOF0yozP9IpSt7Zv4+VH4wVz9zCrtp7toORL3+qfiI3
NL8Zduflu+lkO0AzVmTpPY3NX51Yb1NKikT8/ywcRhKp+OqhZMVfW5OXjaCcmn+3
20M7bvQOMTQeavHTaxMlptsDP8WADAJPn4Qsi6bhHbuiBrucwHsYJTw12Gi0FjvO
32qz6x99exo1Gt+/nd+nQYViCBtF1M526M+8c38rnw8ufKvq03I2OxFhMGoU+XAB
KlgcG5uOW3z/gxTm5xQwKanPa3xLfA==
=peKz
-----END PGP SIGNATURE-----

--ahH29RshIXgcaMP2--

