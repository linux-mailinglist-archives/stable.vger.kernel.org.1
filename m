Return-Path: <stable+bounces-158615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E9AE8C96
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 20:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542141709B2
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC72820CB;
	Wed, 25 Jun 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INVoRSwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852901519B9;
	Wed, 25 Jun 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876550; cv=none; b=Sn43qjB4YMovfnRisv5e/NhLMvs66z5EghchvFTV06HhI6r3bMS0cZjOPuSrOkdoR7qoiQ58EkoXlOdjKKSrD3RlOA/FHLyfSrxU8XKV562m1kp4z8xmvBqIUu1H2wtGEnrN91PuER0QH1+5zFHKvQN78wLCKAxoKHSepIwe/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876550; c=relaxed/simple;
	bh=OPTSLtWniYLawe+Aa/fcVgod8ueGCNsDOa0pnGw5jVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDQ2PQb0cw9hung+nq0XHDCwLnNaRZ+JeeBJG/P2RHkZL5pgKq4PecD89T3qDTQdRdRqg/kgrmQ1skQln1E2IpJQLHom+7ap1tv1vKqEwjtpMUOqF7VKnuNj8Y5qn+hp2Lj35Ki6ZmiipzYzXY5ZRsGjYSS1iKGUjwBnrxr4JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INVoRSwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E028C4CEEA;
	Wed, 25 Jun 2025 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750876550;
	bh=OPTSLtWniYLawe+Aa/fcVgod8ueGCNsDOa0pnGw5jVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INVoRSwvc7dJpXq99t03kVQXKpRXq4pp3oWTrgeqbBMVAFw2yx+ky83RHQtG7zzrr
	 p4Shr6zgr34go9HCg1nZVNqujMZPPs6sYVdn0zNskKMt4GPFDq0k0xCXMz/g5vbI3K
	 lZCQhHp+yHYKVdFTVGPPIqb3/gwM2mI+39+jjAPxwiGNCBa/Cn4G0v9iUXaJt/NWay
	 V8y6C56qv18NK4T32fmQbpY0rHeZcttqszfDnSi05cTFSRFNSFf5EKCyOfhfq/Azjb
	 itO4pQDvOFaVQr6gOMoXmFJ+2lO4DSR/1+R/poT/vffacVG006y159DxNTLLvlDf1k
	 RIA15SKPd5bjA==
Date: Wed, 25 Jun 2025 19:35:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.1 000/507] 6.1.142-rc2 review
Message-ID: <1490ca7c-3093-4ead-8179-c3e2501505b9@sirena.org.uk>
References: <20250624123036.124991422@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcJ4OGB7xZu8FFFs"
Content-Disposition: inline
In-Reply-To: <20250624123036.124991422@linuxfoundation.org>
X-Cookie: He who hates vices hates mankind.


--gcJ4OGB7xZu8FFFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2025 at 01:31:39PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--gcJ4OGB7xZu8FFFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhcQX4ACgkQJNaLcl1U
h9BDHQf8CO6qlB8Q1p2WclEA6sLz0knPDnH75R1mgRuJiT+w8rEyBQjNTYZooPOQ
soPgD6bDBe1Z2FBpYkYbs909ZO6hPE03rsOXgbq0ibhXKdzcogp4yVw8zNWbCDwd
mW/ndUvYejpkOTO/TG8x0wpM9MGjK+t5xwvtU91lOjHXtUaLIr7vdxXLHXlHgBwN
ZE5KO739MoVteUCa9JdSzBChGLgv+eeSs4rXzNB1XRqa6TPEF8oTLoB5LSVNp1Nj
k+cwbQKiIA0w4MSu/Ku2zARdLmbj6hgCHF2lrBnJrDpd6srqeQ2VivcRV+VMQdQ6
jxwV5nZyqOtDAOpWdn9ZJv9Iomc7dg==
=YsVP
-----END PGP SIGNATURE-----

--gcJ4OGB7xZu8FFFs--

