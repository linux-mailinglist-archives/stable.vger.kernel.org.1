Return-Path: <stable+bounces-237752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIPnLLf13WlolgkAu9opvQ
	(envelope-from <stable+bounces-237752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A93F6F1B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5170E30BC9B3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149D38B7DC;
	Tue, 14 Apr 2026 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="T15xJmLv"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927315E5BB;
	Tue, 14 Apr 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153777; cv=none; b=KbyfkcKtSZgS05EhMizmx2DlAk6b0JPDBp4wQP0nLh6PugUStI+l93X+AWDleSl4PeQehmejewz1dwCywVDjZ7EgnOSgff9uBPiHAZl0ynkvnZQcV0qvKQ7SMHKNB7ZHNpe2h24ydE1mM/Y7StvdLKHXAZaOIiyR48oKDJ6OC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153777; c=relaxed/simple;
	bh=TgZ1xryqhH3dhCiAul25nJYvdwZ1cXIBuW/9yPoctCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh9quEHaOJrj4Oz3FYC9tU2qIyUvW5EUfnNCzRxmtrc9UY5Pl14TSraEbbjKqAGvfdjN7p7HQ6Ss8qcIymDKtu03I6L9vTzfz5uCgxAIuhrXvOJ2fN4WPBl2MTL43CPZj6ih/BIoDxpzCI3u+mmGik9dMPHnk3iWceF6g1IA2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=T15xJmLv; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D720112404;
	Tue, 14 Apr 2026 10:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776153763;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1gupBawJhk/S1dJ63WSl3J8HMDhD+h/6bK+mZY9+lhA=;
	b=T15xJmLv1FBZgFYYI3PjqbKA+UAApe8tHoB3G3LHDOw4FABDvvxvcuIYfEuSsShldeBEfM
	hSVYbcNUR7Vh6oXmXMEdmTVWvoRNQtusBAo45+aMMW2H0QxO/5flBUQTC5OAvEVBYwm2oP
	us7sdEWbTvKEaQftMv4vYYv3YBc9QkqiE5NLnaZ6zD0HXdN6rTfBmn1Bt/gfwU2fMzlclg
	uCG9585AhtcgnT2X6Bo/auP6GffsAA2ijjLiU0nU81yXtl+IguRp2pKcVihRL82Tqiq2Fe
	rKmtnlXQV9RpSX3C91pTk9q8khLqZiYu6VEjF1JUOABzI2w3rzg/mh7Y7UwS4w==
Date: Tue, 14 Apr 2026 10:02:38 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.10 000/491] 5.10.253-rc1 review
Message-ID: <ad30ns8QQDzk0h72@duo.ucw.cz>
References: <20260413155819.042779211@linuxfoundation.org>
 <39e878af-7418-4538-9e1f-8b62de3d1e3f@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ifr7Q8hCnjDix33"
Content-Disposition: inline
In-Reply-To: <39e878af-7418-4538-9e1f-8b62de3d1e3f@nvidia.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[gitlab.com:server fail,pengutronix.de:server fail,nabladev.com:server fail];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-237752-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[pengutronix.de:server fail,nabladev.com:server fail,gitlab.com:server fail];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,gitlab.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 564A93F6F1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--6ifr7Q8hCnjDix33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2026-04-13 19:52:08, Jon Hunter wrote:
> Hi Greg,
>=20
> On 13/04/2026 16:54, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.253 release.
> > There are 491 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> > Anything received after that time might be too late.
> >=20
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.=
253-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-5.10.y
> > and the diffstat can be found below.
> >=20
> > thanks,
> >=20
> > greg k-h
> >=20
> > -------------
> > Pseudo-Shortlog of commits:
>=20
> ...
> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >      bus: omap-ocp2scp: Convert to platform remove callback returning v=
oid
>=20
>=20
> I am seeing the following build error due to the above change on ARM plat=
forms ...
>=20
> drivers/bus/omap-ocp2scp.c:95:10: error: 'struct platform_driver' has no =
member named 'remove_new'; did you mean 'remove'?
>    95 |         .remove_new     =3D omap_ocp2scp_remove,
>       |          ^~~~~~~~~~
>       |          remove
> drivers/bus/omap-ocp2scp.c:95:27: error: initialization of 'int (*)(struc=
t platform_device *)' from incompatible pointer type 'void (*)(struct platf=
orm_device *)' [-Werror=3Dincompatible-pointer-types]
>    95 |         .remove_new     =3D omap_ocp2scp_remove,
>       |                           ^~~~~~~~~~~~~~~~~~~
>=20

We see that one, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/139011=
55305
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
450043152

Best regards,
										Pavel

--6ifr7Q8hCnjDix33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad30ngAKCRAw5/Bqldv6
8rxYAKCxwHUuJ1AM452hBMTY6vKmNZ+3IQCgwaxjVXJxZT95XYc9TUuSm70yvvY=
=5fqQ
-----END PGP SIGNATURE-----

--6ifr7Q8hCnjDix33--

