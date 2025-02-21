Return-Path: <stable+bounces-118631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A0A3FEDF
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793B9168579
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E71FC107;
	Fri, 21 Feb 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="PZzZdVBt"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA551E9B09
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162770; cv=none; b=b/uaVMmzH1XOUAna9bTkiSYYuLw4azgCFEfL0QWRj4EHVlEktxu4nB0TgZm21kCsYg8+Jj0FVSSARiYmSeB3GTgSHASYFHG9C7Z8h2OHs+QKVUahIDAGIgK2hWgK7Y2KCyGAb3tMqHreXwimcar1EpcEDxoi+Du++ahR4Vv/44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162770; c=relaxed/simple;
	bh=1wXoHj4YalXCLwHFlrFl0ZRTLaB8wRyrCsGoaDczxSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRhBa7rAMyaTOCNSdek9FzPsepRaUDLbysnESWa8yZn0FtLfa+fzdnHMOxEF+oWFTNwcSQ81a8ChYV6DhVNbeHWoSZHXhncCfF/KG21aNSsi+lnPoCDlHEaSUEZL4ilUmsqrXNl7R7lIpvsEHw55pZjtdYHGoV1+6AMKU/WFCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=PZzZdVBt; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740162766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0maluwGgxutRgX14YHugBpqTJpGuQb5ka3VWZSifqk=;
	b=PZzZdVBttc0fGRLjeS7w95HSQOamv0+Yer1tdUGRpjB3wypW6tmmsrTaeMnI6p6AkEz4py
	9/QUq9KcN3DzkMeaBDqh50lPPvVrwiEqCAsVd+ItZph4mUKxLFMDHTkScuTvPYcZEm1iSj
	cTGDfTM8U2zX0M2G1f34VEYH+mdQQOw=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: Drop unmanaged ELP metric worker
Date: Fri, 21 Feb 2025 19:32:44 +0100
Message-ID: <6025110.MhkbZ0Pkbq@ripper>
In-Reply-To: <4657309.LvFx2qVVIh@sven-l14>
References:
 <20250219165451-d7aeabb8444db978@stable.kernel.org>
 <4657309.LvFx2qVVIh@sven-l14>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1818345.VLH7GnMWUR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1818345.VLH7GnMWUR
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Fri, 21 Feb 2025 19:32:44 +0100
Message-ID: <6025110.MhkbZ0Pkbq@ripper>
In-Reply-To: <4657309.LvFx2qVVIh@sven-l14>
MIME-Version: 1.0

On Wednesday, 19 February 2025 23:38:07 CET Sven Eckelmann wrote:
> On Wednesday, 19 February 2025 23:09:53 GMT+1 Sasha Levin wrote:
> > [ Sasha's backport helper bot ]
> >=20
> > Hi,
> >=20
> > Summary of potential issues:
> > =E2=9D=8C Build failures detected
> >=20
> > The upstream commit SHA1 provided is correct: 8c8ecc98f5c65947b0070a24b=
ac11e12e47cc65d
> >=20
> >=20
> > Status in newer kernel trees:
> > 6.13.y | Present (different SHA1: 7350aafa40a7)
> > 6.12.y | Present (different SHA1: c09f874f226b)
> > 6.6.y | Present (different SHA1: c8db60b2a7fd)
> > 6.1.y | Present (different SHA1: 831dda93b13c)
> > 5.4.y | Not found
> >=20
> > Note: The patch differs from the upstream commit:
> > ---
> > Failed to apply patch cleanly.
>=20
> Was this patch applied with or without the already queued up patches from=
=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-5.15 ?
> They are required for this patch to apply correctly.

Ok, now it will definitely fail because you've added your own backport..

Kind regards,
	Sven
--nextPart1818345.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ7jGzAAKCRBND3cr0xT1
y9iGAQClc9J5Ro3ktEXgUnY81cAkoIeIGsu+O3sZVpx1sfcPLAD+KpxkNH3kixXe
UHG6a4Yz8+5MAQlDr6K5mTa+TizIaQY=
=GNsl
-----END PGP SIGNATURE-----

--nextPart1818345.VLH7GnMWUR--




