Return-Path: <stable+bounces-61853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789193D075
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3172B20F58
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB058178360;
	Fri, 26 Jul 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ohJriQwv"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58001741DA
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986559; cv=none; b=klueG/atRlnPVgQ3FegvUxifazs9TDF/LM30nn1rfA8L+R//mgLAkgUsKwjOKTbTpcsRX4vUbbletRelUvvJ1g0ajtOfkJnsOQit+XGJ9min1P3Ej+vYiQSyjkntJxMDSZgq7dbTtYWAtEaAvKXwSLfFmiH+uJRaokaqm2Yi5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986559; c=relaxed/simple;
	bh=d17qNW9Cmc3z0FcmOgveSQqUgbjM0ztt3lwp/ovST/0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=jR29b/IOm1cWRYI0UrYwLBu3HR4OFcF+CcWZiFUbU031etf/cBvgzAABXR3ZaFN62nlxv8kzfN+V+uCGN0M95uTSjAkBN15irdoBQK/gZjhi/MGPT90A3l9/L8Zz+j2jxKcwOoqX8J/WzV8Wmm3RPlkvcTDy/bqs7lqqaEUgz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ohJriQwv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id X4dAsaPf7iA19XHMisIVav; Fri, 26 Jul 2024 09:35:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id XHMhsvLn6XCIHXHMisJZ9E; Fri, 26 Jul 2024 09:35:56 +0000
X-Authority-Analysis: v=2.4 cv=dKWgmvZb c=1 sm=1 tr=0 ts=66a36dfc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ptl5cmTnn6koUKZXVZBKDW80S3sMtIdccC55tkeSdBw=; b=ohJriQwvdtZ160OnRv2Muf0O/w
	Nvre7/RkyKsBYIBenIlD4zU0CDKmHe7xzohFUHTIWJyFUJQqC58gn0E/jS3RMTagPCBIa0d7+V1oU
	JTaKVJVGAXIJPDdO49opxLnvkuyjyTBylTzIxmVovvWKuybt6Ztx4sAeumzh2E/xv5hZGV2P+L7Uz
	k+mHRNO7YIWFf8kfI1Ao2nNBDMefi1xmvGR/vhLMgc2rLNHfePBM5gwJNatQkXux0bjX1cWTEel8K
	er9VI8W7304qV/24Nh8cx8YWiL+tl+tYMJcTDYHrfOwvCUDfST6RuKM5gikrE3S+EJgCjLu9ejy7N
	s9aF8nwQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59298 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sXHMd-0003yQ-14;
	Fri, 26 Jul 2024 03:35:51 -0600
Subject: Re: [PATCH 5.15 00/90] 5.15.164-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240726070557.506802053@linuxfoundation.org>
In-Reply-To: <20240726070557.506802053@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <4e18540d-b1bf-7c72-04ad-ac08263b37c8@w6rz.net>
Date: Fri, 26 Jul 2024 02:35:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sXHMd-0003yQ-14
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59298
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPoh4BJIe1m2eJC9FZJoCKrrieQ86UZ9Ooo0p/FxOsO9KHJ6i/oiG3ftC7lAQ/cgIrPql14l2ZHS1iBw4PRzS2Y1RVqQj6QwVuerLM7DYNyzrsFwpQpe
 w8Dbm6W8xMFNqdsyh2iIZ2/Jjpr2zh76WET5ZzyaUdwWBN+I9dYaelTHdXA3qHJfJAoDv+FDzvA1Ng==

On 7/26/24 12:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 28 Jul 2024 07:05:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.164-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


