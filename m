Return-Path: <stable+bounces-50132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB1902F65
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 06:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9AA1C216FD
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 04:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877616F91C;
	Tue, 11 Jun 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eJCAd/rs"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA01416F90F;
	Tue, 11 Jun 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078397; cv=none; b=AK5E4PNQK0KdTtvghsG195i2D6pgkxq1fTrMVSAJs8qH3zUdyfaf7WjGalikLkHp+9oG5/j6KJ1XXrpBLflqUboMv8OjKDRdsjAWtsgn/UEz4mvNcDDl7U0tWLV1NwC92xDDAjcFq6ede5RQs17yDNXhIqEmmOs2SsA9EzlxSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078397; c=relaxed/simple;
	bh=t3n1jARdwCEpwkFlx3UPCwYWR3ioikWGpffuxIdqtts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqYygHTqiThVh2fNJfjJVc/quOPIswaTgAL0lpdvDaMSfFzYNKH2qunPhuPqGp+HlhI1RJjhfnD4sIpfAApBnudjz7u59aOKB27tfWeIQ0Ms73npo1fBLAbKAZ2isVA5ixjGvRGkG9SYsx8wCtJanjKAGzaJ4UYlGXzdkpeoELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eJCAd/rs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 35B9A20693F6; Mon, 10 Jun 2024 20:59:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35B9A20693F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718078394;
	bh=lf+a1Y8JwL/u+XX2fROmxQYeNIyz1Ke9sCcb/wE+Fjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJCAd/rscTtxzK1TWUD/MNCQDLfHF4dafagnBwfGwXgHs7KzgiQu7dJCe6Qo/7DW2
	 QZsXDo3H66OxXE4bt9BbNOcqy7W3bfdRDMC7NdOxAfHgjVX4VNOAuRoxQmw5sOiZk7
	 H+mECnKK0eRCSoy84LAyKkOh5XhKPCRW7/DmF8+A=
Date: Mon, 10 Jun 2024 20:59:54 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/368] 6.9.4-rc2 review
Message-ID: <20240611035954.GA27792@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240609113803.338372290@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609113803.338372290@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Jun 09, 2024 at 01:41:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 368 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

