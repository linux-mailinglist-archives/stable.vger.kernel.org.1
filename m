Return-Path: <stable+bounces-215657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEo9NOori2lEQgAAu9opvQ
	(envelope-from <stable+bounces-215657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:00:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B511B11B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A77CA302BEBB
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB0328B48;
	Tue, 10 Feb 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBWnMij1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAE1A294;
	Tue, 10 Feb 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728421; cv=none; b=cDZQjAv/Xd99laGubOBcGprYt05TtBCpCtI5mmFkN3DHflPk/3EhkyfooF/sQmqPySsCVLaRQc2j5asoFuGBiFQgNZf+S+xuDkeEI9F2mj8Vi8Mbi6Nc2+ONxjZKwNbJ6B4+aHAefAuULUE+CSx2NQsw27ONrCp6/c8+kAFZHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728421; c=relaxed/simple;
	bh=Yvr6V4PH9VNc0x7TopA7i86TbVPiDDNM/VrkrhuwuWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9lLubP9yloMnsxFI9bkRYWfRwHLpJlfznSi06bTqCa3JmUiMxZnd+37zU0YkH5SNP1wWJrb/h8wklceyAqNwoXuv0L2naWTa6t1RUpQH/j/25kzy7YN8+4fWTTn8WNVEU/EvRYRdkYhv4Wx9PGFbnwa7fH8zYKDW2j/ExSiOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBWnMij1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DB9C116C6;
	Tue, 10 Feb 2026 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770728421;
	bh=Yvr6V4PH9VNc0x7TopA7i86TbVPiDDNM/VrkrhuwuWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBWnMij1O6wnoGmk/vCDWJ8DfizFHgbS4DrdSM2ZNEGzrpR7nlQy6nGF/bWNrjMds
	 9TunFNQKSKd30Wv7Qj9sc8Q+HoQj0Cd9H/P0luNeRlARw0YdDi4TJJ7lUrPmnfqgDy
	 Ca7zMpTbt2TRdPFidgIxxBhBXpcaJDCM187n61u0ciPM4PeAdnJKEvNeJrboP9XJT4
	 YvfVfbW1CsNUb5L6svTpmWJ1rYnKYi9CK5IxddgpCHbQLrhmknSiSIoVOqrrJ/vu/i
	 IKkec+DGXhyiwF1zSjDbK84v3VErYCkp3RlrG3YJT46xLJq6RKXCYAWaC+glYSIDkB
	 xUfGxs/b+zQVA==
Date: Tue, 10 Feb 2026 13:00:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/113] 6.12.70-rc1 review
Message-ID: <b7a499f8-fd6a-490e-b1ca-8f2aa2046bbb@sirena.org.uk>
References: <20260209142310.204833231@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSoaACWq2QqvHoXp"
Content-Disposition: inline
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
X-Cookie: Spelling is a lossed art.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215657-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: AF6B511B11B
X-Rspamd-Action: no action


--LSoaACWq2QqvHoXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2026 at 03:22:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.70 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org

--LSoaACWq2QqvHoXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLK94ACgkQJNaLcl1U
h9Br5gf9ExwZEPOuAo4alfba+2hWb9WgtPKzqe9AtTnThIPEarA/3Ca+iPBff5sa
p5QalyA3RqYMxo/ebZlVhcjUZq5AjVtuFB1tg0toQColTnP+hI6Q/zdWMlOa465V
zGUqGjCNL9i0zpTo22hw9Oca7IIYovNkO7Ymu8uCx8xnpBXGfMJooHHePf+xeXNq
lbLkV+xYyAmrGauJEnQ0DcNJ75KrB5Nu+FzHgH+3jfRq6FslOVbpw0RnEWAgp6CT
L+dba0Vpnl9K+mBN/SPQzpuh6GXJ93N8wetLEdQ0qSbMnTUxvbClma+KH76JuQut
ge7SyvkdUR6dcuTMbUAyytRqJNc3OQ==
=gVpk
-----END PGP SIGNATURE-----

--LSoaACWq2QqvHoXp--

