Return-Path: <stable+bounces-222458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJQtBPUspGnZZgUAu9opvQ
	(envelope-from <stable+bounces-222458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 13:11:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C951CF8D3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 13:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A8B301159B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B123218BA;
	Sun,  1 Mar 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GryP8xSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5352EFD9B;
	Sun,  1 Mar 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772367068; cv=none; b=cJqpEzU8s39BZ0tIryW99JDSsbGDBL6L4yIwBk3qJDWx3RTroPuL4aDpGDfd5rHh+ImfURKrv809WiraHJcwpZOOrjr7IFI9CPnyDlXrT5kgq6BJvAT3Gn88AyTaIF/qsqh8lKLZ5CdPEl7ksxCW7FQ3mWsgouW5gF6IfI7Ju5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772367068; c=relaxed/simple;
	bh=V0BZvPGOue47VwghMA6cgQ0amv/2FuZYzv1oeHWj6ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCxYrajZH2sLUDj5VAy3AvskIVTIl2JNA6fxFQxEefk+H+KMSpArX7Bnjuwo4BN+Bf4y7wTt4gQqngth9Bl8E8STbLAs5t4Qr6JP/UhUwNJzoNknCYTLEaMiW6o0r6MX4sXaCqWSeRh2AfxMgbR8KoxmB0Exu2Q6RRVIeQCr1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GryP8xSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6990AC116C6;
	Sun,  1 Mar 2026 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772367067;
	bh=V0BZvPGOue47VwghMA6cgQ0amv/2FuZYzv1oeHWj6ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GryP8xSptu0zXj/ES+gFNT551BQlo/TG32nzcNCZPcX4W4Hu9k9IQ4N2OkufNAks4
	 fih2c3d0DN0G8ipXN+JgczP+4mcny0JFiU9JEoyY955TtDRfG32pniQApyN60kxvfG
	 qu3xaYQ0JE2AoBwr/6dAVXvJEaw5yZXZfuSXrKXDkNHrthjtB0Sfnsc/AH2Ianjy60
	 kFJmkcrV8SalKYz+kYeivicxX+nnEmWTjMOjn3K9K4fWNGRGhgeexNAcrBhSCH7a5X
	 X2T89PCITjzyAHERoDfs2vIhYU3e1Q99JlcO0AUVrlLmljAbB5nwebc+PkZQ8Td7+g
	 2Ebvj15Mi+CJw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 34DF11AC58DB; Sun, 01 Mar 2026 12:11:04 +0000 (GMT)
Date: Sun, 1 Mar 2026 12:11:04 +0000
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
Subject: Re: [PATCH 5.15 000/164] 5.15.202-rc1 review
Message-ID: <aaQs2EeOipjI6g9y@sirena.co.uk>
References: <20260228181458.1600528-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iWfyzNFDF/2K9AJ2"
Content-Disposition: inline
In-Reply-To: <20260228181458.1600528-1-sashal@kernel.org>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222458-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.co.uk:mid]
X-Rspamd-Queue-Id: 66C951CF8D3
X-Rspamd-Action: no action


--iWfyzNFDF/2K9AJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2026 at 01:14:58PM -0500, Sasha Levin wrote:

> This is the start of the stable review cycle for the 5.15.202 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--iWfyzNFDF/2K9AJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmkLNcACgkQJNaLcl1U
h9Cwxgf/feRu8t89wQyxJgg9xKuMld6mf7KMRbrJvcH7MC3f0p/QGuoB/YQ7NJhW
m4GU0MiWtJxPWUn6ZizgqjGlWMYHB1SgeOZ+ym25mFoDrvKk8YPCRDdj2CbSEPEa
xC1bx2XTySf65o43Rs+w4t7oau3mskNICGQdBq4qbMia1JMHKMc8jeID+XCj0I2u
83m5ApSTEt7uM+6Q9MrW0FzjlNORRcyQvDNpZ7dNVijyXDF5HRBdS+K3B8xE2dT0
dwAnCMe/Z9N2SUpI7005s0mOSRa1+dvf4tATfPb8+TnZFV17Gam0fzn9FFEkweeR
M19m8u1pWACjWoix6UUHGfJUiDsMBw==
=2PvH
-----END PGP SIGNATURE-----

--iWfyzNFDF/2K9AJ2--

