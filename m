Return-Path: <stable+bounces-179030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC80B4A177
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 07:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700C94E0374
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402DA2FCBE1;
	Tue,  9 Sep 2025 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="nOWvEa0n"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB872FC87A
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396843; cv=none; b=AUu9LDClX1bswZkT5PTg8tHIvFl3NWuDmnySo7PFRtQd4Kwtc39VxpLBe4lwC44nJvdNj/8T1mNe9yVXdl/9zZrms/IiQaFzPk1fecZoueDsR0lXMP2+/JQMFcjzrYbEtu8bAWty014c5w+4dhDz+f42yTm7JO0Uek22ZPg5+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396843; c=relaxed/simple;
	bh=pNFLJBWaBI/4oOG7dhwpGC6SsZk9hVfRXeYkyZRJWhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL4V7D1CjBcBACe1KScA8OGmxJk1Wo/UyYKos3spzR6juoJltKFs61kfd4Wju3YiDnpP+AnQ+BscT46B84TAjciet9FKCXnTFoQKYo2oveFUudppirSoTUIro5viccxSpkTwCSTZyydLb8GqxRarfDvBZJgLz1hT7eHdLanTb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=nOWvEa0n; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id vh5wuwsxiSkcfvrCEulHzN; Tue, 09 Sep 2025 05:47:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrCDuBYE1WIZzvrCDu7yjm; Tue, 09 Sep 2025 05:47:13 +0000
X-Authority-Analysis: v=2.4 cv=M7JNKzws c=1 sm=1 tr=0 ts=68bfbf61
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ftbTpB0QAGd6IXrwbd+wdafHWdUigT/c1X1z9SsHSFQ=; b=nOWvEa0nmGoB43DuqXYy0xRSKC
	Gf1l6+nJARY0FE6Xj52zWE/e840mvLgKfgS7URxEQ4UrCMUlDHlHktvtUrBcbOLQY7YnQpkivv4p2
	8vfgnzRKdXesJFgJqfaeHvm38GY+nJFV9iN2HFFgSM05flh4BmUCWbSL1r+B0oxl3/Nlr3rw+CETi
	LcJXwwVL/gxLYlIgJOAWmtd22ObC64yqkouk3ULZSQuRYBzxg+WK5jblCvVfgLQ3iGJrLC+J2SLWy
	ocPOVKA4aTs4k6/WyTDPk9vzHkW/t+SN3IAakmhvB+O/SFSz+WxIpy1EyhLcn0F0vBGp+aUfkI7db
	WY/byp6w==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:44608 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrCC-00000001kTV-1MGZ;
	Mon, 08 Sep 2025 23:47:12 -0600
Message-ID: <57940525-7e4e-4f65-92d0-19d8ae244ba1@w6rz.net>
Date: Mon, 8 Sep 2025 22:47:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
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
X-Exim-ID: 1uvrCC-00000001kTV-1MGZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:44608
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfByOHo3BFIAWKlJ++z6ZkG+oFo8B1tW+7myeb2ZmMArafswOwcURhgkqDEwxQM9dI27b0wFZRMYsbjfMvKF1wsaXkhHFwCZXD+5vlOCi6sM1egE/wZJp
 CmrPHFWBHsxHl2IW2E13B7pEinsr1mPaEqJHAG0ITlX1wNPt2UqOi98nN31MrR/pXLGnZDk63QcQ4w==

On 9/7/25 12:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


