Return-Path: <stable+bounces-235330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQLA9hU12kFMggAu9opvQ
	(envelope-from <stable+bounces-235330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:27:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E53C703F
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A63304C96B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEA337997E;
	Thu,  9 Apr 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="B3FphoSl"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF037B036;
	Thu,  9 Apr 2026 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719427; cv=none; b=Ldo6/qPM0oUivv6wleHQjKn5DmM56egHxN2llTaNgT99Xi8iOoS5z+BiqnMYwymlB4AQNqPRFAE4DG5UGMBQuhA4yYyIPq2UcWzTNCD2M/m5AXYR00Tj3roAOt2Loo6+67SKIhInFAlKaMWfoZEZs9Mw6f6IYDcqY47TX7l4ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719427; c=relaxed/simple;
	bh=qJAyJQnE4GoBVHMZMuGyPRuXIskJ7dDdl6jqPbc/B3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfnWB5cE2xSUS1ZLOB1ycAqLE0QOip8YuD85+gtFbIRVtRfW4kbuZ0z6Bc6ogBNFegWCOdcJxhfFJ4GKYLLlLjVxBcUxfol20QBzl2mWOE7OtZwRgnq+ahaaWAXmeWAM0OuY/FGnSJtzmStjnRt/YsDqTzM5JrOkaAgtI9/4S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=B3FphoSl; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6455910DDDA;
	Thu,  9 Apr 2026 09:23:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775719423;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5j0hR6XQUCb42SoCQHo5rOLfwdvI6n6GdV1EjgQr0gY=;
	b=B3FphoSlEZ+dq0p7sMEFsOiT9k9tHeZH752xp87eSqYIOGU8c8rliLyeT6Ibm3RXTk/s9r
	gbROdkamRuvU0BcoRhnVwP/AltPHu12+cN5Y2ArBJMrkWbIdhs62AIuzEl3Nr4fIkgg5Ia
	JKgZo7U4tSbPOcz9omCm+3/RcsUOK1Qd7yJodf93SM2Y7+lvoZZ/kmXGUnE/okJeB56d4a
	AvX29rz6GGrkWyTCn3iFfUmIc6NUwcNzU7Lh1oHcJUFhxPC2W7KXF3sxoALJI/YrIH0C3A
	BuW6x9DuzmNtkTeyTzxyy9p6hozSa9FaMeBXQSMEp3Q2MuUd3ji3R3VQUvjSzg==
Date: Thu, 9 Apr 2026 09:23:41 +0200
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
Subject: Re: [PATCH 6.18 000/277] 6.18.22-rc1 review
Message-ID: <addT_XArASAs1uGp@duo.ucw.cz>
References: <20260408175933.836769063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7odyUTW3wAw+L2qp"
Content-Disposition: inline
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235330-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[duo.ucw.cz:mid,nabladev.com:dkim,nabladev.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: 5D1E53C703F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7odyUTW3wAw+L2qp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.22 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel


--7odyUTW3wAw+L2qp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaddT/QAKCRAw5/Bqldv6
8tXhAJ9VQhEBmgLYbfS/W6+yi1Dgu7BUGgCeK7rMh7k/B/oI3xnOMx17zCI5KKU=
=JVsF
-----END PGP SIGNATURE-----

--7odyUTW3wAw+L2qp--

