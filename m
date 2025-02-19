Return-Path: <stable+bounces-118360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF2A3CC8A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D2E188A74C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CC25A2D9;
	Wed, 19 Feb 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="w13qzFFF"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892925A2D8
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004720; cv=none; b=Te8QniSEORge3Cy7YSTJq0IinyoZWpHhButddc+pHAd/YQtyttc3loC1lFfsOiIqLnu/RbnkN9p0VZZ14Dhhwf6ec7G6dJSZm0OeoVell4BNYsrG2/N4Rc46+M0ZuKw8i+51WX6LDZstHaSkK/ycDOgxkpusdjdbcn1TqdFxD2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004720; c=relaxed/simple;
	bh=1IL902/IVkCRIcWgw9vaYI8ue8ww45C7/e7boG7w0Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lThKRzJaV+cvJ+QydKS5w4qcicpjQPchyT1n9jfbQhchJjm0jBOYaiAev1R1ogw0BtkYPipQqd5iHYbAkoiwnkCKi8TeMklMRKDWQeBm+t3/RJp6Lk2DuB90xCU4IGBabmJohl/MZwKXOcnNl7P2ApEL9BZHJVYSlWGBp1o/34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=w13qzFFF; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740004716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eWFtox1rlHhictQKUiNJN4qhCg63NKOrJUDaxS7WmHY=;
	b=w13qzFFF2xO+dwpoJd1JijXVBioIe1K6fty90O6yPaYcMHYZHZqZQFBXJVIQyG1HG2HDBF
	YGQxl3vz4WWyq0UHpZ19sE5jhlcLHAQfOVg+YH3bGKLWaZLh92FZuWYDobKAUfmsQxGLCJ
	TgFkn8ZyX2OfsqazQrufxMZUb+wiSgw=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Date: Wed, 19 Feb 2025 23:38:33 +0100
Message-ID: <1939631.tdWV9SEqCh@sven-l14>
In-Reply-To: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
References: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2240570.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2240570.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Wed, 19 Feb 2025 23:38:33 +0100
Message-ID: <1939631.tdWV9SEqCh@sven-l14>
In-Reply-To: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
References: <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
MIME-Version: 1.0

On Wednesday, 19 February 2025 23:09:58 GMT+1 Sasha Levin wrote:
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
> 5.15.y | Present (different SHA1: 72203462f255)
> 5.4.y | Not found
>=20
> Note: The patch differs from the upstream commit:
> ---
> Failed to apply patch cleanly.


Was this patch applied with or without the already queued up patches from=20
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tre=
e/queue-5.10 ?
They are required for this patch to apply correctly.

Kind regards,
	Sven
--nextPart2240570.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ7ZdaQAKCRBND3cr0xT1
y8HEAP4z+Gz4+Voz86BxEpr0w8WHCK+fz4LQzm4Z06wqfXmmkwEA8XBWSS9PKTN3
UIsR9dU2HpN5owkJ6ExKEhnSnn7DegY=
=QXZ9
-----END PGP SIGNATURE-----

--nextPart2240570.irdbgypaU6--




