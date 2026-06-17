Return-Path: <stable+bounces-266793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wm47H0OvMmph3gUAu9opvQ
	(envelope-from <stable+bounces-266793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:29:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045769A8AC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:29:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MMG+oeOZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266793-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266793-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E02B300EDB5
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB64418F0;
	Wed, 17 Jun 2026 14:29:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DE3F7A97;
	Wed, 17 Jun 2026 14:29:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706553; cv=none; b=i6mQpOo7NAk+35M6b5vlfQ3LSdST1iihHgxuyXGmgLF00/AKL/OsSVTBGmMk0LzdiyKXPdHathxhvo3/ew/AJiXBE0DhqvIqy62y2rI4rxtpy8Cwjv+Iw+4IUVE76OtS7iXua1SehEmcSaXNtzWOetQ7zmmZXnBzMc7WIvcR8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706553; c=relaxed/simple;
	bh=/jFEeum7cabH6f5adwQKLkg8+APbV4GTNp3GLjNzae8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFAhQKbXlhRYqO1tALNu5TQwxdbl6YWIhuUXn3uhHxYJaREf5uFX8lMFXp5Gbp5QNC2u34wH0L1Yu3v+WW1eYVpTx75ek52FIQmqUOAVjWAatqq7E1jNTsaC4apnFAEF648KeujmFRTqpfMkfXEZifBVsdlu0elfCZcwqDt/G/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMG+oeOZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B91F000E9;
	Wed, 17 Jun 2026 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706552;
	bh=Ys5pPCaJd3TPOlqA6QLyisVRTVqI0cuhvJWAZEBiOP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMG+oeOZlI89QiV7SJmi5c8q1U2g1/MB6brc8enq9zcuL7JR+Vu945Ki3Mca2gYkJ
	 e3FgWHbwd0KCntrImxyo2fXO3+n/9AqFyYTsWcJhylq7XxJtDxh2FsKeCvapIxE4WB
	 jD5FCkUhRaQ4mZsL5WEXHI8re9aVCeTPlJXTutleY6hvasdcbrNdjEUvcX4UYwJm9f
	 Is6VsUyHxPIvJkYK2UO0777DyjLZZBcqUprpLH0pWiRYTd+bNAVravDxItBRoefack
	 pyIwqVOaEgr0TyoZCdGJtmW1ZfTYt+2MXsyPN90gdDLu3L0H/GlAZpFkX6mpgBB/L7
	 7sLm9zPNL2/kg==
Date: Wed, 17 Jun 2026 15:29:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/410] 5.15.210-rc2 review
Message-ID: <558118d1-5d7f-47cf-b01f-7cb0340b86a0@sirena.org.uk>
References: <20260617080316.111043001@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5jOam4bzOVJg+QJ"
Content-Disposition: inline
In-Reply-To: <20260617080316.111043001@linuxfoundation.org>
X-Cookie: Absence makes the heart go wander.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266793-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0045769A8AC


--a5jOam4bzOVJg+QJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 17, 2026 at 01:33:49PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.210 release.
> There are 410 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--a5jOam4bzOVJg+QJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyrzEACgkQJNaLcl1U
h9DvVQf+MkXn9MN9aRem6/JsRJh3TooMNVfzdjvvtkR3HcK3IGiL5I+NY/KFKCFe
7vq3vylc+vJ/oHZyL2tCS7nn5g+Zvb+6RX/uQMGaMivA4KKO0QMKoYmd0zE9wA94
slzbsvmOwq7MPrDfZD78lwZVs9kWt8Pnny1HvUF/DZ6LvJ8/ClsnapF3+WEYDRpQ
hRBMvRRWb1dTOavKVwprVngYaUqIUZbyJuLnl7LDFrx/1Ggimp3mujallbQDee7/
18bNLvPK0zY2w+YaqFFjlkQ/GMC15Y/TGCHZ7FoSPmNXhxAlcSlOHkNuRNYYowXF
O8+m/i42GK4uWtn3POGlyX+J8i8EyA==
=SCuh
-----END PGP SIGNATURE-----

--a5jOam4bzOVJg+QJ--

