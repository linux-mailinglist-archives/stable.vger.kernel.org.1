Return-Path: <stable+bounces-191389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D91C12E14
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8941A26146
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B37238C23;
	Tue, 28 Oct 2025 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="X1HAw4Xa"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E43236A70
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 04:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627013; cv=none; b=PzhzU28gEptsEkKqUOgSYvvKO7qOCIo/Wbph4An0zGs/x5FTPBlZ+zsjlh0o3LqSz2pyYI89RzA0u3fkk7hl3vp+PuECmyV0svRXBuCJY+xwijqqqxXENPuuvISRTmNsqun5HJiEhWkesncCPGTYLlxhwrwfs4MFgXaTQbUaZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627013; c=relaxed/simple;
	bh=HczQKsoTq9bG91ZgMaU1ONGlCVa9s98TDf0X1YkuKFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gum0dys+Yp9iZebrqNJCfOf63/8cSky0bYMFOIvUoW3+sZ/qG6aL5iunPsUcAikxPFQUm29jTWXNOIDYdSim9o8y9kxLNPsCDPPwf0/V2SV2F3kwqCCmZ5hDZE+79BprznXf5tOrzTdznqpC6hF8J8pV+lFg9l36+Oc/E6EKL3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=X1HAw4Xa; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id DS1Mvwa3oaPqLDbemvsnXT; Tue, 28 Oct 2025 04:50:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Dbeivp929HwAIDbejvyNVq; Tue, 28 Oct 2025 04:50:01 +0000
X-Authority-Analysis: v=2.4 cv=LbQ86ifi c=1 sm=1 tr=0 ts=69004b7c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=LJ9ngj4a5Ur-kbwn2PoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xGFJqws/sjdhw2gBoS/JsBvsWK0Eluys8JTz/11lTe4=; b=X1HAw4XaeTnhac8AWa4eQoKBcU
	oYjr29lBFN5f2kOAskUOq7q8MWAqUftHyfF8mHJ7v3pDp9Vp8sf98tZ2AHhM6QHUobeET2EZ+ztPb
	8rZPSt54K7bAz+d7S5svpFpLE8d19VD/A+EDp0uhyeH65Kp91FMI5+Bdcfx9r6ngginnGWcEwnvFh
	3MDNoRIMF6xh7C3RePK7pKKz0+H396Uro6u9fUb7+htK4k5tKa/EAlYmIrxH/nAPsXFiZhmQ0fLAY
	SjQtPuwZihY0xhjWBSNG/+xhvfc+MybFx2hj00Dl7ok638U2Elsuyn02ccQVUfwyn23RK7akhISoQ
	XEWLrk8g==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:53180 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vDbei-00000003rHk-2MEQ;
	Mon, 27 Oct 2025 22:50:00 -0600
Message-ID: <d61b75c9-a6a1-452c-a2be-34959d354739@w6rz.net>
Date: Mon, 27 Oct 2025 21:49:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vDbei-00000003rHk-2MEQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:53180
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJjjsMJAI9LRjA9g+15AgLQ5BUyXRkzeL/+STs+iYSYq08gwpkeKiRVG1YYS5eOYBZVlsqPDaL8s5dqURcSlMX9nMgrymC4eQs8TP6WdLUrZF7lu1aXP
 DK3bIU9njZfgya4FoS6sWII9/VKpDWf2aUB7i0y/invqXXmxolUA4q1hRG3aJvIllBbLGyb0Q80Bnw==

On 10/27/25 11:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The RISC-V build fails with:

arch/riscv/kernel/cpu.c: In function 'riscv_of_processor_hartid':
arch/riscv/kernel/cpu.c:24:33: error: implicit declaration of function 
'of_get_cpu_hwid'; did you mean 'of_get_cpu_node'? 
[-Werror=implicit-function-declaration]
    24 |         *hart = (unsigned long) of_get_cpu_hwid(node, 0);
       |                                 ^~~~~~~~~~~~~~~
       |                                 of_get_cpu_node
cc1: some warnings being treated as errors

The function of_get_cpu_hwid() doesn't exist in Linux 5.15.x. It was 
introduced in 5.16-rc1. The following patches should be reverted:

87b94f8227b3b654ea6e7670cefb32dab0e570ed RISC-V: Don't fail in 
riscv_of_parent_hartid() for disabled HARTs

568d34c6aafa066bbdb5e7b6aed9c492d81964e8 RISC-V: Don't print details of 
CPUs disabled in DT

And the stable-dep-of patches for the above should also be reverted 
since they cause warnings:

989694ece94da2bbae6c6f3f044994302f923cc8 riscv: cpu: Add 64bit hartid 
support on RV64

8c2544fd913bb7b29ee3af79e0b302036689fe7a RISC-V: Minimal parser for 
"riscv, isa" strings

e0cc917db8fb7b4881ad3e8feb76cefa06f04fe6 RISC-V: Correctly print 
supported extensions

c616540d6b67830bb4345130e8fa3d8e217249a0 iscv: Use of_get_cpu_hwid()


