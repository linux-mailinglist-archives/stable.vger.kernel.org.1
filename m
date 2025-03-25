Return-Path: <stable+bounces-126639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F09BA70AFC
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F5A179B18
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDC5265CC3;
	Tue, 25 Mar 2025 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="J2IWJvPN"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D61F03E6;
	Tue, 25 Mar 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933155; cv=none; b=gk9Z/eBiIfwuN5ZZWtuYsAi97fIc6uxloR7oz4kjvgcryyAhUSlSq3sD9/XPfPjPlibnBpjC+TxMEHmdEfU8al6RP4y9kOUKfPncWx7wgFk3xnyCkpvv8QjaNuTO6FQyw9NRHjxvLoSktJNluswWl+QNdwBXCpp8wU8yQmG9WV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933155; c=relaxed/simple;
	bh=PGAkhABXnxd41204V2AYWG/wCmnIXbwKUppclXtUxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5vZieCue0jjKwR5xp6WneXnvMaFD5brPXo6O1uXn1ih9eRmtQIOhSK9vqdpgiRvlYReDyl5R6unI+1SGo0uFTh+VdlnzFD99LwuhizeT4F06hq/hnBxJVpGl6/7Uiar8gmv7eVlEns4mTZvnfgRc//DzdyLLnF2InWq6bojRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=J2IWJvPN; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97EC9102F66E4;
	Tue, 25 Mar 2025 21:05:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742933150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=KyyxNsONepDd2/RuTEcl4CgAsXJouk0NlQPd8mFXAXI=;
	b=J2IWJvPN/AxoTiY918TLOq1AEiwiTIem7uJhyya+JTUxhlbsDf7AVoqjxWjeQfYYLnXXdy
	OdmH7Oen3EGguXqW8I4poLzoNuDcTznNK9nrt4xCpkB2fx/Fc8b28j5vpP0vPXufdPPQRS
	adyb8WUMZN+V8sSnzU6Hhy7jzaWPuIrzpYmy8FFCm3u49weBdf3HJqzW4nI/UlBV7sVcyl
	V6gHbqar7BTJQmjU6mYcXGj5i1Q31V/A4KP+8SGzK4ch/hJYfsKWITErZwtRO1riq4N8NB
	+zbhf0qLWYUPDQRaZZEDFD459KBFGZvoMIJ6sS0K84TAA4RZQz5Y5oBH++crvg==
Date: Tue, 25 Mar 2025 21:05:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/198] 6.1.132-rc1 review
Message-ID: <Z+MMmG+f4IGx4e2t@duo.ucw.cz>
References: <20250325122156.633329074@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPQuxGFZU6NtkyFA"
Content-Disposition: inline
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--CPQuxGFZU6NtkyFA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.132 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Ouch, and we see failure in xfs, too:

In file included from ./include/linux/string.h:5,
3824
                 from ./include/linux/uuid.h:12,
3825
                 from ./fs/xfs/xfs_linux.h:10,
3826
                 from ./fs/xfs/xfs.h:22,
3827
                 from fs/xfs/libxfs/xfs_alloc.c:6:
3828
fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
3829
fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use in thi=
s function); did you mean 'tp'?
3830
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
3831
      |                                                   ^~


https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/951826=
0339

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CPQuxGFZU6NtkyFA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+MMmAAKCRAw5/Bqldv6
8sc6AJ9bE+u8ahxgD+TLaAgPaZZC9FS5zACfThFXC6CUMnjdT42d6z4LigP78DM=
=yzlP
-----END PGP SIGNATURE-----

--CPQuxGFZU6NtkyFA--

