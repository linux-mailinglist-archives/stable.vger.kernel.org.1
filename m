Return-Path: <stable+bounces-268857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgmhOD1mPmpTFQkAu9opvQ
	(envelope-from <stable+bounces-268857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:45:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A126CC99D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:45:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=EcrkmsYH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268857-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268857-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 553DB3020EAC
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C745380FF8;
	Fri, 26 Jun 2026 11:44:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FA3DBD55;
	Fri, 26 Jun 2026 11:44:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474297; cv=none; b=J/hYSGLCISV0N03WbQJYey9aAp49Nn0i0sBK18hT1v5eGucso5VDHsmN+waW/SgZB+SLO9fb9UGQR7S8PONSxopJi3nYoe+ym0xbRHauPrXOLqqfid5XemC62J7mlpyunrrn2NTmI81uJlp0UVPj3eg+tkdb54z/pgqVCWPuF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474297; c=relaxed/simple;
	bh=TjOsQk8fELsZW2uj+46KbkV5sOFDaVPfr+7+FHCv6jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6a+NOY3AvD8pYkUuiNNJ3h3XmxPcTi9+IIv+EEXRhYwqyqN/E4jRxM65hYB6WjrbarYb7RKYoNZfIG0hG8CBzTUxD5590UuvxAlv0sJS++bZuvXaIR4iMpOnA9+txBVUkLNWyzeTvF4Xewq5O4dvVbhCimgNTunjYvtlAWL5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=EcrkmsYH; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B28FB117E1E;
	Fri, 26 Jun 2026 13:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782474292;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Wt9pwN3xvqQpYzqex9ofgxGr+gijVC/fPTW/JNx/IHo=;
	b=EcrkmsYHddiAEU70gAqxc3MMKcQoC0/H7Y1HvM3E2QtzxJ7WjfM2EWeEd2wUTkbfE4HGaj
	WPU+/HaJxy9XL4LhI6PKYtFEBy71xBoq+uoFnp/GLqQwimADVNfz8V8FHG2cwvsJFinqZO
	VbTL6ikO5LN4M4/f1T19Ta0UKEageZh5WFCBksty8ZcbLMb8h9idbUGu2ODRWNZVd3ip87
	L7ro0+UKTbr0UVY/KXitP6r5rezsFpdm1VLEeJbqpOZ8ARsqIkHNDXwPUqv5ohDEjAhW6L
	D1eUFl17Bni2iqCpuZDxrzhtaO6sRRyMQotMks//pjeJdfXe0O7InYpgdnzlLw==
Date: Fri, 26 Jun 2026 13:44:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>, Chris.Paterson2@renesas.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
Message-ID: <aj5mMP6X3NUx5XZM@duo.ucw.cz>
References: <20260625125637.527552689@linuxfoundation.org>
 <aj5ho8stx819px0w@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JL0oPREIppCv6AO"
Content-Disposition: inline
In-Reply-To: <aj5ho8stx819px0w@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:pavel@nabladev.com,m:Chris.Paterson2@renesas.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,duo.ucw.cz:mid,nabladev.com:dkim,nabladev.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45A126CC99D


--2JL0oPREIppCv6AO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2026-06-26 13:25:23, Pavel Machek wrote:
> Hi!
>=20
> > This is the start of the stable review cycle for the 7.0.14 release.
> > There are 49 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>=20
> CIP testing did not find any problems here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-7.0.y

Disregard this, too. For some reason, this release is not yet tested
on gitlab. I'm putting Chris on cc, perhaps he has an idea what is
wrong there.

Best regards,
								Pavel
--2JL0oPREIppCv6AO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj5mMAAKCRAw5/Bqldv6
8mkQAJ92aRgjtp0fJ0vqrTaBBMsbZnesbQCfcDvRlNFKYVT7jllVgxTbH4XKXFQ=
=4fPg
-----END PGP SIGNATURE-----

--2JL0oPREIppCv6AO--

