Return-Path: <stable+bounces-246678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHfGMMCVA2rY7gEAu9opvQ
	(envelope-from <stable+bounces-246678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5C529D32
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACF45302C371
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7973C5552;
	Tue, 12 May 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="e46UNZEk"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BB30DEB8;
	Tue, 12 May 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619835; cv=none; b=hdKfqs9udoiR0tXMoWvLc7PAkfiZEwCErTabBFgRlbDDMT0+hqA6bSa3xZ/e7kI1OhUv1IQorxVIj0kEPLF3gktPP7dZEnStzIjO06syxyniR1g7iqj5TdRdWKpYiFoVGUuDR+/GDUJ9Oq/7onZffPBDstkiOoqqHQ3YyCphE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619835; c=relaxed/simple;
	bh=dWAKedENUjBFun1WIb7DHwMLiAhrJg8SChlbpM0VUJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6LsTvZK1YPDi5Xo0u/BngcLt3/f8VUtLHRfWKti3zrjIPvvmKepY2WGQKXdLljzJ0MLkNCLSaOgq6n7Lr6VdU/YXBkf2GDYLAGzq5umirc8xv9I9TW/wbozdEtF6dyO7UPFx7yYBRbL1Wu7vv7ztKEBLbxd+q7QgDKJtV9hR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=e46UNZEk; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F340411589F;
	Tue, 12 May 2026 23:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778619831;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QHYwIj1w1BWmuOfKcol3ilAqiCSxXsIvIAcqkkXHFVA=;
	b=e46UNZEk+6/3PYQioSCd+LWuDHXk3FUmV6acKVvUgwHeSt5GKG1CvgtzCwa3ExHZ3b3aiJ
	nUPY9OsPBYSlidE+EyGsxKjGJcbQqCD3pG6AO3YvlTYKypE++shXh03dNtRAhELi6oLL8v
	TQ3Upr0IIdGlwPV7WdlLy8L7ya98N3IB0VAhiBDqtCxN70fmpQDyutpivqt3PDV5H9IpFm
	2aLDDLjfO1+aZ8X5uGUERzZWRvFwDg8M49aRz74wioQUSV1W8kNdGqj7D3HC365lo2eCG5
	Uc1lbA6kSSA323Mv+py0vALWzX5GEklDNu3tth82fOG8fwukyvgDBdrpd8dz5g==
Date: Tue, 12 May 2026 23:03:49 +0200
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
Subject: Re: [PATCH 6.18 000/270] 6.18.30-rc1 review
Message-ID: <agOVtULWiYpSUZfY@duo.ucw.cz>
References: <20260512173938.452574370@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QBe3oGtwdR1t5qzl"
Content-Disposition: inline
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 47E5C529D32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246678-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:email,nabladev.com:dkim,gitlab.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,duo.ucw.cz:mid]
X-Rspamd-Action: no action


--QBe3oGtwdR1t5qzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.30 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--QBe3oGtwdR1t5qzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagOVtQAKCRAw5/Bqldv6
8pB/AKCRz1xzOUsyszyBnMTAK+al0ch2OgCfbRihEV5r3do0jP8o2ZvZytCvSWo=
=JjS7
-----END PGP SIGNATURE-----

--QBe3oGtwdR1t5qzl--

