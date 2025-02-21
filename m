Return-Path: <stable+bounces-118630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94CA3FEDE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2078F189201A
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91731F7561;
	Fri, 21 Feb 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="u/+2okWL"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA241FBCA9
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162765; cv=none; b=umtoLRt8BgIqWFk2owM/Qtp8Sq+LJuFs27ZatYKpyDBtHOvBkq/2+ftQNmhbgSt7Dq11EOmKytGFtqCQIUNRisOZZ4qVPiFD+J57hmIWhQXmq2jmXmG95pZaAJ9f340puMhcnUVaLnOK/M+FMwdwrozND5YzK3ZYLh3l5rYWBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162765; c=relaxed/simple;
	bh=4xH0fa9rC2ybFLI5hh2hbaY+qLQJTcc/7Jvej4twixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYljfMnARIG8Ze3GDTSegrp2lYoTQG/b+7SE58BXEvHmWb3i0UeFYRssaBGTHLxp1pBXXdcka3IMp3Smy0voxILbaNzmnT7GCi4GEE/N6HP9e8CCIGft1Zhnh+CBJsy5MRTP0uzLSOthxFRgnEgPa+sr1g4suSKoQtD+fNF+o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=u/+2okWL; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1740162756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=83mTXp3WlPr0dmh+edS5xDOoCK5jJKdV9wVYKPteUlE=;
	b=u/+2okWLLjXK+DmK2nCMygcUjbrpM7eo+oPFUP8IP6EOAZDxCkPbU0CO5mhirf/etQPZz7
	w4li71a7zHRUkqh3iz8LtA7dG1jwzkrsu2ajY06DyfIgoQxXr339IHD7kwD5+IMuFTdDJs
	SspmuOPjUdiuuqFrY7OQBOz8pfzvRG4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: Drop unmanaged ELP metric worker
Date: Fri, 21 Feb 2025 19:32:30 +0100
Message-ID: <3614082.iIbC2pHGDl@ripper>
In-Reply-To: <1939631.tdWV9SEqCh@sven-l14>
References:
 <20250219165644-edb7cfac3c0ce091@stable.kernel.org>
 <1939631.tdWV9SEqCh@sven-l14>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9410071.CDJkKcVGEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9410071.CDJkKcVGEf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Date: Fri, 21 Feb 2025 19:32:30 +0100
Message-ID: <3614082.iIbC2pHGDl@ripper>
In-Reply-To: <1939631.tdWV9SEqCh@sven-l14>
MIME-Version: 1.0

On Wednesday, 19 February 2025 23:38:33 CET Sven Eckelmann wrote:
> On Wednesday, 19 February 2025 23:09:58 GMT+1 Sasha Levin wrote:
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
> > 5.15.y | Present (different SHA1: 72203462f255)
> > 5.4.y | Not found
> >=20
> > Note: The patch differs from the upstream commit:
> > ---
> > Failed to apply patch cleanly.
>=20
>=20
> Was this patch applied with or without the already queued up patches from=
=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-5.10 ?
> They are required for this patch to apply correctly.

Ok, now it will definitely fail because you've added your own backport..

Kind regards,
	Sven

--nextPart9410071.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ7jGvgAKCRBND3cr0xT1
yzlSAP9crDuN/4sEqZp4jOTSm0H3kl1dELSsDNfICAeq+H2oTwEAu3FGmyZdsJq1
+VT0TBbY+6lBBxrp63Rakpbb2dylYg0=
=v9/W
-----END PGP SIGNATURE-----

--nextPart9410071.CDJkKcVGEf--




