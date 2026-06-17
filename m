Return-Path: <stable+bounces-266770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O80PCZ+nMmrz3AUAu9opvQ
	(envelope-from <stable+bounces-266770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AD69A4DE
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:56:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O2YaVGMm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266770-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266770-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA654304F88C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068983F8EA7;
	Wed, 17 Jun 2026 13:56:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC33D47C8;
	Wed, 17 Jun 2026 13:56:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704572; cv=none; b=hqBoo5wOx72CUHfInlqjbFvZSkZTU6YSPlQrjsTPS02cDJUzDiINVsI/SUn+TBlr/++KLA+6Msz/g0isdwWUo0X4eO9PMSWODP3/PvfZNsl77Dsw72KrrAIkQUo4XVdqaqDoAwVa/sz5blPPy35d7/JHvgWJb4o7Mnje5fvifIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704572; c=relaxed/simple;
	bh=iTWAV0/QgymAYUWHubOAceNomkZl8fow7VtraiMCF4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izk5RYE2znt9moFN09ZUcRzdyaV/uWeZhp2N3A8SYAf17ZHP1tHljngiAfukwYTHhzbWORVR6kOXhl4rR5x3a7W57Fbyat4s0MKSpTYLIwGSwFvOYClggoGfJPM6H9LcQL73dRPUVMXvnKDYOsXNu7lRA7oJmWqIfCQRn+FgxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2YaVGMm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFA41F00A3A;
	Wed, 17 Jun 2026 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704571;
	bh=isTw6+xeh+YNLcUcSWnoDeZkl7QnUKdUlNZcFZT2vyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2YaVGMmWO4BRsJjJ1+a+8HE57q014tmzLDkgIg88+VOFq4uzFFvqqo4OfokiVJmL
	 P4EIitbYEYpamLOJswS+TmDy9R/BFjrlk8n3O/wWwZ1nS8r31MznipNyHBa0NXoVS5
	 J5PMV+ZvhTgScNMp1HiBZdMlF5Tn0EGT9odcVXYDmQA6Py793VG5gUqfjFHUBpahNw
	 b/VJy37nJInETw6oRabVf0FEEzgB+8devT+aIHK+sobw8kGejlC17FPBypNyDR2RQf
	 cp/oHxK5lxlvJGh8n/1PULwZH15iWO76kaU+Wq9UGiIukvXKjVv7NvAyAENaEtoDWj
	 qa2gc3yX4iE6w==
Date: Wed, 17 Jun 2026 14:56:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
Message-ID: <689e1202-45d5-48b9-96e7-a64d30a6bf61@sirena.org.uk>
References: <20260616145109.744539446@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZftC+37NQqhM9/u"
Content-Disposition: inline
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
X-Cookie: Absence makes the heart go wander.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266770-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD0AD69A4DE


--LZftC+37NQqhM9/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:23:51PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.13 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <brooonie@kernel.org>

--LZftC+37NQqhM9/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyp3QACgkQJNaLcl1U
h9Doewf/Xi7VqpZ4OzBYEjIlVN30SrbVCDtl06uKMILlnXIfCKAUqha75u1vx8KD
sOdV7nBPD4zvoNAA7sB5+SixMEgkU1ZUXzUQjpfQtuiMIH9oWfWSh9gLOz1XjHDo
oH6H0qiYvf348+Oc6P4IqMcqKX+pQ45igmahY/HJur0Vj+63p90P7sbwGfmX28Rx
XBEPh3R7i7lTiCrIVZNrH/yZdPkp7jmuqLHN/ATbcDaR0luL7ASxbHcpZzS487mz
Y/x3849EGWSVoDLvV3SXoxiFTDH6jK9Y8wRCKHV/KxSmu1nyKry72Y7rdSgs1FwA
RJ0Cz+71MOmzWrBjmAzFxU9gomYwEg==
=KDdJ
-----END PGP SIGNATURE-----

--LZftC+37NQqhM9/u--

