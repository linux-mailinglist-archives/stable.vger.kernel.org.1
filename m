Return-Path: <stable+bounces-65254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE08945011
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8631B1C25B2E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE381B5812;
	Thu,  1 Aug 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Af53mvYB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D501B4C5D;
	Thu,  1 Aug 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528309; cv=none; b=ZaJl9BV7H/8qmj8Pwn7FS5KPHX1v/fF4fP1nRM/K1CXCRctpAkpmHLhqF/KuI8HKd5THxzdPrEtEG/mopr9l9ozDIW0lYlwAliCzmiR9F6mJFhJXjbYnF2q3ih/t8z1gYOAsA5Jpp3dMyn9T5HlUwk6WW3MHmsRFO6GECwJTvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528309; c=relaxed/simple;
	bh=W8/R9aLqy7LIax4nkgkWE/G99VFmDszMQoPWoPWsfT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihfmaIVw+OvFeWQH+Z5Qq2fE19ZZ/b8h6VKeqTSufIO2SWi8NSYHVGPDz8apNKc85KKotVie2tL9C4Iw/Bob6bIs9rbOYUZnzuDciY9TcVfnD3daSmz9r0aDNt7tTeazfTZ1hV/HpjUmfjSDlnNrXthoot+ZTDU9BTF+QXR8ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Af53mvYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C96C32786;
	Thu,  1 Aug 2024 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528309;
	bh=W8/R9aLqy7LIax4nkgkWE/G99VFmDszMQoPWoPWsfT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Af53mvYBdiZvPwMvstIBZTnxpLeBih0lF2tpNDBDU/oI4o+PYWimnRuOMPPOMTTw1
	 Fy6M421OxvzvNUT5VU4dFU+l6FVeRQRoLawKNwn8xwvlnmDNqSWKpJcBviJGUIl3zL
	 wQqpTPWJw0pR1+SCp0QlOUMEbX+4VoMSrw7P6mAIkiO2R8mIHGs5X2+TQScL863kAy
	 0eBCVMYj7Id6CeigRfTXF85aqFwiNDQnG6vkOxNrD0Z6jmzx2SFNsTeXAuJqKRpJHF
	 RYvXqWNN/R0wIqyYUvTx2FjCbPpWCdPFyVfySmlQJ1vhzpxKI8hghowWtzAaaS6JPE
	 yQGMzHDErQSXg==
Date: Thu, 1 Aug 2024 17:05:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
Message-ID: <20240801-thorn-washbasin-69491a50e7ef@spud>
References: <20240731100057.990016666@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="04M3SJTeNjajUNxT"
Content-Disposition: inline
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>


--04M3SJTeNjajUNxT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2024 at 12:02:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

--04M3SJTeNjajUNxT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZquyLwAKCRB4tDGHoIJi
0lb6AP9Mcgkx1Duw+YlBXUwjjrB2lFZFI1+80ttuZhx6M/psagEAuoGrvovXLCn4
zPg+iJ6Iu39e2FLVvlLCnEujjMzRHAI=
=+olp
-----END PGP SIGNATURE-----

--04M3SJTeNjajUNxT--

