Return-Path: <stable+bounces-46116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500098CED48
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C333EB222A4
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0B10FA;
	Sat, 25 May 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d8jIOOT9"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187BAEBB;
	Sat, 25 May 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716599177; cv=none; b=O/FW/Nv7JVCZ4YfhTg3zdcxyyCzRJAtkRlMufZ+Zs11FeorDqEyrh5/9bS8QM3TN2KUK9SxPow4rmdnQq1WyFsy020nxPVJY1cTnCbDbhONQZv17AGyVSFJLLBuMc0UbVxDm/iFK7o3TPEnaJVHfLZ4e7uCPTMO2G69yfo9AKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716599177; c=relaxed/simple;
	bh=NCknf76MRpR20ILad/BzqWqMaTcV6AbBrxZA4egZt+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX1x8rRrGyss2swTC1hn+JsMhnkYPDRr0rsi7W/ld4aWdL8rqO/1rUpp4oMTXzsoZXPtTQLFP6LSXWTSulLgoAT7Gm7tcR+k/Hn4AyJB5XuERqKNfJXXjYMrGqqe0MzS1MdnyAqj+xjepk/+RvVgK/N6DKipyxSIIGAaDO44wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d8jIOOT9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 995082067B51; Fri, 24 May 2024 18:06:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 995082067B51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716599174;
	bh=sy0QkNZINZi/+Pt8o6vSVMfz69ATnFWHORuPXwwpPVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8jIOOT9Zt3FTS0x9pQOzQT8/KtDSqW3hVwKJxP6wlBOTMUKsnbd8EshZBLz66dm5
	 KxI4eWY932BgCkfebIVvEMuVAPdTfCrGYAEXDr8XrozioJCPL6QE5UwySp5I6l8aeX
	 NlQPlbdhokjROVgOP4CqIBxrpdu7IOIIW+zYUwN0=
Date: Fri, 24 May 2024 18:06:14 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
Message-ID: <20240525010614.GB22512@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240523130332.496202557@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 23, 2024 at 03:12:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

