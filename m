Return-Path: <stable+bounces-136569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B64A9AC98
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414DE1B66B05
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E7226D11;
	Thu, 24 Apr 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht2xw09W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38222688C;
	Thu, 24 Apr 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495896; cv=none; b=HhQ8kwFQ7Lks+7zZMiynsPFpEBMLTs6g8RbpRQKzGdZML/fBovP4IJPeJ9gGsxR4k0GHoRVUMUDFAzOrLzpxPI5cwz0yu5GTg0v4aYAzQG1IHlhH4KTLc0IsFKeQEO0z1BWCaj1ruJchiOPTHq98VpTQYsFo3+1DN04NTEXYUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495896; c=relaxed/simple;
	bh=Fo6lCLgC0Xol0vCDlZhTtso6aUEZQPGhVkQpAi187fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYONvgy6UxafjwmZoY6W+GHvp8YhR4pTEfvsbC26lA4eMt92Sxe8rovxRx4uKO5ywGFWQcTEeco86y8B2KQuZt3kW7q708MoSB4RRGDYlF0iKjkuIAuqyPO2zz9fNzy1cxgBfzoMbufTihf1UPTeBFYnmM0Fx1eG5C2t3kKyRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht2xw09W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A8EC4CEE8;
	Thu, 24 Apr 2025 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745495896;
	bh=Fo6lCLgC0Xol0vCDlZhTtso6aUEZQPGhVkQpAi187fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht2xw09WGvPKAVvCu8Zhi5yCdW7Xs2a8slzjBNCoi9qksBqghc7I5Spd722Ug6Nnz
	 Xndg29Nvk10E38NEGssK6sB4NQOIenUR8KlJUOGswCRPAyjQ42w7Mz2jzb2dDkRRRk
	 9rBuemQCuhmNTL4/UcHZzpXG9ghdW6xTb+HvZCCciBgaWMlWhzXt7FOp3hphiMsbDS
	 5euTnenNeZo0cblIsjRoPotNfvE3e1t7akvzBoRx0+jb4TxcqtPQaiLKnGV3mE5Mtl
	 k/6CSW1pAogWRFIX24+GBb4cVOq4ri3tS1Cx2L7tvNb9ItQTwCROq8qLvTPLQxyBsW
	 v0l2/lRu2Ca+A==
Date: Thu, 24 Apr 2025 12:58:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.1 000/291] 6.1.135-rc1 review
Message-ID: <6783ee09-7411-4484-ac4b-d8a03f2028c1@sirena.org.uk>
References: <20250423142624.409452181@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nBzARq21x+N6IT2+"
Content-Disposition: inline
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
X-Cookie: Star Trek Lives!


--nBzARq21x+N6IT2+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 23, 2025 at 04:39:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.135 release.
> There are 291 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--nBzARq21x+N6IT2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgKJ1EACgkQJNaLcl1U
h9Cz1gf/avKiwWtr/j89MoyXyMSWefRsh4WSUVKoH6TAiub7bhNmx6O5KL+YfY7p
I6UjeS0vTPzgpyHrzZ8JKqUMqNJtUxgsLpAdRNrUQ+I0icUMHQ6iJTzY9xfe6I77
cBo+N4G4FvwAyi+5kK12MEtNaOrYuGKSfeQ+mUwCaBdApu+E9cwFRkhyM4ZdBp9C
5pE1i5pmBb9maWa0EuFU7M90gbdw9E69WSTKK7MPDVPTsCa26We/ZnhBCrAL/KtF
ekfAa0UGSmMKiFBYQVCrEQ5/ebJY1ueVsqjb1ymnUelOLwTxTmnBUg8RNRvgOtc0
YVNAL3LroNONyFxa2cLJwhfsTG1gaA==
=2EI0
-----END PGP SIGNATURE-----

--nBzARq21x+N6IT2+--

