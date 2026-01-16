Return-Path: <stable+bounces-210018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D3D2F35A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C672C300AAC9
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD73587CE;
	Fri, 16 Jan 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hQdYg8u3"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF04C97
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557802; cv=none; b=a694wlU45bKtcl4H96sx6+OtuKEAdAgxmIWSSGoOZv1g3hYUnG7hcNhotem8Bi3BP5KoQ85s32beB9Knp6Bp98tWdDMioHkR5rPCnBzuu7nRXdFPELm/6q6Hkyl/Qv206+9vtB+HnnAuaVEtzb3zbm0oiScQPNcFS7VA2wED4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557802; c=relaxed/simple;
	bh=1gHeHHn2xVWlJ+9Bx3hJjHa00v2qF1X9BvU70LWoWWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2wo83oMLFCgq0qZZacFs/2p2jlcIMvSXGRzLMT4bIO7Qb9nNUofCm/mOtSuIRk85+R3/cTN5KA17mmfunFxlCTdhBTr9UOHXJvVlNcikvJQ/wkN1Q7q7Ywt/N4T9JiT6AhaxWXoAjmAIqn9RJNScD4JPl2ZADuJbCzG56XuKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hQdYg8u3; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id gcykvmjWnKXDJggfovgQna; Fri, 16 Jan 2026 10:03:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ggfnv94GmSqlVggfovhWUr; Fri, 16 Jan 2026 10:03:20 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=696a0ce8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=yLgqrl2s3EH9fNXCsX4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kES9iazB2idCZZIKfv/owPdu06B62E/Pp4ZEPH4rl3Q=; b=hQdYg8u30U0lcYqVQyKLqhDJpC
	WayY3utOJmdy8GgUIOXVKAou6Ez0hLBBaliVJ04vMrlh415zW9TqBaaPLIVWbtpxi17vnIC6PJmMW
	O6Y40Re4WpUPMj7CBtp0OBHfNSmtFvovltL0ithllTKoIjyxnwXBviDccqyMv16pPhipbby0okFtT
	e72s+cjkuQNMcELL7vbtLDCrXVnJlde6yJKqcK3WSnbNFC22tkFJkNLbBn3o/uMoFUgSFlgDyCn9E
	IwmwbZKnoLvn8nW3fXe8ptFfPtte9l3RcJNTGioY1GNGbA8H8unHU/Yayas+tHJR3FRBWehxUPS81
	zmj2I9iA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:54876 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vggfn-00000000DvW-1yW2;
	Fri, 16 Jan 2026 03:03:19 -0700
Message-ID: <cfd276b5-9e65-46f9-9513-e7ea2feba187@w6rz.net>
Date: Fri, 16 Jan 2026 02:03:17 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164151.948839306@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
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
X-Exim-ID: 1vggfn-00000000DvW-1yW2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:54876
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHfBHFUudEObumOM/DKRXO0bxWgOq1eZaRBB+dnGpkO6EK0b+uJWBPv6E8HUp+tDHvHKFAETcf2DCGsMdn8/C5Jl1B+JUmdGnx6qzQjV9ZE+hT87uyWI
 iENrVNo4nwl2nguouFGeBnLrFFbGjJD0OBitf/ctsOXtIji+Q44i1dtJba3M+Ydb1oW3fTlv7sEGrg==

On 1/15/26 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.66-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


