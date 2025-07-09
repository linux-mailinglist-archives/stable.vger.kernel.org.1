Return-Path: <stable+bounces-161381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A7AFDF48
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 07:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CCB1897377
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191E13A3F2;
	Wed,  9 Jul 2025 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZLlVWrlR"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F201EEA40;
	Wed,  9 Jul 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039248; cv=none; b=IH2YFHmNHPiNT1lVAHQ/9gbjRbxVm2LdBmFBPpfqOESK4kSKLq7s8wQsDrH4rqNpUlCD6rXrUuxzpBci1lR7BuP+ULA2xYjsaahw+/AK9D2jOo9kFDPaAmOJSrdc7fSWAwgLc7NDdlrSmd6fyTiePV5CA8EeiElO1+DSXhK5rBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039248; c=relaxed/simple;
	bh=QhT5bjzj4QT5ngMYnr9u4GNkirMME41npjcUYSlz4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKGEpDG/LJbLz0qFrT/4OKsQdGUdScD+Vfj2C/u+qTpwzS+XvyQbxqHbVDFSRZ6KTjqHk6rP5RS8spjcfBTfdFeeFHyEKaqw985RoJZsYJ0CeKr7E+EcH9kmB+6/drsj7WrXfavN5scvEINjYsPjBxqcDmN1zztLEQibfMAYaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZLlVWrlR; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 621F01C00AE; Wed,  9 Jul 2025 07:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1752039242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svwnB+Z4890tufsaoGz9vRW/N/RBoDGCgf6HDoGv1HI=;
	b=ZLlVWrlRUQqnMifGmK3yjkLxLl1p7B4ZowLIPRsJOzvRmjvFiSiSid5Sd40vG2PMEOs85p
	4jQhfVlBnpSS/vQubGpk1igKOLft3dq8LDhyaUVHZqQiUzhAZqYzR3wnYJdU9LJFi2TClc
	1H6nRB/2N9qxKNQV1bmHAub/sBTDPRQ=
Date: Wed, 9 Jul 2025 07:34:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, "Eric W. Biederman" <ebiederm@xmission.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG3/SUPgejAU8I0f@duo.ucw.cz>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <aG2BjYoCUYUaLGsJ@duo.ucw.cz>
 <20250708204607.GA5648@1wt.eu>
 <aG2JzsVKuBkFcXj9@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9YTTCnEuj//7jxM"
Content-Disposition: inline
In-Reply-To: <aG2JzsVKuBkFcXj9@lappy>


--q9YTTCnEuj//7jxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2025-07-08 17:12:46, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 10:46:07PM +0200, Willy Tarreau wrote:
> > On Tue, Jul 08, 2025 at 10:37:33PM +0200, Pavel Machek wrote:
> > > On Tue 2025-07-08 16:32:49, Sasha Levin wrote:
> > > > I've gone ahead and added you to the list of people who AUTOSEL will
> > > > skip, so no need to worry about wasting your time here.
> > >=20
> > > Can you read?
> > >=20
> > > Your stupid robot is sending junk to the list. And you simply
> > > blacklist people who complain? Resulting in more junk in autosel?
> >=20
> > No, he said autosel will now skip patches from you, not ignore your
> > complaint. So eventually only those who are fine with autosel's job
> > will have their patches selected and the other ones not. This will
> > result in less patches there.
>=20
> The only one on my blacklist here is Pavel.

Please explain.
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--q9YTTCnEuj//7jxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG3/SQAKCRAw5/Bqldv6
8r2AAJ9LEsNHdZxl57bzpvttS8LUch4m6QCggkX8D97YgfYW/zLInEjyv8Cmn4k=
=9zck
-----END PGP SIGNATURE-----

--q9YTTCnEuj//7jxM--

