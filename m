Return-Path: <stable+bounces-39966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D38A5EDF
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBED1C20CA3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF8159208;
	Mon, 15 Apr 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HH5ZCBWU"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3F157A61;
	Mon, 15 Apr 2024 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225175; cv=none; b=nN3MiSOAeKdikFgDWkr0wIzKJJGwLF8zIDxzgbIJBQutjs04bBVYUdma2uyxOFBnMBbf4T3/Je0bpCHRHaVD8WGZPytpEmhM0DD78TMEpiUs4gLlV3VKx1pWwbAvNvMBu8TNHah0ZLn4h2LI9VoXldcQfp5e4rMbIBwwAGX22PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225175; c=relaxed/simple;
	bh=JnPe0iuKGgHgoZfYjUEL6sXQANy5Qmi5etDqJfl4Igw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJbPrDaBvg65kMA005TxuzakGf3fvoAC/QDlgsF/tYzn/sPwUcDDuXXHV6+attt+y9NRKcz7ajhFRg5yzRaJ8gRaNHfKHh8W72Gj1Q5z1WIYq3bWp9wBoeEUeQcrebqHcoy2j/uVK0u+7/EXafx1u8wlOvHZLQ5leiQOW2JQ4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HH5ZCBWU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id B425720FCF9D; Mon, 15 Apr 2024 16:52:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B425720FCF9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713225173;
	bh=02dP7LHW+8c1XbtLEvrs6vdVDK3XxcXgImREnnEmroE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH5ZCBWU7LDRpzC0impALnokS7d0Ip52isSSYuwGYqeWlQli/zpQvuoIZXGv4yp/A
	 QtvZVnDU8R27i34QALKPKyE82qPX3RnmMovIcK4PEfM5ldSTRIoaaDiZPbWOF/RSp1
	 gw/8T70nYhdB9ctscJ9rY3N0hrxtTVWCRenCBzSk=
Date: Mon, 15 Apr 2024 16:52:53 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
Message-ID: <20240415235253.GA11121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240415141953.365222063@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

