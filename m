Return-Path: <stable+bounces-94492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52049D4687
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C67B2396C
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A714A4FB;
	Thu, 21 Nov 2024 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nPWpUXwz"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEF14F10E
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162424; cv=none; b=jXetgtV4Yq+VBhM2PHzkmDICMHSQAOBByI1Yxbt+f+0m0sbpaQbcsMFUWKdy/Sula35Hbfb5FpjbeEl99WbHJwqrL7f3eI701uaS4X/CrLX6E1DveUtYFkNyym8zY14N5p10hPU2xXfOIcBVx1ZPdADcITNGAwWNNWn64+DFlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162424; c=relaxed/simple;
	bh=rsgcDDpuonVLuevU8p+YsVl9GKVNmkAo9l7A4aM06qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyDbNU9mxFIYSv03Q9kayjzTBgTjh6zOCvFpKQBob43Ti5YmSh4A5rGCLpdVm8bEljtKyq1A+3lha2jj0fu4vDkyo5EBxHvbdtlJUaoinc9uGkekFjRPXmtevPdKjoz39NxbjASbpDyF5DBCptxu8Hb2e8W0Xg5YznrzXsNkI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nPWpUXwz; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id DndVt8A2rvH7lDyZTtIJfS; Thu, 21 Nov 2024 04:13:35 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DyZTt6dCxbs9MDyZTtGvr6; Thu, 21 Nov 2024 04:13:35 +0000
X-Authority-Analysis: v=2.4 cv=FY0xxo+6 c=1 sm=1 tr=0 ts=673eb36f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=u4wymUDdFjS2QedViv0A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yMNNEdoktASNnB092jEUhXeJVO1jccuHG1TKJjyMy7U=; b=nPWpUXwzBZvdclOqiDyT1rwdtZ
	uGXs0Xm5qrfEG/zwIjbI5x+xMspg5+FPtwutloYy4YPfpOR2oAXpvBxRgBtySX0gX+vYMRhZB3mfA
	wA8TijR5TE+Q7k3CnwIxxlkjY6qQ0HukJ5hBfDQZ8XdLnlLwV+eceheEHNgB7L/hJ+g149qUkOJFa
	ZJ5320Vreb5o++E/9tbAMLl2cB7Okye3HdrPJaNYeGYY7S1sq1DAMUSL73T0Oee0WftnFF9nucKx6
	uWKXej6EQ6RE5yZe2FDBk26AMgQVgxpE+M3JqfCc3+/LxrzZ7vR7ozRXZO1xFcSPy7y8GKMAqmSBE
	cFOSP00A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43124 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDyZS-003Ejf-0u;
	Wed, 20 Nov 2024 21:13:34 -0700
Message-ID: <52d9eb66-e5c8-4d70-a0f5-58fa9cab3eb0@w6rz.net>
Date: Wed, 20 Nov 2024 20:13:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125629.681745345@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
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
X-Exim-ID: 1tDyZS-003Ejf-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:43124
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKTTQtZrERJJwH3M9x8TYGlh/WgCm9ufF9DcPeYCrB7vLUzDkHBXHe43qEHQYDwB0xybP88j2lJjJ0maWs871XVzCiV2ZO5RJKRoV2vV2U7J/CVKSFJP
 bEwhmDzCIlpJmQ8eeet+2Gnr/SkjJ1fdwRzJXtHBB5aUd2cYUoqBqPhumVV6YjJFjOlb6Y62cGHPKw==

On 11/20/24 04:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


