Return-Path: <stable+bounces-43599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDA8C3CF3
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5028229E
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13343146D62;
	Mon, 13 May 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lAUvX962"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218F26AC8;
	Mon, 13 May 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588107; cv=none; b=MviRZAAA3TP20WRe5Xc/1KV4TPKdpp8f7pKtL7uKfivCXeATqFkw0bo6724rvp9XnuWDCB9LGzCzL1nu2wftMAOoIe6zWwRptp+x6yd6x6w/iIS6MwwxKQBUGzejNtArDK23+b1HMKSBcL3U0r8srMfyxLvmo1nv2/072mLRDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588107; c=relaxed/simple;
	bh=nWTsCaqEbYJVfqtjWMFj+S9jlUSh9KVsdAYjy1jyLC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z63DJWQE8vAIBLBemmyb/+vPqwluQEVhvBySa+4GvYtuD3PmmxCN/dyELlmXeMmUkkwn/X6YbjWwBZicTjSq+2PIBGLSCqPfyPakjHNfc8vdZEISyqyX/jDzloO3MEUhIUcmr6sSMQtyhuDUSmXF99ITsGpOJ+ncdgYxqwK/9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lAUvX962; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 43C571C0081; Mon, 13 May 2024 10:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1715588097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYm7twR3pfErY73ktn97NY63Rk+NhUxzi7k2RinLgho=;
	b=lAUvX962VDZKnzhE6GmBDcD3Q0FjCw3+d62OCLLdvIApX2HIan9sIlkjuN9gzD+gDI1a5v
	+J6KLZktniU6qvqZ/M5XV17Hk1Alu9QJzN+7KanmqD3VKgYjRa8AfAfAfy9SPYFyBtxatz
	Ye0LmnHT5B0NDeD/zesdDjaCtjietEQ=
Date: Mon, 13 May 2024 10:14:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.1 03/25] ASoC: rt5645: Fix the electric noise
 due to the CBJ contacts floating
Message-ID: <ZkHMAP48JapqBfGb@duo.ucw.cz>
References: <20240507231231.394219-1-sashal@kernel.org>
 <20240507231231.394219-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uRgOcYeDul5ZV0Sy"
Content-Disposition: inline
In-Reply-To: <20240507231231.394219-3-sashal@kernel.org>


--uRgOcYeDul5ZV0Sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The codec leaves tie combo jack's sleeve/ring2 to floating status
> default. It would cause electric noise while connecting the active
> speaker jack during boot or shutdown.
> This patch requests a gpio to control the additional jack circuit
> to tie the contacts to the ground or floating.
>=20
> Signed-off-by: Derek Fang <derek.fang@realtek.com>

AFAICT this is unused in -stable, as we don't have corresponding dts
change. Please drop.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--uRgOcYeDul5ZV0Sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHMAAAKCRAw5/Bqldv6
8hh5AKCI1g0ZjEvt7PsMAzpOOXSPwWFX7wCgkIbRWyUCA2djK679LJ9lojqnkog=
=ypKm
-----END PGP SIGNATURE-----

--uRgOcYeDul5ZV0Sy--

