Return-Path: <stable+bounces-132177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB64A84A58
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4364C00D0
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2B1CAA79;
	Thu, 10 Apr 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fbx/VJsZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0D13F434
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303564; cv=none; b=hEKQYUWwgV+Q5t6Yj0yk14ajH/q1NYNaFMy1zM3qtKmuJN77GIWwK02Yr4grz6FhtExwJsWGwFHOlTej+0eujVEjOqNPuE1iDd4PZhqMcdZR3iTLzvWLgziRXdRBzuHa65Tuixh4XOoShvUf27Uyuz594d7FtW3efdRCspMTC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303564; c=relaxed/simple;
	bh=09Mb1yiSgtqPdkps5f2rGdEuqEnpVokP8xpdq/elb7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkMNu0QaxFPzk6iZ40xc0lR2IKsI+1VxoqGTCEQaY6td01zKxZnI4rHX57BIfKjgv8PdfAaYjJy92ADH1XvcG/Rh2y4bWnZtMaAaIxwsDeE+o8Hw2aKqGsYl0tvN+zYbcB83JubijCAoegLt3FUeW7Opbds7RzQLfFEr3KrvqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fbx/VJsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F94AC4CEDD;
	Thu, 10 Apr 2025 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744303564;
	bh=09Mb1yiSgtqPdkps5f2rGdEuqEnpVokP8xpdq/elb7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fbx/VJsZp4NuM6fbckM9C8WpPfwjqzWzRtSfeakdDRJeW1T+xH1I5y/BhS/Q5S0im
	 PUfLb0Rejp0j0BXBPyKTPa2o27HXbbVwURE8XZVg1pw4mgtRJrt2rBzFl4GPJJykef
	 0Bzv4iLU/H42P59s0VpnumpiiXpwFetYoPSU7Mik7iUq+71wvjjhvVgfXZtNYHrc83
	 SJPBbmapOuL3a52wNQT9un6XSMDXsyQED59yCxBWZNKQNI4OormuG1Xd6c+eGGuPxt
	 Mmv6zC6XzUiLKvU4Oiv3NuYTr3PFicqRTo+47Zhm0pzHFYQOxWj73rpsw3neuVoWkX
	 5m788Nca1019A==
Date: Thu, 10 Apr 2025 17:46:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v3 02/11] KVM: arm64: Always start with clearing SVE
 flag on load
Message-ID: <217f7c75-c624-4795-90fa-a19a24c5d2d8@sirena.org.uk>
References: <20250408-stable-sve-5-15-v3-2-ca9a6b850f55@kernel.org>
 <20250410112437-6c51badd1fa7bb35@stable.kernel.org>
 <05817c61-13dd-42d4-86f8-4cf76ba1df4b@sirena.org.uk>
 <Z_f1MGoJ6T4m77wY@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R4bQNAIis3MlQ+Uw"
Content-Disposition: inline
In-Reply-To: <Z_f1MGoJ6T4m77wY@lappy>
X-Cookie: You will be awarded some great honor.


--R4bQNAIis3MlQ+Uw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2025 at 12:43:28PM -0400, Sasha Levin wrote:
> On Thu, Apr 10, 2025 at 05:11:06PM +0100, Mark Brown wrote:

> > This looks like some sort of infrastructure issue with the linker
> > crashing?  What configuration was this trying to build and with what
> > toolchain?  My own per-patch build tests were successful.

> You're right - sorry about that.

> The cooling setup on my build server started to fail, which caused
> sporadic failures during heavy load.

Stable kernels, they're the hot new thing! :P

No worries.

--R4bQNAIis3MlQ+Uw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf39ccACgkQJNaLcl1U
h9C6VAf/Wc6yCC5fcgs6mORfvUFfrcCR7Ovd2ypP5guMPXYjkMt1XTkP1IgNwJ6g
MQ6adpBBB0nvkSoc9o19ebNiJAfDLQU5fARZGMDTcPyALfszEhL/jUjZ6HQ4qNw8
SZ/UsbxPwgAjBjsE6snrJOYnooHmaEnBiuZkkDSJBX79TTAPf39i24bkFksIVjaY
hS1nBJHJRK1UVPx5HcHfRuXboYemWEiQQ3Xo2QiYb7YkiNFUmikiA1fbXS9GlJmZ
UTYlgMqIZ9knSFG91FTAajXSUj9e8NohyufL+P0CXqII/KuqcNg6/TrMSMzLcZtC
pp9Db/SYFw7egk0P0qgoF97jabZf7g==
=kT7f
-----END PGP SIGNATURE-----

--R4bQNAIis3MlQ+Uw--

