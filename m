Return-Path: <stable+bounces-104173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908579F1D15
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 07:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69DD1695B2
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697912C470;
	Sat, 14 Dec 2024 06:57:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD985931;
	Sat, 14 Dec 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734159478; cv=none; b=VHv9Miw57+lTFSxMVhrgALFlbU4FBjOSCy595qMPhsMWYy+X14ZkWn2tSBWtOVY7wz9xaRcT0912kC3a3hAlujzoI4LTWoSWIzQp4aSvp8oXYkzonbUmYU3kSPNmkRJdkDLuxpGaTcMqPRUc2abxCFac1+94COyWR0Z1zre5bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734159478; c=relaxed/simple;
	bh=DW85s3K/2RaRQoRpw/TsqtSuThFC5ie2FU5BB6r6MnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW9jGI6bMj7sdLj6gOwOxfW8qwnyrD5q2BbW2fJSK7QhKDHtnHNA2Qj4x2bhP5GXE3O31cV06Q15jCOMajRu7sZEV6G51gzNUFSLb9tWTGJ1bCenJxjVqE7VxGV3ObdGIOgOgoRk0Cxu2ngVqVISp0PK63kudC9pj/2ymxpkzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4BE6urk6029602;
	Sat, 14 Dec 2024 07:56:53 +0100
Date: Sat, 14 Dec 2024 07:56:53 +0100
From: Willy Tarreau <w@1wt.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
Message-ID: <20241214065653.GA29240@1wt.eu>
References: <20241213145925.077514874@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Dec 13, 2024 at 04:03:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.

Booted on Radxa E52C (arm64) using pcie, rtl8125b(r8169), eMMC(dwmmc),
usb(xhci-hcd) + cdc_acm, i2c rtc. Looks good.

Tested-by: Willy Tarreau <w@1wt.eu>

Willy

