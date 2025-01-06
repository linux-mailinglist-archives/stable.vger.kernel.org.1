Return-Path: <stable+bounces-107753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D3A0305C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF0A3A500D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE31370830;
	Mon,  6 Jan 2025 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzqfclh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DB1DF985
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191030; cv=none; b=BfNpde7jjcd9fOfCd+hu+N3zmOT9Xwzb6aGtu1JFQmF8gqFtKXR1RQDjV0GUveYWUroUX2+1C3nzfvCYVzscSHxlTB/yPwtATflIZvYCz9iJmZux36yG+UzfxgHYSqC1Q8bc3Au92KkZ3lrfLIVr80j62IiuRUP0vqQPBYiI2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191030; c=relaxed/simple;
	bh=6qqkycaChU04ByYjXtkPjgTjS4Ua9uw484eT8onPDKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFJdGDSxPP+lxchWFR6/XqPXPxcZBezSXRzKfAlcxHLwZ1R8cDr99L/FqcpizM9HSZsbE6hxDoxJkX3GhFd8Ylez48uVx/L0m+ODT3KH8kq1VaYLOriTUTUppEvCETKuzEvuu02BcGY59PSCTtppZNWr/hqX0MGxgGWTk4aGkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzqfclh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0335FC4CED2;
	Mon,  6 Jan 2025 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191029;
	bh=6qqkycaChU04ByYjXtkPjgTjS4Ua9uw484eT8onPDKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzqfclh7A68HZXspO39YAG3pSFL2wOfsLq8oX0mIJ7rrwOgqEpyKqeTtB4QcQnkNI
	 YVs2MzkIM1TipZLgcUlWucIA7yAf/+Zdiw3wpFS0S4ZW+y56XXb64MtAxRzvawO7Ko
	 FruGwNDAnfSRFl5qbupeBDpBk81ijRm/1B22JAo5cdaBkCJtGFoYIFdGRiZelzePmB
	 OMv+lYcR7QhaQlhy3i5iZcK/xheJEh75hrU829nvAYA6jwbe7rL6btFFpft6K80GfA
	 P1c+JQi71nPm6DyOdwz4kn0Np/xLX7eAJg82yvGXEUHLWGVJeRv6LUKr3AXuIS5K19
	 iGiRQxkyFvL4A==
Date: Mon, 6 Jan 2025 19:17:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] arm64: Filter out SVE hwcaps when FEAT_SVE isn't
 implemented
Message-ID: <f36c5201-940e-43c2-acf3-b117d5cc3573@sirena.org.uk>
References: <20250106174020.1793678-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vZFIhnK71t2UBznl"
Content-Disposition: inline
In-Reply-To: <20250106174020.1793678-1-maz@kernel.org>
X-Cookie: Do not pick the flowers.


--vZFIhnK71t2UBznl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 05:40:20PM +0000, Marc Zyngier wrote:

> Things become a bit more interesting if the HW implements SME.
> In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
> features. And these fields overlap with their SVE interpretations.
> But the architecture says that the SME and SVE feature sets must
> match, so we're still hunky-dory.

> This goes wrong if the HW implements SME, but not SVE. In this
> case, we end-up advertising some SVE features to userspace, even
> if the HW has none. That's because we never consider whether SVE
> is actually implemented. Oh well.

> Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
> being non-zero. The HWCAPS documentation is amended to reflect the
> actually checks performed by the kernel.

Reviewed-by: Mark Brown <broonie@kernel.org>

This is probably our best option here, it's what we really meant anyway
- SME did retroactively complicate the meaning of the fields so it's not
unreasaonable for userspace to get confused.  For SME specific usage we
should implement separate SME capabilities that have a similar has_sme()
check, I'll look into that.

I agree with the discussion on v2 that anything reading the ID registers
=66rom userspace needs to have a similar understanding that SME only
systems exist so we shouldn't do anything there.

--vZFIhnK71t2UBznl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd8LDAACgkQJNaLcl1U
h9AjWQf7B82mmLxvEvpghzPsMNERTf/lPPS7nYAi8h/sDfAuP4OfpP7GsSbQGmJ1
QAk0U60pmoOKIKqSeBA5DOYXE1Nf6iJDPraJDgtOSY8iVulXlKbT0mE4WYbtcLXH
LRwwfwrnb9PXONqmKQD/nD6qNElAs+yet7BhE9ROxvrto1Ndht1viZRQgt9y/gM7
fi7Eyzr/iNP7RZqc4BmOAwi8YkLrsKt/y8hV2LI8tbxfATUCizl1K+oh4pNSwxg3
sNnRwqYR7N8Cm3YqhSQEKMw4JAUGnCp0J5iB+0unmvOQjp8XD8O83qs9HhWARyXw
798pCr5lCZJb7/ZmisMMbEKim5YSyg==
=SojD
-----END PGP SIGNATURE-----

--vZFIhnK71t2UBznl--

