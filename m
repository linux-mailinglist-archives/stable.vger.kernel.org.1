Return-Path: <stable+bounces-83653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B799BACE
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 20:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E1E1F215D5
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B3614900F;
	Sun, 13 Oct 2024 18:26:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE32F5E;
	Sun, 13 Oct 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843998; cv=none; b=d0TgMVuYIai2/iJ/oZH5E9bf0X676UeVkaQtexuxar+I15MRu3/OiCNpTmjFqViDkQRMvHyhC6sbbKNT4SR6aQArnrKeYe/wdJgUhZcoW43mCH4lBe263hcguFkwpZ1KRG2oMqqAOE9awXReBTUsZkNRAQIhv5U7+raHYdts814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843998; c=relaxed/simple;
	bh=+uRFS1+6SrkRWkxX6UFXGh/pHtPSWUqfgSLSjt5ir2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qitfpBX4mhIObiAC55/eyX5gpxzBa+nxR0yNabzLFz/zofEvkCnefy4C96WBTN51MjDJfgKurbG9eLgX4rkbFFMR78cSENeynUrA6dGkUc7c55ngWX0/3r41PiqN/cUUpdJjkKpcwbDm91nanyFUUbzBxGQfWhWV3HEbAv17Ddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 33FB21C0095; Sun, 13 Oct 2024 20:26:34 +0200 (CEST)
Date: Sun, 13 Oct 2024 20:26:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>, Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 1/6] usbnet: ipheth: race between
 ipheth_close and error handling
Message-ID: <ZwwQ2c9DgVSFa7a9@duo.ucw.cz>
References: <20241012113009.1764620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="quvMNBrn+ugQDGWm"
Content-Disposition: inline
In-Reply-To: <20241012113009.1764620-1-sashal@kernel.org>


--quvMNBrn+ugQDGWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Sasha, please include cover letter.

This whole series is already in -stable, as part of 6.1.110 or
6.1.111 (and I guess that means 4.19/5.10 parts are queued, too).

It may be identical to earlier AUTOSEL series, or something like that.

Best regards,
                                                        Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--quvMNBrn+ugQDGWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwwQ2QAKCRAw5/Bqldv6
8m7uAJ9twFQDBitYO2cWa/h5dW2xs9oPoQCfQIC/s3C852Wbfd7ydoCTqYT0t1A=
=yuDY
-----END PGP SIGNATURE-----

--quvMNBrn+ugQDGWm--

