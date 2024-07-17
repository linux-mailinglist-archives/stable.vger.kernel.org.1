Return-Path: <stable+bounces-60469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D79341EF
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59940283D2F
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F218A954;
	Wed, 17 Jul 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bQcdB+OW"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC7218C33A;
	Wed, 17 Jul 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239704; cv=none; b=X1d54bTnud/vJGDikrJ5hqpKVQmcB6YsCQu0mBLZl6lHvHN6Pm9UeuM1NGJ/vJVkrRYGFZV1+TIUWSc13jSDJELITEkr5RATvgtpZBcv5gCBFkoxng48hNjJAunHSwAN6oZfE8YnFdaEOySknBuP8bUigESYor+OkruxfvAwHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239704; c=relaxed/simple;
	bh=9hxNeCBB8b5Vej3mf5NmU9RvWiDp8eSSnsAiXtQIXko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyXWV/goIpZZ4ynvyt2L/132A0VYhn/xtaa6nZnPXDRgt1XgOLP6/hx5bgMr3bYMhO6wjq2yn89UuxNo2vQXeTjE6cw2dIOmgqe7JPX+Fn8c/VBX+jJwUXkHNG71r4MgUpQIw6IhZf9a2Ztumxp3WEQ34OS2Avif0Lr9IuzfBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bQcdB+OW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 36C9B20B7165; Wed, 17 Jul 2024 11:08:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36C9B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721239702;
	bh=H0dZi2HUxG9Kqf5PJWw1uBjQr+BrpxyIdPGsVJYkk0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQcdB+OWlkrw//dIOl2UeTwMbDLZvwwy0boDcuA9+VNDE8XG1ugev5Ry576RpnBRp
	 4EEPBYiYvl8jTILSdIT0anJl/kRmx5YmD/FajfqQXN07CRJlJCt8MqNCBsThvqQz6Y
	 pU7DahD2uJFda2au9EvHy1U7hjNe2X0pcZhAa8dk=
Date: Wed, 17 Jul 2024 11:08:22 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
Message-ID: <20240717180822.GC7194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240717063758.086668888@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 17, 2024 at 08:39:41AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

I had hit the previously reported build failure with -rc1 which is
now resolved with -rc2. Thank you for always getting quick fixes out! :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

