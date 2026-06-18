Return-Path: <stable+bounces-267064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJBPJAiyM2qqFAYAu9opvQ
	(envelope-from <stable+bounces-267064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:53:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740069E9E6
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=RQJrUmAs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267064-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267064-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7437D3015724
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250F3B71DE;
	Thu, 18 Jun 2026 08:53:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC4271A71;
	Thu, 18 Jun 2026 08:53:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772805; cv=none; b=nvKZmLHVVbNQyuEhzLX6LtCFkRBczad3Lht84Zxd5KCFMtWwkofLEN4WWO03AjYPvuHxcw3UQSG2U5YG4afgy16V3hWW5pMZd5Sn+n1KsNBT21SxsuvJ6wD1Z8w1umIxkhgk0be2dR7wnDMlpxox6VDq1MseoPy72K5jstkutZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772805; c=relaxed/simple;
	bh=1ZFv1nhBTPQWNuX7Ot+xgbs9fCzS+/3n26vad8yZP00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN7yrP299QAMju4LaCjQhwIpIwZHh2Qs+lG6E8Kr1nYV3vPwTcJwCy6OnZZ3QAtlrHw0c+QxBIpn3Tu9FVBzQqeC0BSQO70EltBnhVO14Hd0J09Qg/NmiRTnsiw4zDL9ejkHBnUOdGCdC0d8xJzSIi9yptxEcUt6bhTEpDqF2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RQJrUmAs; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E8F5115853;
	Thu, 18 Jun 2026 10:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781772802;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iZnAskoFx4V0iPabmnepZDLwJ/my1HGaopxdKH9yMfg=;
	b=RQJrUmAsLg4GzH/UAKSQNjz1lRhsCYtTn6fdTq93xaIDUgZ0cPWPX7Z2KXgXbBgedeZHmQ
	dC6TosZa9udOeNVvKZX/3T7XGNb/n6y+jvrMwRhmmp7ZIbpv8qWNZuykSOyCx3po0chgt0
	58J0+SxukowMsHOk9SsWcda4yKIa31/HLybUSD55ycdgebR16tUHlHbKZG/uuWy8MHgL5K
	ZM4mh398tP/oMxm+veXulOQIBtAIgJdtGOE2S1GTFM2ihguNP22mig/ljSz/EJvRsxfcHf
	z6mcVQiboe00FbeR7A9QFR6sEyUPCOOzSQYiy0KU8iNz2uyyLx7J72V/ASr5RQ==
Date: Thu, 18 Jun 2026 10:53:19 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
Message-ID: <ajOx__VhG7HN1-sP@duo.ucw.cz>
References: <20260616145117.796205997@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tIxaxChvFOuO59Eq"
Content-Disposition: inline
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267064-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,duo.ucw.cz:mid,nabladev.com:dkim,nabladev.com:email,nabladev.com:from_mime,vger.kernel.org:from_smtp,gitlab.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2740069E9E6


--tIxaxChvFOuO59Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--tIxaxChvFOuO59Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajOx/wAKCRAw5/Bqldv6
8oZOAJ93xGz/csdmTR+irzYP5i80FpEJxwCdGi4eIJcQwNDJkmBXw1h4moWNXfU=
=/2Mn
-----END PGP SIGNATURE-----

--tIxaxChvFOuO59Eq--

