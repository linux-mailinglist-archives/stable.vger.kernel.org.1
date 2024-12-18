Return-Path: <stable+bounces-105138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D09F613F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F2B7A289C
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67357192B83;
	Wed, 18 Dec 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Mpa+aKfe"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679C193077;
	Wed, 18 Dec 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513462; cv=none; b=Q71GQCfgbkMavrVho6OOOamEYPclyF9O0rX6xWZngx5D8eO+jsyh6BsHbbpewmAnIJ0R+RdC+fWrYg7/kRkA6Zg2Dv4uHckauspQ/5BTGpQxTFj2OkWcq+vTRR8UpsGCbWjrGlb2pNog6YhHxdc4viEbDQZtqelOpr6q1Vdbwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513462; c=relaxed/simple;
	bh=81W03X68gGBYzA3rl6BqV/sE4OB77VA/zHv9hxXlc94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBzXKjFy/UT4MyyWwJbMqcDqj+PuL6XG1B+qX6huhyH2NwbFNt1h+l1lFVOMVJ9Dd93efoZVdLSg5cTTYvVMyTAZpaLQskC79Enj7wLg0nFA97H2KnDH1nmqa4kBil34XSAVUUDLgtBHly1/9z1FDKHnkXayfmLcDCpv4hZW/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Mpa+aKfe; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 51B8214C1E1;
	Wed, 18 Dec 2024 10:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1734513456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=66qhJNGeTZTNkdOOvfPlIMhbXk5bK/sdDLXwyNqim4U=;
	b=Mpa+aKfenaajNCrIkuT99c8lCdd2hZkxsDWdqcxNFQdKE33fAwuX0PrulH77mMuXriAbps
	T0put/ctxTpAacWYmpV4IkTq62XOwn0nSEmBbdez1fS52HxGSBDhPsXZLlQhCZK6zQQIrs
	Ocji6lLVsy93jeTDcXs5DqSXhE2EPHyiSCbPUYKsXtC71r7aZi5/XrOs5BTUG+Q4+mv6Iu
	KetxL6FusR8vlWbruEZQKjZLntypqH4ViXmVxqEe0WeGmlbF+6sm9JcA4l7F4Z6EFANd7R
	HNafggCdGu7s+6zUFZRRNg7d6mVzkWWylCdkP3fLhy/EB9uyrc/ereoe3t63bQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 15f15ba4;
	Wed, 18 Dec 2024 09:17:29 +0000 (UTC)
Date: Wed, 18 Dec 2024 18:17:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/43] 5.10.232-rc1 review
Message-ID: <Z2KTGgOWlLdPmlnr@codewreck.org>
References: <20241217170520.459491270@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Dec 17, 2024 at 06:06:51PM +0100:
> This is the start of the stable review cycle for the 5.10.232 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.232-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 238644b47ee3 ("Linux 5.10.232-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

