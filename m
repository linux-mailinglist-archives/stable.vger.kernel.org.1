Return-Path: <stable+bounces-256551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MUtNEVPGWoduwgAu9opvQ
	(envelope-from <stable+bounces-256551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:33:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E15FF413
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FE13089E57
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27F3AB5DA;
	Fri, 29 May 2026 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="S8kTcXnT"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867213A0E8B;
	Fri, 29 May 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043326; cv=none; b=GLNxD+nzHHDGu7tf6OVjqser0H25lCCNci4OX+VDV8nznSTHkKEY8xxKZQVYafibleuvM2XxlFwtfk+L9cF3/DF6s7Obt1uAEqPIJFmCnN7SS7KSjgRxLmzfQ4cqkRceXMt8gPUhZS9kFzDyWUdNEfZ+T8rUeE9kvO6lkzyM9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043326; c=relaxed/simple;
	bh=rfaQTsDARDv2rWRPISYkj21mRcbs3p8S7+4tiqbmeoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYJHitwYa/yqu2962qAl2lczwQB7IUzl7Wk1QEQ6z4p7b4RaGmYiRwB2Vr50m5juFFVeYTcGo68KbdAK1qgrZ4mNhStxnoXcjKYcaUGjPIV23s/S7mZo0fhiQX216k3xLHXD1tikW4+ivnPToPehUVvnLLnrGtos3lxHw6Aqx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=S8kTcXnT; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D880115CEB;
	Fri, 29 May 2026 10:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780043323;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mDKlzVQqhPkP0caENvEL+QLVgJTkgEhTB92Wz0Mn1PQ=;
	b=S8kTcXnTqyp3xUsuzWRNJEL53/cPPyznwaXaVNQY6bFy1heWwJM+UePoNRq82U64OYTLSe
	JVfVzXD009U/R3pGaH690/7XMPjRc3FIUjASoJmbCvXVs0XLiacea196TkNCjpwj3HkGnp
	cBmKXOa5BX02WMfDce6s+QyC6K8f9D3lMxL1yV7467DVryHhQuCBAhpSEJimPifyR6fhDf
	uo38WNlMoggtjmWqJcyjd1uUgnYOhkqR8Sr4iFYfdwmf04G1jtd3NT744QWfswIe+EZGsz
	24vhYUOs2q2g5h8xBhJLg8NPd1/Y9P2MrCJ1ZeEpL+Xv3z8ySm7pwuBgDWs9Yw==
Date: Fri, 29 May 2026 10:28:40 +0200
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
Subject: Re: [PATCH 6.18 000/377] 6.18.34-rc1 review
Message-ID: <ahlOOIkulR5D9MEG@duo.ucw.cz>
References: <20260528194638.371537336@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pEZSPRa8PUxPKhwR"
Content-Disposition: inline
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256551-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gitlab.com:url,nabladev.com:email,nabladev.com:dkim,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: 257E15FF413
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pEZSPRa8PUxPKhwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.18.34 release.
> There are 377 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel


--pEZSPRa8PUxPKhwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahlOOAAKCRAw5/Bqldv6
8oReAKCEd38ZJjbIJY7QujPeL0OaDqDAPwCdErWq31VNrlsnbly2F3Ru+KLjT/M=
=JgQE
-----END PGP SIGNATURE-----

--pEZSPRa8PUxPKhwR--

