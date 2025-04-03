Return-Path: <stable+bounces-127704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BCA7A77F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCD188E547
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950072475C8;
	Thu,  3 Apr 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsQLYyeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB12505C5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696285; cv=none; b=oq+nmGnYiDKAv6YTgPtBDKo4SLutVrUSY04ikauCpVJAAh7Zhnrj0UjA49zMem4NvwPpgkdEqOLT9NxgK3fOa+fAqLABxsbhPUljB5wgAMK/a5eHlpxVotZjnSbSuS88huOXait1hlIJe6bfZGEflgVZRtVeuaEXQOK0tzZ928E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696285; c=relaxed/simple;
	bh=hhxUvNUNww/P+PVipS6EK0kr8bFb/VFReyJVg0nMDHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rolm8XaNLq3hc2QQ2zxOwZJZN0QIUDrW3U/pHLYk76kz0cA2F9Ia7yvhtDVnR8kg8KBiXPbYZSTHuEu7mwJJj5/fILvrkBAFmGaW2F7JOkWv6l4mpHX+Pecyp1JQE/xcPA58bBR6pNZKrazsvGGRuIWhmkqnCIa5lPfseyHZQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsQLYyeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D519C4CEE3;
	Thu,  3 Apr 2025 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696283;
	bh=hhxUvNUNww/P+PVipS6EK0kr8bFb/VFReyJVg0nMDHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fsQLYyeh5hPV0yS8HpOxU9I50ap0oMfHXZPhJFfOBdDfDyvWZdCsmyUJXBIi0ycOF
	 BW6/BAxjwn3gCKQLLfFy2dcWFMeU4NW83pOju+LTiV22VDqqD9CcD4G+AxvG9/iJiR
	 bcMuoenn8GHIIezK13mJjMHfmT4LBntjPJPOGP4s9RqC+ZrLq1fbSwN9dD5saqBXYK
	 Ne0iP/Th51oms7IAOu8/etvi9AVL4hnpJdtEWfXd0YGw3ZQow27bHrFEeuL0LGtQtR
	 Lviz1O9gNtiT+upyhJw29do+Q3MVwZI/XKjfgF3bmf1oeWqNngcxPugioOnCXE5UL+
	 iISxhd4yOI0qg==
Date: Thu, 3 Apr 2025 17:04:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 v2 01/10] KVM: arm64: Get rid of host SVE
 tracking/saving
Message-ID: <826348db-e0ce-4242-910b-8ce0770f984c@sirena.org.uk>
References: <20250403-stable-sve-5-15-v2-1-30a36a78a20a@kernel.org>
 <20250403081043-11bc930a2f4bbcc3@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TV6ujbwxIDR+pye0"
Content-Disposition: inline
In-Reply-To: <20250403081043-11bc930a2f4bbcc3@stable.kernel.org>
X-Cookie: Logic is the chastity belt of the mind!


--TV6ujbwxIDR+pye0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2025 at 11:38:38AM -0400, Sasha Levin wrote:

> Found fixes commits:
> d52d165d67c5 KVM: arm64: Always start with clearing SVE flag on load

Yup, I'll pull that in and resend.

--TV6ujbwxIDR+pye0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfusZcACgkQJNaLcl1U
h9Dxmwf+LHNKFqihvY/d+NNPgR6EIelA3xZ+SBqoekV42mj0gZEBFbshUVrQhzaG
YNKuoMuL66iYT4VH1KFPhVYG7vJl1qhD7+Fpb/FDXQcYhd7XRd5rCkf1qKeowdZc
zOpdTB1L6J3mX2pvPUhbOR7l0fUcsRz0YC9JZ7+4jGNuZygtnbbECG2qkVuM82qI
43m9hxhGaSupCfPZcEOzM7Bd7kRKvOpynUs2dUzBYdccbOvpFA342ju4SKNjQlL1
tswzZnLdS6lEvjzvC32ab3Tve9NIjoSjGfI52G8CeugJWrbs35BwHnCK5ZtZf5dI
GCvtc25Y8DbAb5A8AMSZg9W8oskvrg==
=Vzih
-----END PGP SIGNATURE-----

--TV6ujbwxIDR+pye0--

