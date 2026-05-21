Return-Path: <stable+bounces-253497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MCNDlfYDmr2CQYAu9opvQ
	(envelope-from <stable+bounces-253497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:03:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B64425A2DEE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCAB83061C9A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB92389472;
	Thu, 21 May 2026 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="DamkeTp9"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32238836E;
	Thu, 21 May 2026 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357322; cv=none; b=utZ/9U4VkRdL10fS5piBIAlkjRKLjjsr/4Srb7EGEASK5nU1mUJUxgFBcgzbTx697LwjvX9Xp/O8eoHMCSkPyCq4vNHipv/GSs0taU45WOXGdboLKSlpvsmEcPiNIpMnh5gplqiobVVJeHdlikAJuuoe/DauzZfUgt2CVWj3dIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357322; c=relaxed/simple;
	bh=hPvSeY9tGyS4+nKNFqMDhpEjJ/KMN0ZtFYypWFwxq1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2t+yzHWayYb5e+wPv5Y4q2CbWFS8CSJ52/62x4SjI7U426941h/viWSqCUWMYewrUGNXM9rY1K8Y020tv7wrJdAQ79BFsakKHTz+A5UrXwCyI4lpkJxFjoD8CLjkZ6kEdqZI9V5Ux7c/zzj1y7FxN51iYMx3QWjBs2YkvdDkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=DamkeTp9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8304410CED4;
	Thu, 21 May 2026 11:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779357319;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NIBW02XQrfatk3mY04OijQIZ0lAF0RpUhejjhCWO4qk=;
	b=DamkeTp9WHUAMlWiR+MZ19SdquEm5cDdHy1ydmNPgZEnCum3BQqyXWuSiEUkaiGp0zr5cH
	FDWGptnDCynglYeByopozIZgwcUbHSaWD6l80PRMSBZZLPt+GhD1dlzEEhgICNP7ZSf/WA
	hGDb0PoLRtXk8IlMYm9SJfLErOgH7kCxZvpobkEgGXM+IxhDSPtWuLnyuZA6icqTxwLww5
	Ad3C7FVmHFioptms2E1IDD/qeqowehdgf8fArc3wECOKUEPehjVRK9hzJMi8SI6ruSGH5r
	FqZLpUjdIhOH9pu/MRCVizRn7ELXLUZGB1Hl7Y/EmrPnt95Vd/Nx3fW/9I8d3A==
Date: Thu, 21 May 2026 11:55:17 +0200
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
Subject: Re: [PATCH 6.12 000/666] 6.12.91-rc1 review
Message-ID: <ag7WhYyAeVzRng1Q@duo.ucw.cz>
References: <20260520162111.222830634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="36VgFSgR8pbkgqbN"
Content-Disposition: inline
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253497-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gitlab.com:url]
X-Rspamd-Queue-Id: B64425A2DEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--36VgFSgR8pbkgqbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.91 release.
> There are 666 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--36VgFSgR8pbkgqbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCag7WhQAKCRAw5/Bqldv6
8oyEAJ9PxJPTloAyXx02MYmBYrOiVOBcAwCcCS5AO9t1rgoEaK9BNo6wpoOSsus=
=DTEE
-----END PGP SIGNATURE-----

--36VgFSgR8pbkgqbN--

