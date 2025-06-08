Return-Path: <stable+bounces-151953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C6AD139F
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 19:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFCC1682CA
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5819DF41;
	Sun,  8 Jun 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gWDKBh3l"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CC194098;
	Sun,  8 Jun 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749405245; cv=none; b=JvvgHaljGMePcgUY8QLTJp3IeC9xZxJPaYNvTKPrNCwGEY/PPUy2Wm3vDAXRYICXqsJXB7XMHHa1R7/UV22TqCxg9/NrXFU9nd9vz+7XNt0sSoYWTNYDWfNdCmmZeJAQrF4OCbx6nU18NKsihU4B4AuAte5PqFQPOtkdHOk91Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749405245; c=relaxed/simple;
	bh=DYNGyy54dIQZ+yASfRD28QurH5y9Icczf3Z8e976bAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skt1WbA8Pq0eRM8/Va79WKnpTDAqVZU54IRIv3MRMmmGsqr92/LUqY7bue6iIa738sNJqIzRbOmUPEXxWVdNJPsgc/gtovMOoZ8cNkkI1SI5d8w5Hn8K388ugHd70XRTk/c5BPRDO2NMeiDW5x+UfZiEcnSDnitxQXZdqHSirlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gWDKBh3l; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A08A110397298;
	Sun,  8 Jun 2025 19:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749405239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6SR1HHxqpvhPr125Ug92SYZ6Kv0xs3/+dZrKaa/IaIQ=;
	b=gWDKBh3lWNK9SJ7+d+8ZDw4+M1LT+hCR4bIabV4ivMxw1m3ZL7bzjlVi3rCx1ItalLNteS
	vTePSsxICxRBDLr+R1kcsT4xwMejqI3gw9yQvDKIGZmZ03/P61iuSo91nBacCxwRSbTygJ
	fs628Rm7J6FM7qFhqGBIDymRnmOhwqFDzW2mGOGZfe919oC8R9DAGhONc+KImwlmriVgs0
	moUWcHbx4CScDIXNcm5hjcHixfrClAqinlILF6B/ZcBQwfTm1XSgrTAU8kBuCTN4yOWjS1
	I9PaoKco1Fr6zjTjhc+0tAvb/wdgmldkznR+Spr1lMQrJdrPqNx/ubUHTWM65w==
Date: Sun, 8 Jun 2025 19:53:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
Message-ID: <aEXOL7+Ywuln9wS8@duo.ucw.cz>
References: <20250607100717.910797456@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Asto3FxhM0duGw7"
Content-Disposition: inline
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--+Asto3FxhM0duGw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+Asto3FxhM0duGw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEXOLwAKCRAw5/Bqldv6
8sUgAKCw6yIwimENhy6etWedi4GeCjdlHACcDOOH5u1w9mjoa+ezBPROBgi8E/A=
=eY7X
-----END PGP SIGNATURE-----

--+Asto3FxhM0duGw7--

