Return-Path: <stable+bounces-256550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJmfAgJPGWrzuQgAu9opvQ
	(envelope-from <stable+bounces-256550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:32:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D35FF3BC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95F6D3043512
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD83ACA5C;
	Fri, 29 May 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="VVjCIjK+"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40F348C61;
	Fri, 29 May 2026 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043300; cv=none; b=D04ePD5vVYGSZ8gPP5T2/EH6zI+pSmugnItbfJQ4nsZK8hoWWX7dMOB623bxanfuer3LLG3Xr62NvR3EvpX6cvBD79PMFi94FU7e1G2vAeTDAO1oPjdTTMCQ3Et9ZM8n5D2w8u7rycn/7xEWuQFOXKenRybIua7EDuu+1QlsPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043300; c=relaxed/simple;
	bh=71bWrpqRUbUcTf+qs6gIWfSwyP+gZv70tvYKXlYjbok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFd2fbWWedSjCZM8AUS60jedmIDi/onfUSTPW3bRn3HcmRdWf7F0i4YgyxXr0a5ZVXJoQZ7h1lZ4Rb8KymJEOARQmtY3lGsCc3whX5OZt79VyfVXb79rhCqFH3+gSDi946XiBagzhLDai8BjFpNzeClyx2BzITQa7LGaKzuMQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=VVjCIjK+; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D44851130C5;
	Fri, 29 May 2026 10:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780043297;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hyE2Nz5YBO7wgOZ4FYUSHDyA+mqoQn+FL8CuKVsBPdo=;
	b=VVjCIjK+R9ciOphH0BH6B4XCX1+upjV3pNwmzayX1m+LC5A8mgIA9MCDWVSg89VQnXl2WR
	09s2DwM8N+6Zi5rDQA3sNE9ASdmop1/iigwCB7qxa6aXlUKQXQBYprtQkjiNSYqitpbxQp
	2lNZfRu4lfoIehkUyXog1hvRrorXo+mi2/als+39E+buiksAMD4j7wY8l0FKvLZmUMuTuM
	Bf8dlfYywMMcFlael5/N2S/2qhhEJqWrrecr/FxI2hTcj7ba3ptFNRL6S+S/FdEEvUtCSB
	tll9xswGectdUuC4sUplMqfBIjuZYatWbbG/0VYKwLlqmb3oNkC85OB+0dErZQ==
Date: Fri, 29 May 2026 10:28:15 +0200
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
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Message-ID: <ahlOHzYwb0Aoh4ds@duo.ucw.cz>
References: <20260528194646.819809818@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sri+6UpRP5hbEKNl"
Content-Disposition: inline
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256550-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nabladev.com:email,nabladev.com:dkim,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: 557D35FF3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sri+6UpRP5hbEKNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.0.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--sri+6UpRP5hbEKNl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahlOHwAKCRAw5/Bqldv6
8mOLAJ0f0qJbXgAp0PxdSy7UiWvqKymu2wCgnI74h/KLPIBh/1S3/OpYeWj+qp8=
=vWiZ
-----END PGP SIGNATURE-----

--sri+6UpRP5hbEKNl--

