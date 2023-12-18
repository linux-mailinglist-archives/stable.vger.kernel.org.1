Return-Path: <stable+bounces-7832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C020B817BDE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873BE1C21A0F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B773470;
	Mon, 18 Dec 2023 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXJ1tXF/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98573467;
	Mon, 18 Dec 2023 20:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F70C433C8;
	Mon, 18 Dec 2023 20:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931358;
	bh=aWQLlvcSN1E41vLKTdFfI7Qwu3vRTZzCc+Wqo10RRlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uXJ1tXF/6In53V3aZzO4yJR7h2R3lTG3oFf4zCGKhDJmz0zvSSlnbuSvO3IpCuDSI
	 EdgJ7FZAWQ0pPQibn8qvQ9gAmgquJ2bfci9sHGnCtkYWNngMKRNeJuULfWVAEYKygC
	 1LFuclK8ghlvF7VmFWt2xTE2TnRF2L1prYrn8cHqs9WJ3TDpq6azGjKd6iCEeLAYXp
	 5MoHKWSpGTQON2sjLQgfegTEHozy9yuhRi+Ef7U1ThmIStAifedGzDmJMf+GjBo5Gz
	 l1lyT68qLO/7M6+scW6NfK+KTdewSWo0FCRtF6DJZK3bAXq5O/SYZUUKyiEntEElbK
	 vP7i/cnbnAz8g==
Date: Mon, 18 Dec 2023 20:29:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/166] 6.6.8-rc1 review
Message-ID: <20231218-ashes-stellar-1334c2d5efd5@spud>
References: <20231218135104.927894164@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wyAPTNF2wCcjmXmz"
Content-Disposition: inline
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>


--wyAPTNF2wCcjmXmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 18, 2023 at 02:49:26PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.8 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--wyAPTNF2wCcjmXmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYCrmAAKCRB4tDGHoIJi
0tYWAQDjcN2Udo5gbQgnoYK2/S6H77jahe2qdA3Ktg52av1V7wD+PWa03bsRsjft
pXKCl1DXf6GlhTgFF1oTDJmroRdESQc=
=Trkb
-----END PGP SIGNATURE-----

--wyAPTNF2wCcjmXmz--

