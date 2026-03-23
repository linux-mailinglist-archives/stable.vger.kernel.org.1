Return-Path: <stable+bounces-230000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCiaBTaUwWnuTwQAu9opvQ
	(envelope-from <stable+bounces-230000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:27:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956F2FC3E7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8EA530106AA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4535A3AD;
	Mon, 23 Mar 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="PSI1MarW"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59514359A79;
	Mon, 23 Mar 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293463; cv=none; b=ZtkE09fanBFuXkd03IAOjPPZBq/6/tJIuoeBGt5f771WO7KiEeYzNieVX1PvetCHyDXE3dbf8QAq9iI3dObhoT56b5lQMqhUqtldJRmAEm83H1ZDyrDqnwya/RNcJW/xDeAbF9+vrTtd1jITtxDZr4lB2bDwk8ObMyDMm6IJyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293463; c=relaxed/simple;
	bh=ksZM4WvFWU46lMJbhGzrEIoybhH/VXsRUVuC6bdHuBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW5SfUOEoMdA/6hlP/5nn21zEJlxN7sfvJ6jSjan2FCPWXUod0/NI9GgI2qpDKUt+7jVSt71l50NLn4oPlZsNhOFppmjt0TjdabCKJ1jiBFUCC5rGCHE+w0CzbV4gyzXi3ifVOYKnT5cbeuaHCtfbz5imgcYgOTzErDjiHCjOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=PSI1MarW; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5A8D10804A;
	Mon, 23 Mar 2026 20:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774293452;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dRpexk9kg08HOIQdId3NX/QsWpU/duA1o81y0BrZGwI=;
	b=PSI1MarWfF9DfigkH1yHFT6Rs2kasDaUmiu6BODCf0x9KbYoa0RmPqlfnWS1aTe/gmewEl
	oQPHPXJ82eJDGgJu87wA5w7OYl/PI6CU5nnXthSaQNBgK4jCcAy85RsMM9a5c0q5iW6wPa
	8yheGjlXoTz0pHuSatVSWwqwZlI8vnuymlUFNm0gFyoEXYW2FKt0Qo8YxwyxBf1VdIDf9Q
	qoXApgiW72+Ixi0mhitsC0vcaGIvANg4ArqANUymDg16Sxty4kGJYEcnki6irBOXbRpTJs
	rpXq6UfDadP7dCuD/nGsi1HZxoHyJeWLPokP1+8DFUrhAcUnQ1n30SqqJl11AA==
Date: Mon, 23 Mar 2026 20:17:27 +0100
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
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
Message-ID: <acGRx27gRa8St9zb@duo.ucw.cz>
References: <20260323134526.647552166@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5kmGVKbbH4ep21FY"
Content-Disposition: inline
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230000-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[duo.ucw.cz:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:email,gitlab.com:url]
X-Rspamd-Queue-Id: 1956F2FC3E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5kmGVKbbH4ep21FY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.78 release.
> There are 460 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--5kmGVKbbH4ep21FY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacGRxwAKCRAw5/Bqldv6
8hP9AJ90Cke/JJ7gCtYum0L89QcMoMyZBQCaAuc3YamFhb+1OfHWn5L++TeL6wg=
=fywJ
-----END PGP SIGNATURE-----

--5kmGVKbbH4ep21FY--

