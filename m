Return-Path: <stable+bounces-158502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0EEAE7A0C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 10:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35759163A7C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF30268FED;
	Wed, 25 Jun 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Bn1zpG0d"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87379262FE9;
	Wed, 25 Jun 2025 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840077; cv=none; b=VNrRyCKTH6b7COQKgT5V+4VUw1drCD3p5AVg+AQjpoj5zMJy9F+qELDN+mAqrDhv4BlpHfI0B5pXPjyORj0QxdIlu7ogXnyacRdI0pIOOpEx0Fte9FWrGnTXOAtMy4lE/MGsL1NhcUg3bDr4biDGWgzZEVgtX8/fXsuwNhXqdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840077; c=relaxed/simple;
	bh=tFRL6sdurF5C0oF05Wkk5ZCUtUZzrnnHgrfd/+IUM3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hALoX9q5QIINoi60XdDductszu5kGdQOlz0dQRdZxyRV2nFSt/mQ7tMBYlGsGpq7MAIW4x9OcMQEY5XZd8JZWFeKoUr818HuOsKm04lFtoGjKVQDFiFUGBLpTUygEahje0KDe6i+FocqUMt2hIPT7kavIYubq/S45yWlNuJ68y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Bn1zpG0d; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 13E5A14C2D3;
	Wed, 25 Jun 2025 10:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1750840068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M7MBda3ifyG4jp7mOkjP/Pm966Gi86mycz9M1yI2mNc=;
	b=Bn1zpG0d0TEoLqEscnCtADjX6ukY5s8GVqwl1HB4lH7+XwbHkwitjyZxBR1+2MVTIgGkI5
	a3EpquCcp8HsEEAfVmtGlEOoSfP6WQDMprf8YxNO3+aON98bMEnLTXDctDULMO4PvheqBk
	RcGP0ZrFMWNt0ll1R7x3GZbYFjaoiX7JuuEVMifoVJzdJsBcgokzNKJNGdrUKe5OMn+60c
	BIJ1rj728L+9ClIXX1wWAfujx1ydzEEhKcoaWNuUfmf6EbxKB1AEYNAoFj5Wfdol5+cJr8
	AAPzP+TWiZVLyjKJvUy2REorrm+I/fpI487Hg+ko1bogTRHQ5zVw6vcrkCOQXQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 38d76608;
	Wed, 25 Jun 2025 08:27:41 +0000 (UTC)
Date: Wed, 25 Jun 2025 17:27:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/352] 5.10.239-rc2 review
Message-ID: <aFuy7qm1rv3tAUka@codewreck.org>
References: <20250624121412.352317604@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624121412.352317604@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Jun 24, 2025 at 01:28:53PM +0100:
> This is the start of the stable review cycle for the 5.10.239 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.239-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 9dc843c66f6f ("Linux 5.10.239-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

