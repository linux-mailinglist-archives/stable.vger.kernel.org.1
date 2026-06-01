Return-Path: <stable+bounces-259481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNvPN3tMHWphYgkAu9opvQ
	(envelope-from <stable+bounces-259481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:10:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BCE61C256
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACA7E3054E1B
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C088E368D4C;
	Mon,  1 Jun 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KvdZvbf9"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E631F98D;
	Mon,  1 Jun 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304200; cv=none; b=Inxsl5pNvpzHY04356yOyH2gkDWsDLAgICGQHS+ed1ZyQjMSsJxMTUU8vGGY0Fp3Qop5UTr96WqN8R9YbB0+9Qi78wyka8cibDSIm7F95vOQR0sSGuswV7HuXwnYZ6ZT18BwhKIbBf07ELt1AiAaAONLoPy3nMiiAIObYCWN+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304200; c=relaxed/simple;
	bh=kdjmhyKz//fjIMOuk1DoUiELRlSQILJHokm+KiwW8Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mako5198qQLBNTAwZKxxx8HdKY9PdpwODarK9Q2g5pDfRwSjN15krFM5aE+MKjkFhs4ZqOrFfYIPHUSqh4QImtwbttyLna4NqZpqHxxbmf53QpgNkAqj7O/1m7D0VSMfojjPiJChl05vBKojoNEdnVVeqMcP3lLE7PJUGtYBZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KvdZvbf9; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E25B0116BF5;
	Mon,  1 Jun 2026 10:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780304193;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yNB8pokyYVxKzFS/Vh+8vPeb0b4cK/EFAVmU3A9AKyE=;
	b=KvdZvbf9o12dTIcXcRuOkXKXqrwNHkvQ4JL9ZJ0sjnCmJ4DDhMZ1eQ+kTrjHSBK++ZU4Em
	urhbv3VtcXH6z1NsL+Js8/VZITElTGk5CMRxuOqfoVNUVtwi+GKaS7139JCzkJpsmeCYjX
	m1fl+i0jej6QM55oBRJ2n7G7L7d06SlGoR211p+Z5H9hR9cpeAJQ3jNZL4izoc0JLmpZjP
	sV+f7zPQoEqW9Fv36P4mWNAmLLpiVUkuo8krDl0Q/aJWSioMcKwp4UfIPhJVr1QvjtgVXn
	6WTJ0ousAXSiwoMKoahks9lhAUJBRDkepPRjLH3nE9HGWmoLfLX2wWVDLbrW5w==
Date: Mon, 1 Jun 2026 10:56:30 +0200
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
Subject: Re: [PATCH 6.1 000/969] 6.1.175-rc1 review
Message-ID: <ah1JPrjMumdcPlvG@duo.ucw.cz>
References: <20260530160300.485627683@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cgG21IZHn9Yqy1T7"
Content-Disposition: inline
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259481-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nabladev.com:email,nabladev.com:dkim,gitlab.com:url,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: D2BCE61C256
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cgG21IZHn9Yqy1T7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.1.175 release.
> There are 969 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.1.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--cgG21IZHn9Yqy1T7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCah1JPgAKCRAw5/Bqldv6
8ptHAJ9Jx3zozxGqV4kdfoA4T4PXcxqegQCfaF9ugW29UZR+5W2gH1unrERpnJc=
=z6CZ
-----END PGP SIGNATURE-----

--cgG21IZHn9Yqy1T7--

