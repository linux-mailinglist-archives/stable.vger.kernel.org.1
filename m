Return-Path: <stable+bounces-121101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570E5A50B9E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7027A2212
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81059253F01;
	Wed,  5 Mar 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="BIsTq1PI"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C254848;
	Wed,  5 Mar 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203454; cv=none; b=swR13NokFDIcl5WbM7/EcQ3OwXHwBZ3KdM2ur/M8O8s3vSjnOTLLsLI9H3EM+FopGZxqeBGVjNM19m0gIs++5szqIeqMJCOnc1h2Z5dAs7mmWabIkIHILf3h5+OEvmUuyC2ZU5uIOQ1HE+s7Wuf6O+4vOVCyicZTwUAcwBbGsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203454; c=relaxed/simple;
	bh=9vhMP0zGanGCaeuvGfuPag6z9ZddLvLWl4w58eHuX/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhT/zvRGNrk9AA+S2zv2CM2/Eso2S2KFGY9kX56qHWeuI3FNyMblNpHpSbRbNpNgQbl/UIXIPTGc3xv7/YlpKAgPmOqc4C39WMP7R83tW0Ib5V0Q1OJ7924TyvSSQTBmGJFgyweSFv298Ru6duBYCYmZMG/rpydufezNEsSlWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=BIsTq1PI; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8988D10382C18;
	Wed,  5 Mar 2025 20:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741203448; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uLCLZyF9chiE2e+9nrAul9Rl8NcyHcKHK1QTFrk0MjM=;
	b=BIsTq1PI5qtbPGeQyt/DqwEb5IMeIXphj7ctU68J9xs+Fim40wfASgQBU1KCz3tDbF32Hv
	Q9Snhu6Und/L3DD/qcapgpcrJbbOugHFRM+brF44WfwSCAjYVHBlXwBrJGdF+QKOUwS4An
	LwifKGmFebM1u6d4J6+usupqlLuJ9ZuLwYIXA+6K1rtwuFs7HebM82CfYQ9nVw4avCQAFy
	VlUDJLKAcwsbs4RVcXNTq1FB+Y5wPFFLg4tVNUXHER+WUZht8i/h0waeGjXnf1jPcskGDO
	r69513fccWtbHF6gvUVm5p7/Kh1JCX2SG4+sm3Ox9BgFCtDdgQHsNhlObMv/9Q==
Date: Wed, 5 Mar 2025 20:37:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, conor@kernel.org, hargar@microsoft.com,
	broonie@kernel.org
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
Message-ID: <Z8in71h4nhXDbbCq@duo.ucw.cz>
References: <20250305174505.268725418@linuxfoundation.org>
 <891abe3f-af74-47ee-8f5f-b5d43f11d8fa@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzM4msC65fRIJi2c"
Content-Disposition: inline
In-Reply-To: <891abe3f-af74-47ee-8f5f-b5d43f11d8fa@gmx.de>
X-Last-TLS-Session-Version: TLSv1.3


--yzM4msC65fRIJi2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2025-03-05 20:04:26, Ronald Warsow wrote:
> Hi Greg
>=20
> no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)
>=20
> Thanks
>=20
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
>=20
>=20
> P.S.
>=20
> is it necessary to have all cc'ed user informed or should I leave them of=
f ?

Normally, people leave the cc list. It is quite important to keep the
cc list at least for failures, so we can debug them together :-).

BR,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yzM4msC65fRIJi2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8in7wAKCRAw5/Bqldv6
8tkLAJ9ZA3sUo9518cD4PqRro2WWD0ZvLQCePBHmtCIIM+bqGcNKOelO67OJdtk=
=/YrT
-----END PGP SIGNATURE-----

--yzM4msC65fRIJi2c--

