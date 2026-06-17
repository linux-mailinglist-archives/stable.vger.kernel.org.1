Return-Path: <stable+bounces-266780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 82aYOdKtMmop3gUAu9opvQ
	(envelope-from <stable+bounces-266780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:23:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B069A802
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cF46vUBI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266780-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266780-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C115A30215B0
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DA43D4ED;
	Wed, 17 Jun 2026 14:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AE3E92AF;
	Wed, 17 Jun 2026 14:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706190; cv=none; b=nbeO6z9BsT4Nv8wSXcjxWy9ppAfMJ+Q1GXxhfuDYu6+/T4WRNshxAO0MJHD9EZeBolGj38gm0gaofFXnERcfW7weJ1qvPA8Nag/9oo3n4KpRL8C2Go7lThupW1CeJL+AXLAfWlg+sF/h2gH94cbzspf/kq/ggxYiBrB46uz3mL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706190; c=relaxed/simple;
	bh=bvTqZeSqTs9vPFMD+qud+7r9bIWNHwSPJpqnhfqJ9t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMnC8TCUjelP2l8UVzR1MtqDQyzvrCUAcmiro9IJjqZ3qdRE9kBCx6m+Tfp/bn1x9ig56maJIp+IcXdwnIaDsYCKnmc/MUiVhAdgcBB/sIUv2iEMePIRh8AZpEbrvC8an4udefQo/DEBY1SIZxuwCj+rbUBvs0N+AyvzsnqwW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF46vUBI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD491F000E9;
	Wed, 17 Jun 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781706188;
	bh=jRlhKDtgu1QTULdW9rM7c+rrEiCoUSzr1hrk+PvmQuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cF46vUBIWBWhT61S67WOs5Z183wDnyUYrYmIK9oHxy6vJxv06O8vxusFK0OO7Xd2t
	 17+pS5xY7totQoz6BPcCQv0P/WuacSEdxJD/382S7ZQJxI1cnYkvHfxhTI+cbxwaVK
	 kgfjI2qon21o6xf/bi8SJRAMVsAB7ujOUAi81qTkglVuTaXBXbJgCKmZNEWgnzrPM4
	 5ntFqCT/170Jjooz/R1IPiDaZ/CTbhoxGnh7y6nI8cD+Cs6lW0xy37A3IIDB1VrxKr
	 V6kvjXaH3cdH56YuloGTomhSi9QU6o3eJDcUmlWuhXMVVWNuCHPf4CzBO/Wh2amecv
	 oiXoAO5Iz67kQ==
Date: Wed, 17 Jun 2026 15:23:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
Message-ID: <da169502-33fa-46c3-8d16-e82114d5a4d4@sirena.org.uk>
References: <20260616145117.796205997@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxVnta0QbCDnrZfV"
Content-Disposition: inline
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
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
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266780-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 6F5B069A802


--nxVnta0QbCDnrZfV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 08:23:47PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.143 release.
> There are 452 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--nxVnta0QbCDnrZfV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoyrcYACgkQJNaLcl1U
h9B+oQf/f0UbQdFkyZTbBqkAcgc2OVwaHA0gIOluMrDlKsQY1T8zywA8ANfOoiyn
fI7vbjqy0ueVqshWGVhQMm0rOeF8tJtqgaGRe/MmzOV4Irqt1ARLUJmOyDa740Nn
s0+TBc28KBIkPsT3D+vNJ6FNZAF1x+FaU32AaNL1hNh83NoIYZsX51kYpngp1eam
VM3a7LmG/9y5wUDVSHB/H9b5JgbzgTIpIhdjH8e9ztJPSHHqb7XTbbEbYI3BzZgg
tR/r4lug5phh3CfNTvs3G5Jt9Hqe+dMstRVu993qV8TBNkiS48i+g2vc9gt6BsWx
z1NvlCmS5oJPkk7zMEDrEa3G0K4mEw==
=UGGA
-----END PGP SIGNATURE-----

--nxVnta0QbCDnrZfV--

