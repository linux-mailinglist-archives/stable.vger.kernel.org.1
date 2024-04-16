Return-Path: <stable+bounces-39986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C68A63B2
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 08:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2381C20DAD
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99980611;
	Tue, 16 Apr 2024 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Qx9802xj"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474587FBB2
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248415; cv=none; b=THVojvydgAMSMZjaDUgSu1NOmVS1vFJtYNiChj1Sy1UgzoOiPPnxxjj5ROdjthtug+vxFhbqDnZPWjL+Ms4OWuY7or6AslagMPUURzYpFZF52bWGHC+azQkk33UO8L0eEsfKyTzsWQxHXFm9A74QbQTUAlYdz8ZhejFzTarawrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248415; c=relaxed/simple;
	bh=zpgDwiLdQOBjYTSasmSSCBLumx9YfPVZtGQ6bchdS90=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OArfbjQgyGP9bxThdRu/+gBmAHJbwloOu/WPOl9F1AsjYEQnzybkbFRtipEUdepVTEHIRKgzL7AD2u0GlJsKwFWJY69gurHteTMcrvIEjVD1cz0dmiNq9TV7fsjgmplylXocY6LC8Evys1WhBEgyRJg52iIPOs9T4ywwInzJ5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Qx9802xj; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id wEHKrNoQfPM1hwc9Nr3xo7; Tue, 16 Apr 2024 06:18:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wc9Mr3D6VqaR9wc9Mr8RQr; Tue, 16 Apr 2024 06:18:36 +0000
X-Authority-Analysis: v=2.4 cv=MqZU6Xae c=1 sm=1 tr=0 ts=661e183c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jfNlT/ySn7Qr3FEkdlgxEswL18d/N2lZhHDAF1oc5A0=; b=Qx9802xjVPIz5Kj7jDB+ToHydn
	acJrfKQM4kdfODpOfxaeIgNyVSFqeujIET9zmdOg/0jFJr6cY9OA2vB2zUOUHM6TJcYUPbfskWpYB
	5VfZn88gCxdJdfc8E75hITTXiIfFuuobB8/sQtvfW6XUW7WDti+kR/dPWl2haUSF1srG7SKyyM/5w
	iJSckR8V7vlt1Wnm/0BMjt4p5MKttpNzwGxOOjyNX7Sw8qeUAZnw3XwSMnjzO9ny2bx8sjLb/gDoL
	l/54j05GzCwC+vowqiHzp4iEMldyXE3n/1lyWbBuVDXiThIRSlTM9lhYoY8vihI0r6KRVrV64NCAV
	3+R0SKWA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57892 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rwc9K-0025nK-06;
	Tue, 16 Apr 2024 00:18:34 -0600
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141959.976094777@linuxfoundation.org>
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <ac614ec6-feb3-b4ab-0835-1d308a4ea7b3@w6rz.net>
Date: Mon, 15 Apr 2024 23:18:31 -0700
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
X-Exim-ID: 1rwc9K-0025nK-06
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57892
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMmLdINjFg3mEx0WCZ8jXYSuInMnQ04nPSCkfHQUHt0KDR22wIB41EVr2a6ylbg3Bm/MxCMzkh7y+LftNJwF/95sE+LMuN2Jh1yzv1pPG87feE/JDyFH
 zFkDslSCg69XVv60VLqD81KVGarr+EPqY9tVWleS3raxx115N0TLaVYpRksqYXvydMZB5qdrwhDo8g==

On 4/15/24 7:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


