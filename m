Return-Path: <stable+bounces-93618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65FC9CFB77
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 01:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00971B2B51F
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52B5624;
	Sat, 16 Nov 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="dVNHcI8p"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C489383
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715927; cv=none; b=WuOyFignl/8QpUO6dMyVU93qHi1qyWUBcn88lqQPwZfzC6jH1IENEBPoWiUWPX8VLVM03TLeoyWKc8JfAu+nzHYxwe60Da2FhY3NAeBFSFSBW5v8p3DIKpln9X2Lcuy0H5lWifkEL5Fc7Ep8GDZdb4S0hPY/bbBBvSJmzTM/eLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715927; c=relaxed/simple;
	bh=Y6ucSegMiZNxU0GjhASPfY1PY8RNWBlsE/zVcIgEAik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQXXqXJYKY0GuvmkOAwKsdEvuL/APartXn3kkYlh2N+YyV1hd4YuBOjh1x8GFEbgEXHCT3CHjspf+2qQueuxiMiuiczGLvO2zF1//SZVEIXpdfibRHMoAkkjdqbpZn+3+M2gJpDwUd2q0MQlCKDBieYuP/Kluv0PBl8/GVMi1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=dVNHcI8p; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id BzfHtVNxFiA19C6Q0tjgLF; Sat, 16 Nov 2024 00:12:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id C6PztcTPJWdNZC6PztCH8x; Sat, 16 Nov 2024 00:12:04 +0000
X-Authority-Analysis: v=2.4 cv=FtTO/Hrq c=1 sm=1 tr=0 ts=6737e354
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=l_-f7-u7_j4nK6mRNekA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gP8lDwYQhs/yL6Aq9LMMJ1T/8YvadtJjp7zovNXWkvY=; b=dVNHcI8pMvCb7k+uwESbBS/kkf
	UqYRNLI5SA6Tc4qrhmGI2XBBoejH/9Sxi5MX3jlyVr2HuzAWBEyqRwb3UO0Als5rOJ4QenQANaQBV
	R8APRASu2TAp8mRFjha9lnhobeYzANNpcgzH9v/xEBLgp47FU9/8KPUhf0rp75D996vTQctiRSB/s
	/ZXZ8DCAsEstV0z/eovA+JXAr77+sLwWx5cgVIBUuzM6gSvkjUJRh59Cs+vOGTblyruNbnL7iyETe
	Lp2/lyqWk4vvJTosldPhXvZDqje64yiEqVrOVXNXnnKqD3qSSqZV3a/mNEAVV5G9O9QAGRnU4xQj5
	UfXfynGg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:52226 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tC6Py-002txU-1j;
	Fri, 15 Nov 2024 17:12:02 -0700
Message-ID: <20714abf-7249-4610-a59b-d87ab4b7fb16@w6rz.net>
Date: Fri, 15 Nov 2024 16:12:00 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/22] 5.15.173-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063721.172791419@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241115063721.172791419@linuxfoundation.org>
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
X-Exim-ID: 1tC6Py-002txU-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:52226
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA/V8y4bfFf9K/MyTCyp3DiQl3scIHQ1E6JHUKNf7TJobVGBaJnhdB056cDs/ZQZfps3IM0W04vrOdIpwha2ACY3V006AtmD99YZtwUxPkLF7nPAGLXl
 +07gP70sh3DlT7Q3rmDYdMfjfCb+c3TTjARecrJq578k1Aj6vK90vrn+0iSJvfns5Y43g5PHUlwQUw==

On 11/14/24 22:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.173 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.173-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


