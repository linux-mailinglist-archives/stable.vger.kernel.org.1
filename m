Return-Path: <stable+bounces-109412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA47A158E4
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 22:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB15E3A1C9F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACA1A8F84;
	Fri, 17 Jan 2025 21:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WWhYbGgq"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87202149C55;
	Fri, 17 Jan 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148572; cv=none; b=VG7/PZ40WrfeOs/9niLsgDYMWZCcsBVo4ZtbA+JNYQoDPdqiIA2KuWgo9XGtQxtoLFZnl6MQMWOWooni2OBkh59XwToV+5KWh54l1J0Usj3AQPWiyioQYIyjLdS56diRWxmb7kWNmrZaK9ZPJdfVV4zhn+Xu8TZfMJ7VBsiwAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148572; c=relaxed/simple;
	bh=nWEQx70NCwtwNPc1XNlaPe6/oXaDl+iP9y47p1jRxes=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMcTP8ZWSOtL7iElIlmGxjROjxn+hEm4dPv/c1HVoEVxLpmcOI0QmDi/k67YZMzd7AHYPX8DWEAGNRAJRQLShW8fpeFn+WGJIVt42XOTf5m2ZvoVzAeQSPcGHePei/O+Zeod6pj8W736yqRjyOFZuzQft4uJk6sFw15h3dffzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WWhYbGgq; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF462101D2388;
	Fri, 17 Jan 2025 22:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737148567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh/0Jzdkf3ZovZrFrS2H1TUALuhMd3aUUOuqhaBvLp4=;
	b=WWhYbGgqnUD7IHUYqtVi5Ao42tItDYT/bZwuOSTDLFweQpcjhAvoqJcjn3NfHOPYiX8eg5
	/Tgw9+R6flAwCCLtxhdDEFyOXbw5/A5zNIOiRLiMhgQHKcogrzmTU1JFQ6TBfkdt9yP2mT
	BZQZIuYlzo+OR7+EaBrxGBTQWNf9m/SzPzGsRGSNdmF4Gvj2L+gE5IHNIx6XiQKbp4OaK3
	agfnqeh4ahdyyJ5ab++gcnsedeqsvltmsL6etgO8G1H0eqMujKwabF6XcQBti3YZQ0YVAJ
	zPPTCQ3L2DwMVzeR8tylryqQQ/cJJztpQxmxnKKI0PFKfDFQS2wyFpqzhqHBvA==
Date: Fri, 17 Jan 2025 22:16:04 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 6.1.125 build fail was -- Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
Message-ID: <Z4rIlESGC6mwi8HP@duo.ucw.cz>
References: <20250115103547.522503305@linuxfoundation.org>
 <Z4evJUkzHauW+zOU@duo.ucw.cz>
 <Z4e+u8gj6BV37WdM@duo.ucw.cz>
 <2025011725-underdog-heftiness-49df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TOuS2KVQQGJVwKw"
Content-Disposition: inline
In-Reply-To: <2025011725-underdog-heftiness-49df@gregkh>
X-Last-TLS-Session-Version: TLSv1.3


--6TOuS2KVQQGJVwKw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Still building, but we already have failures on risc-v.
> > >=20
> > > drivers/usb/core/port.c: In function 'usb_port_shutdown':
> > > 2912
> > > drivers/usb/core/port.c:417:26: error: 'struct usb_device' has no mem=
ber named 'port_is_suspended'
> > > 2913
> > >   417 |         if (udev && !udev->port_is_suspended) {
> > > 2914
> > >       |                          ^~
> > > 2915
> > > make[4]: *** [scripts/Makefile.build:250: drivers/usb/core/port.o] Er=
ror 1
> > > 2916
> > > make[4]: *** Waiting for unfinished jobs....
> > > 2917
> > >   CC      drivers/gpu/drm/radeon/radeon_test.o
> >=20
> > And there's similar failure on x86:
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/1626266073
>=20
> Thanks for testing and letting me know,

Ok, so it seems _this_ failure is fixed... but there's new one. Build
failure on risc-v.

  LD      .tmp_vmlinux.kallsyms1
2941
riscv64-linux-gnu-ld: drivers/usb/host/xhci-pci.o: in function `xhci_pci_re=
sume':
2942
xhci-pci.c:(.text+0xd8c): undefined reference to `xhci_resume'
2943
riscv64-linux-gnu-ld: xhci-pci.c:(.text+0xe1a): undefined reference to `xhc=
i_suspend'
2944
make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
2945
make: *** [Makefile:1250: vmlinux] Error 2

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/888318=
0471

(I have also 2 runtime failures, I'm retrying those jobs.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
630005263

). I partly reconsructed To:.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6TOuS2KVQQGJVwKw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ4rIlAAKCRAw5/Bqldv6
8hQsAJ0TGzbekcSv5eUGhFEUUXubYqjAEQCeNSbnof5Wib7DZi2JlJKWZy/EAsA=
=4SBr
-----END PGP SIGNATURE-----

--6TOuS2KVQQGJVwKw--

