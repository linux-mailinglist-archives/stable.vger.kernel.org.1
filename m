Return-Path: <stable+bounces-25315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305286A475
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 01:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240221F2C951
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30255A29;
	Wed, 28 Feb 2024 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NHVx7sIY"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ABA36D;
	Wed, 28 Feb 2024 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709080212; cv=none; b=ulGSsKAcx/FTsxb078gZVlW75O8FTtK4OrbBkFG2O5OrjtuUpMq/smO6Q54uG9mSxiYGoMSImQgewiONII7vt5SwvvKWukdG+Il/3LWMQnimFMFue5hZe3i0HdfEdEaWNRpbxNP80qlWh1H+k6r68I+wovFtLF8cWNIlIw8lXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709080212; c=relaxed/simple;
	bh=Gapeige1NohtYSEInpUMBhKULoCbIe92Wzryxp7iHPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h50EQ/IG0PZ6sU5QyhBDa3PWRHNpj33h4jdnRk27BFKlJ966euK1JweTZjNZIl90e11rcDcBeUTqf3GmTvYlAeceks4MgZrk58FHYqpo4WukIQTGOHJAAE2tn7qMIqxdpcHjL4mXIMwQnpEVMdYXxRENh7uEZbT6DK/Od3mb9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NHVx7sIY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 482F720B74C0; Tue, 27 Feb 2024 16:30:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 482F720B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709080210;
	bh=AhO6uxEd07oDsK8/NcS87qlm25AjJnA593l9lyyamaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHVx7sIYKyJ966qVhI3k39NLIWNVb12HpMEgFJgIMIuu65rzUA3gy9IRGV4zjA8uu
	 6UHH8VogVrK7QLkkL4F7YdnVyrNT/uVQPdrRZT7RWIYB3oW0dT759TpjbMUa93D0Ah
	 H1KQZKZ/v8si4RdNmT4h6UGCfTjTLpUi8gM6hgiU=
Date: Tue, 27 Feb 2024 16:30:10 -0800
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Message-ID: <20240228003010.GB24086@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240227131615.098467438@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 27, 2024 at 02:23:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

