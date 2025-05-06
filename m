Return-Path: <stable+bounces-141814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67326AAC6C1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81864173602
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5B280023;
	Tue,  6 May 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA/BBRAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF91A9B28;
	Tue,  6 May 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538847; cv=none; b=FlMoDA7uVNggVstuMuBgBnsvTiIiG8oWuQ8cg3LpdiWJ0wVrYofWSMkKarKngdsIdwLFomarsCfl0Hzwv+E0/1xZEVSB6jg8ALr8j/CqSYthf/dQB+/VNi6CvaLbpLL8rZ3myzVRla/vTZfGZNc0GuLHdYKZ+cDZ48zVlKWK/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538847; c=relaxed/simple;
	bh=TnsMB6oXDTL83dZ5GGXgMLoaKxr/HvwUPrxb2FLg/nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIeItECUQ1Kxsgz+u0VnLZwtoJGjDiX0y2SgUohwP9tATsgyL3cOHEBm46xRbj/6Fmm4igN4t1VNefy5Ke8q9THQMR5N2c27CKQDeD9AG7IBxfO1v8yv/V6bIvNG048dIiE0Eo4OfG3L8TwoPcF3KZVrzlNltz7FggYHGU+HWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA/BBRAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FCAC4CEE4;
	Tue,  6 May 2025 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746538847;
	bh=TnsMB6oXDTL83dZ5GGXgMLoaKxr/HvwUPrxb2FLg/nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CA/BBRABGSCouOyN2s3DHXWxIxY8k8K6lcCeP/Bp6YFHEubJsj4q+Ki9edUoAXCWZ
	 zr1IX+FZJgWOfUse3y1JyM5uCIRKbEB8FMrpZd3qX/WEyfo9aYc2fA0QpPom8A2/hX
	 Hjdhjx7Z1lrRpTvQXnokDcwF1QxPyMCNBF8Y1jd4OV5u1i6o/CHZDyJuX7Hoe2i6Vl
	 f25johlq2LtiUN49ATle/TkFnWqP0PtEgxE7lDsBlqf/6//yxZHX9LHcG+StQonmjh
	 H9WvZDxG7uIY2cU+51vrXsqkbGDhMkaQSxMoEndxI1wGaAkaf/r2X+rcYb/JPP5OJG
	 PjeRWevC2sVYQ==
Date: Tue, 6 May 2025 22:40:41 +0900
From: Mark Brown <broonie@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, will@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	akpm@linux-foundation.org, thiago.bauermann@linaro.org,
	jackmanb@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: fix VM_UFFD_MINOR == VM_SHADOW_STACK on
 USERFAULTFD=y && ARM64_GCS=y
Message-ID: <aBoRWZr3oGh94_qr@finisterre.sirena.org.uk>
References: <20250506095224.176085-1-revest@chromium.org>
 <20250506095224.176085-2-revest@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2jWddA5IH0klT0O"
Content-Disposition: inline
In-Reply-To: <20250506095224.176085-2-revest@chromium.org>
X-Cookie: Well begun is half done.


--x2jWddA5IH0klT0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2025 at 11:52:21AM +0200, Florent Revest wrote:
> On configs with CONFIG_ARM64_GCS=y, VM_SHADOW_STACK is bit 38.
> On configs with CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y (selected by
> CONFIG_ARM64 when CONFIG_USERFAULTFD=y), VM_UFFD_MINOR is _also_ bit 38.

Reviewed-by: Mark Brown <broonie@kernel.org>

--x2jWddA5IH0klT0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgaEVkACgkQJNaLcl1U
h9DNhQf+Od2vOQsm8ZSTF5BxQFaQvck4UfZc2SRgJP4yUv++XNZmdwyXQ3L5+JiS
EQiK3uPOGueSO5nt3GBaP4Jmh6Ii1a2kLENKY5dpGf1Gp7cwvyJbVD6wSeoBX3Q8
rHZvWoaDzvHS6xsmGpLfNKN6CcS9w8HR4t0g4em1pDeJCyo0CgF46fZE3ljtarcU
VPrWEPGWqeccT5PfP5EexnEhR5ChJXLS9Gx8q36mIJivayq3mbwkvCTnPOKnNXxy
l04gz3JAWDhZ9hvw+64iVK/FtcO7c4BGKfDyij1RZ8W15RJpRwHcy9aCNcQ0oRqd
UyYKkkjph35w5vBvN4Cg49RoFXNGnA==
=f8rh
-----END PGP SIGNATURE-----

--x2jWddA5IH0klT0O--

