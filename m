Return-Path: <stable+bounces-32243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63188AF91
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A60F307832
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53841134B6;
	Mon, 25 Mar 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="sH/zu2q8"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F51BC4C;
	Mon, 25 Mar 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394054; cv=none; b=dNmtpUNN2mg4RJkul15zT7SW/ly9UXayeTA0xjyOSs+3Bpve/g4oKjF68iIrYEE7206htQ1XNNtTyFXlwb4NIzSqyoHE7KNQhzEwbmXgVZy16VEyxLT82b2d5kSvDQW5OwP0rNrwxhQ3AJa/yzLQD7xxOW9HaalUH6bupKrKRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394054; c=relaxed/simple;
	bh=DiLYO+iWodkRJqTOEiNu6GAd3X0dXX8ZaKgOEGopjt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZuzKUNtGgX4ovBvg+Xjk8oHJNETwbZObQXG/BbsD6EGAVuwmlrvWUJiy5tntIw+ypr88nkjpVSi33G3cE960JsKgmbXfwQx8Yogk62GK0Ql8h2Lb4bA1kbnsk67TaWazU7XkH3D8Xyf/qVPCUsrvU01kggiqFi9LqhxHvoXoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=sH/zu2q8; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 709D21C007E; Mon, 25 Mar 2024 20:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1711394049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTKQMqQ5swI5N8GoYSCrSa5W20pFj2E06/nVThesd4k=;
	b=sH/zu2q8P4LEeqhQ4rNLPyenXbf/XHR0SlPj+g8f4lMwvbd0M9em7X6ymQmWrtnU/wU9//
	RBoJuSDfJsWRL5fSXVeZoq10LR0isFSTQ9bK60Kx2a7kfGiZoJQSC73tpanUxsY7ZE99Xj
	yIPbISfsdBl2SdGVLyR8V+rhqa5PuT0=
Date: Mon, 25 Mar 2024 20:14:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
Message-ID: <ZgHNASvv5iZV1kKc@duo.ucw.cz>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJAgsL7GgeRE9cmy"
Content-Disposition: inline
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>


--xJAgsL7GgeRE9cmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

You submitted ~1500 emails to linux-kernel in few minutes. That's
quite serious load. Are you sure that's okay with postmasters?

It is convenient for me, but Greg stopped patchbombing linux-kernel
some time ago, and I guess there were good reasons.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--xJAgsL7GgeRE9cmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgHNAQAKCRAw5/Bqldv6
8vOUAJ4iQv5wEi3bbhbDeJvEOT+1MrVWtgCfQm9dm46HBY8FicilzHKeOMGILlo=
=Ol8Q
-----END PGP SIGNATURE-----

--xJAgsL7GgeRE9cmy--

