Return-Path: <stable+bounces-262033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gNY8IKnEJmoVkQIAu9opvQ
	(envelope-from <stable+bounces-262033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:33:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB3656ACC
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 15:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=gMAXgbv4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262033-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262033-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0B6302D53D
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184437C0F3;
	Mon,  8 Jun 2026 13:30:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655F371CE0;
	Mon,  8 Jun 2026 13:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925448; cv=none; b=P0I1hydbZdRHkluMgKaX2fQ6jO2Ih8PFuxmKsE8d/4U9z8LJbu/9QT88kvVr95xbobsiFUf8QTlGhb61tK/ZwcrcowoG3XmSGSllx7BXSnIdkN8zY4lDDO3aYe45dO8kPqYnMiU4tPc8njiRNGuF0ylOdXykMy3ku73b8xLUsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925448; c=relaxed/simple;
	bh=HoVxJrmNdNyKuTfgfkUcnzVzitIsrz0sFkGlO1oPAt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as1mho3lxegPIwEvYG4HoTH3NnN758Ua3E8SovFlD6cAJllz+mL9Cy1QRIRsUn4I5KRYvuYZHzotKTWjXY3cDDB/F+XuqT9e84eQhAzSSojAcbGofe8yeYf/SCiqnGE/xVH+R22yKs/15Y9jQ5mgoaOHIF6l0uUzJxPiu+SSvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gMAXgbv4; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A6A811587E;
	Mon,  8 Jun 2026 15:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780925444;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5HwpKJ/UIYyOBqZ/ZTusFSBPHXp/ne8z0sYRp/3RNGk=;
	b=gMAXgbv4aIYLrqsPZX0pyFHkG8u7Z2YF7QNCA0wWGkJok5gTkoExNiDpTHrE5BeXQCQz/4
	3x+tMhfUhhUywZ6ZljRclr796Y41qSyU5HtUfz9FSMLpD681kPkFqO1Wl7UY0MBSjlU76m
	lzFbEAP8nfQ9jpWAJwD/XAF5jWBWQ2RDZp0iSnGENm+x9mR1h9BCnMYPkbbYG02duB/9rU
	Az8Z942RQd2tpknQ+yVIOjoLcObFlE+dZiXi5J9om1B6EKVtr6rBZrLEXmfosKjLxPNr22
	XH3Y1fg/odvlW9QQRsVe1FddinHzs1emjmkJWoTh1RwKvFAfVfiQzZqsSUbySA==
Date: Mon, 8 Jun 2026 15:30:38 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.18 000/315] 6.18.35-rc1 review
Message-ID: <aibD_iqWXoarE_Yn@duo.ucw.cz>
References: <20260607095727.528828913@linuxfoundation.org>
 <aiWjTGe7fRnSvIl4@duo.ucw.cz>
 <c56becbe-aabe-4c27-9324-7119ccc68d6d@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ODYpK5TG9lXt+gsS"
Content-Disposition: inline
In-Reply-To: <c56becbe-aabe-4c27-9324-7119ccc68d6d@nvidia.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262033-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:jonathanh@nvidia.com,m:pavel@nabladev.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:linux-tegra@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nabladev.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gitlab.com:url,nabladev.com:dkim,nabladev.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16EB3656ACC


--ODYpK5TG9lXt+gsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the start of the stable review cycle for the 6.18.35 release.
> > > There are 315 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >=20
> > We see build problem here:
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/14=
732223960
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/2582906697
>=20
> I am seeing the same build error for ARM64.

Thanks for confirmation.

There are more details in Message-ID:
<20260607170440.90814-1-ojeda@kernel.org> .

Best regards,
									Pavel

--ODYpK5TG9lXt+gsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaibD/gAKCRAw5/Bqldv6
8tmjAJ9INLpyBDjuDOrCySvQ7DTBRZpoqACeNArckBC5CRzuOQKYUtAZCdK9Vdo=
=Hkp2
-----END PGP SIGNATURE-----

--ODYpK5TG9lXt+gsS--

