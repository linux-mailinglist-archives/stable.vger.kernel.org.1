Return-Path: <stable+bounces-104159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD439F1A23
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F157A0428
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5E21B5ED0;
	Fri, 13 Dec 2024 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JZAv5/XL"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5218E054
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132938; cv=none; b=c7BJ4q+kc82hTUaqX2jS/R4KLumVU1G4f/tCmHkXJUi+50t3t5ioKGMNU4QCzk3ZYtjmCdwR6d789lQ1rvAY/ImG8HQfQT/PAHdoVVr9othRLvxJwufj6qUgpgkH0QPG/l06LizFU7PZdxoioNds72/1wjZMQBWVK/a1L+abwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132938; c=relaxed/simple;
	bh=MMd09NUDrNtnOC8NmenQG41UThQUqD7+DAdT6Zeev/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhQcJBnjmGxlEA1k/D2jQQgGMX8RCcE/Zu3lAzA5IH5ZhJJRRK1yAAjTeId7XF4y23Ik95zSIox1T+kmB8YEmYesMkUTVJkkoUaQraDtJHETXACbSQlABibZ1WGya22sb7okqh9w5E9KvNK7bXLypvQrPBX6prhCWhSFrOYX1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JZAv5/XL; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id MDybtZ9kvumtXMFC3tfTl2; Fri, 13 Dec 2024 23:35:35 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MFC2tSMEVCgT6MFC3t2RqM; Fri, 13 Dec 2024 23:35:35 +0000
X-Authority-Analysis: v=2.4 cv=XvwxOkF9 c=1 sm=1 tr=0 ts=675cc4c7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=U14AhigymTHLZSuqQ78A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0yyYX3vr7rXLLk5LRQep12YtMqmm1Hhxnc6isvMbu/E=; b=JZAv5/XLt/5FQ274b0daCOvi+p
	qC0h3MzP5fDXFKEGgt/q5QAaq/9UoIHdvpipYa2MZPnGwcpIJgA4FFG7/ICbYHV99XOyIMCClnq9T
	2UcqDhQJgYFViPfX1lBYgVqxUEYLrlqIQV3To83tkOAbb8/nidsCNyKdByIHRvdAOou9cTStJb+tI
	kR+4rsIpVB65OiiR+n3s/6bE7KuCcXlRJoZ1gMg8uPTUCBVs6lNlVOQLblwfuCMJfk1hb8VEyi51B
	LdnL9Oyr0DbTfDrWXJA4Ol9KIArxv4lHm2uYnVqQSh32f3eAACSNk4Qsxz6RZAfDSL7ZLEAMlvZbY
	OAH+8jwQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:34866 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tMFC1-002YJ2-1j;
	Fri, 13 Dec 2024 16:35:33 -0700
Message-ID: <01fe4794-2ee7-476b-bfeb-9cc3ae2eee82@w6rz.net>
Date: Fri, 13 Dec 2024 15:35:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144311.432886635@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
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
X-Exim-ID: 1tMFC1-002YJ2-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:34866
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNNQHCW847yIy76eVusqs6pavYDdKuyCKvkJwK0TG8NxL9urEl0tPafYOwe7Q5WYzp0GFiNUKsJacFLlpxftKcVpy4PG80OYXDWkZN8SyjHxOhmQHQcu
 lKBxSRfGUoWQHzEp/dO5r9p+yoFHEcR3q1EX1pWlgHNzTuyLZMy4bT5LJhzhySu8JlMEafydri8CaQ==

On 12/12/24 06:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


