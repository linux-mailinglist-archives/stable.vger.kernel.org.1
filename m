Return-Path: <stable+bounces-177588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278B7B4191B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC00D56158F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE12D839B;
	Wed,  3 Sep 2025 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Y2QpXu1L"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7B2DF135
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889407; cv=none; b=kfx7b502WHgJ48MHNDqizllFZvrpbXC7M4SO9lRe7oO/wZIWYrcoOFMkqS11U5HHsZ3+JgZk/zD6loyNgO94mEGm1WIyjtgONVmKaOeThRs5M9pYoky/BKhhL43KESY9FuEl8jTv2OJwnOTYc42dGkq2LTcm6+YkKIsI7hcOQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889407; c=relaxed/simple;
	bh=MiQin4cOn2+EGynYYK3FaJfsn+MBsVtWGk2cEA+ArL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HynuFJpn69wkN5W+spZdnUArKnsiH3WVraOFPEoCBkbuxiGsa34Ja6CmQLCh/ygGcUzJXp1gJi2ysaqzsf3hIlvoDYe5oMdJfGNhUI+C67KfgIf4vUEcSysXo3e3IpS+U8s2AgxZNKBE7I8BQcrhQTcksYh3T7RXNPalPiP0nKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Y2QpXu1L; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id tiPUu0lFjKXDJtjBru0jYq; Wed, 03 Sep 2025 08:50:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id tjBqulY795QkFtjBqu5DM0; Wed, 03 Sep 2025 08:50:03 +0000
X-Authority-Analysis: v=2.4 cv=DMKP4zNb c=1 sm=1 tr=0 ts=68b8013b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wQHQzwf_Hs2TCVCgcZgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XPE36onuc2rycoyaawl/cY1/M6tjYkM6CJTTl/mMhZ4=; b=Y2QpXu1L9g3lgPlxnk3LVCJ2Ss
	6nEb16TLl8qPx0QiC6TWZ9vDA5KjXa4tM1sYKtCBoIjKhgqCI4g9Tdm5r4wSgzaKbJ9NPDsENloNl
	LRHNynOR6ySpHkV1LAmg0brf6AUgIwnoWOh/sVyA1GJ11rzPZdC7PMaZSdBn4K4rxANNBuTbmkSDJ
	yPTyZs4CNIVMyl9nU2CS+iTVoa7WNrAIHJIBe7gHfLcExfUrIrLFcZNjJ2Za77F0oMQ9lT9GZkow1
	RNiK2lLkGjQyz3B23e2O0mpLzEY6Ue7FSaHzm9imkGFPfG2A7P13fiF7sqd3B6CiIfxz/+fn05+6p
	PIdwmoZg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48696 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1utjBp-00000000ge4-2qI5;
	Wed, 03 Sep 2025 02:50:01 -0600
Message-ID: <e63d2a07-56ff-46c4-b957-7375a9fddf44@w6rz.net>
Date: Wed, 3 Sep 2025 01:49:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131948.154194162@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
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
X-Exim-ID: 1utjBp-00000000ge4-2qI5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48696
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBpVwZ/b34rDwVhoPhQaZ+QPxYHVzkTGDcwRFQRATmEy3eVfPC/0zzULj/0H02GxYybFQGOMmTV3H05moFKJJ+5KGCJJUpsNamAy+2gNvOvl/UUpR1Q1
 WCwrz/YgJ6Bmct2Sd4a+1nNhPLLY7iBIRhYtbIDyzODSDUF8eB3CRwbdJpqec0dHVx3GnRybWRx4Lg==

On 9/2/25 06:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


