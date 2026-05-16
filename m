Return-Path: <stable+bounces-248975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PdbSNLUhCGroagMAu9opvQ
	(envelope-from <stable+bounces-248975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 09:50:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16B55AA48
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E6C301113E
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667CB2F7F0C;
	Sat, 16 May 2026 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="PGSeVvAf"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269318DB1A;
	Sat, 16 May 2026 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778917809; cv=none; b=TMUdwA27V5VxEU1sNuU/gA1e+VAOEexuUmMwY+GslPy5GhS12aa1K5gunTwpwzwZY7AtjmFuBoulfzHhiBYDQLzERjsffudWZhiG+RvV9CHmuc8nCDl76poYk6hj9WsQvfEOWttWZTbkgJri9f6P7dZdhDva4oyZXD8Z05pMmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778917809; c=relaxed/simple;
	bh=atze2jfNFJoiG98/XvSgCC1B0Wcjagl2Z16qg+nNbU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggUAtJXIV4YYgosPwGw43ONwQ3CiFuVLCwY2AOI95vaKHTASbmDsou1nhxFijRNIEPHlXow9RUugE+fdDrZqxVk0VjKyN6TUoRHM99SIwLi7VYJAqiof8zbNVBNwm4W+oOI0HQ9FZMREzIzzWhtmD4Yo8sKqN7Lk6MJtaCcmYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=PGSeVvAf; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BEFE115D28;
	Sat, 16 May 2026 09:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778917804;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xxHNgb4b5AzrmFNaxheW6hdSKh8RxymdhQK+Xf5TjmE=;
	b=PGSeVvAfEbxCcQ57tqyZtYHzMGWRO8LkG/G5ZAt51A+JxX+FA5z3ySGU61vM1HgZYUwryD
	yZvl2jZfwYa2EOU0Pqp+Gq2prclCcvRGR4d3wbN2F8DiUmPk8droYvvXp2jdHJQ+D347Bw
	5mcYPOOQiDqWrtWEieMN2JP8TlKoX7eKQm5UQlC02elX7/Sw2N7ki06oinhkXBV/MPhYYf
	EOhpNgEBdM3eLFs2lL2ljcN/dreNVDyfi3BD4JtUlhQWuzJE9vFLKRlFT9RccktBzQ6yPq
	gki2OjDxtO9d0G+XeVbv/YXJyhXFQq+6ZnDVHH9+sIkd2F8E9JFH3Yw1tOy81w==
Date: Sat, 16 May 2026 09:49:58 +0200
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
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Message-ID: <agghptFaCxg035YS@duo.ucw.cz>
References: <20260515154715.053014143@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eoWplzZ9Tp8d3isz"
Content-Disposition: inline
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 1B16B55AA48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248975-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--eoWplzZ9Tp8d3isz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.6.140 release.
> There are 474 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.6.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--eoWplzZ9Tp8d3isz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagghpgAKCRAw5/Bqldv6
8iM7AJ0YnTxvZaGj18SVy1M3REsp/xNhLwCaAkCNUZbQpO0w9HwoSH1T71kAWgs=
=KaPs
-----END PGP SIGNATURE-----

--eoWplzZ9Tp8d3isz--

