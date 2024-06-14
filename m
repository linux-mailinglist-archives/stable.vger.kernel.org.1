Return-Path: <stable+bounces-52157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB3C908677
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE51F240C0
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A108190479;
	Fri, 14 Jun 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wqmcqBgR"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF0F19007F;
	Fri, 14 Jun 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354291; cv=none; b=j3isAmLD90vIo6rzpfCPL9+kTX0tZAf7RS7K1R0RH0B+B3/IyFue+O0Lv3faqjhiQhdA5M6CdAMrnV8Q3p97f+IkZrD40DizL0DjpTNwl+aBRNxuVpcNrdJulUjMbTlrSMwi7Op1/DI+agm3YIiqQ1ZHMjZj8yZfRONerFjEBMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354291; c=relaxed/simple;
	bh=6QqwUINZwrYIdITWIBtpBk2qJO2319v2hxiHhZiXk5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUlQ2kRc0CLYvkA2MXgJeqkoo5Xb3NbHPhbmZ5SM0ue0wmnEvSdfx1dkOY4Of45KixTh9FynvDY92xpxR4fdZ39a9LkwyU+5awnZKNNv9O/UNhK5rjT04uyYxHlSkvaB5JqH9qcy6ifGSfBxe1CsCz87YfY2tGgSLID+oUT0sLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wqmcqBgR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 23DBC14C1E1;
	Fri, 14 Jun 2024 10:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718354280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzytT4OTAPYYW6m/eVOiV+9/isR+EfC8guGdMV3QHtQ=;
	b=wqmcqBgRPTtVLHA9EsnvT3Dc+kYnUrS17ArNJuQh9LwEh7GaogVQlE5qChrkhKmgc0FGzi
	Jy0vOuO5RCrQ+pZzm/G7ji9TYvKvQxylvKWjD5HZsKF5w1JD0oALKspX7Xvd/4kR3cjL4F
	cXF8SpBXcrBCSGG1Lqyafu7TS82pskwlxJU9aJQ8mbIxOYInXutcNhfSVTG3fXU3ybY/nc
	BwJNgWrxJukQ9x/ExTpYO7ZMnqDTEToClvCyi1YyPFo/wHgIwnxw1p/RdEAtuaQ+r8hE79
	+/GpY56BJBhO28XBndA2QAsvNVWGMNaN0VdvEqWJFlj0HBB7fkj1mJRbU6++Vw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b9898663;
	Fri, 14 Jun 2024 08:37:50 +0000 (UTC)
Date: Fri, 14 Jun 2024 17:37:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
Message-ID: <ZmwBTwSgfoQSlOGG@codewreck.org>
References: <20240613113247.525431100@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, Jun 13, 2024 at 01:30:18PM +0200:
> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.219-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

(There will likely be a rc2 for riscv/ppc, but..)

Tested 853b71b570fb ("Linux 5.10.219-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

--
Dominique Martinet | Asmadeus

