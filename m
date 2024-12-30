Return-Path: <stable+bounces-106572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889029FEA55
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C473A29F4
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF14197A87;
	Mon, 30 Dec 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FZLMQjmZ"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E683191F88;
	Mon, 30 Dec 2024 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586908; cv=none; b=ohY0kZOdmNejWYoFh1AzqtkciS7094+5S10NNjnqOPxqE++0EYOY5Np05Wi7DC18YE6GjBNemJqfss5X8otTQ5pbh7SZErzpqowXbhpO8hAnJdqzKvXDK0W8tj4RuAAPzqRa/c8iBsTiiqKpgkjp42Ya6kj3B87gFZ1S9B3YAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586908; c=relaxed/simple;
	bh=itZhel5mHr1kn33vzDJsY92Bvdv2grLdNhwuPD5QvZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7ccuu5QNfvRTFJCy5TXFLtpa0QRCHrv5dp3vIlMsSbLCQ2c+wIbw25sNJ14urHuDvoRuM6JOD9Dq+0aPKubKrUjmRDmNXJCPKUwxlG97dV5VPkmk3lHXOSQiGn0OlkUR2jjJN9o1FSaw0AkaNi3XO37RYwZAoIKkbd4TqM0a/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FZLMQjmZ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44014104811EB;
	Mon, 30 Dec 2024 20:28:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1735586897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LIGfCgHWChKFe+Jc17KnLeix4oRhobhy0lIzwSm8gc=;
	b=FZLMQjmZItqRvNXY3OqvaTjoupbVzjbFTiD9Qxly7VugH43414V6LDXKeXuK60GOxlqtBn
	JrwzidBDN+1kQmOJ2LpVxkA/DQOtvOtEJK3C2pxpJKZdcOJkLjjDMaKgg75U0Pqio42nHt
	HOGGam6Ot6isrMT1ripHi+fl648nzfvep07gV5q4cooV7zQ4qUx4kYPlWOVAZhe38ZqBPB
	wA/2dmMxpKIU6zQOViY75QiYAPRCoP/IFmg4W+W3d0pjRH2xq99QtwNQ2Sz7F5ceozW3Ny
	XiYCiy08Ag20VDla532gKylFTj+1sj8V/7nCsqYIoy+c2qeabTpss+cwbUudlA==
Date: Mon, 30 Dec 2024 20:28:11 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/60] 6.1.123-rc1 review
Message-ID: <Z3L0S7VislWo5jEr@duo.ucw.cz>
References: <20241230154207.276570972@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kZw8J04CcL2vipdw"
Content-Disposition: inline
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--kZw8J04CcL2vipdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.123 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here (obsvx2 target is down):

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kZw8J04CcL2vipdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ3L0SwAKCRAw5/Bqldv6
8rCAAKCgtD805aqctM7sFpzmWz91D8jutQCfenJ31Y9dkz9I/0FBf7T/tQyda9Y=
=TEGa
-----END PGP SIGNATURE-----

--kZw8J04CcL2vipdw--

