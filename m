Return-Path: <stable+bounces-240231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CZSKnHR52k4BAIAu9opvQ
	(envelope-from <stable+bounces-240231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:35:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5FE43F004
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 21:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 382853013FC6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41133803FD;
	Tue, 21 Apr 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="RxHNw/O/"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5951EACD;
	Tue, 21 Apr 2026 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800054; cv=none; b=jnXQdkJ1OP0c5s+jObAikqiIII8+JDipaTSu2hMSyt7x1yKibbg8cwfb8k2qxZY1LOM8vw1iS+3HAkzzkZw3kPMJbUM7ZgNa79qjbdKOEXLGzJsjBYB5MfoPAgQQeVGdnV94V1F2Fpmu0M40AEMlIIoi8+HExRr30zU9cjTJLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800054; c=relaxed/simple;
	bh=1TJbJddqXNfliFde2SNOq34up6/NGogPIBUsuEIBQvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amJEnOJaEjBC4A1jb7q61/fhHZPNzwgOlEQUgmSq60jhvG1yMHAHbNTyaZLLvetMFSVgxNsUUghXq0Vmjc4nWVxGK+XYbS4ZpX0Qb/gNsrcnJTY4BWh85W+ANljn4lfdVkHFxxXOYRJ2lwS4R5g1LL8l7pTIRc6YzTKxlHAYo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RxHNw/O/; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B245A112D0B;
	Tue, 21 Apr 2026 21:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776800050;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tXp5/Dsik9poSscKmB9rLckpR5CS+eTljORT3XX01Vo=;
	b=RxHNw/O/IxFvnVRxp+nvHaIx7vVRQFfLdfF9BINhlwcnSCM/NQdJwk2dK4HY/61vzx3WrR
	PNH9cQz6AUZWDUJre3w+STMYuVyFeGcOzGRx8dSlHBTOzUX02SkG+Pw2T5A4zRE+9PKumz
	7LHDB05B0cCwvqzr6zpjM6sOxuYb2UzE3O058ly3EVJNyJ9+VFJ1KalwJOKaDG0q7A5vuw
	SbJ4USe3hyqUXMCRLQmnjeVzK6aAxZYPWI/K/26K2ywvHP9ECaX6aVCYkdgXalX/U+FxMQ
	HZJqMU9JtpWS1OFjf5sgB3UFOLNf9qBrGDYq1cDAgLpIceCfAG52eKYmY/ULjg==
Date: Tue, 21 Apr 2026 21:34:08 +0200
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
Subject: Re: [PATCH 6.12 000/162] 6.12.83-rc1 review
Message-ID: <aefRMH-8AfX8T-oD@duo.ucw.cz>
References: <20260420153927.006696811@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvTOkM4VA3kdj8dW"
Content-Disposition: inline
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240231-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.com:url,duo.ucw.cz:mid,nabladev.com:dkim,nabladev.com:email]
X-Rspamd-Queue-Id: BA5FE43F004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--kvTOkM4VA3kdj8dW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.83 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--kvTOkM4VA3kdj8dW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaefRMAAKCRAw5/Bqldv6
8jD7AJ40X1GkOIRmII/ARyLmarAxV/NByQCeJYHCFkvVL2BtUrYxpehGnlDD99s=
=E+On
-----END PGP SIGNATURE-----

--kvTOkM4VA3kdj8dW--

