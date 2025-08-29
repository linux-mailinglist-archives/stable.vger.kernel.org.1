Return-Path: <stable+bounces-176681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA955B3B2E0
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 08:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A53568122
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 06:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8245E1FF1D1;
	Fri, 29 Aug 2025 06:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AC216E32
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447413; cv=none; b=CvOJ63Qj9LmjyMQuCs4he5BJiylvSAdAIpsMSotN3MI3mfX+tvRZDjz8MEl5+diYstTCcVfmpUXKWLM/zdlxHeTjbAWx6DAwBN0dqGSJ2hFXiYGNv7G63CTMT3QEbIKv2x0iMzmTm+uUGHMzsVr4zm8Tb8YepMuQyP4c3v1wH5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447413; c=relaxed/simple;
	bh=RDU5MeTuDuySpPFewMtdjUwt9JMdY+Vo6HVaO3FpanA=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=J3OXdAhfsH0XmlqM24IIZ2moTyD4A1uGwdDzexpt7N6nPY/+Q4CXOEbvseYywzCuBtQeAMzRotaRGbB8sx50z1BpIUGKzCkPlpO/WE/aVb4WWP8ZGKhG2hs3LCzWLyC9Xf2Ycy4fkc87q1R25AODJArV/QSA5e2HNLkSXKrcGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [192.168.0.1] (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0C571340DB0;
	Fri, 29 Aug 2025 06:03:30 +0000 (UTC)
Message-ID: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
Subject: 5.10 backport request: ASoC: Intel: sof_rt5682: shrink platform_id
 names below 20 characters
From: =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Date: Fri, 29 Aug 2025 08:03:27 +0200
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oMNL343h7vNdF2SpnZHI"
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-oMNL343h7vNdF2SpnZHI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to request backporting the following patch to 5.10 series:

  590cfb082837cc6c0c595adf1711330197c86a58
  ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters

The patch seems to be already present in 5.15 and newer branches, and
its lack seems to be causing out-of-bounds read.  I've hit it in the
wild while trying to install 5.10.241 on i686:

  sh /var/tmp/portage/sys-kernel/gentoo-kernel-5.10.241/work/linux-5.10/scr=
ipts/depmod.sh depmod 5.10.241-gentoo-dist
depmod: FATAL: Module index: bad character '=EF=BF=BD'=3D0x80 - only 7-bit =
ASCII is supported:
platform:jsl_rt5682_max98360ax=EF=BF=BD

TIA.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-oMNL343h7vNdF2SpnZHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFGBAABCgAwFiEEx2qEUJQJjSjMiybFY5ra4jKeJA4FAmixQq8SHG1nb3JueUBn
ZW50b28ub3JnAAoJEGOa2uIyniQOIdsH/ix546il59MQYpRwSexLfRPjQsy4HRn3
EgcW1pnarp/FctZ9t6EwCrbC7bWkBFxGI0zJtcYEZeCmxnzftxWC4yTWblTxigze
R9jeYD5VJS+637OHYJpnbYgAc6N4HoStxnb2OoyZ+pYOTDTOcqeRvfPtt5byBJOh
f4EK47z3VV+LGT6u3CzHzGk4a+EypRxPtoOBkL0omj/rfOJ7D5oWqf6pYrXh0Xbu
gTJx9BI9uhxgOF38sM89qVyezNYuVQBWMnsWSSJy9fhAYsDbhmy8kZCCtDnbRFNy
zGJ0hxzKcf6z3F8bRE8gTBjZEv3DlCCgDEECAJVZaVn1yPkJiWNzktg=
=Nh0H
-----END PGP SIGNATURE-----

--=-oMNL343h7vNdF2SpnZHI--

