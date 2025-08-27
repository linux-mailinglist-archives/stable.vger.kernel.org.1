Return-Path: <stable+bounces-176480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C48B37ED6
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB93E1BA187D
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A4279DC8;
	Wed, 27 Aug 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GASRpSg2"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2050A278768
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286969; cv=none; b=dbtzqmmeV4AidoSHiskZGO9tDhP9n5IhSpaw7+dXieV3A6QbsSBm428bLJ68Mt2BK7wvRQ5UAp+m3nu3+C2q4URqTlkNzVXMLcoPQn9UBGSLGEq9k9cxDDN3EM1iF5JDmqUrGb1Vifn5k+eilVGPEdlWDn9+eltcoztEl994mVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286969; c=relaxed/simple;
	bh=K25gUegfkpHs5Am96in8kT0g2GhYBHTMCsYstLJf4h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGmLvS3JN2K2zxeSyB81EcCabXGhAY7WO6I9H/k9SYB5JtuZ5BEkeeuyY3htQPOVq6hQp8Nm6N1r5k5VbMELO5eBBcoDofXqAZ7cmeXUDBXfyE0uCv/NFcITP2AWLpMCjqpvfdwKSS8xodJ+vcvKpLcUAUxytkQtFYM2ZfOH7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GASRpSg2; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id rANpuavLlzNRxrCT8u4a1j; Wed, 27 Aug 2025 09:29:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rCT8uSqOVgahDrCT8uTENp; Wed, 27 Aug 2025 09:29:26 +0000
X-Authority-Analysis: v=2.4 cv=faKty1QF c=1 sm=1 tr=0 ts=68aecff6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=LA0ryxVzlY9gRhvUUasA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZpuQVkr+ncYTfHaur4Vk4N0UYIp1vbsfXbaP9mfv+lU=; b=GASRpSg2V/wwNvQHD6oXYPaZ5c
	PNg9GO8tmr6/LvWhi9jsLFy2Tqsf83duelmXlp+F5a59ThZIxU27KE+NeHxpKYZ0h0yrhQKzpGFOu
	zS4NBSQMmFNbBmgHVCYOT1A+AIBKBzhkZm4NgD61aTNvktzVQ10AqgpsIDC1fo0AqJfg6K67/fY4/
	Tsf0jKSoQD9avgu0pmHftRyzU/ufwC3pntAb7FlvgZKfq2E5IDB5LwMvAzomMIiDH8pb5fx+7gyUS
	7YiS2PPY18ZKsA6Qrf8rwu2xrHyLa5Ch1wohQvAMS5ZJmUNc5076tllr28lCeaZ4rYWe9HrfSoxz9
	9zqXnYSg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49774 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urCT7-00000004JhP-1Siu;
	Wed, 27 Aug 2025 03:29:25 -0600
Message-ID: <dd049c17-71f8-4af0-9b17-a3d607b77286@w6rz.net>
Date: Wed, 27 Aug 2025 02:29:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/644] 5.15.190-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110946.507083938@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1urCT7-00000004JhP-1Siu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49774
X-Source-Auth: re@w6rz.net
X-Email-Count: 79
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCS5qTQSScyiROu5VxlBknSbduOhH/2j/LnTH/2G56s3M+KnDK305Qa5n2lBc0pGpF1akpJ2fhY3JrVetj/sa25CzrOA1wKa0BxMRg1+R1mMRs4g6QSV
 aSLHoBahSlYQboP9GupI6Gbb8Y/RLK51TOe+btfYC9u9vRHFPnsDy+i00n5LsQeqTuPUF1EJ8vcjJg==

On 8/26/25 04:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.190 release.
> There are 644 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.190-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


