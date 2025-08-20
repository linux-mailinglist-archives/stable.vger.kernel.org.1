Return-Path: <stable+bounces-171871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED70B2D48C
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388DF1C40414
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EDA2D24AF;
	Wed, 20 Aug 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Uj7RxlJ8"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A3277C80;
	Wed, 20 Aug 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673916; cv=none; b=X6yvGSMc0SvW90TL8r1umCtRc0LfpOVXLkX9iIfV6x0HuPOdCvmQbpff9QOScImEKd+8W5hEKqUJBUyow59BclywcwHJ56i/Zw/wjWXMWMYIZYkzebt59JAa5a+ahzBLhziZR9mWgk/WpJK6zvEdLost3GwZBDj9RldPUrcHfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673916; c=relaxed/simple;
	bh=0My0nruW+wtQVHOpDq41hwdibx0GRaDbU/OUIU5WwkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqN9YNcu2LqwsnszSr/tnk8/4DhyXM8hQN5MFRSrhqXcF9qMUZItMudkADLflhiaK0Of9cyxbxyRAYGmASVhM19jaqjWd2bzTs7y8a0rYFQrrslUbVnI1KSqYzgk1BArwDo1MVS9ReYuvG/UnL2qmfNc3oJJ6CEtafXrLFcr8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Uj7RxlJ8; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6450510391E95;
	Wed, 20 Aug 2025 09:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755673911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QWK6fDo3fD5ZpwL3KEaiHhSHjSMwZsvwVvTIf4mXTrg=;
	b=Uj7RxlJ8PBL5nl/xumb/vuyXx4TQIMmoXYBDODvake4VDdt1wI23NFsi1RePhzWGMKeyUV
	CWO1q5iIuoxQID5edJ4pSd3IjZQkUjYTumhEORBwKZpITLBFQX/6LkKWh6eYmdCvtFz8i9
	C/rKtPqhHrU4Fw0zCc6QWmp7dVG0ZM87AYcYYCa4ZcjRsPQPcKvUfTciry4zBnYNTwR3r2
	OIgFAFRkF1vvA/Gq2Sek0lkHH8wyj3mCsd0UHbtj6WVkfl2KceWPahed3R7W7j03WfsnuU
	5ZD/zu4WE1Be0Zeisw1JE9ld2Xh2yBIoGreU/pErLMoVQB4GrXfJ3un0nm9C0g==
Date: Wed, 20 Aug 2025 09:11:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
Message-ID: <aKV1LlA1wbzXaSWq@duo.ucw.cz>
References: <20250819122820.553053307@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW6hhxMXnlKkMv/8"
Content-Disposition: inline
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--MW6hhxMXnlKkMv/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

6.15, 6.16 seem to be okay, too.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel


--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MW6hhxMXnlKkMv/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKV1LgAKCRAw5/Bqldv6
8o7nAJ4xtK4HN6/iP1hiAOqmKPh5qFqaXgCgu5Wvk9riKfJdn2bxz9K5F1EIgjw=
=3Cp9
-----END PGP SIGNATURE-----

--MW6hhxMXnlKkMv/8--

