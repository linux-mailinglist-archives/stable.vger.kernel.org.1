Return-Path: <stable+bounces-132174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A39A8494F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7D03B165A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD461EB1BC;
	Thu, 10 Apr 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd8vNwyF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0E1E1C36
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301471; cv=none; b=du+se4Eeok+ZYLpYUDrYA1NCTtQNhN0eeK4VwdR0cn2Hov8dH/H6/WD/Gd9dClamghhAn9lMieJmqxQk08JrNjCDhFSv1B0FXSoJ1OsOF3Zk3aZgU3/kdx/eVMFyl/7lzwzYkPgsHuEvGGrVEEOyHDWr0DlkGtvxwNoux4D88eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301471; c=relaxed/simple;
	bh=8tqXQsuDeXNx3vLQ0t/YPQbw6SLxac+JG+W+sSqnyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbxdcwI6wPdLAi50E1DRBeXsuqbwV6oYs3Q69A1FsXDnqivNMtELsYGGq+Ife0mEDSKcSEdLJlduyc+VEix6ZFReOHqLAQOD+AJBSZZsRmWjjZjbrqi1yENFKzNNE8Fpu37Cfqev7hpySTPT+i8yVBRc3bs5YHXNrIZgOKFzp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd8vNwyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4A0C4CEDD;
	Thu, 10 Apr 2025 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744301469;
	bh=8tqXQsuDeXNx3vLQ0t/YPQbw6SLxac+JG+W+sSqnyQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rd8vNwyFJqZOldX0GuXG56AMIwVRFru4Q3FdB7f+GweRem1lrqeMp1EPaynS3/dKf
	 Ei354QkVJrm/pcA1rvXNDcmvGcHZKpKnGqur0frUf6O1Gn+JwDUUyEZ+tqF7PSq04G
	 Ors5X2NrfuwzjSaM1WMf/OYg/k9r7LHJ+ZvgmppA0xuJnUkReswLvcd5vw7Aa2Ni6Y
	 RfM8zOQz4+EPcrRv0P3QgCgF7qqUENPGpc17p2AcL6C1DuuKERzuObxbDQC0rdiF3Z
	 bEFrrHWvYtM0DQJqbFcCH47JIIi+iIysFlG91qMQH48j+Zsu4m89yjUQX/wHOJwHC/
	 VyWkYjjRQaq4w==
Date: Thu, 10 Apr 2025 17:11:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v3 02/11] KVM: arm64: Always start with clearing SVE
 flag on load
Message-ID: <05817c61-13dd-42d4-86f8-4cf76ba1df4b@sirena.org.uk>
References: <20250408-stable-sve-5-15-v3-2-ca9a6b850f55@kernel.org>
 <20250410112437-6c51badd1fa7bb35@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L1mCirjBRMWIrkcH"
Content-Disposition: inline
In-Reply-To: <20250410112437-6c51badd1fa7bb35@stable.kernel.org>
X-Cookie: You will be awarded some great honor.


--L1mCirjBRMWIrkcH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:53:32AM -0400, Sasha Levin wrote:

> Summary of potential issues:
> =E2=84=B9=EF=B8=8F This is part 02/11 of a series
> =E2=9D=8C Build failures detected

> Build Errors:
> Build error:
>     Segmentation fault
>     make: *** [Makefile:1231: vmlinux] Error 139
>     make: Target '__all' not remade because of errors.

This looks like some sort of infrastructure issue with the linker
crashing?  What configuration was this trying to build and with what
toolchain?  My own per-patch build tests were successful.

--L1mCirjBRMWIrkcH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf37ZkACgkQJNaLcl1U
h9DYVAf9HmaWlSjX17LskXru3pt+y/Q1GRBbI2OZ1gu52hc5PUZ+IxY5/UwyUsiZ
u9PzJIHw6L5m984ZY963MEAYNSYjRXYSP9UmOzvAKvXesjNhAlUe9CvbmsWlrGue
Pz5Hg4yP/UqXR0JLF97crLKubugHQWHg0B09qKg/zK/BEp5dlggfNfwiVnGxj5dj
NyYsWeZiWmzhsP7IvSW0iBtdvFbo1kY9VKx5rG3REPDG4uoxARVNWes/l2cBzGrF
mhYE27UMHDPdbm2UfIeAMobLUGoLO1xRPmiXVOb0Nj0gnaPXVxrD37Fii9vx7ZeJ
reS1N+xXm3TtLhXgoGmzpwHqcQgM1g==
=rNb4
-----END PGP SIGNATURE-----

--L1mCirjBRMWIrkcH--

