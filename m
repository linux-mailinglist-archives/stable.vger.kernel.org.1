Return-Path: <stable+bounces-139079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95DAA3FA0
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F6188A57A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E5801;
	Wed, 30 Apr 2025 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO7pbjeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382D7462;
	Wed, 30 Apr 2025 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972607; cv=none; b=tAuxFQ+VLDX+NJ8Hriudxdvs97rOWbfe2UyHjJogk5TNvqh5aAZ+yvWZCIKbkx/G3rMy7pg2APbxKh/Pucd+Uy2H/0zFhXLwkkr7Dvs4DImgpuKl1chXjA/ErVvvJtJAWAV+2ru2WQ+lBnLpIfAWu5tWN1mWjeZghptjCOoN+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972607; c=relaxed/simple;
	bh=LnbXxn6cfAZ1LTNdbY6B1qJi8/AVpoR91fSjqgmQQ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf+SunVcGO0uP2Rab4XtaRQR0I3X1JJpKBVbzFz8Ko/O4IeuFJy2YaNZNHZ/BQ9M+PtJyZ/sj0xqXcyL3HCTi74+/cHAs405S5e0rSm+GvLKtNkhT1IpkSPbB5zkkMr10V3fC2ULeizuGU/07CmsV0XKz9tZJo0ORaVsLQpPT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO7pbjeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC9CC4CEE3;
	Wed, 30 Apr 2025 00:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745972607;
	bh=LnbXxn6cfAZ1LTNdbY6B1qJi8/AVpoR91fSjqgmQQ4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO7pbjeDbnVXE/n/z9HbdDKaUWn0AE0FB0fjHQyAYO1pQvqZCOc1DnAsTTIagOjGE
	 IinOPJPJJWCyGDxl4eZVw+9ZisCnZuCGR0RDCICa5c0Qp27mO8eM6zXM+kai6kTqDr
	 zru468uguQzT2sXdbOaS9G3o/zsTYAO29n5RYy48Y0Ymr2XTrJtK3cEQLGA24Qr8Nl
	 8ndy/tLrUPN6sQRzWd/qODJ7a+y7u24BwmddSbWH4Lt78uFJ8irq4YF3rBsTFWndwL
	 Ou75B4JZWtJxDo7X3FUAPNbwlHf1Dctk+kJqOQUkjTe5MtL8/MI7avQP0PiA9COqGR
	 H4tJtPJbu+qAQ==
Date: Wed, 30 Apr 2025 09:23:22 +0900
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event
Message-ID: <aBFtesqln2Xeab-d@finisterre.sirena.org.uk>
References: <20250410091643.535627-1-herve.codina@bootlin.com>
 <174429282080.80887.6648935549042489213.b4-ty@kernel.org>
 <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+n29DJNat32DEv6U"
Content-Disposition: inline
In-Reply-To: <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
X-Cookie: Well begun is half done.


--+n29DJNat32DEv6U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:20:42AM +0200, Christophe Leroy wrote:
> Le 10/04/2025 =E0 15:47, Mark Brown a =E9crit=A0:

> Would it be possible to get this patch into one of the v6.15 rc as it is a
> bug fix ?

It appears to be queued as a fix, could you be more specific please?

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--+n29DJNat32DEv6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgRbXoACgkQJNaLcl1U
h9D2igf+IcSLAyyqPyCkgkxObz6ejq16mYpRMVXdZgtsyHGwuf21NEktBbBgp3Wb
sxMIFXayPEfzTqCLLcjojYObuIU3gK6zFBOIx73YRxysA6dtMV4EIm41985xKvNd
aYY/rxmR5HrZI1zZyqz7zkxM1AxmzFeKpD/PzJTmq0c4uM/ZbrmiihxtH7fg5e0/
hQ8OeyYviqP0IRVrxq5DvirNF207T1vwhXXlkB5WQqkxUqjAD9EsE4mkDc0TUDx9
SxljcDisxCz3w0DC+Ej9awxAm1Px35jb4UJxmPYX5ALjc9p8VcOhsre+sPWhHoGZ
6Ihvu7uJBQgr5wMQCcOJZifShXbGzA==
=K3dG
-----END PGP SIGNATURE-----

--+n29DJNat32DEv6U--

