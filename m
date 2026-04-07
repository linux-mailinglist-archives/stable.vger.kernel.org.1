Return-Path: <stable+bounces-233582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA7PEBvy1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:01:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D800D3AE12B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF16305C4B6
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97883B27CE;
	Tue,  7 Apr 2026 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="UwgXmvMo"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74161395247;
	Tue,  7 Apr 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563128; cv=none; b=DeIK1LnE1wR2wp7LVcqcIpVE3HPxy4Wb01izdd8XA6/sHSxd5o3MU68krwmFj/DBY9sw2hDNG2ZahRNbmMiFxv3R5Xzup8+UrK26QsCLXCUawDrxhCgZ2kZ8cKaJ+ZQzDRZvmE5TPHa2MDLaIby4DzoR04sXgEv7eYJovY1/DB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563128; c=relaxed/simple;
	bh=krQ+qmx41QUi+SNdzh1GDVRv9d2J8WV8wjPP8wPmb6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl4rK/lZt3OEEoehhXYfAZb0HYhw+lKHFkIUoJrKDn331tIa2p1sQEp6yeBrLAHmqIbirXOufX3Wh2DFo2SvisrZz4niIU4QlYfUKE31FlGBB1DQeQztEUK5Fx6KlEf1/BlPbLUmejw9tHUqv+GeJRcxBcz1v7r+xv5YRTAxw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=UwgXmvMo; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5506F111730;
	Tue,  7 Apr 2026 13:58:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775563125;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oQXbDh/K2K0BfE2ojLdy23TU/VVRdqMSNRWkn8uwc54=;
	b=UwgXmvMoMU1sz3a2oU4yrlmo+lurgIStOWAH/uLGONrdKwpVPoWMYiVq0UmVsU3dp0FPGr
	+RfJ9WdDoj4j3L8rattwNRNSXQARSkYfPWL8QwHMj4l1QdaD1eoiL2AsGgzN1X/Ahmgsac
	UvYeLm/Od6EYIDxV3DHOd1iAkUFsg275VknYiS639uPexJwHNLDPpMUNJqm3UiapkQnoEw
	PLxFY/DE4j95ojsmFTI9mgjKLQElbmfba8St58DqDFvlx8HSzLzsaYgTHNI9Eq3h3+uOsl
	Y9f6LkaFId2KbpYKwu7lAsrvT0hqqGAPqSzyB6zHzTLQcII2uqO08SR0DOJcQw==
Date: Tue, 7 Apr 2026 13:58:43 +0200
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
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
Message-ID: <adTxc7s44iS8kbRO@duo.ucw.cz>
References: <20260331161753.468533260@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G+cfJLa5gZn45coF"
Content-Disposition: inline
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-233582-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D800D3AE12B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--G+cfJLa5gZn45coF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--G+cfJLa5gZn45coF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadTxcwAKCRAw5/Bqldv6
8oO/AKCoHqozrGumppY89qBFbcAhjkU+MQCggRJMVvWz67v6bwamXAULa35bzaI=
=iljz
-----END PGP SIGNATURE-----

--G+cfJLa5gZn45coF--

