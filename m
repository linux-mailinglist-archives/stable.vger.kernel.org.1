Return-Path: <stable+bounces-235329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKcZLdVT12kFMggAu9opvQ
	(envelope-from <stable+bounces-235329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:23:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 762D43C6F70
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE4A53008C2B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718E3793AA;
	Thu,  9 Apr 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="exbVVjsN"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481D371063;
	Thu,  9 Apr 2026 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719377; cv=none; b=lK6LrXP5GO0rMxXW3cfJqtQ/XDmty2IzPcdUxV8sgMeQn+q9m02hAPxOrpAKjc8jStKTZlZUblK4pMEnmVtei6TuaQxIDPWMStjvrgQwgFV0KxFY8tJj4nyRuXyNLbigG+jsNcEQNfUvmfYFBDnNoSSTlsQ87uWpWCkEt2IJhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719377; c=relaxed/simple;
	bh=crl2m1t0WmzqiuY/CuK8wS00Q6A4wRlil8zG2+fmid4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJC+Z4Bjz1AeGO0oKgiPEQVRuR6ZP59Ptgz0lOqALB5oFZJPAqrieg5JCcG0AM0pGVPWWOJQUHRYjcuApTRAKP/661P7ohn4hSVjICypAfNCE7JBWgvHJdQyWISU2rGdX+BuoEV/FZWfkgNB7j+3GwuTaA8NHjrInrB2DJZEFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=exbVVjsN; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6A9110DE8D;
	Thu,  9 Apr 2026 09:22:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775719374;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=b+LfA2rrGd/zyHTlUzY+SOA272LOQDIEYpIcg0TkWQ4=;
	b=exbVVjsNXt7NIC/XaKzt/sQOF35ApXuY4po/kgTiaQElLmLI4VNGzGwhBYseuJX/YShSF+
	7mnxp3d5Sp8o5CSQm3f4PV18lhHMeRsIuPujej4Mqu9YTusmwfLRbqOYv2ffr3ML7tds+O
	nU8vPkI5xU4crb/ZizAh3G2bpHOmHWuqFFavBtyMQvWpYIaZ7OzY8b6IK3HbKyWPK2Vee8
	f8xUg7KrHXbYkPVF61YmRe+xcgM2dl/zgy0VUg16KmGebwC+xZXq6Gx/6LBLBjeoH7AW/l
	7pgSFx91lGMYsDSygBJSgrgIvs9ZmUViLtMN+anDAzn8yKEePqLM4OB6TFeEMQ==
Date: Thu, 9 Apr 2026 09:22:51 +0200
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
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
Message-ID: <addTy8nZOdwRkzTQ@duo.ucw.cz>
References: <20260408175939.393281918@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyAIJ+VV9KRRvqOk"
Content-Disposition: inline
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235329-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: 762D43C6F70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--RyAIJ+VV9KRRvqOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.19.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--RyAIJ+VV9KRRvqOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaddTywAKCRAw5/Bqldv6
8rNKAKCtvNZVG82+WJFoRbZwq2vAirtOTgCdErmjFh3ex7uMTXiB6i66Elq+pdE=
=7IPj
-----END PGP SIGNATURE-----

--RyAIJ+VV9KRRvqOk--

