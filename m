Return-Path: <stable+bounces-109222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D087AA1348F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9C13A6737
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F01553A3;
	Thu, 16 Jan 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="I2Sp9GZ8"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAB5588F
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014459; cv=none; b=HwVYP3wQAjE8EduG7N+fMlqf2zcNiNMqCEMmUaTXmHWnbHgZj4tR14QakVioA7tgN8cULBxEi6m8JP6/uNXDMc3hDaSZyUQjd8qIMDbnmMCcvHKE+Z5nCwfXZremS35Z7GqeT40vtXKzJ72au2mECc3+KMXezmT/AmRq/6VPdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014459; c=relaxed/simple;
	bh=xESsO7IrVCDj1T4kGQjCQ+cyzv4pfXZRGNM9WFKdlNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1PjippfQrEWkhCJ2R/KQq2lfSDObybfzVk/Kgp1nIBLSNyoitsoVyCrK6azkjY5qdIsRmZrfbHmTI13euxwKd91J5m52QIdCpfEMVjIFEqd6N5Fkp3XIP5W1unvf0CRJrb5V66FZN4hUGcmlFQ/XZHNxeQO2xBUMovfHLc6QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=I2Sp9GZ8; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id YH6mt6ztsYpSZYKoBt3Re2; Thu, 16 Jan 2025 08:00:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id YKoAtQVHZhlR2YKoBtha5P; Thu, 16 Jan 2025 08:00:55 +0000
X-Authority-Analysis: v=2.4 cv=M/WGKDws c=1 sm=1 tr=0 ts=6788bcb7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tf+d7fWnxGiaRANB2zdEhJTQbJoR0ngmnxinW0Rk2dk=; b=I2Sp9GZ8aEUSzwObswuDS8APEQ
	Ddvus2oClIwiAFdbBWXES2O+pJcNh3mYTLefm3jlTod2p65QhNzECMhSpYHvP9uzD1fvQeEsJwl4j
	QdYG6O7doHvZHpJYNzx7IMTnoWg7Z2KM0yKaPxocyL+WB+E3qj8eE8xgxYBc56s501hU2eSqRmDRB
	u6J2IUw62NWwB31Lacg8/S/FOAZGF+LNLGGEF5WRSzvJ3xKpk1Um/uLRjmgDHbwdBYLNRQJ5VPgdd
	XFd9SQO410PANnqHIP8Ta+xF4SWuD+MgIAQooaopiCe/uPycgmg1WXS9Qe1aRv8ZVVYd/m9AafxOu
	BTMd6EWw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40436 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tYKo9-003YvL-2U;
	Thu, 16 Jan 2025 01:00:53 -0700
Message-ID: <b7dda222-970b-4866-b120-c1e6ac996b76@w6rz.net>
Date: Thu, 16 Jan 2025 00:00:51 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/189] 6.12.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103606.357764746@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
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
X-Exim-ID: 1tYKo9-003YvL-2U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40436
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGoGW/vyvIy1aeqLMszRd4decSCj3xZsIXE/IyFjESesh3quuL6fWBSXIkg9oNtux9+/sHkZnkFPF+KKgMbFuqIKi5BJAE8zwsI3Y2vpbv2gc0LCe0KB
 arVUtDmE5dgWAGhX5Z9/esYWrj+zqzINOU+a717H2K8ZWEytfyhdEjBWMREgEwqNBfsWOG4uT+97Gw==

On 1/15/25 02:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.10 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Jan 2025 10:34:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


