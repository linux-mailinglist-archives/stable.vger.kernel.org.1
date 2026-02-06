Return-Path: <stable+bounces-214736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMv8MttqhmnwMwQAu9opvQ
	(envelope-from <stable+bounces-214736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:27:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3A103C5B
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 23:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAFBA300E494
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADA2FB997;
	Fri,  6 Feb 2026 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="QPJ2U2n6"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD923183F;
	Fri,  6 Feb 2026 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416852; cv=none; b=W/IN0NgDMHPIChg3+gwBsS5WconaNgQhB3V1W2sVrLEpNTDeKsLjJuFElQJPVgYsDaaWKjPXiUcphoKAiTdiJ84ZKxI/Sx7zO9wWhb/G0gVTmKzZ74UL3m/JJIViROKlCHYk+7unX5MVVpjHNF+H1qiYg9r1o0BhppRd9wm3yA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416852; c=relaxed/simple;
	bh=bAr2Y6N5zggNqSeToHu2R0bJYQlJ9HqHiElQi/CjLEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpABmz7QqTDEESWwStpylFVa35gYAgeO8I8saMXRtcTMtw3TiYfDZZqCmE8Vov0FUqJ5rxGOqFrTc8EV/1F2fFp5YBmrfN43A9erg4EZvilMHfA5a/QUxUoXJoMiwpVFt+RotsD58vyaN4wvOd/QIi415v9BWTPtwpEAmjCgPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=QPJ2U2n6; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AFE31100D2;
	Fri,  6 Feb 2026 23:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1770416843;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g4rByCDjGd1zb5JddtX35obfQ/VpbH/jK9xZu7hrtZE=;
	b=QPJ2U2n6KLhO/AjHI56Fje9HXsWPcJbjFGGO3+glea+UNZe4Eu1P8DXZ/hgZGwVwl+MoWA
	76YpOXuullvvxAjYf6VbV5xnOhoEidOnM8ArVieicKlqcSfTVLisLDpQKHx7ApuWpufLA2
	mWsArwiLEGqCu5tZVKlEZm11Jshj2flDpTCOYqNxOBX9s6qZTlR9zPfBJYUdnf5cCAUaII
	Gj9ip6VhfHBT50ZzgSlgH+fIF0D2+TDWvGPktWI1ac/WXpiRQA1whMpZoKCJjgTaSPNaEi
	xNdfzt8CSmuSMR+CPJQGeS0QSLFbw2EbP+qpXFgguIlyJ4eVVZpsT3EZnn+obA==
Date: Fri, 6 Feb 2026 23:27:18 +0100
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
Subject: Re: [PATCH 6.1 000/276] 6.1.162-rc2 review
Message-ID: <aYZqxnK/K4PF4fAr@duo.ucw.cz>
References: <20260205143450.492803005@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fz4Co0v/KQhdbl68"
Content-Disposition: inline
In-Reply-To: <20260205143450.492803005@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214736-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nabladev.com:email,nabladev.com:dkim,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: E8B3A103C5B
X-Rspamd-Action: no action


--Fz4Co0v/KQhdbl68
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.162 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Thanks for updating the email address :-).

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--Fz4Co0v/KQhdbl68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaYZqxgAKCRAw5/Bqldv6
8m88AJwJFK2hXwKPuaox4IFUM2V4658ZZwCgitSxcUJTFt7leU3Q0Ubv7Fw+9H8=
=qo8g
-----END PGP SIGNATURE-----

--Fz4Co0v/KQhdbl68--

