Return-Path: <stable+bounces-54685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5F590FBB8
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 05:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145CE1C21554
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDE1EA91;
	Thu, 20 Jun 2024 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ok3V7Js0"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFADF200C3;
	Thu, 20 Jun 2024 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718854997; cv=none; b=r0pM++bKsRxFk2LqhEsTaB+/SjCpiXndYnouLlurdxTVu2MwO59NM23yQlLAbX+SCeI36+sN5yOuHOKH+HjF2ALWGwevcbmrJRvwg1jJ8td7YTvGQhhpsAcvt5QLpBGJ3+pRWzo2mDKPFR4itqd4pUeX3uJGcR/5PAECQVDxYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718854997; c=relaxed/simple;
	bh=jHeoHdPqeSGrptWXQ33oLMFjvBaKeMx9VvpQowy5jRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzPkWzuT/kLsuypd+lCNXrXXmrmLxQSPckCT/AtWCQbT3XohNuL/tI3VFd3CaPIQmyIThRoXFiwQYkaICokwVyB5skQ/BGAAFcdL0WKCF9JtDolA3QQtbt1pB56ZcSNA0KAHzycDPnq5EdEO4jAjPAzdzBHD9Xw7Z9m6dp2i0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ok3V7Js0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 2BB0820B7004; Wed, 19 Jun 2024 20:43:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BB0820B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718854995;
	bh=oOJU1IXLqEglf++fZEc8wq61lqzir2jQjaIDNqEfOH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok3V7Js0aduGkrNUFHf0wKEx1Z/JP8pxpfTk2zm+xKpP+ajWdOQ/WSPvAfD4aah7X
	 pofxcAUcctu5XbQjX1A2byfSG40qxQa504FF7GdrCDwoPg+R0Hs5DHplTcM3p+g6Qi
	 ULyz8LPyDV4gfc8ZSmLqj07DevT6kNYFDe+l0XBg=
Date: Wed, 19 Jun 2024 20:43:15 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
Message-ID: <20240620034315.GA2251@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240619125556.491243678@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 19, 2024 at 02:54:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

