Return-Path: <stable+bounces-127705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AADA7A79C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941EF1889FA3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AD2512CC;
	Thu,  3 Apr 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF3A8hsx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89E24EF7B
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696616; cv=none; b=iQ6KrKEg3yzqtcBHsVLyPSa3Lm341CmaANGQocDiHSUQdkwzgKxJbhVTeOo/522vzASvd6olFiw1H5xYqWalgOiTyBMGBiNZxWxKXMs6nviHbw1vZJQbOyVZ0AJ5Pq81Fb2FIKpevOvBQPsIncVHbTsLhb2UNlTGm/KMBg82Ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696616; c=relaxed/simple;
	bh=G5S302+6nw9vvw9Iq+oVSbfv0o4jP02C3D5f2PomKIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhvXjBpRv+qSoa2e5P/l4mCs+wNVqETolBqpGdm7HSYdm4LH0P45V3VNWoSKV3J7jTeO2YNKNApERHTBS/HmEBN4mqVlSlDlBYIRxWXATJJD83T50zoLvwDml7ExulOBtAoyYOULC4bypkrDGloATecyOgxW72vChqK3SQY6Dak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF3A8hsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6922CC4AF09;
	Thu,  3 Apr 2025 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696616;
	bh=G5S302+6nw9vvw9Iq+oVSbfv0o4jP02C3D5f2PomKIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eF3A8hsxS3MCfKSXbtrEsazY9nr8CK+4shlW6f1yeG/59rrDKFAp121/41MKRR77w
	 kS+3xhrQiFKGXvE6mUMcElXvV99NMQBUIkNz/pkUQwnv0mYpjIN684/639Q/v8J++8
	 OGf77jikEvDDWUJROPYj0PUf1Su6RVeE014qqBssTC3BVPKQ8CHz+wQgvxI97zC31e
	 lebxKlF3pSQbNunZ0ZHZAP4tlVjdz7sLSvA9vF0Y+8ysnE3VFxFMREN7RZ6Za7JJlX
	 iDMggKDxQRBZuGkhaW5JxsTUCmluLJpC+QS1q87uv7epiniOxHxlaMWy6Fcfvdl7aE
	 azwlsDY0u743w==
Date: Thu, 3 Apr 2025 17:10:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v2 01/10] KVM: arm64: Get rid of host SVE
 tracking/saving
Message-ID: <8de0b46f-879f-4dd5-9b1f-8a8c9b0e6ca0@sirena.org.uk>
References: <20250403-stable-sve-5-15-v2-1-30a36a78a20a@kernel.org>
 <20250403081043-11bc930a2f4bbcc3@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1FIXRCir1U5Vmo4Q"
Content-Disposition: inline
In-Reply-To: <20250403081043-11bc930a2f4bbcc3@stable.kernel.org>
X-Cookie: Logic is the chastity belt of the mind!


--1FIXRCir1U5Vmo4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 11:38:38AM -0400, Sasha Levin wrote:

> Found fixes commits:
> d52d165d67c5 KVM: arm64: Always start with clearing SVE flag on load

FWIW I'd squashed this into the subsequent patch.

--1FIXRCir1U5Vmo4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfusuMACgkQJNaLcl1U
h9BzcQf/T4RnJG03Nf2/5FaQndyt11WQ22GbDJqCvWD/0kBZAxmBs8dGICQQM158
z5O7g6+u5HVWV5KdKpPlOcvvA70pA8L+X4mLGBEy7bAwI5ynkdPgSeWRGJU3/XZ1
Q+KgEceauubE8tsDiyTWd+KfbNKxkhtiPnF1DmpoY5IFAyywY/DIS3D1jzljT/Zp
EibS1pdN+UbyXGYMv0v3ZxJ6u5Aw2PM/UOZVom9U7uLLByIA+g6nP25ZMfhZid5J
1hOHE+TBRq9iJd7Y6DpcW73b5LMX2YU8gV0g2Yu8IEskjWzS83/ElL8QStWj52jl
d6XUjR1+hHVzPrC/ApyZrv7LEWPYEA==
=p+bq
-----END PGP SIGNATURE-----

--1FIXRCir1U5Vmo4Q--

