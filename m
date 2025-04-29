Return-Path: <stable+bounces-138947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51924AA1BE9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7169C1BA53CB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756F261362;
	Tue, 29 Apr 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XzHCLtkI"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F41DE4F3;
	Tue, 29 Apr 2025 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957830; cv=none; b=sXqk6KR27iuJJuXZ31qeQjW9GrmgBvpMz5xrYfU5QDm/uxjwvqPjhwx/ZiWsYWN/ym/RMvIKYtrMnDFv3DJv0ZUePWZUJ1pITiLQRpRSLa/LdROv0RWOXar/V53/UgQn58fY06uSsQfY5jyMXH2rhBZPeh3rhWCSwko7fjjwxgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957830; c=relaxed/simple;
	bh=hFBTMEmaHf6s2MBLUN+i3MPudnyjQ5inJc+P6QHb/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heFMMYbZoOAH3r/q7CH44+QztMrUSnHHcfoSCSC9dBBmj0OWWAxwdTQ1Z021TCw8DT1CaoHgAj0T94cymS+pGm5pMsqsQzjjEOGVBMIL34PHMYDIQT8SIVK3uHaH8QYV6YBLYZ5WbNCv7xSgS3ngN4aMAig0yKZzx3iuke2ilK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XzHCLtkI; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FC6710273DB0;
	Tue, 29 Apr 2025 22:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745957826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4j/yiV5NKpHHxjQpGZnyDBnPZwZOAa4wZQq4VLSzkoM=;
	b=XzHCLtkIcE/RBYTqKDPlGdGI7OXx7+oZMHFlpZj9JK7HTCLhNKP6sdEpAcTf35uZGnmg9O
	QWnosW5y9Rx3Dq4uPzv6MPVhj59WIjhdqW2dFB7T9NyEORHom71fYr5+STI3a+Jm+qJVs7
	0zHoNRzb5hjXjohdyRlmuk1oS84NHfTiAyXEdcxNpxhA2oENcTpm5GQQ7PSSSjoiU+0F3L
	nPbROe8ZuoWVPDPLYA1j2HWaCznUTGz2O73uyWIFCdF1yRrBp2D/6H9jaYZjoPvvY806yd
	6wG6bI96jn4KAYDsXEXvYAE9Bg76lEPJ8xhL72IQ3IgWczfgyZFUemx5GJoQRQ==
Date: Tue, 29 Apr 2025 22:16:59 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/167] 6.1.136-rc1 review
Message-ID: <aBEzuzBVkyzGnm8w@duo.ucw.cz>
References: <20250429161051.743239894@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/80VTIZSwblmNnJ"
Content-Disposition: inline
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--w/80VTIZSwblmNnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.136 release.
> There are 167 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--w/80VTIZSwblmNnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBEzuwAKCRAw5/Bqldv6
8pwBAKCF1Dfk/0Ah9a2XYAVlPz05ynfjdQCdGPK/d7s5QhrRhK01NG57uQY/8Hk=
=Ijli
-----END PGP SIGNATURE-----

--w/80VTIZSwblmNnJ--

