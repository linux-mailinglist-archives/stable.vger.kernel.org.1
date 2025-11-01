Return-Path: <stable+bounces-191985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE974C27CCB
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 12:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156DF18906FB
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 11:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9A284686;
	Sat,  1 Nov 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="z/dudYB6"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BD226D16
	for <stable@vger.kernel.org>; Sat,  1 Nov 2025 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997055; cv=none; b=Pe0YIBoTGB/Oj3/R96Iq1vBEB1uTCo0KUVSs6yy4/5YiIRXwtYsjDXZtBssaPmgcSEz3FbaWZZW4BNqEInqBFt7NGyIfInorTFMeMhKf1Ganu0tPl3r8VERooLT8EJ2hakhZdhmQUpox/2obe6G1/WeGm1v2h7g5jrBj4NZeMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997055; c=relaxed/simple;
	bh=jBBIH7MG4SUzxArAdWl/9abCdnBvCrp6q9Gg5bOYK/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXcE7arO4Obx6rLAhNJVNWvJU94Yo9nseky/KOHEX8ESRtE0fDERB0Up6+9eUHuitEcg/GAgEJOyf6tCDfXh/T7VvDq3kLcCW6lfh9qJg6RjGjUpj1QjMIbZx9eQBJm7iWhUfFL3CIqWvDsjL45xJCUH/DHPXRc5WMA6t/nhoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=z/dudYB6; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id F9gnvaPz9SkcfF9vCvt6Ip; Sat, 01 Nov 2025 11:37:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id F9vBvjajSniktF9vCvJwbg; Sat, 01 Nov 2025 11:37:26 +0000
X-Authority-Analysis: v=2.4 cv=FOIbx/os c=1 sm=1 tr=0 ts=6905f0f6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=iZo6ewWmMc9ApeDx_DoA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TWHceUOi+puB+4vFJPbTXNJOHv78GEBKrK1kOsG0L4A=; b=z/dudYB6w0QTB7pCJTpwt2eQ50
	a54yIoIfuSBDvRDP1Sc2PcpGKMFaSwjvWOWL5OwGR0nWCmYCvQyHjPUXaOvoqNnbxNPqgamb+/Wsq
	H3qL877SYFfIHzFUsNhlyol6mRYMu1RuAWDLsRWQjH1CHuFMBgW34XT4WuJfq06jKv4qW1ZNbGJDN
	NRNVcZZ5UM4FIib06tRzEiwFxFA5pPMa+NvWrpkXOkQWCKdBs1JpO0jHIypcAMxa4c35cSo9y37Ev
	IE/O8tfG8usT3Katc4wPi20yP30QVPrZ0o+j9g74Uc/NYU/qONxO3MlNkoha8onGAQ+FRJpvTzcIq
	XcxqJbHg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:50078 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vF9vB-00000003aYP-1knG;
	Sat, 01 Nov 2025 05:37:25 -0600
Message-ID: <5ec93d4b-fadf-4d38-aca7-e22a7c42078d@w6rz.net>
Date: Sat, 1 Nov 2025 04:37:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251031140043.564670400@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vF9vB-00000003aYP-1knG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:50078
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEr2pj0M/VAlC/jprQwC3Ywypllx4wIOBUISx2y8qMDR38lineXbsLBVZ4cUwdhRhvxx4r2kTNBJs1WSwSEwEEttO2mkr3RNSAmS1lNvom4WvACWrKgL
 1pX/uarHGK4ObDrYfY6ojjZrr3U0Q/X2LZ++n2bkBROGfLJGVDr1SpQXyRsPIfLY2zRbPUra9UuY5w==

On 10/31/25 07:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


