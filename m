Return-Path: <stable+bounces-225362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBXzIlc+tGnZjgAAu9opvQ
	(envelope-from <stable+bounces-225362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:41:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 866EB287489
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3D3B300BC94
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D53C7DED;
	Fri, 13 Mar 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZXyfgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D963C73D7;
	Fri, 13 Mar 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420060; cv=none; b=ERs0o4ABsRR3OPHK/NzMB5+gN9bPszvQYoTQWlqvhurI+uVRho3tfbD5Fb0op/eAtlKak4VQXKgHM4BzKBIIV9dIkoy915tcGDV3P//TG8ukGExzsTX+cGm2uVGGdxXlDrLYhARtnX6cr2SZ+sGEFEXqU+7n1VzYuC+rZW5AX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420060; c=relaxed/simple;
	bh=uUJT5S/wnOF5iVsrEtl5WrHPGTZVElYrlF9m042sl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHTS5i3W98X538KjONi12+rQmsUbNjVLAzrx6xxNGSsN1X8vvSg8xeE1jxnfyxd3h5czK4bWMcKAn8ruzhkpuB15zwUrxRUDgP6DoUq3/b14xqQ8Cv1YdFb8GbJHBc5ja5cG+z098cUd26/IAZnUgck6o6uB9DaAnXPSgx4AhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaZXyfgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44540C19421;
	Fri, 13 Mar 2026 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420059;
	bh=uUJT5S/wnOF5iVsrEtl5WrHPGTZVElYrlF9m042sl0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaZXyfgKfp5qz6EtnRuJLi3xzzQsWMMT4+kgrL7Izc9jVwj86oqn4W6y7daM0EHOD
	 NgU1TRlfVE/RxK9QTSroKfh7CoiBMUwFkSKp82PcIcwZIKpwWyN/WRoQJSJY6boKhE
	 AYS6AuQhbn3YKjvBsh3e937oledJ07lvRbpxkCDIiSE/0WnHlBeOvsL5rQnLBycKYv
	 4MsRXRIpxGwueww/9Kwpu/wIzmFyPYj0RfQ5U9JkCWTVGT9BtFU2OuVQ+h29vCWtud
	 WRUvp8VF8JgjCUuxEAcFkFRGBL4/d9WEGJpOtV8vMdKQggDE/LVi2kmkmGRHodSe2a
	 unvFGRdZ8qAyA==
Date: Fri, 13 Mar 2026 16:40:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 00/13] 6.18.18-rc1 review
Message-ID: <ac8b0505-bd16-4d26-9079-ec179f7b8b6b@sirena.org.uk>
References: <20260312200326.246396673@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4kDf5LN62NAtP7FV"
Content-Disposition: inline
In-Reply-To: <20260312200326.246396673@linuxfoundation.org>
X-Cookie: Monitor not included.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 866EB287489
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4kDf5LN62NAtP7FV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 09:03:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.18 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Reviewed-by: Mark Brown <broonie@kernel.org>

--4kDf5LN62NAtP7FV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm0PhQACgkQJNaLcl1U
h9D32Qf/cN6WEHCyxgW9OktNbHtXNvhq1RyqT1iz3o/eUmwsbr6xrTZnUjlAXLux
+znrMO1kB1oW4hQ0TwmWSA0hON8/88nGNypd6aQPTUzcrLB2u9qWNPm4xAQ2A9NV
XhI7kFiyIgPWxucf/9xXbPBErMFajncEJbTcB7K51dyi9w8tBnKQbYZNz1rPj4fO
lqOsVkEKNSVhji+IO1nMiQ+/Qa2Lurka3P4/IA/vrRph/c4tHrCUYPl+6nUPotHv
BAt89/jsm31RJ7jj1hJmlitpQ2FpUggu1ZyVCr+EiEljLzdn3ojXDUzmOO/eh2lD
kInJ38mS+TJUR0qPBPBw2hgpqN3I9g==
=39wB
-----END PGP SIGNATURE-----

--4kDf5LN62NAtP7FV--

