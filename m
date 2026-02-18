Return-Path: <stable+bounces-217264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPTiNCellWn4SwIAu9opvQ
	(envelope-from <stable+bounces-217264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:40:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51107155F2A
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1C03009B0C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFD30DD13;
	Wed, 18 Feb 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZXmMOnh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF52DCC1F;
	Wed, 18 Feb 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414821; cv=none; b=u3fWptq4SuteP8cbj2IZOKefF8XhZG7h2Vj8+jXp8R8b6MzCe9Xy06dQ1cgo7O1FZJcAvwoh4Xmpsl8pNhW0psIuzTABJ2qwLELvj0FUOayhdQ2BKgIdeFR4neloQIjv2CzYupOf7BXMeMI4aSvVGr1tMICF71y4MTgIs1+vjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414821; c=relaxed/simple;
	bh=BQgQ5qLcYRi5LRHIlERVsxvN/FlZDTYpWB9Pj5yLa4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDP35ZVcn0kpT7km2THM/oUuO3XvzVCzGKya1+JdunCnZmQp7fPJ3HjqPm7LXXuiB7FxcGTw294+w6FBqnXtLrksm8HhMIR9Xtx+fav0rXQriqObgJdQto6CEGM1wxngUIvxy/ppCh0Iy6wmYDrJNSlTKAXyvsYL75U0rIjLgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZXmMOnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E8C19421;
	Wed, 18 Feb 2026 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771414820;
	bh=BQgQ5qLcYRi5LRHIlERVsxvN/FlZDTYpWB9Pj5yLa4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WZXmMOnhGmQY3yxEabwFwAx/y3CLnodIIK6t+RhjndlM0qulzYz8rLa/ZCV4S+GRT
	 7/E8suac3OysjGAaFSV/g4JcBqai4rD9OCL78E7BnozONmWR2owdso7ToEaJ5uGhXY
	 zgKVWN+bYLOKjKqEpCm8K9kc5QwxgmLercgCjQ9S49ZbNCOAAvRxbZH4Q/4TZyjkiH
	 S+w0Eo+8MdFvwtbw/AQkZmwKfm0wK8YVeWaGnj2l+duC+GDwf1X3U+Nb8zJSSkTQK9
	 mfotRNaf5lqxDrAvzQfaeT5QnbxIbtsFrU4MpFDb5l7SCeHsMHSzeVv1v5BCjJtqxo
	 fkwyGNTsbQ5Qg==
Date: Wed, 18 Feb 2026 11:40:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
Message-ID: <c63f4882-1853-4e10-9f9f-129d60d61421@sirena.org.uk>
References: <20260217200002.683975158@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZrLDxUzRS/7FZ8MR"
Content-Disposition: inline
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
X-Cookie: They just buzzed and buzzed...buzzed.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217264-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 51107155F2A
X-Rspamd-Action: no action


--ZrLDxUzRS/7FZ8MR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2026 at 09:31:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--ZrLDxUzRS/7FZ8MR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmVpR0ACgkQJNaLcl1U
h9C/bgf9Em/GAa+esLQ7xI7YQ+7ntKkq0zwaFARFLiUFtMqIZ6x6jApe2P74U5Ib
3KCnydfZSPyTzO/yw4bxZomaIms2S+cfFQ8TnMaOCfmD7JdxIsS+siiIt8Jow8HV
RzQ6kdpdDT7cGZoOBiDSiyxo9GpKerjpp54xMl0M2vm0TNE9JDxqextMD2EWdYnk
CHoy6jhRXrSXkHld3XWzSwpzCekDUXtPZ4eibmqeM96ZJjXGatNcG59L58KrilQG
bWyIDpzBUjbZCU5nwshy/fBaal+e+P5zFfa092Mj6q8+3IJqJUUK1My0iYMVVRVj
gSwcGtIVfpBK2A6gLoZlln/Pq1wWpQ==
=qtDy
-----END PGP SIGNATURE-----

--ZrLDxUzRS/7FZ8MR--

