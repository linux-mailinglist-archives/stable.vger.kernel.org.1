Return-Path: <stable+bounces-118359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69AA3CC82
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AFA1888002
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3825A320;
	Wed, 19 Feb 2025 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="SoXzTBOE"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722325A35A
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004697; cv=none; b=ZcCU0I6OHqj4JXYR3xhTVPi55ephtfmQb+CUkWyswFT3vNSNi9v0Iro98sNuclZ4wgnHCMLqAPdOsVcOY5FWqDZkDVkp5z+YxD65URKSIhs4AsNMWRl3ftcyN3hCLBDO9s4mn17WGlrHr98y3vqsqfxtIpm4seP84r3y2YhviPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004697; c=relaxed/simple;
	bh=1r23Ksj/ylNWgfNwWYJBazEcLQkspHU22s2jxL2i2CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0ltn/2zQe6ySgM6z8qyCRZ6q4EbZs8JggenWHblb7SCep076OStExHY1w6GxWo6/0Vy9K8caDcClHmjQlIgCe0ybkQnVrj1tEzPyeoIc3WCq1P6yFF1RneyJSA57kiVGoyyJkjt7XY89cX1f7aXD4RvIrJMXFuNYtf6t3owdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=SoXzTBOE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740004692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9yWHInypVHzCY2I7DE5FATTe+zw3AiG6/ZoZKomgZXk=;
	b=SoXzTBOEnX/ycl7mI5hHzeDzDsMTrApJn3FJlRJO4T6s3wrEthFrmcMoEYTPsD8XVX47MU
	vrm5fnXKmzHTX3kHJkjuINa6oItKWV/4KP1oIPNcP/U6o6TKA044NtReOu7Fv4SF6Zefy1
	XqvtIqah74OaigC1guO2QbKO5fzKFJU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: Drop unmanaged ELP metric worker
Date: Wed, 19 Feb 2025 23:38:07 +0100
Message-ID: <4657309.LvFx2qVVIh@sven-l14>
In-Reply-To: <20250219165451-d7aeabb8444db978@stable.kernel.org>
References: <20250219165451-d7aeabb8444db978@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2384176.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2384176.ElGaqSPkdT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Wed, 19 Feb 2025 23:38:07 +0100
Message-ID: <4657309.LvFx2qVVIh@sven-l14>
In-Reply-To: <20250219165451-d7aeabb8444db978@stable.kernel.org>
References: <20250219165451-d7aeabb8444db978@stable.kernel.org>
MIME-Version: 1.0

On Wednesday, 19 February 2025 23:09:53 GMT+1 Sasha Levin wrote:
> [ Sasha's backport helper bot ]
>=20
> Hi,
>=20
> Summary of potential issues:
> =E2=9D=8C Build failures detected
>=20
> The upstream commit SHA1 provided is correct: 8c8ecc98f5c65947b0070a24bac=
11e12e47cc65d
>=20
>=20
> Status in newer kernel trees:
> 6.13.y | Present (different SHA1: 7350aafa40a7)
> 6.12.y | Present (different SHA1: c09f874f226b)
> 6.6.y | Present (different SHA1: c8db60b2a7fd)
> 6.1.y | Present (different SHA1: 831dda93b13c)
> 5.4.y | Not found
>=20
> Note: The patch differs from the upstream commit:
> ---
> Failed to apply patch cleanly.

Was this patch applied with or without the already queued up patches from=20
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-5.15 ?
They are required for this patch to apply correctly.

Kind regards,
	Sven
--nextPart2384176.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ7ZdTwAKCRBND3cr0xT1
yyYmAQCkuBIMYM/H0T4IM6DBr9RVLGW0rSBTFX8eu/2Vdk2P8gD/avDgG892cc/J
kIMTS8jk6nSmdH38QfyTmSnS+8Bszgk=
=97k8
-----END PGP SIGNATURE-----

--nextPart2384176.ElGaqSPkdT--




