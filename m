Return-Path: <stable+bounces-72629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA0967C55
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 23:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3691F215C8
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2A18594D;
	Sun,  1 Sep 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="l90DbWeJ"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2118308A;
	Sun,  1 Sep 2024 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725226323; cv=none; b=YlgvaqdrBUqV3Y2evVgiVpDomlTXeoZ/N/yzCpGJm5cy5WZ6n36BnvNyhBS8g+29v7rYTzcdZQBWpZFUNhR0QraNVK2KVb62YWyuHjWonQzqhfgkkNJhrsbWfw/Ez8rJOCOeYQz0Wk5S/4aMn0i1hLBRs4IWN6gvn0tXwixqI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725226323; c=relaxed/simple;
	bh=hAKxii2AHA4r0SKAFo3pvPOxzOVgeBfKCGIQJSUYPXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDuSarLX2xeu0jfLOo5xXljI3Gc7U3UJ4q3CvtaNxm9DXAc+r6Br+a6VRxnQb8i5ppCLBCzdI8GhHeJtz04bGJk6MCcB0uptBc7gN1i1VMcKj/bAEFIMxMO4z91XhTCg719oaoPDWn2ia2nAsIgyZU7t/3aHYIypcKMtrWS6GH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=l90DbWeJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 452F114C1E1;
	Sun,  1 Sep 2024 23:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1725226312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjF8kFSC1OaoOTtQg6ZwHQDUnXTJvG+nyTqgCngUekA=;
	b=l90DbWeJ0eSih6v7OKDYJeda3OTeGVgfxuPJZRrmAa2xtWUjyjAH4eceGrjcJNg+V/Qubh
	O6Uuskt4Je8JiudgTu1SAdW97eUZzPoPFpBBITz+mLgvCLUq76aN30n3ANOF5i2b0babl2
	wXtdylEN2mxJhNut5rxX4+pJS5LWIZMj6KfVYei0Erc7zpebX9LSDVk7ElQaEHdB5hcID6
	FzEBwdJGLVqkBtRiz6f/J1SDYirCOz9lhfMO6fCNPxY2mmrr0lNKPoMcMsebqPBnN4jrSU
	K/TdWmcXG4oXJ+I69it8kbF3Mjg1KErbmw3vgEucOnszsmUFh3wsPpdeetR1gA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f91a7026;
	Sun, 1 Sep 2024 21:31:45 +0000 (UTC)
Date: Mon, 2 Sep 2024 06:31:30 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/151] 5.10.225-rc1 review
Message-ID: <ZtTdMijfnu0mqanS@codewreck.org>
References: <20240901160814.090297276@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>

Greg Kroah-Hartman wrote on Sun, Sep 01, 2024 at 06:16:00PM +0200:
> This is the start of the stable review cycle for the 5.10.225 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.225-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested ee485d4aa099 ("Linux 5.10.225-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

