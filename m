Return-Path: <stable+bounces-235460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBsBFXvg12klTwgAu9opvQ
	(envelope-from <stable+bounces-235460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:23:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF783CE12A
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F0A306B2D6
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A2B3E277D;
	Thu,  9 Apr 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="eTOfZxzp"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114832F5328;
	Thu,  9 Apr 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755071; cv=none; b=YGpcF8/4Zrxf/DwBIVMA2zAp8gWKSbQ/aDHuAeCDd+oVUiFVdnjm4JN8VZ8a0B9LM6d65jxzUg1wJvZAxVhVlMi6cDEsO9lGvtDLEZRThqK4oERmiZvOf0QYa3v1XH2rQ5WkqTn3XIxMivkYIN71D60vpaOGGD16QGEsPJUOKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755071; c=relaxed/simple;
	bh=XNSFXUdOMMNeLntGyWhwp5y3uK3cglIQvIAzR9WCEqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n81izyTRC8bb1XW74BDkOqyvFjsGF2LH2iL0Yu+KAPJjtwmcjDRc4H16Oas2cgFQ62kcxuuiYhGAf3z+aJNrOK/blggy46fC6eBS6pnUfy2IDPpTQosLb5VKvpxVq0+TRr8l+yOcKcmjqjjwXsf4ZeWcM8+WX/bZC8joxfz5x6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=eTOfZxzp; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E88D41123EF;
	Thu,  9 Apr 2026 19:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775755057;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M+7dYn9NOWAyl8B1gSJpklr1v/6uumbFdxA9tcC4lF4=;
	b=eTOfZxzpEm+BnCqEVr1XkPcyKe0LexuJswcEvtM8ikk6eTMJUvewjDAb58dyjP8EJtJADr
	E7eJi6VJi/WwroXAH0NfWGwgwarva2hAdEtw+Bk/Q+TyD484uK0seiLsx9zZENstosxirR
	hNFzqUXbEMAXCQS7tAbSiDl+W9KgjGssE54NUrP6t/52ecfToj87XDlJKSvBpjebJpZS4C
	kGKXKd371jdGZBntrkRdQJt/ECNk+Y+6SUv0Iu7II3ccnCiUanxTePSY4oDacSjzPGVIzM
	HvFM/uIwsRQX+w4iVO1YIIB0/CnEBsBsr55gPVSdXbjCsBU6L5C+uvLrGBiULA==
Date: Thu, 9 Apr 2026 19:17:33 +0200
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
Subject: Re: [PATCH 6.12 000/241] 6.12.81-rc2 review
Message-ID: <adffLTWdq6J_TmhT@duo.ucw.cz>
References: <20260409091733.126574279@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yDckzbhZkNE0txpL"
Content-Disposition: inline
In-Reply-To: <20260409091733.126574279@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235460-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADF783CE12A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--yDckzbhZkNE0txpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.81 release.

As far as I can tell, this is rc2, not a start of the review.

CIP testing did not find any problems here. 6.18 and 6.19 rc2's seem
to be okay, too.=20

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.18.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.19.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--yDckzbhZkNE0txpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadffLQAKCRAw5/Bqldv6
8uUyAJ4szpQRsmGav2w13by7yNMMJ16h0ACgvwrU9ZGolJz5ysSsG+Lwo7yP+5s=
=ZKLJ
-----END PGP SIGNATURE-----

--yDckzbhZkNE0txpL--

