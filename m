Return-Path: <stable+bounces-139095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D3AA4194
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 06:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09A99C391D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2912CDAE;
	Wed, 30 Apr 2025 04:01:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBAE2DC76B;
	Wed, 30 Apr 2025 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985681; cv=none; b=ewM+8VHoJN93dQxEctqs55YRqSUO20BDNh75pEiEt5Q7DdMn4BGFxWH7xPudiy+t5trYlzCy/YeTujV+ksXGnPuEC8zCwfdB1IcrBPZfnLQGagGeX2JVakr81VeWDOxu3tv5vKUIA2tQu97nhroX9k+/wDdHnN39pS6jth2cst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985681; c=relaxed/simple;
	bh=Sji22FZ1M0eD8lQLStguWTgwHobTvbJs4tW4DqZrs1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJWrKu0R+TWW8UlrHRfrtjbKXJHpIIFCFx/mwIY1fSiS5ijU9P69XP3dwsrNKUk+TzX3WG+Wx2marvrKKAf+7YOXBv/Um7w1D3L7wAAjFJIf89JTtOqT/jxn7O3GMmnkF17CcwGVXKb+F+0fA2YTyvEcRWXO2Nn5MXJzQN8mcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=notk.org; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=notk.org
Received: by submarine.notk.org (Postfix, from userid 1001)
	id DB4A714C2DB; Wed, 30 Apr 2025 05:53:08 +0200 (CEST)
Date: Wed, 30 Apr 2025 05:52:53 +0200
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/286] 5.10.237-rc1 review
Message-ID: <aBGelaBd7q-br4e7@submarine>
References: <20250429161107.848008295@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Apr 29, 2025:
> This is the start of the stable review cycle for the 5.10.237 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.237-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested ce0fd5a9f1a4 ("Linux 5.10.237-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

