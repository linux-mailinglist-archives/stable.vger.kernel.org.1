Return-Path: <stable+bounces-18768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91660848C11
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424FF2845A2
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CEBFC09;
	Sun,  4 Feb 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Ghkf/B8s"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AE10A19
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034385; cv=none; b=nI76p0eeddskGl850meU5f2WZIyDgU2mSt3JjySf7aKo2bChnkWVbUNTTYKYpC56AmyjCk7F7KDxv3VPCLOoUUPpqzd/RIqgK6v7eejIqL+QTBVYJ2eH+65epDZC23UeFzF+7r7a2a0uYMH8YItomy+UuuZb3Zf5yl9wXlXGW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034385; c=relaxed/simple;
	bh=rZoq6b5pkukaVG8jwnirhFvcRHGagrh51WlaI+SeVG4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=BJmRj0VG3QttXMDKC8ALDWs7uXqBNkCGM9nlp3ygBfE0kVuerah2FAAccr6C/D8PzWWx6pl69R0Tq7LmhMFKPahqanFVsXuOBZXpne2y0V1KQEZ9B4AlIRRF1JwoZUv6gOLcw4eCXU5gM1b5Q338ZyUgMjS7vujQoaEHIPLVTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Ghkf/B8s; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id W4Bsr04f780oiWXcWrV3aK; Sun, 04 Feb 2024 08:12:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id WXcVrlDmKSgZXWXcWrGsse; Sun, 04 Feb 2024 08:12:56 +0000
X-Authority-Analysis: v=2.4 cv=bpzvB1ai c=1 sm=1 tr=0 ts=65bf4708
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pHq7qycJMCxksKlQHHsrnLJ7JcU6CWtMAm4b1Bs4fcw=; b=Ghkf/B8snnPxdCMD5Ud/dyZ6E4
	+gad47o6/FS0nUOEMd+krH30sRsP7Q1YjfkeCapOk9+epJtWc041g1Dcg0eZO9hKWr8Rsh9LlMyUU
	SY0TsddWzLEjH7ve6q7McYV6X22dMpvLrlwGcO8HJuRcFf8gey+aWEujcHleYgCst4LT84o5+szFc
	ikMmgnjSYT8r2SBjHd1j8gmxDoxP6FYo1Lg3QnR/1wtRG1s57xQfzLwniYWZQOwcC2OFF1KcWx0Xq
	+H78x4KtAQTMi+tmalR53bVilkHPUuLZp/G1LJ+RI4oDMSu3MtU4VicCJHpesl4y2jD4FalQIqP+Y
	pkryFV4w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:38136 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rWXcT-001HVN-1X;
	Sun, 04 Feb 2024 01:12:53 -0700
Subject: Re: [PATCH 6.7 000/355] 6.7.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203174813.681845076@linuxfoundation.org>
In-Reply-To: <20240203174813.681845076@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <19dc547a-d718-351a-ae4d-4b91a239db18@w6rz.net>
Date: Sun, 4 Feb 2024 00:12:50 -0800
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rWXcT-001HVN-1X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:38136
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHDUeLFn+paTshDu2sdm1h79NItuNuN+1qJ7+OORHAwkDJ1+LyQCz7nSO77+soqP4cz4QL+d5xR4ykbws+GUnQAgi/R3O82J2Ntc3B/HRzC9RdTm7cSt
 5saL4SL8+EkaXIkxo3fNBlx0DZtTXnmyZkv6d1mi7e7mTqUYxn+JAHgn0awZMBkm5u5J/pHs3iqBuw==

On 2/3/24 9:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.4 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


