Return-Path: <stable+bounces-83652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD099BACA
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 20:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CE21F2164A
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD281494A0;
	Sun, 13 Oct 2024 18:26:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B633148316;
	Sun, 13 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843982; cv=none; b=uvZ6IhmljhOq0z22Uq1PuPqxcApTc2ntKwb8rdRpNdmXjPdD9JSd2+OMTHUIIpRgOykdh7Kqv3IGAZSN1JpcbDoYm9YvJV+NJBz6ZJd/2qm7CD/2y9PDS+fUNNEwN0Fy6kkQeVMu/SXGdLSXHhu9NKIiACIa1oknDpO8naacmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843982; c=relaxed/simple;
	bh=QisvjnGbifgd9pnDqEKpWVCpLKpYJz/EEYQg7M4jCqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTagS9f+y2ijVtBztq7Ii64MNOQVqvNIp3MrV2F3VZvQ1exVsktKSNZvquUSmfwiW2wzvOxLlxeC9yEBXH/WRTYNtKEkJqO09Kkpmg5dm4CdWRM3kRU9SbPxw9Ss5/G0vHQiiyQmS+8M9oL/YWcidXuyk39K+uFZw+Xmp+w0UVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 88F7B1C0087; Sun, 13 Oct 2024 20:26:18 +0200 (CEST)
Date: Sun, 13 Oct 2024 20:26:18 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>, Foster Snowhill <forst@pen.gy>,
	Georgi Valkov <gvalkov@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 1/9] usbnet: ipheth: race between
 ipheth_close and error handling
Message-ID: <ZwwQyngaXHi5yAg/@duo.ucw.cz>
References: <20241012112922.1764240-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OoRqfjySGkXljf4k"
Content-Disposition: inline
In-Reply-To: <20241012112922.1764240-1-sashal@kernel.org>


--OoRqfjySGkXljf4k
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

--OoRqfjySGkXljf4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwwQygAKCRAw5/Bqldv6
8uArAKCAqKGEct0dv67PDstP1uN13YemKwCfQn92hql2qtuFvreXOhK1crTAdeA=
=1NwS
-----END PGP SIGNATURE-----

--OoRqfjySGkXljf4k--

