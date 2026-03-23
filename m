Return-Path: <stable+bounces-230002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJkoD02SwWnFTwQAu9opvQ
	(envelope-from <stable+bounces-230002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:19:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C404B2FC148
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED793008280
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5E35AC25;
	Mon, 23 Mar 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="a98gjz9A"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB935A939;
	Mon, 23 Mar 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293578; cv=none; b=o97dcm6huuQHqhcpXCFmYh3JOgMqV9ccZY8H1BoovnTm9XVNwpfK0mB+aYoL28vRHdYraUavnNa8gzUAe9e+/VjzliEhR78i+tmNq7/CNqaUgFQRGT1AISiSlFGme/iDgLJBVcQlOae51nmx7TTqXGrArXu1ksKRA5F6P/s8BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293578; c=relaxed/simple;
	bh=eCt8GAL1Xgby/lPohtIrWF27irt3W1S4PMGZxkmiF1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFgCROTmP80uLmhQVIc4uJaUV2dfs9owrI9lJPpYWEDEz29OArKutCo+HC2faRH/gcsXnnMfIULKhXkj9+hmpy7t8FngXlpbALPeBPyhOQVin3cQJALWbYoNb/uuwzxcefmDoPMHvNFJ8PK4rlb31WmZ6O4AR1Pc6pflR79ZKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=a98gjz9A; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFB1C108B42;
	Mon, 23 Mar 2026 20:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774293574;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TFBbyBz7BIpcfBZoBmjRCtrvFR4WOSUFh7RusRHlo50=;
	b=a98gjz9Ak/47pJRAeHpNW8FSqvPExfrLPQNPULeE03azchXqRgiy1rSyOh0NGiYPyvLoLU
	SLtRN1R1bQyBwNO1v8haKlCGm9dj03V0/PrfnNafigpmHsmqb7Y+FxQbwADNz1oK5Suyjs
	7Sf296jeSKxTtrkech7WxcxFVCgGZB4U2QJ2mS7/Hp1Lybu1wqlKlxeadQKWBdKvgkp8gw
	xGaBqTAuS1TmNF6D/yj2jXajaqCjLa+3Kcn7L8YAIauoOWSQTVdC0PsvH+/ZGc25KdPCyP
	ijgurLrHSvJVHz/jHuzeacN6j5t+EtzM8SZYsA9ucS8yfAqgMy/LycFynsSRDg==
Date: Mon, 23 Mar 2026 20:19:31 +0100
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
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Message-ID: <acGSQ3fiv_TsjjKE@duo.ucw.cz>
References: <20260323134504.575022936@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v8maf0VAtSXIKhFB"
Content-Disposition: inline
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230002-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:email,gitlab.com:url,duo.ucw.cz:mid]
X-Rspamd-Queue-Id: C404B2FC148
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--v8maf0VAtSXIKhFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.19.y

6.18 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-6.18.y

Tested-by: Pavel Machek (CIP) <pavel@nabladev.com>

Best regards,
                                                                Pavel

--v8maf0VAtSXIKhFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacGSQwAKCRAw5/Bqldv6
8vPzAJ94Bz0rS4aHwm3UD1EZVWmNj09RkgCfRMS59xEtPwFZxXGUnBU6pgs+Dk0=
=XCXA
-----END PGP SIGNATURE-----

--v8maf0VAtSXIKhFB--

