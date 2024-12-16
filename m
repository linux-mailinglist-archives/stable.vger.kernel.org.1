Return-Path: <stable+bounces-104366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2B9F3459
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E84718862D1
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACB1465BE;
	Mon, 16 Dec 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKa9HMkH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5913C690;
	Mon, 16 Dec 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362500; cv=none; b=pvIVr/+9g6ukEzGlrMyL/84YwiGdH7rnp7wl4uczczJlyOeeKo2rqW/KmWBv/YzIRvyBh/kmMtwlTHWDrvgJnX8DiKdjybT+3vtMFHCTNxF+L59YaEVAMbAHyfeP3qVN5ShhatmGU4IiNICX0rTFCdjkEoKndfDitHgp7G2pE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362500; c=relaxed/simple;
	bh=slzMq2uKF9jRRkGUhn2WleIyyRQ8+cdzqcpgL4p7oYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQo88btZjjurkVXJP9PC8bM4epIyt91CNESr0PQvT1ZzD/IKe/DJ4sN5P3HkSIpl+tLO/HKmf6vzjz7IgmS3zbdRKJDezWjwEeUuRMYAEc6MlGdqtE9Cfwon8RLsoeU6GfSorEQHMOvvVMKqHlig4NWlwH4AigQvbUBkCyYG/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKa9HMkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FC4C4CED0;
	Mon, 16 Dec 2024 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734362499;
	bh=slzMq2uKF9jRRkGUhn2WleIyyRQ8+cdzqcpgL4p7oYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKa9HMkHgsp+XrMG0sF+EpAXTypgy9rNBBoDLglXsdMOFg29LozcEpM5Dzrwg1ZU6
	 HyZxDYJQS4SrJ8ePxaZYdm+LMFzHiNpCytcS/JzVrvVsKM5rKIjNpAYIEBH3gDVJE0
	 7Lm/N3eWic7K7eUkPQ7NC36/avdT4BC5klsxVZ/XbhUJpM4VwQ8IuVZbwWDzsFgh2D
	 zvwIEVUFyjB7pPh9W5gHXHVAqeRVVeEVvyymw/6eFqVt7sZNjSkJL2+2RyCIDr7348
	 CUKZWWqJEIeI1CvTF05xFrxglP0OIkdvegCWMgZyAn+Qe1K4BnCKheHC+YlTvNaQ+q
	 pXN8IrSJPh+Kg==
Date: Mon, 16 Dec 2024 15:21:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <4f72a6ec-63e8-4947-9455-fd354d03cadc@sirena.org.uk>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <Z2AfOZ82QG_ukWry@J2N7QTR9R3>
 <865xnjsnqo.wl-maz@kernel.org>
 <Z2BCI61c9QWG7mMB@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1CzcJPayw88to6gv"
Content-Disposition: inline
In-Reply-To: <Z2BCI61c9QWG7mMB@J2N7QTR9R3.cambridge.arm.com>
X-Cookie: Be different: conform.


--1CzcJPayw88to6gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2024 at 03:07:15PM +0000, Mark Rutland wrote:

> Looking again, a revert does look to be the best option.

Since we all seem to agree I'll send a patch doing this.

--1CzcJPayw88to6gv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdgRX4ACgkQJNaLcl1U
h9AyKAf+JZiB5GX/WUa5gpdsOOm851W7LTNeG0kD3S0epkj08gyTGU31EDGh51Lh
SK9sTHXqRTB8ao4x1kZsHlXaDQGsfUyChkhyRr6UDshKsujbl0DBbrmPVdTDOPXZ
b4ALBlRN++sWNzKrrk1w2ARRAmxJfwmr4CtVockPd+E+4pMhmK0kGKsEuKNQ+4Dw
J0Hc4pmpcx0RM7kUmqVi4xtcORNJWfViE0bxu600syWj6KpmtedvRiY81vKs7chs
F9DTPHY5vtEjJCxAE/GZHiV7cVi59MpvrexbF0cjps2inWdoXa2C87YYXPxmyXAx
ISPS5WchssIms5WNwe9k5P5LjHyUAw==
=bdtR
-----END PGP SIGNATURE-----

--1CzcJPayw88to6gv--

