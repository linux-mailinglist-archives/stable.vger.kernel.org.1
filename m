Return-Path: <stable+bounces-131848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD0A816D8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7514C7D9B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3F253B41;
	Tue,  8 Apr 2025 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="E/Hmb5l1"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C6252905;
	Tue,  8 Apr 2025 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744144072; cv=none; b=t+Dao71Be/03+Xn7TeC55mTVMthy2Qj2JWlalnao0gCWDdU2paSGPzweE45mQtkJoVV2ygzyEIWGA4vGvOwO2DGN5q/g/iroLF926Nll5h2hsu1LuqJjt1trwf+t6qTMdN3TAq0dUcqC9XYqLFzUepklGfN78a2g6yg6kLhGv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744144072; c=relaxed/simple;
	bh=XXuQ5BRCj5Kyg2s4GK9xzXOXlhqWC/lECSiXee+NhpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1s/BmYS/yZK1/SBVYVdyQVLLcti1i6rWjA3aRvl8VkvnFfGE+lG+HSOy13H2TrmuFFZOoQ7hKdIDWdDlxodSlA3D3sBXkzMqgXB8jk+tFfyuQSuBnzQwjemjs/UVwDXHUR3PVb8eiUbHHoL9nkdLe42NZEQhJE4YrgD08rxSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=E/Hmb5l1; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50BFA102F673A;
	Tue,  8 Apr 2025 22:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744144067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rZKXR7ncJg0xUJxjw7lbGcqPvtZp4DGpWIyWUfXB+mA=;
	b=E/Hmb5l1bCWS/CaCna91BOLZI2wwgIpoM2HERb1CsiGiWApMEeK5nHqlwirYserTKWcQTi
	TfDSSoHWEMoFlHEuvIR5x5ObypwdeCIHMHOvg+b7r5gDtRnAOr1oA3dZFYVW5eYBlk+0Ns
	KM0i3+nsKNsj18WrIhLQazuqwP99LyI7IW7oiAECRGOGw7cX0AQyy15zWjq1WLdHCaVk+N
	U84heAXv1VpfEQlhbpmcoh7ISu/NE0LKdEZJQL47keECZ4HB4OXXMYsijVVUcfuI1SPwX2
	VSLTVDq1V4U9ffXl5blSYx0D9p1H5xRyCw6hIMP56G8e0KJyGowYoI6y/CI1DA==
Date: Tue, 8 Apr 2025 22:27:40 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/204] 6.1.134-rc1 review
Message-ID: <Z/WGvImLW8m8q+9h@duo.ucw.cz>
References: <20250408104820.266892317@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a3sgVt3/FSOInDj1"
Content-Disposition: inline
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--a3sgVt3/FSOInDj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.134 release.
> There are 204 patches in this series, all will be posted as a response
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

--a3sgVt3/FSOInDj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ/WGvAAKCRAw5/Bqldv6
8te8AKCeW2SSq1J6+XFfbQqliwg7V5c0JQCgnHH9Zj2icBDc4R3qe3Jg/7cILeA=
=uOXJ
-----END PGP SIGNATURE-----

--a3sgVt3/FSOInDj1--

