Return-Path: <stable+bounces-268855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nI6zAPNlPmo9FQkAu9opvQ
	(envelope-from <stable+bounces-268855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA396CC979
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=YAeA0nUP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268855-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268855-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3880302977C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4E3DBD55;
	Fri, 26 Jun 2026 11:43:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D0380FF8;
	Fri, 26 Jun 2026 11:43:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474207; cv=none; b=i2VfuIJIsMV5ox/UNbW+AWJlgZH3BVgt67JHTGWlOzV6XEn2JgJxGHCg7u5xZnCTQUj6VhKAQobIGLqzY7d7Olt3ET9o3IT1eagSa+UGJ8SQIfJJWIWn4RA6P/PqYgu5eOin838G+lDY64c9JwmmDHDKIvIHpCUfucIKcPxciD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474207; c=relaxed/simple;
	bh=P5LOVI6HB/RZ8gCz4+aEk1/QWycuoI952xLS5tAGnVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIKTuwDsdgsAu55dAxvqjhJZxxL5w7PMHKUCvQo2Oy+2/A8kQCK9OOAwyybnLj0YJpxZLV5mRZYNDxPoQOZXfpQNUEuO4cqD+ACECuucG00tCY0xJzrn4zMRdXaMU6YqBOPj464SSImiANfJWw8Ivgs7rLQ0/sbuSeZvmRE/wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=YAeA0nUP; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D09F1180A6;
	Fri, 26 Jun 2026 13:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782474201;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Rr1cEDzLbCZUXK+ljn9CqBOaHcRPnnuRSii5bA4obvM=;
	b=YAeA0nUP92ZixdLW4++8WtJM16k/jEN9xFgkw1o+XxCrwk0qgmE65/PxPSblgsYmmWiECe
	ThV/mA2GRzJx8YnucuWFZshl16djHMoMA5d1qvuehXjR6fB7mulZ1HyKjWGZBRg2VFuAGj
	aCz9kDs+Fgc+XpbMU4Fkpf0M10alNBX7YK6cp+tLlHx/ADo/72NI0cpxfUmTUB1nRJjYhm
	/w5qaWSJ1MgHxthBSrtpj0obexp/dXsuSazeRz6nb1559gPZwMnJYTtfR8Ulsqk1Hg/sn4
	RgiKQBNFPzhlvNlkzPBkXz1WIUIvTHCBqU/W8b8JDudjRqpM32e+9yGUw/bXXQ==
Date: Fri, 26 Jun 2026 13:43:17 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj5l1ZZeX7cj1J8v@duo.ucw.cz>
References: <20260625125613.243729608@linuxfoundation.org>
 <aj5hen7qThm9X7LU@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eip3KXvmoWX0Gcjw"
Content-Disposition: inline
In-Reply-To: <aj5hen7qThm9X7LU@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:pavel@nabladev.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.com:url,vger.kernel.org:from_smtp,duo.ucw.cz:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BA396CC979


--eip3KXvmoWX0Gcjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2026-06-26 13:24:42, Pavel Machek wrote:
> Hi!
>=20
> > This is the start of the stable review cycle for the 7.1.2 release.
> > There are 21 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>=20
> CIP testing did not find any problems here:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-7.1.y

Aha, no, sorry, the test was running on wrong version. Disregard this.

Best regards,
										Pavel

--eip3KXvmoWX0Gcjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj5l1QAKCRAw5/Bqldv6
8lcrAKCEqvZ37UR5AoAcA9wLpykzpnJ56wCgnUDOtTPo10rQ0urXSCMRKchSVEY=
=dNUM
-----END PGP SIGNATURE-----

--eip3KXvmoWX0Gcjw--

