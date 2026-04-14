Return-Path: <stable+bounces-237760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI8MG9P53WnJlwkAu9opvQ
	(envelope-from <stable+bounces-237760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:24:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C09E53F7384
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85A50304D425
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424C3A0E81;
	Tue, 14 Apr 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="j4N+rUvo"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4F39F17C;
	Tue, 14 Apr 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154813; cv=none; b=bzBmWv5srU+jQQAaAuPj/BhtjRumCnQDmZ1vcyOjsSu4QjZoPCqHrb5OUKij7EUKsdFAY/21th2VHs7dvY+YuNL0pNHQcV/Whx0A0EkKYi+W3rIlY75/hLuojUPSIb8h7gd/qnGs7Wupr/iTJEtEOk5VjL+Ry9uMjq/pckeIN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154813; c=relaxed/simple;
	bh=oykHXkpjROeyIB1neFhOSiBFwyB0JQ5MRgug3dnx6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hey/F/egD8M9anm+f2Xud9MRF20AqW8aCEle/8MiWcJDhdQqKszKP0SXtsfiUYsUj8mX6d5N1VN64ncamO9EubEvSOHditDSbU434hGfkJA7InGCkQ3Et+zRNzc0VHP+sFyPKnwv4iy9mqxUvNjTGiY1RG3pKamJtOQZ3xahiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=j4N+rUvo; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0E071058FA;
	Tue, 14 Apr 2026 10:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776154808;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=llJPZZ83E1q0kMIBn6Sh1qcdCsI4+Icrr2Epz1J1pCs=;
	b=j4N+rUvoWwiJTyxCLVZGJOH0MVgk+aqCDBkBo6aT07cKGV+d6NqCYlYe8CDEHwNbyRYK5R
	B/5qsRRU3Ay3RkGuAwDmpWkfFPWtQw1zIl46djeV51zdIcosz/l8wtCPdNkxXpGFu25602
	Gijxg5g6AlG2jcrmCjbAS0a13dlk+6NsEOG6A8xKwDsS5th+D762BIJTij/mb+ZPXv2SqO
	QwkmtzymREu6XGnulCkPDY32/z8t3eDZG6+Z7erP0yaMIiA37mfKzZapftWJEhf3Zkq96l
	Og3N9LiBUHEcqJUH0Pawnvcxk9b6PG+wulqvtxfJ8ya7UPYJBT+RuuQO0O+tew==
Date: Tue, 14 Apr 2026 10:20:04 +0200
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
Subject: Re: [PATCH 6.1 00/55] 6.1.169-rc1 review
Message-ID: <ad34tP_TcEYadIsu@duo.ucw.cz>
References: <20260413155724.820472494@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e6A9JHHX0cMICXD0"
Content-Disposition: inline
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237760-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[duo.ucw.cz:mid,nabladev.com:dkim,nabladev.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C09E53F7384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--e6A9JHHX0cMICXD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.1.169 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.19.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel


--e6A9JHHX0cMICXD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCad34tAAKCRAw5/Bqldv6
8loHAJ0bYnXf6orETPe7AWatbrnRcs1N5QCbB90wICPoITpbetflraY9cfwB+ts=
=UVxO
-----END PGP SIGNATURE-----

--e6A9JHHX0cMICXD0--

