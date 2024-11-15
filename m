Return-Path: <stable+bounces-93506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BAF9CDBFC
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D79CB211F7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF51192D95;
	Fri, 15 Nov 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="1pgplZ3T"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680318FC75;
	Fri, 15 Nov 2024 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664755; cv=none; b=qY54mJBIWUz7jgqHkRFmVX/L/Nnu3VXhapcssF0QjFZ5gZZD+HCpQYQ8wxX1BfaWjubqiGtwCTmYskU9s0ppCNDhs0dwKp9ujywpYmjGStH80TsbhhXq01y6ZcPXJRrXmB/EAxyXkCRiO7TyLabpDCyIcutcXUm+S9kLcYbtQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664755; c=relaxed/simple;
	bh=jzOCG6o7wnXXvzyLVUeR4gputvCjuP86WlWF8hmaU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHmEtO67gp9eWWSXZusvn3GgZ38YHZDhHp62K8pRA47dZe1FCQfskTZnYiy9j5zCvqfpWiBFKRDAIZHYMhZXimaI769aN/U/cpEGhiMpeXC7erPOY5YJ2hVMPGFcfHXGNW6aNrw6+VaVYWUoRSSvn3+z/MYf3ryElfC4CYVKsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=1pgplZ3T; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 17A2514C1E1;
	Fri, 15 Nov 2024 10:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731664751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h106Ml7abfvdmPSs7cdnzPNClvb4af5TQOQi0UsQtY0=;
	b=1pgplZ3TLcCZfJjMIf2Hm100HsbpbdO36HJ6g5JO6cYliLJMGhv0y/wiipOWgJAl03H4wJ
	pRs0+cauDuQ60Ig7q7A1zAYY12GK4jYSOnd3c7yazJ/44Zpwl4f9GaRWbZBNM2v4BhHm2R
	S/iSwVYUv3+vVA+tL2toO1/fwY+CzLpVX8ErBmbk0/rgvwfiiZrhv2KOl7k0sUOmYy9//g
	58XcdCd7ulUYaVO4f3aLO9vs4PKE6YFQ4Hwj1VYA7oUNfQFGwL2m9/GrQwSvtUsDJPrFjC
	mcnpuyPUlpwm3uKIKf+kKrIDRf5KWgvAgIdQZyZgwdh9Ldym6zO2bcGCRSgaGQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8136a238;
	Fri, 15 Nov 2024 09:59:04 +0000 (UTC)
Date: Fri, 15 Nov 2024 18:58:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/82] 5.10.230-rc1 review
Message-ID: <ZzcbWa2Bak_7vvUo@codewreck.org>
References: <20241115063725.561151311@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>

Greg Kroah-Hartman wrote on Fri, Nov 15, 2024 at 07:37:37AM +0100:
> This is the start of the stable review cycle for the 5.10.230 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.230-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested d7359abfa20d ("Linux 5.10.230-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

