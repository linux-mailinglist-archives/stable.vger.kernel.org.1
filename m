Return-Path: <stable+bounces-114050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35216A2A4A9
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921321889036
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7122686B;
	Thu,  6 Feb 2025 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="aksC4HcP"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1C22686E
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834418; cv=none; b=GZC2WYMIkxr+b5TumeAzl9W3ukn0sW4NqGylaNpdsnOuQCCbzudMiprmH51+G1k35sF3ZsCLHjjIaVBlt+gO1mo/usfMj4bQbYDdH9y0gTeLL7Ot4HyduIVpaX8IQa49HtWx4W3/U38Ssz1DiIhqTTajgF4Bcxc0tyPY8W7H/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834418; c=relaxed/simple;
	bh=usdz62LURijbWQ2Ga/7vGTMaHUbDX8+cCgvM+iEDBJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChPyw66TR53xobRXWhHcdmiGg7Glu1aPJhWB0iPr1nnZEcjYBgr4nuSUiVQQSnyfxl8uKykuAqBzsDFUvdl6oR/yVGTpKa6xyrYsI5maSS90oR9VUcH2Gsdts2aUfSwjONUF3s3trOCJoWjisXGuGCd0sdeNU+JU59ZHH+8qZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=aksC4HcP; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id fsvst6kD0zZPafyGMtzqxd; Thu, 06 Feb 2025 09:33:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fyGMtpom1hQfUfyGMtxPwx; Thu, 06 Feb 2025 09:33:34 +0000
X-Authority-Analysis: v=2.4 cv=Negt1HD4 c=1 sm=1 tr=0 ts=67a481ee
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g9OED4ookiJITInLTEIPWloDXRRtGC/+P9KCScsYSdQ=; b=aksC4HcP+RjmcglH6u/QW6svcJ
	65bznwhEy5oTC4EiDMRHnltKotGFMshb75iryQCFGZptqeUmps6VPqYGgd6LnUgMTrlLhnjd5dlU3
	ztmwecvyrQMR5u2g1JyOtpZjoY2/FIYP2szZbmOKgB9NJlrhBY0YxN9xDKkkxrkg2mQLoCOfzs9hb
	j+MZLvBh08V9ECkvlZ0ZRa127r1FCpjQ0rMaN//yI0qg/+6wn6Ldj4/utFXa/jhdsO4LKpzSW3m7+
	kagCOdf8zhwpGIiPxw4CJhxRhMkQqLgWkLwn3AoFiqiC6Xk3h/s/0PL1xCq1I1ugTMHYRPuvN7oZu
	JTJvT5+Q==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:55396 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tfyGL-001iYW-03;
	Thu, 06 Feb 2025 02:33:33 -0700
Message-ID: <97713b4c-e3b5-4335-9827-a695f00a09ad@w6rz.net>
Date: Thu, 6 Feb 2025 01:33:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134456.221272033@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
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
X-Exim-ID: 1tfyGL-001iYW-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:55396
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBYaq30QigBndM4S3AqAfvwUhI3IPZvsD6K0nKRTTAZ8+nPvPbmY5vJOkWnJNUDrsmj5un0+XSOKkmIXcyjdXynJhPFDrndR4GpVOqO1TDeqMNa1H4om
 7p19nie2EhVfvBRVgFHd5ca8csNiwCLYDD2ibH7d9te/gfBxONulELQYrMM0KLh8CVyWtMPGFfbQNw==

On 2/5/25 05:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 623 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Feb 2025 13:42:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


