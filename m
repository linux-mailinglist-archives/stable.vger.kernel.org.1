Return-Path: <stable+bounces-57964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF992672E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 19:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA278B20F33
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102D17B4FE;
	Wed,  3 Jul 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ShsxNzFu"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791BB18C38;
	Wed,  3 Jul 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027868; cv=none; b=sEcqc/oObsq9eiRekyXsRx0LYUVqUItAFiDBZT3hTuecMh8EtQTtyNqopo8W/3rTJK84tLx0q4kdBMUl/OnHC+M7pm2FlzcHU1EOpApMiBDAZfHhmLDSwNvcS2J4YwTLkZ3PEKoq/SuYTG0jz7rFSNh5/v2AxDFRDblVB+gzIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027868; c=relaxed/simple;
	bh=wDCqZSRi531JRw8a+n4+ozCCMHbVnX4O3eiA/AX12YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k21BOsu1C6pPKKcupZrK4kIdx2yeCA+vicvL0vZLEKh3dCwAcF8rcCtG3kxzKA/mmH7s8aK+WcDRc15VIcFllrA+CZnKQmviGyZ1fXQTI2DAX0f7g/gUkVZbBxP/rZloCgCzfNH2fRQVO2+jtq9O+pny2TOxjubT2dndgnLOuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ShsxNzFu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 15BD920B7004; Wed,  3 Jul 2024 10:31:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15BD920B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720027867;
	bh=rIfQcz3PfC6/Q/TEVzslq14IojDQNP4Rv6kQPYbRs10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShsxNzFuLoeoNfInXXcR/PKC34y2ccth55d5SvxyAscncJtI7AvHrpo61zoEmUQrR
	 bgJPUJv0hgXz2dgqFYj+2jUqr9HxnQzOsUOL2Dfnyq25T5GHPRnSouzyIfsJavrAyD
	 6befyINENMgrLDFVyQu/T6Y7HTgh/ay1RpVdNOfY=
Date: Wed, 3 Jul 2024 10:31:07 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
Message-ID: <20240703173107.GB11716@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240702170233.048122282@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jul 02, 2024 at 07:01:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

