Return-Path: <stable+bounces-207999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95FD0EC21
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA83B300DA45
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96D6338F45;
	Sun, 11 Jan 2026 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Wqta/vAd"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8C3382E0;
	Sun, 11 Jan 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768132673; cv=none; b=WEtvvMxVOoXoPpDVuGNAPeqHphMUsaMARmkIxaGWoR1xhl7d27IJFvcMzTa5l4oxo2jOyesrSTd85Ej5T1wz5IG1LVLW+jXR3pLXBz5+XkUbzizdnB7sEzi7x6GV/OG35IrdLIrLgrMZcg35pdua92ObFnbFJs9FkyLJagj34co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768132673; c=relaxed/simple;
	bh=rLs2LYiLaUH85TGdoHcvkTid0BxEbSeao5kxb3NAL5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0GDE9yerGIPYdcrnFm1xCA9cd9C11p4cDsPUAwJuWEF42ehBvAntr/6xpUps6j2kzVoI2OT0eZ5+NQDdagYO+eBSwujAjDQugVfEueO5Ns72AUNnx5qO4kKcvgNxXJI+vRJLO1pr1XDjlrWQFZ5IT52Zjw/FPtQMSANeA622/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Wqta/vAd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AFA3F1FC39;
	Sun, 11 Jan 2026 12:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1768132661;
	bh=FCh2trVJSfubzjU4y8Zw90nTmMIIL6hLSwJ5JsMce+U=; h=From:To:Subject;
	b=Wqta/vAdzEXry9nMgt/vlvILLbe9Gmhu3F7JfIZNSpiiEeI+bG6oRloEhN26TXjPo
	 4nbbEbi3qabpe/B6isqXrDDXwWfVTYGwVp6CKn5mKls1mccGRxVjJZXUzE5i4UTIdV
	 yM3nYkSC9J3M82pnDsFrhzwx95+siaw1MXyvdgX0eJPoCIVGznnBDOORuz1szS4Wqj
	 YExUgA45GT64C/0RMAXR8Y/YKz3QNa0FfOiuduUwCrhZZQqkqp+axSFVyzRT+QRiw1
	 OXsyYOE659z9GwEjMBfCrxbDcCp/SHA13u8kwzWkv+WS6exzXSbTJ0I243yVrR+R7l
	 rwfe1mIYs5jRQ==
Date: Sun, 11 Jan 2026 12:57:35 +0100
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
Subject: Re: [PATCH 6.1 000/633] 6.1.160-rc2 review
Message-ID: <20260111115735.GA23172@francesco-nb>
References: <20260110135319.581406700@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110135319.581406700@linuxfoundation.org>

On Sat, Jan 10, 2026 at 05:27:38PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.160 release.
> There are 633 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Verdin iMX8MP
 - Colibri iMX6
 - Colibri iMX6ULL
 - Colibri iMX7
 - Apalis iMX6


Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


