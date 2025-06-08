Return-Path: <stable+bounces-151954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D710AD13A1
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167413AB005
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EF19DF41;
	Sun,  8 Jun 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TsETMigi"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2B194098;
	Sun,  8 Jun 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749405305; cv=none; b=qTTK2izxsXeKp1dQ6yIcFEal5ZvqNJxCPv5TtXt3jMOrPxEqCcq6N6Komk7wiQd6+QCq7nogx9HszLD7zohRQlOiNzfaar2Xqzmhj+BMA2SRtVP6XYbJduXiHnpiQNMNuMkZrE1OoaJdW7ogMbFlavY7i0P+jmaOpbA46EJe/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749405305; c=relaxed/simple;
	bh=uoX2DuRW1fteJOAAx0KBkfxJHyR+lhgotBks4+PS43c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV2nkSTgA7wuGBHCiZrxSc3usnnHVt8wkv/BFJpkyMvTXe6zvThsWcguQswkZ2w6SpUGedd0lh3Dfo4g3HVbTmjr3zKuzT9Y5biaCE8MoDIVu3J1qAEKK2M5IFMSIcPnIgyUfN7a4Qaf0bVhL9YJ968jqwqNFvGoiAwzMPecSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TsETMigi; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8FC510397298;
	Sun,  8 Jun 2025 19:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749405300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9HcY15vu+KVNkIemPXJdgE3BtXxnw2EJFwL2jpGDlVM=;
	b=TsETMigidVg4Y7N62V4NBEY6M23SEzDwE9vR+baMal6TmFJpHdZa+5VQBTLhYuvUVbEm3F
	Y7sewlclvyz0EExya6B9wQSvTTrqd3zExjdIHHxC8iSOlpJYqodnR3w+L0Rb8l3C5vYOM4
	gA3f6asCr3ZwuNbaVeR9mT6pB1GoH5zy+51oo8Z9AB5cWGB8AvxHD6TXcqD5dSNPZHf8PA
	mdyLnkCkQZTdFq3Er5BsG065OiB8FcScCLBl8AEkKVxWFxJWyT4ZYveJHs9OKUheMs8/qF
	ZiiFTy3bhTezW3/pikPx4lT/ERqkOOXlTbZ6/5+BNZhYOeplil6n1AdES4Pleg==
Date: Sun, 8 Jun 2025 19:54:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 00/24] 6.14.11-rc1 review
Message-ID: <aEXObni734dwd251@duo.ucw.cz>
References: <20250607100717.706871523@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IGNC63kLIJNIKon"
Content-Disposition: inline
In-Reply-To: <20250607100717.706871523@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--1IGNC63kLIJNIKon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.14.11 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.14.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1IGNC63kLIJNIKon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEXObgAKCRAw5/Bqldv6
8q09AJ9op2Tvr68BFh6iJNO6Z3YSW9J+BgCfe03h4VzEQw6PeVteOUPnizCUWsA=
=D355
-----END PGP SIGNATURE-----

--1IGNC63kLIJNIKon--

