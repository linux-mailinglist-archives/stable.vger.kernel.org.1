Return-Path: <stable+bounces-246677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JVuA56VA2rY7gEAu9opvQ
	(envelope-from <stable+bounces-246677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:03:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C2529CF9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80DA0301FAAF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D73C6A56;
	Tue, 12 May 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NhaQn1QJ"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE93A783D;
	Tue, 12 May 2026 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619799; cv=none; b=NbTUv305nApT4LHaGzzJPJmAqBbadNozbs+ujk++vNimAZ/743RGGEGjJdU426sK0sA0Pmj+0rf8zzRFucdkRbDLK07Ox/5VfhT9uvDnkmTy9gX1Ie/eV27V82ovP3SdPf/X0WfFTWqbdAkZEFbYFFmTcZgC5me1Q9QvkXaNJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619799; c=relaxed/simple;
	bh=Ln9/QDqnVC1oH3vzxuT+zkAI+vGf8aPcLTtsmJf45z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbcR+xSz7awg0gnuaSrRe17hiA78/hiDHDWUIe8Rt7/3SSCsX8ap0+cWwr8Z3cXxcm/I0iuz0fS3XY0fbLyTIuJbSDGvUr6IfcSv8DTHZU14XJchf8Tj8zuE0tVl15H6RcQcCbugEDUPLXCXpa76MTH69zAaq78ZpwEfMsVuH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NhaQn1QJ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC42A115555;
	Tue, 12 May 2026 23:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778619795;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pdndVkyOSJ+QzaTIMxoKsc3ir2qqNVzp2PfRK6v1F6U=;
	b=NhaQn1QJmq7AWxvvIcIB2e2OSnUZlvp46WrlBC51Fg0YCkvgecZ7AUDolGroCG8sPF9Xnq
	Clf9xtk1KUQVYZZklRBDeOL41elHTdGertOvqtWoYE9pjYLjGdYJMHrIgAoDy+SnUFTqtS
	cMFyH/EV7B+CRYLBGkSxnWSIAkDoxnJHFYj3eDQQ5jtZlEqNUT8JwUkyIU5jaYpBFXGuf+
	065tsq3IYkPwlIOXhhLCQOpIGKiNgNBSAZbD/BmatCkCOVfkfcdx24NDkIJElODMOQLjpu
	pFVcOtm0V2zQ9fU3+02goE/97VGiVd3pSZE/o6qG/pZke4xiqxWV4gMzH61alw==
Date: Tue, 12 May 2026 23:03:10 +0200
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
Subject: Re: [PATCH 6.12 000/206] 6.12.88-rc1 review
Message-ID: <agOVjtRJWBoqf35a@duo.ucw.cz>
References: <20260512173932.810559588@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bgX5HV9KDREe/epZ"
Content-Disposition: inline
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7D6C2529CF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246677-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url,nabladev.com:email,nabladev.com:dkim]
X-Rspamd-Action: no action


--bgX5HV9KDREe/epZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.12.88 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.12.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--bgX5HV9KDREe/epZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagOVjgAKCRAw5/Bqldv6
8lfLAKCneKDgP24MEGFbsZBLhNfbYA4EwACeORsJMexGhabSFMqnWK9F5KmZ/Fs=
=k1xo
-----END PGP SIGNATURE-----

--bgX5HV9KDREe/epZ--

