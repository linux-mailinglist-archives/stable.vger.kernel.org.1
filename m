Return-Path: <stable+bounces-20235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B236855AA9
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 07:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAA9293975
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A968BE0;
	Thu, 15 Feb 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="skj+4uH1"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E94D531
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979311; cv=none; b=EzFp2CUe5xFYcx6adN5PmkdRX837dc2CvZuVaMKcetkwXwaYgmP1ULJrcO9GYrio9Bo4a/95YYMFa+AbeeBH6Vn/fFf7sLVXO+56ghVlfmFtOSjQAvvQU+vc9z5f9uJxr0scFzA7vOXrtXto13uREudH9KBiDuIi51dO6i7v19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979311; c=relaxed/simple;
	bh=MjLtIxavywyrqMYBPoW5xcftxRVCFdNpvLFC0PnvZvA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Vd35gBWANPmhxEz6fIBmMWx2+gL/iumHEiDLWFtzfgDS6JNis2KualuCDnahivViBKl32XGhiG+FLXPnQKSGQOHR0St2xDcoNwjtruS1QsOCj6nmijsAvyRvqETCKNICbPISGzOc6dnwAa5HWVsyBEXHiACXpxPpFpv1ChzsdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=skj+4uH1; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id aSTvr0KP480oiaVRHr814j; Thu, 15 Feb 2024 06:41:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aVRGrl1dEuIXpaVRGrhv0v; Thu, 15 Feb 2024 06:41:42 +0000
X-Authority-Analysis: v=2.4 cv=C6pKyhP+ c=1 sm=1 tr=0 ts=65cdb226
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
	bh=o5j5rpbz7o4cVtXXRa4LirFePpxBODMAzsqCWJMxsHs=; b=skj+4uH1RdKr/FlqWKQ0SUAz/F
	4Irl5/s3ImqFRjpHBiquGB5W1M8KHOW3JasPOD+ZjuoKHzTKRT5/JmMNudEHktXwqQjGc2icq6FK/
	TniMKda+nRuWuiDiH1PRCsDiKNNmBlU0ZONItHuvZNrZHvN+2SX8EK0bQK0923BEv7iC0as2pXl8N
	0SWuw83Ib0um+SQiDto6MR72KAsiTZrP8AeT/PBH3Ye5VGxW1kMN7N/9Q4RBQyGzLVr/W2JydHVPQ
	PXkNPznxAMEv60bLdR1cj913WM/CZbWhLijltXtZ7TZK3Zp+ky1RibpH13jAi7LiK9DDHi1vCNZni
	RncQLbgw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:46150 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1raVRE-003OOe-16;
	Wed, 14 Feb 2024 23:41:40 -0700
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240214142941.551330912@linuxfoundation.org>
In-Reply-To: <20240214142941.551330912@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <c40d4d6b-0ae3-28b1-e290-779b996b3c63@w6rz.net>
Date: Wed, 14 Feb 2024 22:41:37 -0800
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
X-Exim-ID: 1raVRE-003OOe-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:46150
X-Source-Auth: re@w6rz.net
X-Email-Count: 20
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPyXmMN1OiVty67M5GvFCrp/hDUGX0iWZJfRR9IAKJmdZjDq7BbU9wDMYCFGYlc3JZmjrmuyC8MpweALUyRQ9+PkMeYsxjkYrknzz/3WxhPAbW/XHMQ7
 WsQblCEhRU0m3Ki+lVTSV/Er8rkLOOdXI/gTGWCBGgaatYEHCUN4e94KNGD6+ndxycZ4bxBZg1qTow==

On 2/14/24 6:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


