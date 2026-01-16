Return-Path: <stable+bounces-210020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0276D2F6EF
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904D53020396
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6B35F8DA;
	Fri, 16 Jan 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Qsfe+dgt"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86E2DA77F
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558686; cv=none; b=iZZUwwN3fhXataV3zdUo8ZjFyCQz+8ENueh4tXvBsRt3h5DObxAHYtZyHiGvs4a+uX92l2eBo6ujFd6ZrLXn8Zt23HiMKN7mrwvHs8omRA8HAK5lAjktNq3PVKWDxJ9VW44xf5TdztmpVcaxG0u7tSliQG6Z9LZ0YGWkQ4P2nQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558686; c=relaxed/simple;
	bh=zrBQ2TkhU3lars95tzoy/lcJlXaI2jxz4EyMKffoMB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZGV0QqhDiG85F30+NqUNUgPLjlkAmLAyjAPAMmU9lSZc9NIHs4F3F289t1XShHIiTssAsqS/2OHRwvl+zUXlOD6c7VDWudPLey3UFoJ9CydNMVMsRnoK3affZgqEdeouGdEOcBRBRKOglYfq+PzVdGoimMFdjeBitLuo+5ttnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Qsfe+dgt; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id gbwKvRs7cCxrGggtyvo8yc; Fri, 16 Jan 2026 10:17:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ggtxvF4WEqfpWggtxvP4Tb; Fri, 16 Jan 2026 10:17:58 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=696a1056
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=GSBZQEkW3wUDgFpcFaIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=euwxeN6XqGyK8p4+hEAUM7Hlq/LYVRDH8yofqA3Yr5o=; b=Qsfe+dgthrQNdi2qhq0U7clbYB
	LUK6HgV83A6OBiGsTfdNDyzgBzIpRszQn/VxjYCU+wMgtfK1Kk5evgXKLpdHiQFaGIhdfb9InU9Ap
	i/yA1HFkaMzeX2PxZsAJSmphUjAq2yG2c4h0WPTQ3vHocrd/vU7pvExLnPhb/qeulnMoCNwMwKKSV
	NLtawGZOdQL2Cxe68v8jNTzchXLApxWW9UssEhChZ6XnE6n3NhPteu9+lBYOC3Js309v9ZjMz66Yu
	511lPi5oOJmxPeV4MdPdP1SRLkd5wfnM3NpsuCrnXm3eW3rpLNwmvMkWxaF41sDhr2NLprz/xG957
	sas80ENw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:53508 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vggtx-00000000JDq-0cHO;
	Fri, 16 Jan 2026 03:17:57 -0700
Message-ID: <ee407adc-5458-4bc9-9a26-f6026488fcca@w6rz.net>
Date: Fri, 16 Jan 2026 02:17:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164146.312481509@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
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
X-Exim-ID: 1vggtx-00000000JDq-0cHO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:53508
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM7wfkdhIERY07pPPrkH6qtm7ArYKXlY4oW3XnO6sPhpeDSGgvQwbXMhUCgxCLLsCsuvxDVP0i2mCAlc0ZQk7kIftkRWueZF1UMcxLu0K7QVkFFXzxQC
 86/ik/xeU2wG3GBb1GG/gGzFxlNSi6d0877FoD7hzlNcjEX/l5xdfry/56IYYeGAC76nicyrVA82bg==

On 1/15/26 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.121 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

There is a new warning caused by commit "riscv: uprobes: Add missing fence.i after building the XOL buffer"

arch/riscv/kernel/probes/uprobes.c: In function 'arch_uprobe_copy_ixol':
arch/riscv/kernel/probes/uprobes.c:170:23: warning: unused variable 'start' [-Wunused-variable]
   170 |         unsigned long start = (unsigned long)dst;
       |                       ^~~~~

This can be fixed by adding the upstream companion commit "riscv: Replace function-like macro by static inline function", commit id 
121f34341d396b666d8a90b24768b40e08ca0d61

Tested-by: Ron Economos <re@w6rz.net>


