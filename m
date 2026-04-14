Return-Path: <stable+bounces-237758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MZPLQH33WlolgkAu9opvQ
	(envelope-from <stable+bounces-237758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:12:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4C3F6FE5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34FF6301CEEA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069B3932CE;
	Tue, 14 Apr 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="RFkYHbue"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE937CD4D;
	Tue, 14 Apr 2026 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154327; cv=none; b=pv0PwyBSeTewFRX5/TKAOn5l7LYmzOnSBhpit9qiLTJav7jk6UJ+II4JS+mNk+prqNSyksNqNbJWANWckAXeO80GCwCvmW8UCV/rx23cX/PIkcNBn+Sztx8xchBrDyO5gVmypJ9vUD37DOZkBb4yYrBAvJRkeVZRGB4t0t+3ZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154327; c=relaxed/simple;
	bh=PR52RNJl42WSha26ED3XT84RotR+zfDxRlcRSD5g/kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlNfdAE1JPA8Os5XxO8gvTDGQW0NbPuioyMbpuMKFFdT5asjjy04A0finw0+YoD+SuEDuuV7C0avoDG9/IfwNs/GQ7HvCpfMq05+fTkWCOq4qJ8K1yvi3Bf82ivNgjcakemaZjXVXphEJXwFWggQv74ylDr+jNAhjSlnl8xDvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=RFkYHbue; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5581109A14;
	Tue, 14 Apr 2026 10:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776154323;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Q8j1exTZKRd3Vx/on0NmMquSMKYdWkiCS77BD30h6hE=;
	b=RFkYHbuew0VBjPh2ZIBcoy8F9vqMQZnIUzZBENBbbUL/VHIDjqnZlPmplXwzvitbxq19mG
	kmTTqprE0fAmEvc67jmJ9cEDb0B2uj2pt0cGCdYYqQyzjCzFDQP6kapBsXi6KdzPgCs+ac
	J6cQyHmQQSbmnDsWREBqNySFK8nXJTwMPYdsH5Sx8jGaopB4YF7Z1nduHS/AGc6dighIeF
	2BtSG+ynOKb36J+ZxV0s2HMczBhcLu6Qs8C0Oz34xqaIUwp+TX2YRKMmk6ppRC7r3lJ01k
	GORMEDcJDW190exbKFY0wSaI+98CjgmwpdW0HOm3XA+HKOSlZ6NDbUX36TWymg==
Date: Tue, 14 Apr 2026 10:11:56 +0200
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
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
Message-ID: <ad32zE9N70L20W9Z@duo.ucw.cz>
References: <20260413155728.181580293@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RXxPajHcHu2F13eC"
Content-Disposition: inline
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237758-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:email,gitlab.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: C5C4C3F6FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--RXxPajHcHu2F13eC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--RXxPajHcHu2F13eC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad32zAAKCRAw5/Bqldv6
8l1XAJ9mrYOG4K7iTGns8g9v2gw2g2WXFwCgksZWN1E3T7xTL5lC0CISuHKBzjI=
=6+Os
-----END PGP SIGNATURE-----

--RXxPajHcHu2F13eC--

