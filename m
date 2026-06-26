Return-Path: <stable+bounces-268824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TMo/FBliPmrpEwkAu9opvQ
	(envelope-from <stable+bounces-268824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:27:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494226CC6C3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:27:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=egTfvEA1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268824-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268824-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07A0D300F255
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1B3F1656;
	Fri, 26 Jun 2026 11:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4636C9CC;
	Fri, 26 Jun 2026 11:24:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473100; cv=none; b=cSLCrD+xCbW3bIhxAZ7oYYdswU+RLHZxh7bn7xRtnpt1Ly5eZtQ8s107fCLmEz+MpRkOMkZJJQn4H4tZovWs3Ed7d7BNmvhZwSgDJ+8N0QsPvnz/vsxR8ePttZ0/TMiWq+W/6H6DAnBgyanqLOE7uI5fDGpI8c2a6WEliBGyXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473100; c=relaxed/simple;
	bh=6GdPrW7ZIBvjwaCNgfnAgcM59mBI+Ygg6qq1MFNxKiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPD29HXxAd0LWJsRjEJ1Kr+QiYwk+HeeEcE1qz7jlPid4ATCK/cBVCVd2WQgksjXeExlSJ4ejWhpPBgd0YTmnJktNgWbSR/PH4uut1vmig4VDBFvAborF9NlpwZqAy3Y81YAbcwqAYDF7wST4zMOkJCPPqgCnsFFDbxaRBQiwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=egTfvEA1; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14FE5117956;
	Fri, 26 Jun 2026 13:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782473089;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=v4dXydw18kP0Tdpxxs9TmPJXNIrlVp67JEsAHBC2ryM=;
	b=egTfvEA1VREJZK0rGsiIDNEOCAHkUnAquaiZigh/wXeUsddonC87o/kl83JRouJ/J/4LCy
	nsY0UnM/2LqlDLNCw4l+5gXBhlkusl/kbCXqojnHNw8wrU4GquYLcw+ioCqXeLPNb+WHXK
	NLM6dCxNoxODL1m+flCiJ34OSUdxPIJRH4gp5WYesktj2WDnKVRUXsmqCorJ+ThMkCxRbM
	4NDsl5m3CeUcUHwF9ZFT3Dd4u0cHUX2ResyhQU59mwM2DzNqhK16zwPrt8c86/0vtrkxry
	HGnAM1fVsbx++bw7slj6V2kt1i6qm6tgfq933mpAwrglUHMwIkcynNdJGzdiFw==
Date: Fri, 26 Jun 2026 13:24:42 +0200
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
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj5hen7qThm9X7LU@duo.ucw.cz>
References: <20260625125613.243729608@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SJ3ccNs6oOxM2Sr/"
Content-Disposition: inline
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-268824-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,duo.ucw.cz:mid,gitlab.com:url,nabladev.com:dkim,nabladev.com:email,nabladev.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 494226CC6C3


--SJ3ccNs6oOxM2Sr/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-7.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--SJ3ccNs6oOxM2Sr/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaj5hegAKCRAw5/Bqldv6
8g8BAJ0d80vRuMUslkY9MSnOfgVOL4teMgCeKHKDG2RBDpo0TryY3lld2EsDyEI=
=CpTJ
-----END PGP SIGNATURE-----

--SJ3ccNs6oOxM2Sr/--

