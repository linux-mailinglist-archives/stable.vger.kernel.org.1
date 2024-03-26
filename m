Return-Path: <stable+bounces-32356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981788CB13
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FB7B2825B
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B37208A7;
	Tue, 26 Mar 2024 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS3h/ZW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDB200D1;
	Tue, 26 Mar 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474548; cv=none; b=ESyYcGpWHpXYvCuN9pMqOZVnNvzoUzeboQZ4kGEFNRnG1v5nhXL27ZyE+B58BlQ2XDLUNG52aYC+JUfoUCuW0q68d75qcZPT8hL2LXqwX3Wx/BAgSaqiQNMISH0+JyhNw+GTg5drudQ/ZVju+MV0yRcixYt+f0AQNmvH9Bl3Phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474548; c=relaxed/simple;
	bh=AaiPNSI6xySS2lBMpEJDEiOnnPLF4S/KgYXPdrOD7I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqErz4kLI4/YBozny8T7iM6Spxs1ssdXJkxR+5doE3ULZ2ghb8gsl0LrwSCk6F4ADYeKJi7/PgbINe++LLmpNDubYLqKs6fUexf6EI8vohgff+qDF8WwLnBz19eojLgUlEA/9T7Cj7aGfOyFv5DG/j4BzmMoLRpqdkUSrzya4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS3h/ZW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69308C433F1;
	Tue, 26 Mar 2024 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711474547;
	bh=AaiPNSI6xySS2lBMpEJDEiOnnPLF4S/KgYXPdrOD7I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PS3h/ZW6u0AJ4UigF7GPPaddG63vr1hG8GPPvncQr/yIlx5zyNu4iWAQdLMArsBRy
	 g6ItD51eD+iL4PA/ElxXrAUa7xLa4/L3YaUC8++JcKwHQHr938zPhfGUqmYJz8VMKc
	 Zajufaz9pv+ycrW7OKbuJGOYZsYjcGez7tOmyXNH9b0SuCjzH0R0yERulEPhSEKPk6
	 DhfVEm0Db7ONg143PXUqQgvFxYmlv3ZdTgI6ub6938mS7AhS+GiLyPbAeC/zaIjCWH
	 eJtwpziGqXtK3GChklSME8zr4yR+FGRzkalC/ctR4SkTlULKyWP9E83J7I/YNChejg
	 aCU3ak2bau5Wg==
Date: Tue, 26 Mar 2024 17:35:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com, pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <05e8f46b-d37d-4bfe-a0d7-c638091ffef4@sirena.org.uk>
References: <20240325120003.1767691-1-sashal@kernel.org>
 <cb00ee0c-ed03-4351-9782-99eab1894234@sirena.org.uk>
 <2024032644-speech-reformist-e41e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/lqPfyRsJKhd4LNF"
Content-Disposition: inline
In-Reply-To: <2024032644-speech-reformist-e41e@gregkh>
X-Cookie: Equal bytes for women.


--/lqPfyRsJKhd4LNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 06:28:57PM +0100, Greg KH wrote:
> On Tue, Mar 26, 2024 at 04:16:13PM +0000, Mark Brown wrote:

> > BTW I did ask to be CCed on the review mails, it'd make life a bit
> > easier.

> Sorry, that was on my side, I'll add you soon to the scripts.

Thanks.

--/lqPfyRsJKhd4LNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDB2wACgkQJNaLcl1U
h9BU1Af/dzCdFOz4xUGe3dqGrS8BtzvXIMT6mce/5eAfRs/Djb+8ryGeQrMDIVus
etzm1Y8ouoj1k3jTWphbB4waO1RRn+1vMhWuf9IR1o2IfEdPEEDuV4p9rCTz9f44
If0PEGUJ0YTg9htOlxYEiov2g1n5KZV27BQCAcv0tgNcD2jL6+Dg6yw6Ba1WlXcH
GZicOCblDfT+25nMZLbPy7IsZqVj9ig9vekPNnRH89hCW1KehOt4NqVfDO6xN0Yz
+Td+VJOfkjerGq3DlacHoXeLTbj1qRD2vSJl96qY7TlvKv9TlFZJajrj2RL7C/zn
uuaXYr3yKwhLY6VjwfPdNiyxp7uu7Q==
=R3bw
-----END PGP SIGNATURE-----

--/lqPfyRsJKhd4LNF--

