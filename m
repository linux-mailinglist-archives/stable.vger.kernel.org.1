Return-Path: <stable+bounces-259479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KErwC+VIHWoqYgkAu9opvQ
	(envelope-from <stable+bounces-259479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 10:55:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E261BDCD
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2CF3091321
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCC3659FD;
	Mon,  1 Jun 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="gCK/lI1P"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED96349CE7;
	Mon,  1 Jun 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303641; cv=none; b=LNpJUPNTN8rWjMcTYvICm9QGHIza+Mfxu/hjUvRA86QMaTII/OcUP0cynjrGprlBVedhm7Elh6JMTQbnmCkPSjVTJGbrjoRd8oKSHshyZ9RxD/2tS7k/QAP9nRiCPn4l6yvHEkbBZd0V8nVtTenVJGewELBJVJqqwat7oqqm/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303641; c=relaxed/simple;
	bh=FvWO1DQR9PSK/kSEH1HSoxZBaYkieoINGM+a+PKJUVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGdYvHj6GCJUUywzGHrm/YydsY0gNnVD/xtrrA8cAd4Bhhzvf2Ush3rVrvz8CyzOFrWTeHcj7DilmLeOr9TMEQ31rgqCDRsIs6lPp6/zLK92UGv26yhGu4WRjFSLx2QO32qDQdvC3quYiEH5m64z0MgaghM5WMc5wWI98AMwI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gCK/lI1P; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C3BF116C40;
	Mon,  1 Jun 2026 10:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780303631;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YIeqwSroJEmQZI2uQ5WI4926AydeuIuVX4oqsN3tzz8=;
	b=gCK/lI1Pi6ZdyXqxfKSelEi2CA0EOtX6+IaNEBX0im434GQE76XUuFUrrkVJmGpdS0i6Ph
	3r6LlwAZsynaRe2jNAA5qi8K5be0Nfu7tdSwWtWyN5fSqxL8BI/ovtgh+6SkkYi+InRi+1
	Kn39h0eXej87vNgOGH5CssgKklX6RfQ4VhOjLuF6Y5caG3SvnRFwm2qlzZwUzey5CpiIPn
	33XXVVAsEWMU6Gw+g1QeKcLjfeYUOzG3KR0XWXSExfVwjqjoJoapY2t/4HHNB4mDxodViN
	n0KsAkA2qpJnuuei/YKYsvR1FT50inxoW2ja8NprweQuqhSedY3cphfC2fMAhQ==
Date: Mon, 1 Jun 2026 10:47:06 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	claudiu.beznea@kernel.org, Chris.Paterson2@renesas.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/589] 5.10.258-rc1 review
Message-ID: <ah1HCk9vuUMCzAvU@duo.ucw.cz>
References: <20260530160224.570625122@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wPkJT+ToGdUfRPPt"
Content-Disposition: inline
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
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
	TAGGED_FROM(0.00)[bounces-259479-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nabladev.com:dkim,ciplatform.org:url]
X-Rspamd-Queue-Id: A87E261BDCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--wPkJT+ToGdUfRPPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 5.10.258 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see boot failures on 5.10-cip:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2564188475
https://lava.ciplatform.org/scheduler/job/1451830

This may be related to

[PATCH v3] phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context

but I don't see related patches in the shortlog below. I put Renesas
people in the cc list, they should know more.

Best regards,
									Pavel

--wPkJT+ToGdUfRPPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCah1HCgAKCRAw5/Bqldv6
8u4lAJ403IuxbDkgW7SL4NdEnFK61WHBNQCfSMZnfRg2hVXgRqOWkqgBGTmb+TY=
=XZNf
-----END PGP SIGNATURE-----

--wPkJT+ToGdUfRPPt--

