Return-Path: <stable+bounces-161976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C8B05AB9
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB73B3D06
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489731A2387;
	Tue, 15 Jul 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa4lt46h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429A2566;
	Tue, 15 Jul 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584533; cv=none; b=amY0ranz3ZYhitCQqYhHpTor+MKIHGb49gUmRAdTpgOOBamvVG+9N/XrRJ6JZg6hPWjl9SrzCukfjh7y0xpYAx+NJzddvfFrxbC2w5wBJ9t0kh+7hVws236n2iqweY+sdmVundtFqaGZSXSwfuNO0Qes00TCH5kX20z67JgPpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584533; c=relaxed/simple;
	bh=bOJ8SJUmwY1xIJRqQBze5bezXdl7AQhRGfQSUOpqANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh2UPNLAlPlV+MTFMzFymTOzLGWh5YySL/K5qdsHxPtELOAVIuPRYpYWD8ZFqgp+0qOrQ5A+wMxvI5krBH3pXhHlGZrpDJ8o/cS7pWLhWbQwxkUHkRPWMKsFGHxGc/mcJ/mbLu/C9PW9Op8PhB8k4RBVdNTQzWoHTB5yGHKIbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa4lt46h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54820C4CEE3;
	Tue, 15 Jul 2025 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752584532;
	bh=bOJ8SJUmwY1xIJRqQBze5bezXdl7AQhRGfQSUOpqANE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wa4lt46hR9M+XTqb16d4GClW13D8t4MOlHF6PRtU4lkV9lxJg4UJz5RXmx+HxJl3V
	 8K46nZJmPk+x3imGfk5hPBGmobGtu9CCb+NiQ2uQpUVgF2oRdFMRShjwpuR13Ge3eW
	 UbBBj2HJNu8ob4wQ6+wlQLQGEopVzZwgkpFWwdBdLvS5N0VWW2uZUoxiyY9FZa/urS
	 ymbVgNWPSPphkHmaYXhQybks1By5OfK+8LUmxMNbmB8jbxbIwrWf3JL9pfpFkicAc6
	 62BBTk6Qua+FrIQ1ohAWfo1d7mLyHfOusS8KrFQUChhA2GMRg7JvenidfcwG0SRY5B
	 If0dYrsAXXwmQ==
Date: Tue, 15 Jul 2025 14:02:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: Re: [PATCH 6.12.y] arm64: Filter out SME hwcaps when FEAT_SME isn't
 implemented
Message-ID: <c586f05c-a077-4865-8529-08aaf16b8bd6@sirena.org.uk>
References: <20250715-stable-6-12-sme-feat-filt-v1-1-4c1d9c0336f6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fAbC77fD/JeM77s"
Content-Disposition: inline
In-Reply-To: <20250715-stable-6-12-sme-feat-filt-v1-1-4c1d9c0336f6@kernel.org>
X-Cookie: Your own mileage may vary.


--3fAbC77fD/JeM77s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2025 at 01:49:23PM +0100, Mark Brown wrote:

> Fixes: 5e64b862c482 ("arm64/sme: Basic enumeration support")
> Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

This needs an additional signoff from me, sorry - I didn't register due
there being a signoff from me further up the chain.

--3fAbC77fD/JeM77s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh2UU8ACgkQJNaLcl1U
h9AkyAf8CTyXRFAOmA2UW5KB9lyNRiQUjIEy8ntNvLDc1wUCqr7h9VwSjNVeKEo5
i0SAWtzT04UMrFordXykPqRJ8ZC07MEDEnMTJ0JRG/wVVc+MwYm8OzGRSAh8EX3o
EymAqKldtvgc27fX/8btlgLLv5y7UNJBQKYEYNJvUBlo5Mpw7QerBrJGRVKK3XFO
/xGtPDGtutdnLqM62sM7kGHqVx9nusATF32e3Tp0TiExCS6IguGmAA20T61zU/Mc
NIGl7dEfQm71BZkHYACpzrOsjQvXT2nSrsslBzj5nDSp69hfxoZtXsjHDybWymw+
5eiwwbHDdXiE5kOhTHoV1nYPAwgs7w==
=ijxT
-----END PGP SIGNATURE-----

--3fAbC77fD/JeM77s--

