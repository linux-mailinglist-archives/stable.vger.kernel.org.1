Return-Path: <stable+bounces-27025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0F87437B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826DC1F2698B
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421F1C686;
	Wed,  6 Mar 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hP8u1OiJ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC831BDCB;
	Wed,  6 Mar 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766652; cv=none; b=ey9jRJwsTfzoc8vZxq1Qx7WgOYX4aZYRhGgr3zKiq3m/WwRv8aK3R9TXIh64b4RsRmKwQQVM9X2rC75u2KAFDWaiSudmYq/+JI8DUNCunaFes+EtQHZrjejWm5GXOn3AT3o03ATUyXyzsAoIJsYPrXBs5AzNojVDNSMTpYehbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766652; c=relaxed/simple;
	bh=7VTqeclVPr3FnGH9kzdAkOiynxNGbJdBd+5mrL37qUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtTMYMAu42ww1cQ3XdUUNCCg2soxnhcgSiX0TYj4P01+jeGivggqgqs7NCUJFqm9Qhgs14GwDj+iAtuq0/i88fSqls5o19JbBYmL+sxVoEbfjXnOASXRsY9JAPpeRlilETk892rxmar9YcqtaKqrLyvUIhGISbL2z8NrCflqWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hP8u1OiJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 6DA5D20B74C0; Wed,  6 Mar 2024 15:10:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DA5D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709766643;
	bh=+lT60b34SmHHwIMko6RDTMTeNyVjBhtZUMPZ/aaoAJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hP8u1OiJAJbuwzASfA7NLZ8X2Ee4ebZrgWW6tBKhtH+wqsxcHeMkUzmJu85/vmLly
	 Vq+bkhPvmXrAFKpw3BEKsYSVI2m3dNSB/N+9YZQaA8zpZxFnkwA8GtTVjGPGMrpqjv
	 Rfg00LvRydZF/t76xtiy2vcNWMZj3vqr7n308e/k=
Date: Wed, 6 Mar 2024 15:10:43 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/83] 5.15.151-rc2 review
Message-ID: <20240306231043.GA18984@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240305113135.403426564@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305113135.403426564@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 05, 2024 at 11:31:56AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:11 +0000.
> Anything received after that time might be too late.

No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

