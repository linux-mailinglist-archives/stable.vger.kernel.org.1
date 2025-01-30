Return-Path: <stable+bounces-111754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BFFA23727
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FE73A6335
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24D199223;
	Thu, 30 Jan 2025 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="dR6ZW30G"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D71DA4E;
	Thu, 30 Jan 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275617; cv=none; b=YsMeF1cPzC24BlpbEENLVVNnsVvvjW4l2Eyln5zuVogsN3gpRqyXEka8HwBqHrvJcsVjlBk3q40OLg0XHjke5IiudaD+PG6aOf5pamUxtD7X/XYrbKb91UVKKkQUa79tWsAdRhM43M2HfuD/UGUxhIosolh3DMYvGs26x6w0YjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275617; c=relaxed/simple;
	bh=w1f8CG1ig3eKWA8U7j+Ttjl1EF4PLZxZ8w7ORz6B1dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqP2HCy8WU3QsPh9GuI+zLK1D+VBPbtOdl4raoI8Q0qFXVzFA30TfGHKQs5ImYYE0JUgKq9UqCa30OJr4EnQI6IwMYz3ex/L9MKC5XyOnv3s+1VfVR5DG4rFIBmCvoxc53+DJ2X8XeslVynoFcndwR90JTK3zPuknKnt9RTqqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=dR6ZW30G; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1ADD710382D08;
	Thu, 30 Jan 2025 23:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1738275604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hv4lguFyEdEcn4zVUznDqV484ai2n8g16Id26gKUeI=;
	b=dR6ZW30Gx1nBz2DwC9rW3l9G27ZafOM6+D0QeXhIaW5ZlJlXjSzXTIGmwmCz00BPK25jjM
	AMBB9+mvqGOIMaII2XuhhBP3TFC5lDq/lICMrOIjrRWnQHdpVJn6RJjsSp26Dfhff6dvhz
	9RsjQvkZJIgWF2NXk4Wi+z1DuGvgzh9XOOoiXO4PV+3fHxG/sDxy11jZIGU3dYrAsP9C9E
	VkN3L3RJEYlEkSzeaW1keSwTZf9+M8XVi/MIEmksncdvTai3U2gRLjvurrIVUW2VBET7Ld
	j7ihrL+f82/UgsvtRfOUe5eQUJpp8Q9QK9AVCV9CewIMUESQEMWausHzHIZGcw==
Date: Thu, 30 Jan 2025 23:19:54 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/133] 5.10.234-rc1 review
Message-ID: <Z5v7Cms+SPbgV8tY@duo.ucw.cz>
References: <20250130140142.491490528@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QLIZjhQb0gXyIytE"
Content-Disposition: inline
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--QLIZjhQb0gXyIytE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> This is the start of the stable review cycle for the 5.10.234 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We get build errors on risc-v:

drivers/usb/core/port.c: In function 'usb_port_shutdown':
2268
drivers/usb/core/port.c:299:19: error: 'struct usb_device' has no member na=
med 'port_is_suspended'
2269
  299 |  if (udev && !udev->port_is_suspended) {
2270
      |                   ^~
2271
make[3]: *** [scripts/Makefile.build:286: drivers/usb/core/port.o] Error 1
2272
make[3]: *** Waiting for unfinished jobs....

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/900058=
7039
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
648756200

I believe we hit similar problems in 6.1 before.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QLIZjhQb0gXyIytE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5v7CgAKCRAw5/Bqldv6
8hKvAJsGkAsgHNq/NgNydXdSNV9D9e12WgCgjPPCNSHSco/VHqulYkqRYF0LOtk=
=yq97
-----END PGP SIGNATURE-----

--QLIZjhQb0gXyIytE--

