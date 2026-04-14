Return-Path: <stable+bounces-237956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAW0Cr2F3mnjFQAAu9opvQ
	(envelope-from <stable+bounces-237956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:21:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD233FD966
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FDFC300D9C8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D97318ED6;
	Tue, 14 Apr 2026 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc/jGM8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEB31328E;
	Tue, 14 Apr 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190863; cv=none; b=lqnQQ0T9ZO4HTUA/QV/duXocRMRsPOt+OGVEqyMPu/SQPhMJRQ39x2pL6S6/9PbrrZ6KwVJCIRr+wolbYeLiqWWUlP87iYzC5TYh07XFiU1QsSZZpilBiwm2JRIUQ8rabV4nKKQgwNp9T1EgjojVprtdfAn7STWISbPljePZLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190863; c=relaxed/simple;
	bh=FFW9Zvt+BjBFAk5SiajSFC101vF65ZByXQRcC26cqXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKmOIT3kYYOvLF5ssYSOwyrxcxN14etGZ6rcM4BQaGu1ykODCw54wlLl8u8QU+JvMEAw53ijlKPS2xFhobjOg2l0k2pA51nCCArdBrfDVaVT3EsbwewgIugkYKYENFM/l/ufhlX/0/68nGrqKVo2VJgADBw6DMWNB2xt8iFnbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc/jGM8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E79C19425;
	Tue, 14 Apr 2026 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776190862;
	bh=FFW9Zvt+BjBFAk5SiajSFC101vF65ZByXQRcC26cqXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc/jGM8wsSPsi1SVkU5YOOPSzstTPSPSNBttnKOOyKZ74YJeXAF1ddZKBxG+cBb7x
	 6LDX3WT6YBHPEhQTHJlX4E1JI8CMW6d4qFKVzm4h9Fgt8Znb9M4Xjh6EZqH3CXOdkb
	 XRKJ+I3b7/h9iwbpYYhCDwCs5NXZHRXOTJjvw0L0K6se3NL1dDTH+AUQIswbC6EV/g
	 HXANpGrOTICqODUirFu0wnA0zM4UlVJz/9Z504cLMmZWdiB9iw6Yte8D3/hgcTG3np
	 8ElRjJfp+/HcVQVPteA++l4oITOuRp91X4pi40gENOrVa91UK3qokJ0yZxjbgmL3Ey
	 2tRKtmHP/dhNg==
Date: Tue, 14 Apr 2026 19:20:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.10 000/491] 5.10.253-rc1 review
Message-ID: <9564f562-df5e-42e9-a9e0-f0e605a6e441@sirena.org.uk>
References: <20260413155819.042779211@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AJDCoQf2Yb13sgMd"
Content-Disposition: inline
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
X-Cookie: Academicians care, that's who.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237956-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 8DD233FD966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--AJDCoQf2Yb13sgMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 05:54:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.253 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--AJDCoQf2Yb13sgMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnehYcACgkQJNaLcl1U
h9CeUQf/ZHFQl3jVY/4ngtfNH1oJUnanQorVAR6fPaQfOa3AbIAO5GGnzY6UZDnn
igA/sPaAlLQerZK2qFgRsTi7nEBA9HAE27Ot0JZ3VhTVSYlCTfbB1rNN2ouZuPnA
dj7gxbW8sIpQGB9S9iUy+uRp53ESqPbhiRD1t+aIFPq7vTrIdHoeb//h9XuAE3bN
JOKYYlgLP2G9wuBG78smR2X9cLEfSPnxcEDtgKbyxttWnMFWf0+aNUuZxcSpcY4G
HDT1UHTKL6gmSV/avllEoFQyh3Y5vIOV/ina2jScFxmwg5xbrm3wyxU+YwW6wG4/
z3py+cDCpYB0NfjXDEScrFaLOv5NuQ==
=umX2
-----END PGP SIGNATURE-----

--AJDCoQf2Yb13sgMd--

