Return-Path: <stable+bounces-206130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE6CFD849
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BC9305D9A9
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7B13D539;
	Wed,  7 Jan 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zNQxaFuO"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108D30CD82;
	Wed,  7 Jan 2026 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786830; cv=none; b=dQcoe3MAUafqH7gxgvIfNrTP2qS9M1yUND2oY+n6SSzaGO8Pm/NBm7x+or5xVFvsm7ddCDKn+0wP0TAtv75Qjt7Tro2Xk2g0F8by8C3aulsjkxuiFQPx6EGehJ9R1iaEO9eDjURbKHEUjwmCrwCMMZxY2A7E6xI+12HlcJi0j9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786830; c=relaxed/simple;
	bh=o1ltIjtrOA9HPER2D4rGnFOELy54LxjT3d8U4Nor+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkLtOUeKAFFAM2VidzeoNoMsNxdnmKq79EA4/lX8ZQWNlQ/Ompf2WSCMJWDDqQm1ZQZmJcfotfafbKlSphRfQpy+EybwPpg/wwLP4QbYPhGzau1O1zxFDTEQvj3uDFJ5BdSCP06pTgpzJEz3UhFd7PGALpENsO80FjCdsuoJrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zNQxaFuO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D8C931FEB6;
	Wed,  7 Jan 2026 12:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1767786817;
	bh=6EpNA0RLT7Xitv6bYEUuPLrpKEKrvJijTdXbr6JK2Zw=; h=From:To:Subject;
	b=zNQxaFuOtHWy+jodt1MRDGjkriy2P4GaNGE02VFx4H5twdbzGO/sU9Y48RO8D1YD1
	 tFeD1JJdoO8px4LSv5SLkoMJ4jItZfhT/0PPdqzxEzOUyd0vNVz6SuGLdTlMPP4Din
	 9Cq9KCrziO51S3tTDhZIw1dt9ZQj32Io3WdXar3goYz94WHvh0PHx1cOC3bev6cFFf
	 JVvtVX8iuV0DdaUBCdySltK8U3FaQqGlTEylc3tgIKCrfeYVDoVNE4oCvxKc69iwAz
	 k9UyV+q/bGwr6s7FAFSd7G9HV6/k4kwtq/PCsFpFDwNrxGwqI2mNqEoOl1ZOg9Ozv3
	 0uQ9N9VII/bgA==
Date: Wed, 7 Jan 2026 12:53:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
Message-ID: <20260107115333.GA28907@francesco-nb>
References: <20260106170451.332875001@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>

On Tue, Jan 06, 2026 at 05:56:22PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.64 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin AM62
 - Verdin iMX8MP
 - Toradex SMARC iMX8MP


Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


