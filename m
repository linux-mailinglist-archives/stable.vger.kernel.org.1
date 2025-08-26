Return-Path: <stable+bounces-173738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50340B35F5A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E433B22F2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC988319867;
	Tue, 26 Aug 2025 12:43:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500A29D280;
	Tue, 26 Aug 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212190; cv=none; b=mFu1165aUv2aWKUKz3w37C9kHfCd8FDkZpAH+8aFV6BzFjN6rIGEzsxC5eM//cmuUBb4O+F4QqIedhNy9/3nZQEtoT2HdsrdD6rrUhaY7ztpFBPO74iNBqXZAkkoBHlIbpIkR/f3KmwSGru75h8QqOE15aIRBrFCM7A/uDo2oy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212190; c=relaxed/simple;
	bh=s5zld7zXPuWyzN8MLCRNwOaJfUvYeDsjRE4AwqOsy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEgOWZONiBqQQUyWnCB/dsdXe/jhJ7CbianhGEquIU+uzbbuRtlXLR8xoOYY4vYb5GkJFNKiEpshUq9MJCV+wsVxuumwnkJhvSdzPhA5Rx9btxr+7xcmT4zXSdTKY6fKIh9l5haWn34a+HSrM8WFNLXPTqTqSJX+EcbRw9uq69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 26 Aug 2025 12:42:40 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.6 000/587] 6.6.103-rc1 review
Message-ID: <aK2rwEQ5hdOQSlLq@auntie>
References: <20250826110952.942403671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>

Hi Greg,

On 2025-08-26 13:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.103 release.
> There are 587 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:24 +0000.
> Anything received after that time might be too late.

Quick query - should we be backporting a known regression, even if it is in
mainline presently, or do we wait until the fix is applied to mainline and
*then* backport both patches?

9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")

introduces a regression which breaks IPv4 broadcast, which stops WOL working
(breaking my CI system), among other things:

https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net

This regression has *already* been backported to:

- 6.16.3
- 6.12.43

so I guess we wait for a fix for these.

However, it is not yet present in the other stable kernels.  The new stable
release candidates today would spread the breakage to:

- 6.6.y
- 6.1.y
- 5.15.y
- 5.10.y

Do we revert this patch in today's RCs for now, or keep it for full
compatibility with mainline bugliness?

Cheers,


Brett
--

