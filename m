Return-Path: <stable+bounces-104048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0FD9F0D1C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335B7188972D
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5C81DA5F;
	Fri, 13 Dec 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scpDxO3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3804383;
	Fri, 13 Dec 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095739; cv=none; b=cpql8ie6eBa9q05xuw6Jdq6xtl4AnKi40XV6o4gyzI3/ICOsNjrVERI2Fbii/MgB7/j5bNn+webjGEweMbO42839KRiT5Mt2dEEuskuK5RXFVjeM+fvtcDGf+toDY3tuy/PBB08/Nu22qL9X/ejQYUJWOcV4L5M/UIZl2doPj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095739; c=relaxed/simple;
	bh=lBo6pfUFjsGPI26ePuNC9tLm/e0RgdIXILl2KaWXuZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARFB+4AiAGATx+dQZJckUpWB1ZLPbSBflBE34ikVHI5l1fvwrLINaRKwr90XvijVr8XIL8UIJznprl9aJW2+pZjZEFQXbVuz0YvVUZ1lKeXr9VZgFXKLuTaNZfqsesj9vamYwCgimLBrH7EJ326DJY8Z+1BDQYc8/l1E7TrLbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scpDxO3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06124C4CED0;
	Fri, 13 Dec 2024 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095738;
	bh=lBo6pfUFjsGPI26ePuNC9tLm/e0RgdIXILl2KaWXuZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scpDxO3V9m1+BvMU+Bf0D1qAHvFhE8Ve2zkkQkP0QTskpx9t9kRFc2MOpCvM1xID5
	 yjukkRF0pdQM6WrQIls/Gugsi240yrGVg/zr7pH+wuZFaSV+LUjGxYp+Ma4MWTxXhY
	 RziVpvmDJ+BHCM8Zr4C3pl/3HMuETbjdp/f+ZlKsbdAcs6baD4aV9+rfnROG2jIqfl
	 UMLIeebb1jjnhwS1Y+b9mK/zi0X91ZWZo8xr0ft8q8avyESqdWcHrYM+votjFw7oJT
	 X7rb0lDuV5wZTj8hKehAIoU8SuORfWlYlim+/h83mVhJniR1O7yLVTYrq84By/sIpl
	 VtXSIe1V2glrg==
Date: Fri, 13 Dec 2024 13:15:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
Message-ID: <9933d325-19c1-4af1-ae78-13ff04891e50@sirena.org.uk>
References: <20241212144306.641051666@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdq0fRkD7/4yCBON"
Content-Disposition: inline
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
X-Cookie: Not for human consumption.


--qdq0fRkD7/4yCBON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2024 at 03:52:49PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 466 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qdq0fRkD7/4yCBON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdcM3MACgkQJNaLcl1U
h9D9FQf/UzwMIKqSqRA8vJvFIBwN7jnyVfNyv+sxiKZpO4HdFwAFodHzhjbYLxlM
tOCQi8l2+HxtXxtbFeA/6AG1qHStuxZhY/Bv2ySgEhgrkMAewxR2TSF7iHANk37+
Y7MGvhyLEWr65eGFmo024gACH0WOffRjrAMG5HYgENoKy0EflpTtqVleEodx6feM
LgDIUoWa4Jpn17mnXbRBtqq4DzmXDzTL6X2EnVobfERYuXFadKn3Zh/P4i0UK4sv
k/dKowA8iod8JXTOXko20qFIAIzQ02paiBm9IPNwSu0pyGZJ/jSBGM9ntV2cVvcn
0agor8jZEwJrMhLySWC+0znjeBAWcg==
=92sK
-----END PGP SIGNATURE-----

--qdq0fRkD7/4yCBON--

