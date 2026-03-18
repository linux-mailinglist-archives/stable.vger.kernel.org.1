Return-Path: <stable+bounces-227142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPCuAXv7umlwdwIAu9opvQ
	(envelope-from <stable+bounces-227142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C52C1F73
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E28D30143F0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2593DFC8F;
	Wed, 18 Mar 2026 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Mgi0ntCs"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5403D648C;
	Wed, 18 Mar 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861746; cv=none; b=HpvsAIhzXzUGUEziebZbHj06S4ZwjUW0lzkNk9TlnX3U5bUAbsY3mUTwOT09/sqQAjT3l03pAJq/TX1CN4IPKeAoLlgUXUcRiTdlPmOhzS8UB7PJxOmdBBy9OJaxEnX1hCn1yVpmAreoDVA1JA2yivmVrX1cPm5GlmJXURP6uCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861746; c=relaxed/simple;
	bh=/n37VeJnUPdxamb23b7ifjRa6JuUW62dYfbCx3wst1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiSYw2Zzr22f/pEQJEJmtq2A5HFKtpmjodlS9ByXyFdybxEXw9yrykDbcmTSRcfs5MW+Y9lMOpWf42bq7dIpvBFhOGZybJmuK3AEk1GJ+mhPRFPOPBVmRurAnMZLAeA400ix45LG+9skypd8osxuLJjZG0bvhq9QHEogtJ1WzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Mgi0ntCs; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B2BE10E848;
	Wed, 18 Mar 2026 20:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773861743;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=j8WwpID+9y/QLfVLWV0ys1IBq2nnRtNSI7JbiO3CPgQ=;
	b=Mgi0ntCs7T/HzWJ18g9LuirSOdZYJfD2vwPlXXYHtyz/gEnXpJB0hOMLlestZNujjcItD+
	iYYVkFpeOlLT+AoPAGf9wHpNRUBRv3FYYW0yYSWRazyQHvxOl6EmTwRuJS3/Sw9WtZexr8
	wh2XM/lAJx22WJEsZkFCn3CLhK+KA74qz+iQLjbNTXlTInkwm4BbfVCwzt3yt6AZzZf4tz
	p9+jNBwI63F4MMe8rqmqhoXUzzFlBO8JD8lPdNpYfoq27o9jmNDcFqCFYESROhlNFz6bVu
	O7XPsPRWqKm7sHa7mOreXnP0KT13I/bRXWAYLW5modyQcIVfW+uG/ebOcvia4g==
Date: Wed, 18 Mar 2026 20:22:21 +0100
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
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
Message-ID: <abr7bZsXSDcGT457@duo.ucw.cz>
References: <20260318122547.233850204@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qmdzxYgT3Xj6nvQW"
Content-Disposition: inline
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227142-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[duo.ucw.cz:mid,gitlab.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:email]
X-Rspamd-Queue-Id: 984C52C1F73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qmdzxYgT3Xj6nvQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.19.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--qmdzxYgT3Xj6nvQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabr7bQAKCRAw5/Bqldv6
8sHGAJoDE0jbiSy317/8wd6/yXZXoZVVZgCgvQtxFSWZy92W+2LqUSii7R96lhg=
=7GDq
-----END PGP SIGNATURE-----

--qmdzxYgT3Xj6nvQW--

