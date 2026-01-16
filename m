Return-Path: <stable+bounces-210021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61517D2F7CA
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 209CA3065253
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7064C36164B;
	Fri, 16 Jan 2026 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sS080kvQ"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C931CA46
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558934; cv=none; b=CzXq36Jx3+elb+isLxFfE1l8hsR1kaeOdo5mp0eFD+ilJJs1MrQoo9cD9axVeB5okiIofmcjCd4PSqgcVGIaOyuVbu6Vykv4UWegWsiSZWqRkRCnw/R+Vjw3Z1RmHokf+3fAgfZvihIlzl8W4MAyXxCnqQv8Hvi+mMT9mjoETps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558934; c=relaxed/simple;
	bh=dtUkNGClBI48UMI3su0I1aAQ50UcVkyerNsLFhjO3cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frIzjJNCn7tvm8FNWG2iWhRzxHYXi4/zuVg0R4D9ItoxtHGCPukacZo/hBxUE/Mnv+IcpydXxm9VSrFF1s3pmup94QGzaE1ig8FpLMoGRUlOkBxzPomV/BvT9hFU6aVQcc8MVzzov53Hg7SIBToazCiElLS1qTDpHKDQAynXT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sS080kvQ; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id gfXxvfKL2aPqLggy4v3EPk; Fri, 16 Jan 2026 10:22:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ggy4v2cQjHSQMggy4vldhX; Fri, 16 Jan 2026 10:22:12 +0000
X-Authority-Analysis: v=2.4 cv=GIQIEvNK c=1 sm=1 tr=0 ts=696a1154
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
	bh=k4OkFD9+DVeZQ1b791BBTV0gOdzh87R6sEX+hIE3FB8=; b=sS080kvQP7YfBO7fFEEoLl6c8t
	iAuQTeSonAz+sw5TsOEFK19N+NYAp7o8kS/skJ0V6HzfcjMLzqi6mVvM3sKSObriwBonLO7vYKY8w
	sY34bxDA+9CfzsFvVT1oXXOkHcGqCsqO0vxBHvy/k7HxXbP2loQdPOliu93cMzmK+wAGBohatJoWI
	SnTt8TFtOn/L9Ac7PTfc8TMBQjBMQWGcuF8JtvTn3r+N16R+N5fm2VOTAVWbpgjlsSotkYNLjcdsl
	QK0IPLVme2V5QeNDQGrAfDRweuUpOvjSG4x/90WwB+3De71AU+6wb5Z175aVRsi7+0y6EBDN3osov
	liWHw6IQ==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:43038 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vggy3-00000000KvN-3agF;
	Fri, 16 Jan 2026 03:22:11 -0700
Message-ID: <c5080990-0581-44fd-a713-5c1902389da9@w6rz.net>
Date: Fri, 16 Jan 2026 02:22:09 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/72] 6.1.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164143.482647486@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
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
X-Exim-ID: 1vggy3-00000000KvN-3agF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:43038
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBPL0iuLVv3+0YFlP2R3nIhmEFqCTPsSB9K0M/VG1LJWgZ9Fm5oEqxrchOz/ZD706/rJk26853Ar5EvEA2FYyJbgS+eLeTrL+YCSENDLPWvBPYgAhlf7
 I+XShJLoT89u3E4FjYO0I+3Og0zJWmnpbHSCe/568bln87AvDJgjhr2FijGoBOtZtYfdB9XTFoHgww==

On 1/15/26 08:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.161 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.161-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


