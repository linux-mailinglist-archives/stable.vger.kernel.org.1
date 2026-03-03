Return-Path: <stable+bounces-222942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN7DB3M4p2mofwAAu9opvQ
	(envelope-from <stable+bounces-222942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:37:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6701F6262
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCDCD300D1DA
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E590397690;
	Tue,  3 Mar 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh23rtJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21901397686;
	Tue,  3 Mar 2026 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566640; cv=none; b=pa3EeVTyx1KjTH3sgqQ4ynjlXl01Yxfwuob8elRxltPohtsDvmdNKA3y1FBc+TI6FSp2URS8PNTt8cqX5Zez2Mm/PpjS3rpkwGS6P6PBv0BrU6v8DTSC49sFIB5I2VTl8pv9CEwjXiAwTbxo1UGD31KETqDHVJ+UvKnDaOZ8Mjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566640; c=relaxed/simple;
	bh=b2Ym0ZBWgfz/FbvAxbcn771+2QInOWAbl8UH7i29p0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTSoMQxZTHByDyZVq4Xx6iwxFAkrUhxLqD6cBCUhqQEOO3oI+bCS6iOaiuglm2oIUbiBkEd6+unj3cFW3AE1UiJlW6yCaKbs+oXkUCbZ/ZsmIM574MYZnXVnQM1sKi2yYk9rcw+aNYXcRuWtF4J76ucuzcuHqKCnNGhxoKbCcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh23rtJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6344C116C6;
	Tue,  3 Mar 2026 19:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772566639;
	bh=b2Ym0ZBWgfz/FbvAxbcn771+2QInOWAbl8UH7i29p0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oh23rtJLM4fJwRYjDnjNcTHmtA8ZZ50PxKlv4TNHOu/4gq2jVP/qKBU2p8y6ccgGS
	 cCBJuuiBYj+JbpGH9L1XBEF6dIb19kMGNaIxO9H3jldGAh/xDy6dsht4gRyWGf8OBY
	 4pD9FuEaOiD2m0qjSMvV973zIdmR1TbrDi8MHeX470ie1E5Kdc+HazZW0Xt1Lp9GYv
	 I3b4oyy+I8OGFmFfulFQQrUHatAqr4uSDPfDJ6LXRqV+sCh0h88xQOsbrUUt8kvhau
	 b8cXtmtb8g7oAKeUIpAwVMF1Yt6hbhPBjmkcNoFyUBTWVOlFrRhFNoyb0mxBv/FW1b
	 MedS+24vSv7WQ==
Date: Tue, 3 Mar 2026 19:37:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Message-ID: <6f65be2e-8bcb-4b81-a4d2-6352ac239c24@sirena.org.uk>
References: <20260302160943.2522184-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6n1Z8q6OpHx1meYH"
Content-Disposition: inline
In-Reply-To: <20260302160943.2522184-1-sashal@kernel.org>
X-Cookie: Use the Force, Luke.
X-Rspamd-Queue-Id: AC6701F6262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222942-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


--6n1Z8q6OpHx1meYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 11:09:43AM -0500, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--6n1Z8q6OpHx1meYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmnOGcACgkQJNaLcl1U
h9BUcQf/a59SLF3U0bIXYmafkp/ZqZ7N3Oxa9q9nF0HGfrqyfZVJAglZhW8sCPOA
W8TsSPjhfDRS/yAnpHOuBjbiR2bvWYXfmhZ96VRXCPrl+t5ymUGdoDJtS8IOmL+i
BIrSA9K3Vfq833nk80kCLsP0jmLO1mYzfc15d4ncseA25hkjqKZ5fGYsy+dTUtlt
YTEoJLwK9G6tDbakcajy74NdMsszy1a16XgpChwtqiqkv6sifoEV2Cbk9NjX6wqq
GtXQCJmEIPostYEQL8+iZ1Fivc+AzWLa1UnSK49cRo5jqPEi8Qs6F0GeQ8DtzsdG
AznYlScHnZtGyjR+nIUOF0rowB0mXw==
=B6y3
-----END PGP SIGNATURE-----

--6n1Z8q6OpHx1meYH--

